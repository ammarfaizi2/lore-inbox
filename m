Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTLTVIq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 16:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLTVIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 16:08:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:7404 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261500AbTLTVIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 16:08:31 -0500
Date: Sat, 20 Dec 2003 22:07:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] 2.6.0 sched style fixes
Message-ID: <20031220210759.GA2262@elte.hu>
References: <3FE46885.2030905@cyberone.com.au> <3FE468BF.9000102@cyberone.com.au> <3FE468F5.7020501@cyberone.com.au> <3FE46930.1020504@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <3FE46930.1020504@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Nick Piggin <piggin@cyberone.com.au> wrote:

> Couple of small spacing and indentation changes

agreed. While were are at, there's much more coding style errors and
inconsistencies that accumulated up in sched.c during the past couple of
months. The attached patch includes your cleanups and mine as well.

	Ingo

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-style-2.6.0-A3"

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -79,13 +79,13 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define ON_RUNQUEUE_WEIGHT	30
-#define CHILD_PENALTY		95
+#define ON_RUNQUEUE_WEIGHT	 30
+#define CHILD_PENALTY		 95
 #define PARENT_PENALTY		100
-#define EXIT_WEIGHT		3
-#define PRIO_BONUS_RATIO	25
+#define EXIT_WEIGHT		  3
+#define PRIO_BONUS_RATIO	 25
 #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
-#define INTERACTIVE_DELTA	2
+#define INTERACTIVE_DELTA	  2
 #define MAX_SLEEP_AVG		(AVG_TIMESLICE * MAX_BONUS)
 #define STARVATION_LIMIT	(MAX_SLEEP_AVG)
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
@@ -143,7 +143,7 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
-#define JUST_INTERACTIVE_SLEEP(p) \
+#define INTERACTIVE_SLEEP(p) \
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
 		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
@@ -168,7 +168,8 @@
  */
 
 #define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
