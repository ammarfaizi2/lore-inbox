Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268314AbTBMWtR>; Thu, 13 Feb 2003 17:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268313AbTBMWtO>; Thu, 13 Feb 2003 17:49:14 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46573 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268310AbTBMWso>; Thu, 13 Feb 2003 17:48:44 -0500
Date: Thu, 13 Feb 2003 14:57:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: lse-tech <lse-tech@lists.sourceforge.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: breaking down the performance of D7 scheduler patch
Message-ID: <7790000.1045177072@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1812079384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1812079384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Rick broke the non HT parts of D7 out into patches 2,3,4,5 for us.
This has been useful in all sorts of ways ...
http://marc.theaimsgroup.com/?l=lse-tech&m=104436251927067&w=2
(I'll attatch his patches here for convenience, they're small, and I don't
trust the archives not to munge them).

Below I've done two runs on each interesting combo (2 is a no-op).
Overall results are a slight improvement in kernbench and a degredation
in SDET. My impressions from the data below (16x NUMA-Q)

3 - gives a good boost to kernbench, marginal degreadation on SDET.
4 - doesn't do much.
5 - gives some degredation to kernebench, most of the degredation of SDET.

Conclusion: 3 = good (mostly). 5 = bad.

key:

                 2.5.59 - virgin
          2.5.59-sched3 - patch 2 & 3
        2.5.59-sched3-2 - patch 2 & 3
          2.5.59-sched4 - patch 2 & 3 & 4
        2.5.59-sched4-2 - patch 2 & 3 & 4
       2.5.59-ricksched - patch 2 & 3 & 4 & 5
      2.5.59-ricksched2 - patch 2 & 3 & 4 & 5

Oh, and the runs for 4-2 don't have any schedbench numbers because the
machine crashed, and I'm too lazy to rerun, as it wasn't showing much
anyway.

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                            Elapsed        User      System         CPU
                 2.5.59       46.08      563.88      118.38     1480.00
          2.5.59-sched3       46.12      567.52      115.82     1480.83
        2.5.59-sched3-2       46.37      567.81      116.48     1475.00
          2.5.59-sched4       46.00      566.28      116.30     1483.17
        2.5.59-sched4-2       46.30      567.29      117.43     1478.33
       2.5.59-ricksched       46.11      568.54      117.21     1486.67
      2.5.59-ricksched2       46.54      568.72      117.43     1473.50

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                            Elapsed        User      System         CPU
                 2.5.59       47.45      568.02      143.17     1498.17
          2.5.59-sched3       47.59      573.48      139.78     1498.33
        2.5.59-sched3-2       47.61      573.63      139.97     1498.17
          2.5.59-sched4       47.65      573.47      140.47     1497.67
        2.5.59-sched4-2       47.73      573.62      141.07     1496.83
       2.5.59-ricksched       47.16      571.72      140.02     1508.50
      2.5.59-ricksched2       47.19      571.60      138.00     1503.00

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                         Throughput    Std. Dev
                 2.5.59       100.0%         0.8%
          2.5.59-sched3        98.2%         0.8%
        2.5.59-sched3-2        97.2%         2.1%
          2.5.59-sched4        95.3%         3.5%
        2.5.59-sched4-2        97.1%         3.6%
       2.5.59-ricksched        89.2%         4.3%
      2.5.59-ricksched2        89.4%         2.9%

SDET 2  (see disclaimer)
                         Throughput    Std. Dev
                 2.5.59       100.0%         0.6%
          2.5.59-sched3        93.3%         7.7%
        2.5.59-sched3-2        92.8%         8.5%
          2.5.59-sched4        91.0%        10.1%
        2.5.59-sched4-2        96.4%         7.4%
       2.5.59-ricksched        89.7%         5.6%
      2.5.59-ricksched2        84.5%         2.1%

SDET 4  (see disclaimer)
                         Throughput    Std. Dev
                 2.5.59       100.0%         5.7%
          2.5.59-sched3        96.9%         4.4%
        2.5.59-sched3-2        98.6%         5.2%
          2.5.59-sched4       102.5%         7.2%
        2.5.59-sched4-2        97.0%         1.6%
       2.5.59-ricksched        91.4%         3.5%
      2.5.59-ricksched2        92.6%         1.5%

SDET 8  (see disclaimer)
                         Throughput    Std. Dev
                 2.5.59       100.0%         1.4%
          2.5.59-sched3       103.7%         4.8%
        2.5.59-sched3-2       102.8%         4.2%
          2.5.59-sched4       104.5%         4.3%
        2.5.59-sched4-2       102.0%         2.9%
       2.5.59-ricksched       102.2%         4.6%
      2.5.59-ricksched2       102.5%         1.1%

