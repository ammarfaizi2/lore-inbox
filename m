Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbUKNUux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUKNUux (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbUKNUuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:50:52 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:10500
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261350AbUKNUuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:50:44 -0500
Message-Id: <200411142304.iAEN41bV013356@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - UML - LFS 64-bit cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Nov 2004 18:04:01 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARCH_USER_CFLAGS so the arches can modify USER_CFLAGS.
We now take __ARCH_WANT_OLD_STAT and __ARCH_WANT_STAT64 from the base arch
so that the LFS-64 code gets included or excluded automatically.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/Makefile
===================================================================
--- 2.6.9.orig/arch/um/Makefile	2004-11-14 15:31:26.000000000 -0500
+++ 2.6.9/arch/um/Makefile	2004-11-14 15:31:35.000000000 -0500
@@ -129,6 +129,7 @@
 USER_CFLAGS := $(patsubst -Dsigprocmask=kernel_sigprocmask,,$(USER_CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
 	$(MODE_INCLUDE)
+USER_CFLAGS += $(ARCH_USER_CFLAGS)
 
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE
Index: 2.6.9/arch/um/Makefile-i386
===================================================================
--- 2.6.9.orig/arch/um/Makefile-i386	2004-11-14 15:31:26.000000000 -0500
+++ 2.6.9/arch/um/Makefile-i386	2004-11-14 15:31:35.000000000 -0500
@@ -11,6 +11,7 @@
 endif
 
 CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
+ARCH_USER_CFLAGS :=
 
 ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
Index: 2.6.9/arch/um/Makefile-x86_64
===================================================================
--- 2.6.9.orig/arch/um/Makefile-x86_64	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.9/arch/um/Makefile-x86_64	2004-11-14 15:31:35.000000000 -0500
@@ -0,0 +1 @@
+ARCH_USER_CFLAGS := -D__x86_64__
Index: 2.6.9/include/asm-um/unistd.h
===================================================================
--- 2.6.9.orig/include/asm-um/unistd.h	2004-11-14 15:31:26.000000000 -0500
+++ 2.6.9/include/asm-um/unistd.h	2004-11-14 15:31:35.000000000 -0500
@@ -13,10 +13,9 @@
 extern int um_execve(const char *file, char *const argv[], char *const env[]);
 
 #ifdef __KERNEL__
+/* We get __ARCH_WANT_OLD_STAT and __ARCH_WANT_STAT64 from the base arch */
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
-#define __ARCH_WANT_OLD_STAT
-#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE

