Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSJUKHt>; Mon, 21 Oct 2002 06:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbSJUKH0>; Mon, 21 Oct 2002 06:07:26 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:32839 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261299AbSJUKBc>; Mon, 21 Oct 2002 06:01:32 -0400
Date: Mon, 21 Oct 2002 03:15:57 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210211015.g9LAFvl21186@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, yakker@aparity.com
Subject: [PATCH] 2.5.44: lkcd (5/9): sysrq changes for dump
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysrq hooks for dump crash dump handling.

 sysrq.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)

diff -Naur linux-2.5.44.orig/drivers/char/sysrq.c linux-2.5.44.lkcd/drivers/char/sysrq.c
--- linux-2.5.44.orig/drivers/char/sysrq.c	Fri Oct 18 21:02:29 2002
+++ linux-2.5.44.lkcd/drivers/char/sysrq.c	Sat Oct 19 12:39:15 2002
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
 		 it is handled specially on the sparc
 		 and will never arrive */
 /* b */	&sysrq_reboot_op,
-/* c */	NULL,
+/* c */	&sysrq_crashdump_op,
 /* d */	NULL,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
