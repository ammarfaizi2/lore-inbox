Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbUBXOCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbUBXOCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:02:22 -0500
Received: from pop.gmx.net ([213.165.64.20]:61344 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262219AbUBXOBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:01:49 -0500
X-Authenticated: #1892127
Mime-Version: 1.0 (Apple Message framework v612)
Content-Transfer-Encoding: 7bit
Message-Id: <9D6F6210-66DA-11D8-A093-0003931E0B62@gmx.li>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Martin Schaffner <schaffner@gmx.li>
Subject: [PATCH 2.4.25] enable cross-compilation from Mac OS X
Date: Tue, 24 Feb 2004 15:03:33 +0000
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After setting up a cross-compile toolchain (using 
http://vserver.13thfloor.at/Stuff/Cross/) on Mac OS X 10.3.2, and 
applying the following patch, I was able to compile a bootable linux 
kernel with the command:
make CROSS_COMPILE=/usr/local/bin/powerpc-linux-gnu-

Please consider applying the patch to the main 2.4 tree.

I was also able to compile 2.6.1 with basically the same patch, but it 
required some additional fiddling with the makefiles in 
not-entirely-clean ways.

--- Makefile.old        Wed Feb 18 13:36:32 2004
+++ Makefile    Tue Feb 24 11:36:13 2004
@@ -5,7 +5,7 @@

  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

-ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e 
s/arm.*/arm/ -e s/sa110/arm/)
+ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e 
s/arm.*/arm/ -e s/sa110/arm/ -e s/Power\ Macintosh/ppc/)
  KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")

  CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
@@ -353,7 +353,7 @@
         @rm -f .ver1

  include/linux/version.h: ./Makefile
-       @expr length "$(KERNELRELEASE)" \<= $(uts_len) > /dev/null || \
+       @expr "$(KERNELRELEASE)" : '.*' \<= $(uts_len) > /dev/null || \
           (echo KERNELRELEASE \"$(KERNELRELEASE)\" exceeds $(uts_len) 
characters >&2; false)
         @echo \#define UTS_RELEASE \"$(KERNELRELEASE)\" > .ver
         @echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + 
$(PATCHLEVEL) \\* 256 + $(SUBLEVEL)` >> .ver