+		((MAX_TIMESLICE - MIN_TIMESLICE) * \
+			(MAX_PRIO-1 - (p)->static_prio) / (MAX_USER_PRIO-1)))
 
 static inline unsigned int task_timeslice(task_t *p)
 {
@@ -199,7 +200,7 @@ struct prio_array {
 struct runqueue {
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
-			nr_uninterruptible, timestamp_last_tick;
+		      nr_uninterruptible, timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
@@ -225,7 +226,7 @@ static DEFINE_PER_CPU(struct runqueue, r
  * Default context-switch locking:
  */
 #ifndef prepare_arch_switch
-# define prepare_arch_switch(rq, next)	do { } while(0)
+# define prepare_arch_switch(rq, next)	do { } while (0)
 # define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
@@ -269,9 +270,9 @@ __init void node_nr_running_init(void)
 
 #else /* !CONFIG_NUMA */
 
-# define nr_running_init(rq)   do { } while (0)
-# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
-# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+# define nr_running_init(rq)	do { } while (0)
+# define nr_running_inc(rq)	do { (rq)->nr_running++; } while (0)
+# define nr_running_dec(rq)	do { (rq)->nr_running--; } while (0)
 
 #endif /* CONFIG_NUMA */
 
@@ -396,7 +397,7 @@ static void recalc_task_prio(task_t *p, 
 		 * other processes.
 		 */
 		if (p->mm && p->activated != -1 &&
-			sleep_time > JUST_INTERACTIVE_SLEEP(p)){
+			sleep_time > INTERACTIVE_SLEEP(p)) {
 				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
 						AVG_TIMESLICE);
 				if (!HIGH_CREDIT(p))
@@ -413,37 +414,35 @@ static void recalc_task_prio(task_t *p, 
 			 * one timeslice worth of sleep avg bonus.
 			 */
 			if (LOW_CREDIT(p) &&
-				sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
-					sleep_time =
-						JIFFIES_TO_NS(task_timeslice(p));
+			    sleep_time > JIFFIES_TO_NS(task_timeslice(p)))
+				sleep_time = JIFFIES_TO_NS(task_timeslice(p));
 
 			/*
 			 * Non high_credit tasks waking from uninterruptible
 			 * sleep are limited in their sleep_avg rise as they
 			 * are likely to be cpu hogs waiting on I/O
 			 */
-			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm){
-				if (p->sleep_avg >= JUST_INTERACTIVE_SLEEP(p))
+			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm) {
+				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
 					sleep_time = 0;
 				else if (p->sleep_avg + sleep_time >=
-					JUST_INTERACTIVE_SLEEP(p)){
-						p->sleep_avg =
-							JUST_INTERACTIVE_SLEEP(p);
-						sleep_time = 0;
-					}
+						INTERACTIVE_SLEEP(p)) {
+					p->sleep_avg = INTERACTIVE_SLEEP(p);
+					sleep_time = 0;
+				}
 			}
 
 			/*
 			 * This code gives a bonus to interactive tasks.
 			 *
 			 * The boost works by updating the 'average sleep time'
-			 * value here, based on ->timestamp. The more time a task
-			 * spends sleeping, the higher the average gets - and the
-			 * higher the priority boost gets as well.
+			 * value here, based on ->timestamp. The more time a
+			 * task spends sleeping, the higher the average gets -
+			 * and the higher the priority boost gets as well.
 			 */
 			p->sleep_avg += sleep_time;
 
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG){
+			if (p->sleep_avg > NS_MAX_SLEEP_AVG) {
 				p->sleep_avg = NS_MAX_SLEEP_AVG;
 				if (!HIGH_CREDIT(p))
 					p->interactive_credit++;
@@ -470,7 +469,7 @@ static inline void activate_task(task_t 
 	 * This checks to make sure it's not an uninterruptible task
 	 * that is now waking up.
 	 */
-	if (!p->activated){
+	if (!p->activated) {
 		/*
 		 * Tasks which were woken up by interrupts (ie. hw events)
 		 * are most likely of interactive nature. So we give them
@@ -480,13 +479,14 @@ static inline void activate_task(task_t 
 		 */
 		if (in_interrupt())
 			p->activated = 2;
-		else
-		/*
-		 * Normal first-time wakeups get a credit too for on-runqueue
-		 * time, but it will be weighted down:
-		 */
+		else {
+			/*
+			 * Normal first-time wakeups get a credit too for
+			 * on-runqueue time, but it will be weighted down:
+			 */
 			p->activated = 1;
 		}
+	}
 	p->timestamp = now;
 
 	__activate_task(p, rq);
@@ -632,13 +632,14 @@ repeat_lock_task:
 			 */
 			if (unlikely(sync && !task_running(rq, p) &&
 				(task_cpu(p) != smp_processor_id()) &&
-				cpu_isset(smp_processor_id(), p->cpus_allowed))) {
+					cpu_isset(smp_processor_id(),
+							p->cpus_allowed))) {
 
 				set_task_cpu(p, smp_processor_id());
 				task_rq_unlock(rq, &flags);
 				goto repeat_lock_task;
 			}
-			if (old_state == TASK_UNINTERRUPTIBLE){
+			if (old_state == TASK_UNINTERRUPTIBLE) {
 				rq->nr_uninterruptible--;
 				/*
 				 * Tasks on involuntary sleep don't earn
@@ -663,7 +664,8 @@ repeat_lock_task:
 }
 int wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
+	return try_to_wake_up(p, TASK_STOPPED |
+		       		 TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
 }
 
 EXPORT_SYMBOL(wake_up_process);
@@ -698,7 +700,7 @@ void sched_fork(task_t *p)
 	 * resulting in more scheduling fairness.
 	 */
 	local_irq_disable();
-        p->time_slice = (current->time_slice + 1) >> 1;
+	p->time_slice = (current->time_slice + 1) >> 1;
 	/*
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
@@ -847,7 +849,8 @@ asmlinkage void schedule_tail(task_t *pr
  * context_switch - switch to the new MM and the new
  * thread's register state.
  */
-static inline task_t * context_switch(runqueue_t *rq, task_t *prev, task_t *next)
+static inline
+task_t * context_switch(runqueue_t *rq, task_t *prev, task_t *next)
 {
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
@@ -995,10 +998,10 @@ static int sched_best_cpu(struct task_st
 	minload = 10000000;
 	for_each_node_with_cpus(i) {
 		/*
-		 * Node load is always divided by nr_cpus_node to normalise 
+		 * Node load is always divided by nr_cpus_node to normalise
 		 * load values in case cpu count differs from node to node.
 		 * We first multiply node_nr_running by 10 to get a little
-		 * better resolution.   
+		 * better resolution.
 		 */
 		load = 10 * atomic_read(&node_nr_running[i]) / nr_cpus_node(i);
 		if (load < minload) {
@@ -1037,7 +1040,7 @@ void sched_balance_exec(void)
  *      load_{t} = load_{t-1}/2 + nr_node_running_{t}
  * This way sudden load peaks are flattened out a bit.
  * Node load is divided by nr_cpus_node() in order to compare nodes
- * of different cpu count but also [first] multiplied by 10 to 
+ * of different cpu count but also [first] multiplied by 10 to
  * provide better resolution.
  */
 static int find_busiest_node(int this_node)
@@ -1075,8 +1078,10 @@ static int find_busiest_node(int this_no
  * this_rq is locked already. Recalculate nr_running if we have to
  * drop the runqueue lock.
  */
-static inline unsigned int double_lock_balance(runqueue_t *this_rq,
-	runqueue_t *busiest, int this_cpu, int idle, unsigned int nr_running)
+static inline
+unsigned int double_lock_balance(runqueue_t *this_rq, runqueue_t *busiest,
+				 int this_cpu, int idle,
+				 unsigned int nr_running)
 {
 	if (unlikely(!spin_trylock(&busiest->lock))) {
 		if (busiest < this_rq) {
@@ -1084,7 +1089,8 @@ static inline unsigned int double_lock_b
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
 			/* Need to recalculate nr_running */
-			if (idle || (this_rq->nr_running > this_rq->prev_cpu_load[this_cpu]))
+			if (idle || (this_rq->nr_running >
+					this_rq->prev_cpu_load[this_cpu]))
 				nr_running = this_rq->nr_running;
 			else
 				nr_running = this_rq->prev_cpu_load[this_cpu];
@@ -1097,7 +1103,9 @@ static inline unsigned int double_lock_b
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in cpumask.
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, cpumask_t cpumask)
+static inline
+runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle,
+			       int *imbalance, cpumask_t cpumask)
 {
 	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
@@ -1159,7 +1167,8 @@ static inline runqueue_t *find_busiest_q
 		goto out;
 	}
 
-	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
+	nr_running = double_lock_balance(this_rq, busiest, this_cpu,
+					 idle, nr_running);
 	/*
 	 * Make sure nothing changed since we checked the
 	 * runqueue length.
@@ -1176,14 +1185,17 @@ out:
  * pull_task - move a task from a remote runqueue to the local runqueue.
  * Both runqueues must be locked.
  */
-static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
+static inline
+void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p,
+	       runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
 	nr_running_dec(src_rq);
 	set_task_cpu(p, this_cpu);
 	nr_running_inc(this_rq);
 	enqueue_task(p, this_rq->active);
-	p->timestamp = sched_clock() - (src_rq->timestamp_last_tick - p->timestamp);
+	p->timestamp = sched_clock() -
+				(src_rq->timestamp_last_tick - p->timestamp);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
@@ -1195,8 +1207,8 @@ static inline void pull_task(runqueue_t 
 /*
  * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
  */
-static inline int
-can_migrate_task(task_t *tsk, runqueue_t *rq, int this_cpu, int idle)
+static inline
+int can_migrate_task(task_t *tsk, runqueue_t *rq, int this_cpu, int idle)
 {
 	unsigned long delta = rq->timestamp_last_tick - tsk->timestamp;
 
@@ -1231,7 +1243,8 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, cpumask);
+	busiest = find_busiest_queue(this_rq, this_cpu, idle,
+				     &imbalance, cpumask);
 	if (!busiest)
 		goto out;
 
@@ -1373,7 +1386,7 @@ static inline void rebalance_tick(runque
 }
 #endif
 
-DEFINE_PER_CPU(struct kernel_stat, kstat) = { { 0 } };
+DEFINE_PER_CPU(struct kernel_stat, kstat);
 
 EXPORT_PER_CPU_SYMBOL(kstat);
 
@@ -1391,7 +1404,7 @@ EXPORT_PER_CPU_SYMBOL(kstat);
 	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
 			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
-				((rq)->curr->static_prio > (rq)->best_expired_prio))
+			((rq)->curr->static_prio > (rq)->best_expired_prio))
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1563,7 +1576,7 @@ need_resched:
 	spin_lock_irq(&rq->lock);
 
 	if (prev->state != TASK_RUNNING &&
-			likely(!(preempt_count() & PREEMPT_ACTIVE)) ) {
+			likely(!(preempt_count() & PREEMPT_ACTIVE))) {
 		if (unlikely(signal_pending(prev)) &&
 				prev->state == TASK_INTERRUPTIBLE)
 			prev->state = TASK_RUNNING;
@@ -1615,7 +1628,7 @@ switch_tasks:
 	RCU_qsctr(task_cpu(prev))++;
 
 	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0){
+	if ((long)prev->sleep_avg <= 0) {
 		prev->sleep_avg = 0;
 		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
 			prev->interactive_credit--;
@@ -1697,7 +1710,8 @@ EXPORT_SYMBOL(default_wake_function);
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
+static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
+			     int nr_exclusive, int sync)
 {
 	struct list_head *tmp, *next;
 
@@ -1774,7 +1788,8 @@ void complete(struct completion *x)
 
 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, 0);
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
+			 1, 0);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
@@ -1786,7 +1801,8 @@ void complete_all(struct completion *x)
 
 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done += UINT_MAX/2;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, 0);
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
+			 0, 0);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
@@ -1813,9 +1829,9 @@ void wait_for_completion(struct completi
 
 EXPORT_SYMBOL(wait_for_completion);
 
-#define	SLEEP_ON_VAR				\
-	unsigned long flags;			\
-	wait_queue_t wait;			\
+#define	SLEEP_ON_VAR					\
+	unsigned long flags;				\
+	wait_queue_t wait;				\
 	init_waitqueue_entry(&wait, current);
 
 #define SLEEP_ON_HEAD					\
@@ -1823,9 +1839,9 @@ EXPORT_SYMBOL(wait_for_completion);
 	__add_wait_queue(q, &wait);			\
 	spin_unlock(&q->lock);
 
-#define	SLEEP_ON_TAIL						\
-	spin_lock_irq(&q->lock);				\
-	__remove_wait_queue(q, &wait);				\
+#define	SLEEP_ON_TAIL					\
+	spin_lock_irq(&q->lock);			\
+	__remove_wait_queue(q, &wait);			\
 	spin_unlock_irqrestore(&q->lock, flags);
 
 void interruptible_sleep_on(wait_queue_head_t *q)
@@ -1950,9 +1966,9 @@ asmlinkage long sys_nice(int increment)
 	long nice;
 
 	/*
-	 *	Setpriority might change our priority at the same moment.
-	 *	We don't have to worry. Conceptually one call occurs first
-	 *	and we have a single winner.
+	 * Setpriority might change our priority at the same moment.
+	 * We don't have to worry. Conceptually one call occurs first
+	 * and we have a single winner.
 	 */
 	if (increment < 0) {
 		if (!capable(CAP_SYS_NICE))
@@ -2132,7 +2148,7 @@ out_nounlock:
  * @param: structure containing the new RT priority.
  */
 asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
-				      struct sched_param __user *param)
+				       struct sched_param __user *param)
 {
 	return setscheduler(pid, policy, param);
 }
@@ -2439,7 +2455,8 @@ asmlinkage long sys_sched_get_priority_m
  * this syscall writes the default timeslice value of a given process
  * into the user-space timespec buffer. A value of '0' means infinity.
  */
-asmlinkage long sys_sched_rr_get_interval(pid_t pid, struct timespec __user *interval)
+asmlinkage
+long sys_sched_rr_get_interval(pid_t pid, struct timespec __user *interval)
 {
 	int retval = -EINVAL;
 	struct timespec t;
@@ -2512,10 +2529,10 @@ static void show_task(task_t * p)
 		printk(" %016lx ", thread_saved_pc(p));
 #endif
 	{
-		unsigned long * n = (unsigned long *) (p->thread_info+1);
+		unsigned long * n = (unsigned long *)(p->thread_info+1);
 		while (!*n)
 			n++;
-		free = (unsigned long) n - (unsigned long)(p->thread_info+1);
+		free = (unsigned long)n - (unsigned long)(p->thread_info+1);
 	}
 	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
 	if ((relative = eldest_child(p)))
@@ -2685,7 +2702,7 @@ static void move_task_away(struct task_s
 	}
 	p->timestamp = rq_dest->timestamp_last_tick;
 
- out:
+out:
 	double_rq_unlock(this_rq(), rq_dest);
 	local_irq_restore(flags);
 }
@@ -2754,11 +2771,10 @@ static int migration_thread(void * data)
  * migration_call - callback that gets triggered when a CPU is added.
  * Here we can start up the necessary migration thread for the new CPU.
  */
-static int migration_call(struct notifier_block *nfb,
-			  unsigned long action,
+static int migration_call(struct notifier_block *nfb, unsigned long action,
 			  void *hcpu)
 {
-	long cpu = (long) hcpu;
+	long cpu = (long)hcpu;
 	migration_startup_t startup;
 
 	switch (action) {
@@ -2787,7 +2803,8 @@ static int migration_call(struct notifie
 	return NOTIFY_OK;
 }
 
-static struct notifier_block migration_notifier = { &migration_call, NULL, 0 };
+static struct notifier_block migration_notifier
+			= { .notifier_call = &migration_call };
 
 __init int migration_init(void)
 {
@@ -2823,7 +2840,7 @@ static void kstat_init_cpu(int cpu)
 }
 
 static int __devinit kstat_cpu_notify(struct notifier_block *self,
-					unsigned long action, void *hcpu)
+				      unsigned long action, void *hcpu)
 {
 	int cpu = (unsigned long)hcpu;
 	switch(action) {
@@ -2837,13 +2854,14 @@ static int __devinit kstat_cpu_notify(st
 }
 
 static struct notifier_block __devinitdata kstat_nb = {
-	.notifier_call  = kstat_cpu_notify,
-	.next           = NULL,
+	.notifier_call	= kstat_cpu_notify,
+	.next		= NULL,
 };
 
-__init static void init_kstat(void) {
+__init static void init_kstat(void)
+{
 	kstat_cpu_notify(&kstat_nb, (unsigned long)CPU_UP_PREPARE,
-			(void *)(long)smp_processor_id());
+			 (void *)(long)smp_processor_id());
 	register_cpu_notifier(&kstat_nb);
 }
 
@@ -2909,7 +2927,7 @@ void __might_sleep(char *file, int line)
 		printk(KERN_ERR "Debug: sleeping function called from invalid"
 				" context at %s:%d\n", file, line);
 		printk("in_atomic():%d, irqs_disabled():%d\n",
-				in_atomic(), irqs_disabled());
+			in_atomic(), irqs_disabled());
 		dump_stack();
 	}
 #endif

--xHFwDpU9dbj6ez1V--