SDET 16  (see disclaimer)

                         Throughput    Std. Dev
                 2.5.59       100.0%         1.7%
          2.5.59-sched3        98.9%         1.9%
        2.5.59-sched3-2       101.9%         1.8%
          2.5.59-sched4        99.1%         1.7%
        2.5.59-sched4-2        99.5%         0.9%
       2.5.59-ricksched        98.9%         1.1%
      2.5.59-ricksched2        78.7%        50.1%

SDET 32  (see disclaimer)
                         Throughput    Std. Dev
                 2.5.59       100.0%         1.5%
          2.5.59-sched3        98.9%         2.0%
        2.5.59-sched3-2        99.7%         0.8%
          2.5.59-sched4        97.7%         1.1%
        2.5.59-sched4-2        98.7%         1.4%
       2.5.59-ricksched        96.7%         1.6%
      2.5.59-ricksched2        89.7%        14.9%

SDET 64  (see disclaimer)
                         Throughput    Std. Dev
                 2.5.59       100.0%         0.7%
          2.5.59-sched3        98.8%         0.6%
        2.5.59-sched3-2        98.9%         0.4%
          2.5.59-sched4        97.8%         0.7%
        2.5.59-sched4-2        96.7%         0.9%
       2.5.59-ricksched        98.8%         0.7%
      2.5.59-ricksched2        97.7%         1.1%

SDET 128  (see disclaimer)
                         Throughput    Std. Dev

NUMA schedbench 4:
                            AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59        0.00       38.88       82.78        0.65
          2.5.59-sched3        0.00       30.13       93.10        1.02
        2.5.59-sched3-2        0.00       37.47      111.83        0.69
          2.5.59-sched4        0.00       30.92       90.07        0.90
        2.5.59-sched4-2        0.00       34.20       84.41        0.70
       2.5.59-ricksched        0.00       26.40       69.10        0.68
      2.5.59-ricksched2        0.00       60.15      170.80        0.98

NUMA schedbench 8:
                            AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59        0.00       49.30      247.80        1.93
          2.5.59-sched3        0.00       54.05      306.14        1.50
        2.5.59-sched3-2        0.00       39.71      241.97        2.19
          2.5.59-sched4        0.00       54.05      305.21        1.35
        2.5.59-sched4-2           0           0           0           0
       2.5.59-ricksched        0.00       47.32      261.69        1.59
      2.5.59-ricksched2        0.00       45.88      260.44        1.70

NUMA schedbench 16:
                            AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59        0.00       57.37      843.12        3.77
          2.5.59-sched3        0.00       57.96      849.88        2.81
        2.5.59-sched3-2        0.00       57.85      853.58        3.28
          2.5.59-sched4        0.00       57.63      847.41        2.78
        2.5.59-sched4-2           0           0           0           0
       2.5.59-ricksched        0.00       57.48      850.36        3.19
      2.5.59-ricksched2        0.00       57.29      848.65        4.21

NUMA schedbench 32:
                            AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59        0.00      116.99     1805.79        6.05
          2.5.59-sched3        0.00      120.15     1839.49        6.70
        2.5.59-sched3-2        0.00      126.20     1843.77        6.42
          2.5.59-sched4        0.00      119.90     1825.33        7.05
        2.5.59-sched4-2           0           0           0           0
       2.5.59-ricksched        0.00      122.43     1821.62        6.80
      2.5.59-ricksched2        0.00      125.44     1821.75        6.96

NUMA schedbench 64:
                            AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59        0.00      235.18     3632.73       15.45
          2.5.59-sched3        0.00      238.90     3714.23       17.74
        2.5.59-sched3-2        0.00      235.20     3699.45       18.75
          2.5.59-sched4        0.00      241.24     3689.19       15.65
        2.5.59-sched4-2           0           0           0           0
       2.5.59-ricksched        0.00      242.80     3708.15       16.97
      2.5.59-ricksched2        0.00      235.71     3693.12       16.50

--==========1812079384==========
Content-Type: text/plain; charset=iso-8859-1; name="02-struct_change.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="02-struct_change.txt"; size=2052

diff -ru linux-2.5.59/include/linux/sched.h =
sched-2.5.59-02/include/linux/sched.h
--- linux-2.5.59/include/linux/sched.h	Thu Jan 16 18:21:38 2003
+++ sched-2.5.59-02/include/linux/sched.h	Tue Feb  4 00:30:05 2003
@@ -293,7 +293,7 @@
 	prio_array_t *array;
=20
 	unsigned long sleep_avg;
-	unsigned long sleep_timestamp;
+	unsigned long last_run;
=20
 	unsigned long policy;
 	unsigned long cpus_allowed;
diff -ru linux-2.5.59/kernel/fork.c sched-2.5.59-02/kernel/fork.c
--- linux-2.5.59/kernel/fork.c	Thu Jan 16 18:21:38 2003
+++ sched-2.5.59-02/kernel/fork.c	Tue Feb  4 00:30:06 2003
@@ -876,7 +876,7 @@
 	 */
 	p->first_time_slice =3D 1;
 	current->time_slice >>=3D 1;
