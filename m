Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbTDVT1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTDVT04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:26:56 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:64128 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263483AbTDVT0F (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:26:05 -0400
Message-Id: <200304221938.h3MJc9Lq004944@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 #if cleanup kernel/* and mm/* (5/6)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Apr 2003 15:38:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the kernel/* tree and one file in mm/

--- linux-2.5.68-bk3/kernel/ksyms.c.dist	2003-04-22 13:57:16.000000000 -0400
+++ linux-2.5.68-bk3/kernel/ksyms.c	2003-04-22 14:43:34.636318058 -0400
@@ -457,7 +457,7 @@
 EXPORT_SYMBOL(complete_and_exit);
 EXPORT_SYMBOL(default_wake_function);
 EXPORT_SYMBOL(__wake_up);
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 EXPORT_SYMBOL_GPL(__wake_up_sync); /* internal use only */
 #endif
 EXPORT_SYMBOL(wake_up_process);
@@ -475,10 +475,10 @@
 EXPORT_SYMBOL(set_user_nice);
 EXPORT_SYMBOL(task_nice);
 EXPORT_SYMBOL_GPL(idle_cpu);
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
 #endif
-#if CONFIG_SMP || CONFIG_PREEMPT
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 EXPORT_SYMBOL(kernel_flag);
 #endif
 EXPORT_SYMBOL(jiffies);
--- linux-2.5.68-bk3/kernel/signal.c.dist	2003-04-22 13:57:16.000000000 -0400
+++ linux-2.5.68-bk3/kernel/signal.c	2003-04-22 14:43:58.455832193 -0400
@@ -761,7 +761,7 @@
 
 	if (!irqs_disabled())
 		BUG();
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	if (!spin_is_locked(&t->sighand->siglock))
 		BUG();
 #endif
@@ -846,7 +846,7 @@
 	unsigned int mask;
 	int ret = 0;
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	if (!spin_is_locked(&p->sighand->siglock))
 		BUG();
 #endif
--- linux-2.5.68-bk3/kernel/sched.c.dist	2003-04-22 13:57:48.000000000 -0400
+++ linux-2.5.68-bk3/kernel/sched.c	2003-04-22 14:44:34.028941484 -0400
@@ -863,7 +863,7 @@
 
 #endif /* CONFIG_NUMA */
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 
 /*
  * double_lock_balance - lock the busiest runqueue
@@ -1309,7 +1309,7 @@
 	}
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 		load_balance(rq, 1, cpu_to_node_mask(smp_processor_id()));
 		if (rq->nr_running)
 			goto pick_next_task;
@@ -1440,7 +1440,7 @@
 	__wake_up_common(q, mode, 1, 0);
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 
 /**
  * __wake_up - sync- wake up threads blocked on a waitqueue.
@@ -2261,7 +2261,7 @@
 #endif
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 /*
  * This is how migration works:
  *
@@ -2443,7 +2443,7 @@
 
 #endif
 
-#if CONFIG_SMP || CONFIG_PREEMPT
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 /*
  * The 'big kernel lock'
  *
--- linux-2.5.68-bk3/kernel/timer.c.dist	2003-04-22 13:57:48.000000000 -0400
+++ linux-2.5.68-bk3/kernel/timer.c	2003-04-22 14:44:49.339605830 -0400
@@ -905,7 +905,7 @@
 	parent = me->group_leader->real_parent;
 	for (;;) {
 		pid = parent->tgid;
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 {
 		struct task_struct *old = parent;
 
--- linux-2.5.68-bk3/kernel/exit.c.dist	2003-04-07 13:32:28.000000000 -0400
+++ linux-2.5.68-bk3/kernel/exit.c	2003-04-22 14:45:13.662235585 -0400
@@ -756,7 +756,7 @@
 	struct pid_link *link = p->pids + PIDTYPE_TGID;
 	struct list_head *tmp, *head = &link->pidptr->task_list;
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	if (!p->sighand)
 		BUG();
 	if (!spin_is_locked(&p->sighand->siglock) &&
--- linux-2.5.68-bk3/mm/page_alloc.c.dist	2003-04-22 13:57:48.000000000 -0400
+++ linux-2.5.68-bk3/mm/page_alloc.c	2003-04-22 14:47:27.012380673 -0400
@@ -786,7 +786,7 @@
 	return nr_free_zone_pages(GFP_HIGHUSER & GFP_ZONEMASK);
 }
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 unsigned int nr_free_highpages (void)
 {
 	pg_data_t *pgdat;

