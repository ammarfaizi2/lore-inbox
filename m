Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbUBUVw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 16:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUBUVw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 16:52:27 -0500
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:11704 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S261621AbUBUVwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 16:52:21 -0500
Message-ID: <4037D3D1.9000207@quark.didntduck.org>
Date: Sat, 21 Feb 2004 16:55:29 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove LDFLAGS_BLOB
Content-Type: multipart/mixed;
 boundary="------------010600010607010804030108"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600010607010804030108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

LDFLAGS_BLOB is no longer used for anything.

--
				Brian Gerst

--------------010600010607010804030108
Content-Type: text/plain;
 name="ldflags-blob-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ldflags-blob-1"

diff -urN linux-bk/arch/arm/Makefile linux/arch/arm/Makefile
--- linux-bk/arch/arm/Makefile	2004-02-20 15:22:04.000000000 -0500
+++ linux/arch/arm/Makefile	2004-02-20 19:16:33.713747640 -0500
@@ -8,7 +8,6 @@
 # Copyright (C) 1995-2001 by Russell King
 
 LDFLAGS_vmlinux	:=-p -X
-LDFLAGS_BLOB	:=--format binary
 AFLAGS_vmlinux.lds.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
 OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
@@ -56,11 +55,6 @@
 
 PROCESSOR	:= armv
 head-y		:= arch/arm/kernel/head.o arch/arm/kernel/init_task.o
-ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
-  LDFLAGS_BLOB	+= --oformat elf32-bigarm
-else
-  LDFLAGS_BLOB	+= --oformat elf32-littlearm
-endif
 textaddr-y	:= 0xC0008000
 
  machine-$(CONFIG_ARCH_ARCA5K)	   := arc
diff -urN linux-bk/arch/arm26/Makefile linux/arch/arm26/Makefile
--- linux-bk/arch/arm26/Makefile	2003-12-17 21:58:47.000000000 -0500
+++ linux/arch/arm26/Makefile	2004-02-20 19:16:33.727745512 -0500
@@ -8,7 +8,6 @@
 # Copyright (C) 1995-2001 by Russell King
 
 LDFLAGS_vmlinux	:=-p -X
-LDFLAGS_BLOB	:=--format binary
 AFLAGS_vmlinux.lds.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
 OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
@@ -28,7 +27,6 @@
 AFLAGS		+=-mapcs-26 -mcpu=arm3 -mno-fpu -msoft-float -Wa,-mno-fpu
 
 head-y		:= arch/arm26/machine/head.o arch/arm26/kernel/init_task.o
-LDFLAGS_BLOB	+= --oformat elf32-littlearm
 
 ifeq ($(CONFIG_XIP_KERNEL),y)
   TEXTADDR	 := 0x03880000
diff -urN linux-bk/arch/cris/arch-v10/output_arch.ld linux/arch/cris/arch-v10/output_arch.ld
--- linux-bk/arch/cris/arch-v10/output_arch.ld	2003-12-17 21:58:38.000000000 -0500
+++ linux/arch/cris/arch-v10/output_arch.ld	1969-12-31 19:00:00.000000000 -0500
@@ -1,2 +0,0 @@
-/* At the time of this writing, there's no equivalent ld option. */
-OUTPUT_ARCH (cris)
diff -urN linux-bk/arch/cris/Makefile linux/arch/cris/Makefile
--- linux-bk/arch/cris/Makefile	2003-12-17 21:58:49.000000000 -0500
+++ linux/arch/cris/Makefile	2004-02-20 19:16:33.744742928 -0500
@@ -24,8 +24,6 @@
 endif
 
 LD = $(CROSS_COMPILE)ld -mcrislinux
-LDFLAGS_BLOB	:= --format binary --oformat elf32-cris \
-		   -T arch/cris/$(SARCH)/output_arch.ld
 
 OBJCOPYFLAGS := -O binary -R .note -R .comment -S
 
diff -urN linux-bk/arch/um/Makefile-i386 linux/arch/um/Makefile-i386
--- linux-bk/arch/um/Makefile-i386	2003-12-17 21:59:18.000000000 -0500
+++ linux/arch/um/Makefile-i386	2004-02-20 19:16:33.753741560 -0500
@@ -9,7 +9,6 @@
 ELF_FORMAT = elf32-$(SUBARCH)
 
 OBJCOPYFLAGS  := -O binary -R .note -R .comment -S
-LDFLAGS_BLOB	:= --format binary --oformat elf32-i386
 
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-i386
 SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
diff -urN linux-bk/Documentation/kbuild/makefiles.txt linux/Documentation/kbuild/makefiles.txt
--- linux-bk/Documentation/kbuild/makefiles.txt	2003-12-17 21:59:16.000000000 -0500
+++ linux/Documentation/kbuild/makefiles.txt	2004-02-20 19:16:33.766739584 -0500
@@ -638,15 +638,6 @@
 		#arch/i386/Makefile
 		LDFLAGS_vmlinux := -e stext
 
-    LDFLAGS_BLOB	Options for $(LD) when linking the initramfs blob
-
-	The image used for initramfs is made during the build process.
-	LDFLAGS_BLOB is used to specify additional flags to be used when
-	creating the initramfs_data.o file.
-	Example:
-		#arch/i386/Makefile
-		LDFLAGS_BLOB := --format binary --oformat elf32-i386
-
     OBJCOPYFLAGS	objcopy flags
 
 	When $(call if_changed,objcopy) is used to translate a .o file,
diff -urN linux-bk/Makefile linux/Makefile
--- linux-bk/Makefile	2004-02-18 01:37:14.000000000 -0500
+++ linux/Makefile	2004-02-20 19:16:33.776738064 -0500
@@ -283,7 +283,7 @@
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
 	CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
-	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK
+	HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK
 
 export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
diff -urN linux-bk/usr/initramfs_data.S linux/usr/initramfs_data.S
--- linux-bk/usr/initramfs_data.S	2003-12-17 21:59:42.000000000 -0500
+++ linux/usr/initramfs_data.S	2004-02-20 19:18:31.250879280 -0500
@@ -1,28 +1,6 @@
 /*
   initramfs_data includes the compressed binary that is the
   filesystem used for early user space.
-  Note: Older versions of "as" (prior to binutils 2.11.90.0.23
-  released on 2001-07-14) dit not support .incbin.
-  If you are forced to use older binutils than that then the
-  following trick can be applied to create the resulting binary:
-
-
-  ld -m elf_i386  --format binary --oformat elf32-i386 -r \
-  -T initramfs_data.scr initramfs_data.cpio.gz -o initramfs_data.o
-   ld -m elf_i386  -r -o built-in.o initramfs_data.o
-
-  initramfs_data.scr looks like this:
-SECTIONS
-{
-       .init.ramfs : { *(.data) }
-}
-
-  The above example is for i386 - the parameters vary from architectures.
-  Eventually look up LDFLAGS_BLOB in an older version of the
-  arch/$(ARCH)/Makefile to see the flags used before .incbin was introduced.
-
-  Using .incbin has the advantage over ld that the correct flags are set
-  in the ELF header, as required by certain architectures.
 */
 
 .section .init.ramfs,"a"

--------------010600010607010804030108--