-	p->sleep_timestamp =3D jiffies;
+	p->last_run =3D jiffies;
 	if (!current->time_slice) {
 		/*
 	 	 * This case is rare, it happens when the parent has only
diff -ru linux-2.5.59/kernel/sched.c sched-2.5.59-02/kernel/sched.c
--- linux-2.5.59/kernel/sched.c	Thu Jan 16 18:22:29 2003
+++ sched-2.5.59-02/kernel/sched.c	Tue Feb  4 00:30:05 2003
@@ -324,14 +324,14 @@
  */
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long sleep_time =3D jiffies - p->sleep_timestamp;
+	unsigned long sleep_time =3D jiffies - p->last_run;
 	prio_array_t *array =3D rq->active;
=20
 	if (!rt_task(p) && sleep_time) {
 		/*
 		 * This code gives a bonus to interactive tasks. We update
 		 * an 'average sleep time' value here, based on
-		 * sleep_timestamp. The more time a task spends sleeping,
+		 * ->last_run. The more time a task spends sleeping,
 		 * the higher the average gets - and the higher the priority
 		 * boost gets as well.
 		 */
@@ -975,7 +975,7 @@
 	 */
=20
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
+	((jiffies - (p)->last_run > cache_decay_ticks) &&	\
 		!task_running(rq, p) &&					\
 			((p)->cpus_allowed & (1UL << (this_cpu))))
=20
@@ -1160,7 +1160,7 @@
 	rq =3D this_rq();
=20
 	release_kernel_lock(prev);
-	prev->sleep_timestamp =3D jiffies;
+	prev->last_run =3D jiffies;
 	spin_lock_irq(&rq->lock);
=20
 	/*

--==========1812079384==========
Content-Type: text/plain; charset=us-ascii; name="03-tunables.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="03-tunables.txt"; size=1487

diff -ru sched-2.5.59-02/kernel/sched.c sched-2.5.59-03/kernel/sched.c
--- sched-2.5.59-02/kernel/sched.c	Tue Feb  4 00:30:05 2003
+++ sched-2.5.59-03/kernel/sched.c	Tue Feb  4 00:31:43 2003
@@ -54,20 +54,19 @@
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
- * Minimum timeslice is 10 msecs, default timeslice is 150 msecs,
- * maximum timeslice is 300 msecs. Timeslices get refilled after
+ * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
+ * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(300 * HZ / 1000)
-#define CHILD_PENALTY		95
+#define MAX_TIMESLICE		(200 * HZ / 1000)
+#define CHILD_PENALTY		50
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(2*HZ)
-#define STARVATION_LIMIT	(2*HZ)
-#define NODE_THRESHOLD          125
+#define MAX_SLEEP_AVG		(10*HZ)
+#define STARVATION_LIMIT	(30*HZ)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -1035,9 +1034,9 @@
  * increasing number of running tasks:
  */
 #define EXPIRED_STARVING(rq) \
-		((rq)->expired_timestamp && \
+		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))
+			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
 /*
  * This function gets called by the timer code, with HZ frequency.

--==========1812079384==========
Content-Type: text/plain; charset=iso-8859-1; name="04-oldmm.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="04-oldmm.txt"; size=1451

diff -ru sched-2.5.59-03/kernel/sched.c sched-2.5.59-04/kernel/sched.c
--- sched-2.5.59-03/kernel/sched.c	Tue Feb  4 00:31:43 2003
+++ sched-2.5.59-04/kernel/sched.c	Tue Feb  4 00:40:20 2003
@@ -151,6 +151,7 @@
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
 	task_t *curr, *idle;
+	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 #ifdef CONFIG_NUMA
@@ -560,7 +561,7 @@
  * context_switch - switch to the new MM and the new
  * thread's register state.
  */
-static inline task_t * context_switch(task_t *prev, task_t *next)
+static inline task_t * context_switch(runqueue_t *rq, task_t *prev, task_t =
*next)
 {
 	struct mm_struct *mm =3D next->mm;
 	struct mm_struct *oldmm =3D prev->active_mm;
@@ -574,7 +575,7 @@
=20
 	if (unlikely(!prev->mm)) {
 		prev->active_mm =3D NULL;
-		mmdrop(oldmm);
+		rq->prev_mm =3D oldmm;
 	}
=20
 	/* Here we just switch the register state and the stack. */
@@ -1213,14 +1214,19 @@
 	RCU_qsctr(prev->thread_info->cpu)++;
=20
 	if (likely(prev !=3D next)) {
+		struct mm_struct *prev_mm;
 		rq->nr_switches++;
 		rq->curr =3D next;
 	
 		prepare_arch_switch(rq, next);
-		prev =3D context_switch(prev, next);
+		prev =3D context_switch(rq, prev, next);
 		barrier();
 		rq =3D this_rq();
+		prev_mm =3D rq->prev_mm;
+		rq->prev_mm =3D NULL;
 		finish_arch_switch(rq, prev);
+		if (prev_mm)
+			mmdrop(prev_mm);
 	} else
 		spin_unlock_irq(&rq->lock);
=20

--==========1812079384==========
Content-Type: text/plain; charset=iso-8859-1; name="05-activate_task.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="05-activate_task.txt"; size=3374

diff -ru sched-2.5.59-04/kernel/sched.c sched-2.5.59-05/kernel/sched.c
--- sched-2.5.59-04/kernel/sched.c	Tue Feb  4 00:40:20 2003
+++ sched-2.5.59-05/kernel/sched.c	Tue Feb  4 02:24:21 2003
@@ -67,6 +67,8 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(30*HZ)
+#define SYNC_WAKEUPS		1
+#define SMART_WAKE_CHILD	1
=20
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -322,6 +324,13 @@
  * Also update all the scheduling statistics stuff. (sleep average
  * calculation, priority modifiers, etc.)
  */
+static inline void __activate_task(task_t *p, runqueue_t *rq)
+{
+	enqueue_task(p, rq->active);
+	nr_running_inc(rq);
+}
+ =20
+
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	unsigned long sleep_time =3D jiffies - p->last_run;
@@ -340,8 +349,7 @@
 			p->sleep_avg =3D MAX_SLEEP_AVG;
 		p->prio =3D effective_prio(p);
 	}
-	enqueue_task(p, array);
-	nr_running_inc(rq);
+	__activate_task(p, rq);
 }
