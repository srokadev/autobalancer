.PHONY: default build compile

default: compile

build: docker_makefile Dockerfile
	@docker build -t autobalancer-builder .

compile: build
	@[ -d artifacts ] || mkdir artifacts
	docker run -it \
		-v $(shell pwd)/br_external:/workdir/br_external \
		-v $(shell pwd)/artifacts:/workdir/artifacts \
		autobalancer-builder \
	 	make

shell: build
	@[ -d artifacts ] || mkdir artifacts
	docker run -it \
		-v $(shell pwd)/br_external:/workdir/br_external \
		-v $(shell pwd)/artifacts:/workdir/artifacts \
		autobalancer-builder \
	 	/bin/bash