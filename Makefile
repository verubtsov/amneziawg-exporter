.PHONY: all ci docker_build docker_push

VERSION            := 3.2.1
PROJECT_NAME       ?= amneziawg-exporter
DOCKER_IMAGE       ?= $(PROJECT_NAME)
DOCKER_TAG         ?= latest
PLATFORMS          ?= linux/amd64,linux/arm64


all: docker_build

ci: DOCKER_TAG=$(VERSION)
ci: docker_push

docker_build:
	docker build . -t $(DOCKER_IMAGE):$(DOCKER_TAG) --build-arg VERSION=$(VERSION)

docker_push:
	docker buildx build \
		--platform $(PLATFORMS) \
		--build-arg VERSION=$(VERSION) \
		-t $(DOCKER_IMAGE):$(DOCKER_TAG) \
		-t $(DOCKER_IMAGE):latest \
		--push \
		.
