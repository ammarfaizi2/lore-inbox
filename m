Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268689AbTGLWur (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268694AbTGLWur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:50:47 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:36042 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268689AbTGLWup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:50:45 -0400
Subject: [PATCH] gcc -Wpadded
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1058050640.751.1324.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jul 2003 18:57:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Explicit padding is better than compiler-generated
padding, because awareness of the issue reduces
waste. There's also a security issue, with info
leaking whenever padded structs get copied to the user.

This patch adds -Wpadded for i386, mips, and s390.

diff -Naurd old/arch/i386/Makefile new/arch/i386/Makefile
--- old/arch/i386/Makefile	2003-07-12 18:36:52.000000000 -0400
+++ new/arch/i386/Makefile	2003-07-12 18:47:01.000000000 -0400
@@ -27,6 +27,8 @@
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
+CFLAGS += $(call check_gcc,-Wpadded,)
+
 align := $(subst -functions=0,,$(call
check_gcc,-falign-functions=0,-malign-functions=0))
 
 cflags-$(CONFIG_M386)		+= -march=i386
diff -Naurd old/arch/mips/Makefile new/arch/mips/Makefile
--- old/arch/mips/Makefile	2003-07-12 18:42:12.000000000 -0400
+++ new/arch/mips/Makefile	2003-07-12 18:46:21.000000000 -0400
@@ -78,6 +78,7 @@
 
 AFLAGS		+= $(cflags-y)
 CFLAGS		+= $(cflags-y)
+CFLAGS		+= $(call check_gcc,-Wpadded,)
 
 
 #
diff -Naurd old/arch/s390/Makefile new/arch/s390/Makefile
--- old/arch/s390/Makefile	2003-07-12 18:41:49.000000000 -0400
+++ new/arch/s390/Makefile	2003-07-12 18:44:41.000000000 -0400
@@ -38,6 +38,7 @@
 
 CFLAGS		+= $(cflags-y)
 CFLAGS		+= $(call check_gcc,-finline-limit=10000,)
+CFLAGS		+= $(call check_gcc,-Wpadded,)
 CFLAGS 		+= -pipe -fno-strength-reduce -Wno-sign-compare 
 
 OBJCOPYFLAGS	:= -O binary



