Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSJWJfl>; Wed, 23 Oct 2002 05:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSJWJeW>; Wed, 23 Oct 2002 05:34:22 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:2116 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S263270AbSJWJaB>; Wed, 23 Oct 2002 05:30:01 -0400
Date: Wed, 23 Oct 2002 02:44:28 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: linux-kernel@vger.kernel.org
cc: lkcd-devel@lists.sourceforge.net
Subject: [PATCH] LKCD for 2.5.44 (5/8): sysrq changes for dump
In-Reply-To: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.44.0210230244180.27315-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

