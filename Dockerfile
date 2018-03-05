# Ubuntu 16.04
# Oracle Java 9.0.4 64 bit
# Maven 3.5.2

FROM ubuntu:16.04

MAINTAINER Yevhen Strazhko (https://github.com/strazhkoe)

# this is a non-interactive automated build - avoid some warning messages
ENV DEBIAN_FRONTEND noninteractive

# update dpkg repositories
RUN apt-get update 

# install wget
RUN apt-get install -y wget

# get maven 3.5.2
RUN wget --no-verbose -O /tmp/apache-maven-3.5.2.tar.gz http://archive.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz

# verify checksum
RUN echo "948110de4aab290033c23bf4894f7d9a /tmp/apache-maven-3.5.2.tar.gz" | md5sum -c

# install maven
RUN tar xzf /tmp/apache-maven-3.5.2.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.5.2 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.5.2.tar.gz
ENV MAVEN_HOME /opt/maven

# remove download archive files
RUN apt-get clean

# set shell variables for java installation
ENV java_version 9.0.4
ENV filename jdk-9.0.4_linux-x64_bin.tar.gz

# download java, accepting the license agreement
RUN wget wget -c --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz"

# unpack java
RUN mkdir /opt/java-oracle && tar -zxf $filename -C /opt/java-oracle/
ENV JAVA_HOME /opt/java-oracle/jdk-$java_version
ENV PATH $JAVA_HOME/bin:$PATH

# configure symbolic links for the java and javac executables
RUN update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000

# install git
RUN apt-get install -y git

CMD [""]
