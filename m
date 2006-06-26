Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWFZBIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWFZBIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWFZA6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:13967 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964968AbWFZA6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:16 -0400
Date: Sun, 25 Jun 2006 17:57:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 04/43] Support KLIBCARCH being different from the main ARCH
Message-Id: <klibc.200606251757.04@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is particularly significant for powerpc, since in the main kernel
tree the ppc and ppc64 architectures have been fully unified.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 5ad9bee01be52a0593fedcf905ae26ef4fd65007
tree 0d00148602ab472cef20ed73438da634eec375ac
parent 79d8875c392c6eaf4b9537625c57690a02eab411
author H. Peter Anvin <hpa@zytor.com> Thu, 06 Apr 2006 11:21:10 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:45:56 -0700

 Makefile              |    7 +++++--
 arch/powerpc/Makefile |    1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1700d3f..889ee38 100644
--- a/Makefile
+++ b/Makefile
@@ -176,7 +176,10 @@ ARCH		?= $(SUBARCH)
 CROSS_COMPILE	?=
 
 # Architecture as present in compile.h
-UTS_MACHINE := $(ARCH)
+UTS_MACHINE	:= $(ARCH)
+
+# Architecture used to compile user-space code
+KLIBCARCH	?= $(subst powerpc,ppc,$(ARCH))
 
 # SHELL used by kbuild
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
@@ -316,7 +319,7 @@ KERNELVERSION = $(VERSION).$(PATCHLEVEL)
 export	VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION \
 	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
-	HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
+	HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS KLIBCARCH
 
 export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ed5b26a..7591ee7 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -51,6 +51,7 @@ SZ	:= 32
 endif
 
 UTS_MACHINE := $(OLDARCH)
+KLIBCARCH   := $(OLDARCH)
 
 ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(SZ)
