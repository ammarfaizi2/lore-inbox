Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752392AbWCFS1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbWCFS1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbWCFS1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:27:39 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:911 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1752390AbWCFS1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:27:38 -0500
Date: Mon, 6 Mar 2006 13:25:55 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: fix dump_stack()
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200603061327_MC3-1-B9F7-26DE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 has a small bug in the stack dump code where it prints
an extra log level code.  Remove that and fix the alignment
of normal stack dump printout. Also remove some unnecessary
printk() calls.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc5-32.orig/arch/i386/kernel/traps.c
+++ 2.6.16-rc5-32/arch/i386/kernel/traps.c
@@ -190,25 +190,20 @@ static void show_stack_log_lvl(struct ta
 	}
 
 	stack = esp;
-	printk(log_lvl);
 	for(i = 0; i < kstack_depth_to_print; i++) {
 		if (kstack_end(stack))
 			break;
-		if (i && ((i % 8) == 0)) {
-			printk("\n");
-			printk(log_lvl);
-			printk("       ");
-		}
+		if (i && ((i % 8) == 0))
+			printk("\n%s       ", log_lvl);
 		printk("%08lx ", *stack++);
 	}
-	printk("\n");
-	printk(log_lvl);
-	printk("Call Trace:\n");
+	printk("\n%sCall Trace:\n", log_lvl);
 	show_trace_log_lvl(task, esp, log_lvl);
 }
 
 void show_stack(struct task_struct *task, unsigned long *esp)
 {
+	printk("       ");
 	show_stack_log_lvl(task, esp, "");
 }
 
-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
