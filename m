Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUIWDrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUIWDrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUIWDrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:47:13 -0400
Received: from zeus.kernel.org ([204.152.189.113]:10442 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268238AbUIWDqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:46:44 -0400
Message-Id: <200409230220.i8N2KBiF004255@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - Small Makefile fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:20:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tidied up some whitespace in arch/um/Makefile.
Added -DUM_FASTCALL to Makefile-i386.
make clean descends into util in order to get rid of the binaries there.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/Makefile
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/Makefile	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/Makefile	2004-09-22 20:00:24.000000000 -0400
@@ -67,7 +67,7 @@
 # included; the values here are meaningless
 
 CONFIG_NEST_LEVEL ?= 0
-CONFIG_KERNEL_HALF_GIGS ?=  0
+CONFIG_KERNEL_HALF_GIGS ?= 0
 
 SIZE = (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
 
Index: linux-2.6.9-rc2-mm1-orig/arch/um/Makefile-i386
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/Makefile-i386	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/Makefile-i386	2004-09-22 20:00:24.000000000 -0400
@@ -5,6 +5,11 @@
 endif
 
 CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
+
+ifneq ($(CONFIG_GPROF),y)
+ARCH_CFLAGS += -DUM_FASTCALL
+endif
+
 ELF_ARCH = $(SUBARCH)
 ELF_FORMAT = elf32-$(SUBARCH)
 
Index: linux-2.6.9-rc2-mm1-orig/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/kernel/Makefile	2004-09-22 19:51:41.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/kernel/Makefile	2004-09-22 20:00:24.000000000 -0400
@@ -5,6 +5,11 @@
 
 extra-y := vmlinux.lds uml.lds dyn.lds
 
+# Descend into ../util for make clean.  This is here because it doesn't work
+# in arch/um/Makefile.
+
+subdir- = ../util
+
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
 	physmem.o process.o process_kern.o ptrace.o reboot.o resource.o \
More recent patches modify files in makefile-fixes.

