Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273577AbRJTQOd>; Sat, 20 Oct 2001 12:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJTQOX>; Sat, 20 Oct 2001 12:14:23 -0400
Received: from smtp3.libero.it ([193.70.192.53]:60121 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S273577AbRJTQOL>;
	Sat, 20 Oct 2001 12:14:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Davide Inglima - limaCAT <limacat@libero.it>
Organization: Order Of Llhatarius - Underwater Chocobo - Kdenthusiasts
To: torvalds@transmeta.com
Subject: [PATCH] make rpm target fix in Makefile (linux-2.4.13-pre5)
Date: Sat, 20 Oct 2001 18:08:42 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01102018084200.07924@even>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in short:
- the rpm target in linus tree doesn't work: it refuses to compile since it needs the "KERNELPATH"
  environment variable set as well... otherwise it would fail to create the .tar.gz file needed by the
  rpm-compile process.
solution:
- copy the "KERNELPATH=..." directive from Alan's Makefile. Now it works.

Enjoy!

--- Makefile.orig       Sat Oct 20 17:54:46 2001
+++ Makefile    Sat Oct 20 17:46:47 2001
@@ -6,6 +6,7 @@
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
 ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
+KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//")
 
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
          else if [ -x /bin/bash ]; then echo /bin/bash; \
