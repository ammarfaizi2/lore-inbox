Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWFZBNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWFZBNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWFZBNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:13:34 -0400
Received: from terminus.zytor.com ([192.83.249.54]:18575 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964974AbWFZA6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:37 -0400
Date: Sun, 25 Jun 2006 17:58:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 18/43] klibc (inkernel): merge s390/s390x #4
Message-Id: <klibc.200606251757.18@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes needed for the inkernel klibc merge of s390/s390x.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

---
commit 378abd8f4d39024ea6c87eb5b54155238f647f0d
tree d2f336f8ab090090b07dfb6829b70ead42ea70b8
parent fc8c0c09f9dd5139dd8d797eaf9fe33962b6cd2c
author Heiko Carstens <heiko.carstens@de.ibm.com> Sun, 28 May 2006 11:41:42 +0200
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 19:05:07 -0700

 Makefile           |    3 ++-
 arch/s390/Makefile |    4 ++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c550270..4f684b3 100644
--- a/Makefile
+++ b/Makefile
@@ -180,6 +180,7 @@ UTS_MACHINE	:= $(ARCH)
 
 # Architecture used to compile user-space code
 KLIBCARCH	?= $(ARCH)
+KLIBCARCHDIR	?= $(KLIBCARCH)
 
 # klibc definitions
 export KLIBCINC := usr/include
@@ -326,7 +327,7 @@ export VERSION PATCHLEVEL SUBLEVEL KERNE
 export KLIBCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD
 export CC CPP AR RANLIB NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS
 export PERL UTS_MACHINE HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK
-export CHECKFLAGS
+export CHECKFLAGS KLIBCARCHDIR
 
 export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 7bb16fb..d3a271e 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -20,6 +20,7 @@ AFLAGS		+= -m31
 UTS_MACHINE	:= s390
 STACK_SIZE	:= 8192
 CHECKFLAGS	+= -D__s390__
+KLIBCARCH	:= s390
 else
 LDFLAGS		:= -m elf64_s390
 MODFLAGS	+= -fpic -D__PIC__
@@ -28,8 +29,11 @@ AFLAGS		+= -m64
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= 16384
 CHECKFLAGS	+= -D__s390__ -D__s390x__
+KLIBCARCH	:= s390x
 endif
 
+KLIBCARCHDIR	:= s390
+
 cflags-$(CONFIG_MARCH_G5)   += $(call cc-option,-march=g5)
 cflags-$(CONFIG_MARCH_Z900) += $(call cc-option,-march=z900)
 cflags-$(CONFIG_MARCH_Z990) += $(call cc-option,-march=z990)
