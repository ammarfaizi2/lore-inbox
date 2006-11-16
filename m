Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423351AbWKPKKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423351AbWKPKKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423303AbWKPKKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:10:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63636 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423223AbWKPKKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:10:07 -0500
Date: Thu, 16 Nov 2006 11:08:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] lockdep: show held locks when showing a stackdump
Message-ID: <20061116100852.GA5864@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0952]
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: show held locks when showing a stackdump
From: Ingo Molnar <mingo@elte.hu>

lockdep can be used to print held locks when printing a
backtrace. This can be useful when debugging things like
'scheduling while atomic' asserts.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/i386/kernel/traps.c   |    1 +
 arch/x86_64/kernel/traps.c |    1 +
 2 files changed, 2 insertions(+)

Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -318,6 +318,7 @@ static void show_stack_log_lvl(struct ta
 	}
 	printk("\n%sCall Trace:\n", log_lvl);
 	show_trace_log_lvl(task, regs, esp, log_lvl);
+	debug_show_held_locks(task);
 }
 
 void show_stack(struct task_struct *task, unsigned long *esp)
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -405,6 +405,7 @@ show_trace(struct task_struct *tsk, stru
 	printk("\nCall Trace:\n");
 	dump_trace(tsk, regs, stack, &print_trace_ops, NULL);
 	printk("\n");
+	debug_show_held_locks(tsk);
 }
 
 static void
