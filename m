Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbTFXFPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 01:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbTFXFOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 01:14:00 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:62937 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265696AbTFXFN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 01:13:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  show_stack changes for v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030624052717.1BE4437BB@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 24 Jun 2003 14:27:17 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.73-moo/arch/v850/kernel/bug.c linux-2.5.73-moo-v850-20030624/arch/v850/kernel/bug.c
--- linux-2.5.73-moo/arch/v850/kernel/bug.c	2003-02-25 10:44:59.000000000 +0900
+++ linux-2.5.73-moo-v850-20030624/arch/v850/kernel/bug.c	2003-06-23 15:16:50.000000000 +0900
@@ -17,6 +17,7 @@
 
 #include <asm/errno.h>
 #include <asm/ptrace.h>
+#include <asm/processor.h>
 #include <asm/current.h>
 
 /* We should use __builtin_return_address, but it doesn't work in gcc-2.90
@@ -100,12 +101,21 @@
 	}
 }
 
-void show_stack (unsigned long *sp)
-{
-	unsigned long end;
-	unsigned long addr = (unsigned long)sp;
-
-	if (! addr)
+/*
+ * TASK is a pointer to the task whose backtrace we want to see (or NULL
+ * for current task), SP is the stack pointer of the first frame that
+ * should be shown in the back trace (or NULL if the entire call-chain of
+ * the task should be shown).
+ */
+void show_stack (struct task_struct *task, unsigned long *sp)
+{
+	unsigned long addr, end;
+
+	if (sp)
+		addr = (unsigned long)sp;
+	else if (task)
+		addr = task_sp (task);
+	else
 		addr = stack_addr ();
 
 	addr = addr & ~3;
@@ -125,5 +135,5 @@
 
 void dump_stack ()
 {
-	show_stack (0);
+	show_stack (0, 0);
 }
