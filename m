Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161715AbWKEUgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161715AbWKEUgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161716AbWKEUgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:36:24 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:35948 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161714AbWKEUgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:36:23 -0500
Subject: [PATCH] lockdep: print current locks on in_atomic warnings
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, arjan <arjan@infradead.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 21:36:19 +0100
Message-Id: <1162758979.14695.20.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add debug_show_held_locks(current) to __might_sleep() and
schedule(); this makes finding the offending lock leak easier.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 kernel/sched.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6-twins/kernel/sched.c
===================================================================
--- linux-2.6-twins.orig/kernel/sched.c	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/kernel/sched.c	2006-11-05 21:11:39.000000000 +0100
@@ -3333,6 +3333,7 @@ asmlinkage void __sched schedule(void)
 		printk(KERN_ERR "BUG: scheduling while atomic: "
 			"%s/0x%08x/%d\n",
 			current->comm, preempt_count(), current->pid);
+		debug_show_held_locks(current);
 		dump_stack();
 	}
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
@@ -6867,6 +6868,7 @@ void __might_sleep(char *file, int line)
 				" context at %s:%d\n", file, line);
 		printk("in_atomic():%d, irqs_disabled():%d\n",
 			in_atomic(), irqs_disabled());
+		debug_show_held_locks(current);
 		dump_stack();
 	}
 #endif


