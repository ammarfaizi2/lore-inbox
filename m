Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262191AbSJJTzy>; Thu, 10 Oct 2002 15:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262186AbSJJTy2>; Thu, 10 Oct 2002 15:54:28 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:11086 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262185AbSJJTuU>; Thu, 10 Oct 2002 15:50:20 -0400
Date: Thu, 10 Oct 2002 13:04:27 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210102004.g9AK4Rh29574@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, yakker@aparity.com
Subject: [PATCH] 2.5.41: lkcd (5/8): sysrq changes for dump
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysrq hooks for dump crash dump handling.


 sysrq.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)


diff -urN -X /home/bharata/dontdiff linux-2.5.41/drivers/char/sysrq.c linux-2.5.41+lkcd/drivers/char/sysrq.c
--- linux-2.5.41/drivers/char/sysrq.c	Mon Oct  7 23:54:50 2002
+++ linux-2.5.41+lkcd/drivers/char/sysrq.c	Tue Oct  8 13:27:28 2002
@@ -32,6 +32,7 @@
 #include <linux/buffer_head.h>		/* for fsync_bdev() */
 
 #include <linux/spinlock.h>
+#include <linux/dump.h>
 
 #include <asm/ptrace.h>
 
@@ -307,6 +308,16 @@
 	}
 }
 
+static void sysrq_handle_crashdump(int key, struct pt_regs *pt_regs,
+		struct tty_struct *tty) {
+	dump("sysrq", pt_regs);
+}
+static struct sysrq_key_op sysrq_crashdump_op = {
+	handler:	sysrq_handle_crashdump,
+	help_msg:	"Crash",
+	action_msg:	"Start a Crash Dump (If Configured)",
+};
+
 static void sysrq_handle_term(int key, struct pt_regs *pt_regs,
 			      struct tty_struct *tty) 
 {
@@ -352,7 +363,7 @@
 		 it is handled specially on the spark
 		 and will never arive */
 /* b */	&sysrq_reboot_op,
-/* c */	NULL,
+/* c */	&sysrq_crashdump_op,
 /* d */	NULL,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
