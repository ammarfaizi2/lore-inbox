Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUH3UCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUH3UCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUH3Txx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:53:53 -0400
Received: from ppp-62-11-78-150.dialup.tiscali.it ([62.11.78.150]:7298 "EHLO
	zion.localdomain") by vger.kernel.org with ESMTP id S268922AbUH3Twm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:52:42 -0400
Subject: [patch 1/3] kbuild - remove old LDFLAGS_BLOB from Makefiles.
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 30 Aug 2004 21:44:30 +0200
Message-Id: <20040830194430.30C042C6E@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The LDFLAGS_BLOB var (which used to be defined in arch Makefiles) is now unused,
as specified inside usr/initramfs_data.S. So this patch removes the remaining
references.

A separate patch is provided to remove it from UML, and another to update docs.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.8.1-paolo/Makefile            |    2 +-
 vanilla-linux-2.6.8.1-paolo/arch/arm/Makefile   |    1 -
 vanilla-linux-2.6.8.1-paolo/arch/arm26/Makefile |    2 --
 vanilla-linux-2.6.8.1-paolo/arch/cris/Makefile  |    2 --
 4 files changed, 1 insertion(+), 6 deletions(-)

diff -puN Makefile~kbuild-LDFLAGS_BLOB-remove Makefile
--- vanilla-linux-2.6.8.1/Makefile~kbuild-LDFLAGS_BLOB-remove	2004-08-30 16:02:30.587626232 +0200
+++ vanilla-linux-2.6.8.1-paolo/Makefile	2004-08-30 16:02:30.942572272 +0200
@@ -304,7 +304,7 @@ AFLAGS		:= -D__ASSEMBLY__
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
 	CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
-	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK
+	HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK
 
 export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
diff -puN arch/arm26/Makefile~kbuild-LDFLAGS_BLOB-remove arch/arm26/Makefile
--- vanilla-linux-2.6.8.1/arch/arm26/Makefile~kbuild-LDFLAGS_BLOB-remove	2004-08-30 16:02:30.937573032 +0200
+++ vanilla-linux-2.6.8.1-paolo/arch/arm26/Makefile	2004-08-30 16:02:30.942572272 +0200
@@ -8,7 +8,6 @@
 # Copyright (C) 1995-2001 by Russell King
 
 LDFLAGS_vmlinux	:=-p -X
-LDFLAGS_BLOB	:=--format binary
 AFLAGS_vmlinux.lds.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
 OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
@@ -28,7 +27,6 @@ CFLAGS		+=-mapcs-26 -mcpu=arm3 -mshort-l
 AFLAGS		+=-mapcs-26 -mcpu=arm3 -mno-fpu -msoft-float -Wa,-mno-fpu
 
 head-y		:= arch/arm26/machine/head.o arch/arm26/kernel/init_task.o
-LDFLAGS_BLOB	+= --oformat elf32-littlearm
 
 ifeq ($(CONFIG_XIP_KERNEL),y)
   TEXTADDR	 := 0x03880000
diff -puN arch/cris/Makefile~kbuild-LDFLAGS_BLOB-remove arch/cris/Makefile
--- vanilla-linux-2.6.8.1/arch/cris/Makefile~kbuild-LDFLAGS_BLOB-remove	2004-08-30 16:02:30.938572880 +0200
+++ vanilla-linux-2.6.8.1-paolo/arch/cris/Makefile	2004-08-30 16:02:30.942572272 +0200
@@ -24,8 +24,6 @@ SARCH :=
 endif
 
 LD = $(CROSS_COMPILE)ld -mcrislinux
-LDFLAGS_BLOB	:= --format binary --oformat elf32-cris \
-		   -T arch/cris/$(SARCH)/output_arch.ld
 
 OBJCOPYFLAGS := -O binary -R .note -R .comment -S
 
diff -puN arch/arm/Makefile~kbuild-LDFLAGS_BLOB-remove arch/arm/Makefile
--- vanilla-linux-2.6.8.1/arch/arm/Makefile~kbuild-LDFLAGS_BLOB-remove	2004-08-30 16:02:30.939572728 +0200
+++ vanilla-linux-2.6.8.1-paolo/arch/arm/Makefile	2004-08-30 16:02:30.942572272 +0200
@@ -8,7 +8,6 @@
 # Copyright (C) 1995-2001 by Russell King
 
 LDFLAGS_vmlinux	:=-p --no-undefined -X
-LDFLAGS_BLOB	:=--format binary
 AFLAGS_vmlinux.lds.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
 OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
_