=20
 /*
@@ -455,6 +463,7 @@
 	long old_state;
 	runqueue_t *rq;
=20
+	sync &=3D SYNC_WAKEUPS;
 repeat_lock_task:
 	rq =3D task_rq_lock(p, &flags);
 	old_state =3D p->state;
@@ -473,10 +482,13 @@
 		}
 		if (old_state =3D=3D TASK_UNINTERRUPTIBLE)
 			rq->nr_uninterruptible--;
-		activate_task(p, rq);
-
-		if (p->prio < rq->curr->prio)
-			resched_task(rq->curr);
+		if (sync)
+			__activate_task(p, rq);
+		else {
+			activate_task(p, rq);
+			if (p->prio < rq->curr->prio)
+				resched_task(rq->curr);
+		}
 		success =3D 1;
 	}
 	p->state =3D TASK_RUNNING;
@@ -512,8 +524,19 @@
 		p->prio =3D effective_prio(p);
 	}
 	set_task_cpu(p, smp_processor_id());
-	activate_task(p, rq);
=20
+	if (SMART_WAKE_CHILD) {
+		if (unlikely(!current->array))
+			__activate_task(p, rq);
+		else {
+			p->prio =3D current->prio;
+			list_add_tail(&p->run_list, &current->run_list);
+			p->array =3D current->array;
+			p->array->nr_active++;
+			nr_running_inc(rq);
+		}
+	} else
+		activate_task(p, rq);
 	rq_unlock(rq);
 }
=20
@@ -790,7 +813,23 @@
=20
 #endif /* CONFIG_NUMA */
=20
-#if CONFIG_SMP
+/*
+ * One of the idle_cpu_tick() and busy_cpu_tick() functions will
+ * get called every timer tick, on every CPU. Our balancing action
+ * frequency and balancing agressivity depends on whether the CPU is
+ * idle or not.
+ *
+ * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
+ * systems with HZ=3D100, every 10 msecs.)
+ */
+#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
+#define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
+
+#if !CONFIG_SMP
+
+static inline void load_balance(runqueue_t *rq, int this_cpu, int idle) { =
}
+
+#else
=20
 /*
  * double_lock_balance - lock the busiest runqueue
@@ -972,6 +1011,9 @@
 	 * 1) running (obviously), or
 	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
 	 * 3) are cache-hot on their current CPU.
+	 *
+	 * (except if we are in idle mode which is a more agressive
+	 * form of rebalancing.)
 	 */
=20
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
@@ -1665,7 +1707,7 @@
 	else
 		p->prio =3D p->static_prio;
 	if (array)
-		activate_task(p, task_rq(p));
+		__activate_task(p, task_rq(p));
=20
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -2297,7 +2339,7 @@
 			set_task_cpu(p, cpu_dest);
 			if (p->array) {
 				deactivate_task(p, rq_src);
-				activate_task(p, rq_dest);
+				__activate_task(p, rq_dest);
 				if (p->prio < rq_dest->curr->prio)
 					resched_task(rq_dest->curr);
 			}

--==========1812079384==========--

