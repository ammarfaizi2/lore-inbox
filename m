Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTB0Taz>; Thu, 27 Feb 2003 14:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTB0Taz>; Thu, 27 Feb 2003 14:30:55 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33411 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266686AbTB0Tao>; Thu, 27 Feb 2003 14:30:44 -0500
Message-Id: <200302271940.h1RJexJT010415@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.63 - if/ifdef janitor work - kernel/*
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1350185843P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Feb 2003 14:40:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1350185843P
Content-Type: text/plain; charset=us-ascii

Cleaning up kernel/*

--- kernel/sched.c.dist	2003-02-24 14:05:40.000000000 -0500
+++ kernel/sched.c	2003-02-27 02:05:52.041106052 -0500
@@ -712,7 +712,7 @@
 		spin_unlock(&rq2->lock);
 }
 
-#if CONFIG_NUMA
+#ifdef CONFIG_NUMA
 /*
  * If dest_cpu is allowed for this process, migrate the task to it.
  * This is accomplished by forcing the cpu_allowed mask to only
@@ -831,7 +831,7 @@
 
 #endif /* CONFIG_NUMA */
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 
 /*
  * double_lock_balance - lock the busiest runqueue
@@ -1104,7 +1104,7 @@
 			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
 		else
 			kstat_cpu(cpu).cpustat.idle += sys_ticks;
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 		idle_tick(rq);
 #endif
 		return;
@@ -1162,7 +1162,7 @@
 			enqueue_task(p, rq->active);
 	}
 out:
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	if (!(jiffies % BUSY_REBALANCE_TICK))
 		load_balance(rq, 0);
 #endif
@@ -1224,7 +1224,7 @@
 	}
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 		load_balance(rq, 1);
 		if (rq->nr_running)
 			goto pick_next_task;
@@ -1358,7 +1358,7 @@
 	__wake_up_common(q, mode, 1, 0);
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 
 /**
  * __wake_up - sync- wake up threads blocked on a waitqueue.
@@ -2172,14 +2172,14 @@
 	local_irq_restore(flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
 #else
 	idle->thread_info->preempt_count = 0;
 #endif
 }
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 /*
  * This is how migration works:
  *
@@ -2360,7 +2360,7 @@
 
 #endif
 
-#if CONFIG_SMP || CONFIG_PREEMPT
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 /*
  * The 'big kernel lock'
  *
--- kernel/ksyms.c.dist	2003-02-24 14:05:05.000000000 -0500
+++ kernel/ksyms.c	2003-02-27 02:07:32.099909144 -0500
@@ -462,7 +462,7 @@
 EXPORT_SYMBOL(complete_and_exit);
 EXPORT_SYMBOL(default_wake_function);
 EXPORT_SYMBOL(__wake_up);
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 EXPORT_SYMBOL_GPL(__wake_up_sync); /* internal use only */
 #endif
 EXPORT_SYMBOL(wake_up_process);
@@ -480,10 +480,10 @@
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
--- kernel/signal.c.dist	2003-02-24 14:05:16.000000000 -0500
+++ kernel/signal.c	2003-02-27 02:08:20.382225584 -0500
@@ -756,7 +756,7 @@
 
 	if (!irqs_disabled())
 		BUG();
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	if (!spin_is_locked(&t->sighand->siglock))
 		BUG();
 #endif
@@ -841,7 +841,7 @@
 	unsigned int mask;
 	int ret = 0;
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	if (!spin_is_locked(&p->sighand->siglock))
 		BUG();
 #endif
--- kernel/timer.c.dist	2003-02-24 14:05:41.000000000 -0500
+++ kernel/timer.c	2003-02-27 02:09:30.883609988 -0500
@@ -412,7 +412,7 @@
 
 			list_del(&timer->entry);
 			timer->base = NULL;
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 			base->running_timer = timer;
 #endif
 			spin_unlock_irq(&base->lock);
@@ -426,7 +426,7 @@
 		++base->timer_jiffies; 
 		base->tv1.index = (base->tv1.index + 1) & TVR_MASK;
 	}
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	base->running_timer = NULL;
 #endif
 	spin_unlock_irq(&base->lock);
@@ -894,7 +894,7 @@
 	parent = me->group_leader->real_parent;
 	for (;;) {
 		pid = parent->tgid;
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 {
 		struct task_struct *old = parent;
 
--- kernel/exit.c.dist	2003-02-24 14:05:42.000000000 -0500
+++ kernel/exit.c	2003-02-27 02:10:15.777764804 -0500
@@ -756,7 +756,7 @@
 	struct pid_link *link = p->pids + PIDTYPE_TGID;
 	struct list_head *tmp, *head = &link->pidptr->task_list;
 
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 	if (!p->sighand)
 		BUG();
 	if (!spin_is_locked(&p->sighand->siglock) &&



--==_Exmh_1350185843P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+XmnLcC3lWbTT17ARAvrhAJwM1Eq9x5NyevGhQwZbaFeX4d5W0ACeOCeE
OZBT/80PI5XKGmdgOpU3WMw=
=Yvsw
-----END PGP SIGNATURE-----

--==_Exmh_1350185843P--
