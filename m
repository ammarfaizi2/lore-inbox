Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262680AbTCPPtr>; Sun, 16 Mar 2003 10:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbTCPPtr>; Sun, 16 Mar 2003 10:49:47 -0500
Received: from mx1.elte.hu ([157.181.1.137]:10727 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262680AbTCPPtp>;
	Sun, 16 Mar 2003 10:49:45 -0500
Date: Sun, 16 Mar 2003 17:00:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched-2.5.64-bk10-D0
In-Reply-To: <Pine.LNX.4.44.0303161213200.4930-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303161657420.7403-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch is ontop of the previous -C4 scheduler patch, it
removes/fixes a few whitespaces and removes the MAX_PRIO setting in the
init task path which is unnecessary and which might even lead to bugs -
MAX_PRIO is outside the valid range and technically the init thread is not
an idle thread yet at this point.

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -846,7 +846,7 @@ void sched_balance_exec(void)
 }
 
 /*
- * Find the busiest node. All previous node loads contribute with a 
+ * Find the busiest node. All previous node loads contribute with a
  * geometrically deccaying weight to the load measure:
  *      load_{t} = load_{t-1}/2 + nr_node_running_{t}
  * This way sudden load peaks are flattened out a bit.
@@ -854,7 +854,7 @@ void sched_balance_exec(void)
 static int find_busiest_node(int this_node)
 {
 	int i, node = -1, load, this_load, maxload;
-	
+
 	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
 		+ atomic_read(&node_nr_running[this_node]);
 	this_rq()->prev_node_load[this_node] = this_load;
@@ -1194,8 +1194,8 @@ void scheduler_tick(int user_ticks, int 
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
- 	if (rcu_pending(cpu))
- 		rcu_check_callbacks(cpu, user_ticks);
+	if (rcu_pending(cpu))
+		rcu_check_callbacks(cpu, user_ticks);
 
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
@@ -1353,7 +1353,7 @@ switch_tasks:
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-	
+
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
@@ -1483,7 +1483,7 @@ void __wake_up_sync(wait_queue_head_t *q
 }
 
 #endif
- 
+
 void complete(struct completion *x)
 {
 	unsigned long flags;
@@ -1567,7 +1567,7 @@ long interruptible_sleep_on_timeout(wait
 void sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
-	
+
 	current->state = TASK_UNINTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
@@ -1578,7 +1578,7 @@ void sleep_on(wait_queue_head_t *q)
 long sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
-	
+
 	current->state = TASK_UNINTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
@@ -2472,12 +2472,12 @@ spinlock_t kernel_flag __cacheline_align
 
 static void kstat_init_cpu(int cpu)
 {
-        /* Add any initialisation to kstat here */
-        /* Useful when cpu offlining logic is added.. */
+	/* Add any initialisation to kstat here */
+	/* Useful when cpu offlining logic is added.. */
 }
 
 static int __devinit kstat_cpu_notify(struct notifier_block *self,
-                                unsigned long action, void *hcpu)
+					unsigned long action, void *hcpu)
 {
 	int cpu = (unsigned long)hcpu;
 	switch(action) {
@@ -2489,7 +2489,7 @@ static int __devinit kstat_cpu_notify(st
 	}
 	return NOTIFY_OK;
 }
- 
+
 static struct notifier_block __devinitdata kstat_nb = {
 	.notifier_call  = kstat_cpu_notify,
 	.next           = NULL,
@@ -2498,7 +2498,7 @@ static struct notifier_block __devinitda
 __init static void init_kstat(void) {
 	kstat_cpu_notify(&kstat_nb, (unsigned long)CPU_UP_PREPARE,
 			(void *)(long)smp_processor_id());
-	register_cpu_notifier(&kstat_nb);  
+	register_cpu_notifier(&kstat_nb);
 }
 
 void __init sched_init(void)
@@ -2538,7 +2538,6 @@ void __init sched_init(void)
 	rq->idle = current;
 	set_task_cpu(current, smp_processor_id());
 	wake_up_forked_process(current);
-	current->prio = MAX_PRIO;
 
 	init_timers();
 

