Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVEKDGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVEKDGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 23:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVEKDGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 23:06:35 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:12256 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261883AbVEKDD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 23:03:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: AndrewMorton <akpm@osdl.org>
Subject: [SMP NICE] [PATCH 2/2] SCHED: Make SMP nice a config option
Date: Wed, 11 May 2005 13:05:48 +1000
User-Agent: KMail/1.8
Cc: Carlos Carvalho <carlos@fisica.ufpr.br>, ck@vds.kolivas.org,
       Ingo Molnar <mingo@elte.hu>,
       Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org
References: <20050509112446.GZ1399@nysv.org> <17023.63512.319555.552924@fisica.ufpr.br> <200505111304.06853.kernel@kolivas.org>
In-Reply-To: <200505111304.06853.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MaXgCU04Dzn9CKv"
Message-Id: <200505111305.48610.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_MaXgCU04Dzn9CKv
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_MaXgCU04Dzn9CKv
Content-Type: text/x-diff;
  charset="iso-8859-6";
  name="make_smp_nice_config_option.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="make_smp_nice_config_option.diff"

Certain configurations may not need the SMP nice balancing scheme and would
prefer SMP balancing to be based purely on throughput. Make SMP nice support
a config option which disables priority bias for SMP balancing and priority
based SMT sibling sleeps.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.12-rc4-smpnice/arch/alpha/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/alpha/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/alpha/Kconfig	2005-05-11 12:25:40.000000000 +1000
@@ -498,6 +498,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config HAVE_DEC_LOCK
 	bool
 	depends on SMP
Index: linux-2.6.12-rc4-smpnice/arch/arm/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/arm/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/arm/Kconfig	2005-05-11 12:26:21.000000000 +1000
@@ -324,6 +324,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
Index: linux-2.6.12-rc4-smpnice/arch/i386/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/i386/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/i386/Kconfig	2005-05-11 12:26:05.000000000 +1000
@@ -487,6 +487,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-255)"
 	range 2 255
Index: linux-2.6.12-rc4-smpnice/arch/ia64/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/ia64/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/ia64/Kconfig	2005-05-11 12:28:03.000000000 +1000
@@ -253,6 +253,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-512)"
 	range 2 512
Index: linux-2.6.12-rc4-smpnice/arch/m32r/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/m32r/Kconfig	2005-03-02 18:37:30.000000000 +1100
+++ linux-2.6.12-rc4-smpnice/arch/m32r/Kconfig	2005-05-11 12:27:56.000000000 +1000
@@ -241,6 +241,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config CHIP_M32700_TS1
 	bool "Workaround code for the M32700 TS1 chip's bug"
 	depends on (CHIP_M32700 && SMP)
Index: linux-2.6.12-rc4-smpnice/arch/mips/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/mips/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/mips/Kconfig	2005-05-11 12:27:48.000000000 +1000
@@ -1438,6 +1438,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
 	range 2 64
Index: linux-2.6.12-rc4-smpnice/arch/parisc/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/parisc/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/parisc/Kconfig	2005-05-11 12:27:40.000000000 +1000
@@ -143,6 +143,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config HOTPLUG_CPU
 	bool
 	default y if SMP
Index: linux-2.6.12-rc4-smpnice/arch/ppc/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/ppc/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/ppc/Kconfig	2005-05-11 12:27:32.000000000 +1000
@@ -882,6 +882,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
 	depends on SMP
Index: linux-2.6.12-rc4-smpnice/arch/ppc64/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/ppc64/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/ppc64/Kconfig	2005-05-11 12:27:26.000000000 +1000
@@ -185,6 +185,19 @@ config SMP
 
 	  If you don't know what to do here, say Y.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-128)"
 	range 2 128
Index: linux-2.6.12-rc4-smpnice/arch/s390/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/s390/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/s390/Kconfig	2005-05-11 12:27:19.000000000 +1000
@@ -70,6 +70,19 @@ config SMP
 
 	  Even if you don't know what to do here, say Y.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
 	range 2 64
Index: linux-2.6.12-rc4-smpnice/arch/sh/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/sh/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/sh/Kconfig	2005-05-11 12:27:10.000000000 +1000
@@ -605,6 +605,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
Index: linux-2.6.12-rc4-smpnice/arch/sparc/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/sparc/Kconfig	2005-03-02 18:37:30.000000000 +1100
+++ linux-2.6.12-rc4-smpnice/arch/sparc/Kconfig	2005-05-11 12:27:00.000000000 +1000
@@ -105,6 +105,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
Index: linux-2.6.12-rc4-smpnice/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/sparc64/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/sparc64/Kconfig	2005-05-11 12:26:51.000000000 +1000
@@ -144,6 +144,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
Index: linux-2.6.12-rc4-smpnice/arch/um/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/um/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/um/Kconfig	2005-05-11 12:26:34.000000000 +1000
@@ -211,6 +211,19 @@ config SMP
 
 	If you don't know what to do, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
Index: linux-2.6.12-rc4-smpnice/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/arch/x86_64/Kconfig	2005-05-11 11:45:42.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/arch/x86_64/Kconfig	2005-05-11 12:25:02.000000000 +1000
@@ -207,6 +207,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_NICE
+	bool "SMP support for nice levels across cpus"
+	depends on SMP
+	default y
+	---help---
+	  This option supports a degree of unbalancing of cpus according to
+	  processes' nice levels. Disabling this option on dedicated single
+	  purpose servers may improve throughput slightly but cpu resource
+	  sharing according to 'nice' across physical or logical cpus will
+	  be lost.
+
+	  If unsure say Y
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	---help---
Index: linux-2.6.12-rc4-smpnice/kernel/sched.c
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/kernel/sched.c	2005-05-11 12:20:45.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/kernel/sched.c	2005-05-11 12:29:15.000000000 +1000
@@ -605,7 +605,7 @@ static int effective_prio(task_t *p)
 	return prio;
 }
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_SMP_NICE
 static inline void inc_prio_bias(runqueue_t *rq, int static_prio)
 {
 	rq->prio_bias += MAX_PRIO - static_prio;
@@ -615,7 +615,7 @@ static inline void dec_prio_bias(runqueu
 {
 	rq->prio_bias -= MAX_PRIO - static_prio;
 }
-#else
+#else	/* !CONFIG_SMP_NICE */
 static inline void inc_prio_bias(runqueue_t *rq, int static_prio)
 {
 }
@@ -925,6 +925,7 @@ static inline unsigned long source_load(
 	unsigned long cpu_load = rq->cpu_load,
 		load_now = rq->nr_running * SCHED_LOAD_SCALE;
 
+#ifdef CONFIG_SMP_NICE
 	if (idle == NOT_IDLE) {
 		/*
 		 * If we are balancing busy runqueues the load is biased by
@@ -933,6 +934,7 @@ static inline unsigned long source_load(
 		cpu_load *= rq->prio_bias;
 		load_now *= rq->prio_bias;
 	}
+#endif
 	return min(cpu_load, load_now);
 }
 
@@ -945,10 +947,12 @@ static inline unsigned long target_load(
 	unsigned long cpu_load = rq->cpu_load,
 		load_now = rq->nr_running * SCHED_LOAD_SCALE;
 
+#ifdef CONFIG_SMP_NICE
 	if (idle == NOT_IDLE) {
 		cpu_load *= rq->prio_bias;
 		load_now *= rq->prio_bias;
 	}
+#endif
 	return max(cpu_load, load_now);
 }
 
@@ -2255,7 +2259,7 @@ static inline void idle_balance(int cpu,
 static inline int wake_priority_sleeper(runqueue_t *rq)
 {
 	int ret = 0;
-#ifdef CONFIG_SCHED_SMT
+#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_SMP_NICE)
 	spin_lock(&rq->lock);
 	/*
 	 * If an SMT sibling task has been put to sleep for priority
@@ -2491,7 +2495,7 @@ out:
 	rebalance_tick(cpu, rq, NOT_IDLE);
 }
 
-#ifdef CONFIG_SCHED_SMT
+#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_SMP_NICE)
 static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *sd = this_rq->sd;
@@ -2605,7 +2609,7 @@ out_unlock:
 		spin_unlock(&cpu_rq(i)->lock);
 	return ret;
 }
-#else
+#else	/* !(CONFIG_SCHED_SMT && CONFIG_SMP_NICE) */
 static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
 }

--Boundary-00=_MaXgCU04Dzn9CKv--
