Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWCPEMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWCPEMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 23:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbWCPEMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 23:12:17 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:9669 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751983AbWCPEMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 23:12:16 -0500
Date: Thu, 16 Mar 2006 13:11:05 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] for_each_possible_cpu [12/19] powerpc
Message-Id: <20060316131105.f99a0f1c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060316123228.e9e292a4.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060316123228.e9e292a4.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry...looks I failed to refresh patch...
This is valid one.

This patch replaces for_each_cpu with for_each_possible_cpu.


 arch/powerpc/kernel/irq.c               |    2 +-
 arch/powerpc/kernel/lparcfg.c           |    4 ++--
 arch/powerpc/kernel/rtas.c              |    4 ++--
 arch/powerpc/kernel/setup-common.c      |    2 +-
 arch/powerpc/kernel/setup_32.c          |    2 +-
 arch/powerpc/kernel/setup_64.c          |    6 +++---
 arch/powerpc/kernel/smp.c               |    2 +-
 arch/powerpc/kernel/sysfs.c             |    6 +++---
 arch/powerpc/kernel/time.c              |    4 ++--
 arch/powerpc/mm/numa.c                  |    2 +-
 arch/powerpc/mm/stab.c                  |    2 +-
 arch/powerpc/platforms/cell/interrupt.c |    2 +-
 arch/powerpc/platforms/cell/pervasive.c |    2 +-
 arch/powerpc/platforms/pseries/xics.c   |    2 +-
 include/asm-powerpc/percpu.h            |    2 +-
 15 files changed, 22 insertions(+), 22 deletions(-)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc6-mm1/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/kernel/irq.c
@@ -379,7 +379,7 @@ void irq_ctx_init(void)
 	struct thread_info *tp;
 	int i;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
 		tp = softirq_ctx[i];
 		tp->cpu = i;
Index: linux-2.6.16-rc6-mm1/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/kernel/smp.c
@@ -362,7 +362,7 @@ void __init smp_prepare_cpus(unsigned in
  
 	smp_space_timers(max_cpus);
 
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		if (cpu != boot_cpuid)
 			smp_create_idle(cpu);
 }
Index: linux-2.6.16-rc6-mm1/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/kernel/time.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/kernel/time.c
@@ -261,7 +261,7 @@ void snapshot_timebases(void)
 
 	if (!cpu_has_feature(CPU_FTR_PURR))
 		return;
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		spin_lock_init(&per_cpu(cpu_purr_data, cpu).lock);
 	on_each_cpu(snapshot_tb_and_purr, NULL, 0, 1);
 }
@@ -741,7 +741,7 @@ void __init smp_space_timers(unsigned in
 	 * systems works better if the two threads' timebase interrupts
 	 * are staggered by half a jiffy with respect to each other.
 	 */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		if (i == boot_cpuid)
 			continue;
 		if (i == (boot_cpuid ^ 1))
Index: linux-2.6.16-rc6-mm1/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/mm/numa.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/mm/numa.c
@@ -398,7 +398,7 @@ static int __init parse_numa_properties(
 	 * As a result of hotplug we could still have cpus appear later on
 	 * with larger node ids. In that case we force the cpu into node 0.
 	 */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		int numa_domain;
 
 		cpu = find_cpu_node(i);
Index: linux-2.6.16-rc6-mm1/arch/powerpc/mm/stab.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/mm/stab.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/mm/stab.c
@@ -239,7 +239,7 @@ void stabs_alloc(void)
 	if (cpu_has_feature(CPU_FTR_SLB))
 		return;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		unsigned long newstab;
 
 		if (cpu == 0)
Index: linux-2.6.16-rc6-mm1/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/kernel/lparcfg.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/kernel/lparcfg.c
@@ -56,7 +56,7 @@ static unsigned long get_purr(void)
 	unsigned long sum_purr = 0;
 	int cpu;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		sum_purr += lppaca[cpu].emulated_time_base;
 
 #ifdef PURR_DEBUG
@@ -222,7 +222,7 @@ static unsigned long get_purr(void)
 	int cpu;
 	struct cpu_usage *cu;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		cu = &per_cpu(cpu_usage_array, cpu);
 		sum_purr += cu->current_tb;
 	}
Index: linux-2.6.16-rc6-mm1/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/kernel/rtas.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/kernel/rtas.c
@@ -591,7 +591,7 @@ static void rtas_percpu_suspend_me(void 
 		data->waiting = 0;
 		data->args->args[data->args->nargs] =
 			rtas_call(ibm_suspend_me_token, 0, 1, NULL);
-		for_each_cpu(i)
+		for_each_possible_cpu(i)
 			plpar_hcall_norets(H_PROD,i);
 	} else {
 		data->waiting = -EBUSY;
@@ -624,7 +624,7 @@ static int rtas_ibm_suspend_me(struct rt
 	/* Prod each CPU.  This won't hurt, and will wake
 	 * anyone we successfully put to sleep with H_Join
 	 */
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		plpar_hcall_norets(H_PROD, i);
 
 	return data.waiting;
Index: linux-2.6.16-rc6-mm1/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/kernel/setup-common.c
@@ -439,7 +439,7 @@ void __init smp_setup_cpu_maps(void)
 	/*
 	 * Do the sibling map; assume only two threads per processor.
 	 */
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		cpu_set(cpu, cpu_sibling_map[cpu]);
 		if (cpu_has_feature(CPU_FTR_SMT))
 			cpu_set(cpu ^ 0x1, cpu_sibling_map[cpu]);
Index: linux-2.6.16-rc6-mm1/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/kernel/setup_32.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/kernel/setup_32.c
@@ -272,7 +272,7 @@ int __init ppc_init(void)
 	if ( ppc_md.progress ) ppc_md.progress("             ", 0xffff);
 
 	/* register CPU devices */
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		register_cpu(&cpu_devices[i], i, NULL);
 
 	/* call platform init */
Index: linux-2.6.16-rc6-mm1/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/kernel/setup_64.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/kernel/setup_64.c
@@ -518,7 +518,7 @@ static void __init irqstack_early_init(v
 	 * interrupt stacks must be under 256MB, we cannot afford to take
 	 * SLB misses on them.
 	 */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		softirq_ctx[i] = (struct thread_info *)
 			__va(lmb_alloc_base(THREAD_SIZE,
 					    THREAD_SIZE, 0x10000000));
@@ -551,7 +551,7 @@ static void __init emergency_stack_init(
 	 */
 	limit = min(0x10000000UL, lmb.rmo_size);
 
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		paca[i].emergency_sp =
 		__va(lmb_alloc_base(HW_PAGE_SIZE, 128, limit)) + HW_PAGE_SIZE;
 }
@@ -674,7 +674,7 @@ void __init setup_per_cpu_areas(void)
 		size = PERCPU_ENOUGH_ROOM;
 #endif
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		ptr = alloc_bootmem_node(NODE_DATA(cpu_to_node(i)), size);
 		if (!ptr)
 			panic("Cannot allocate cpu data for CPU %d\n", i);
Index: linux-2.6.16-rc6-mm1/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/kernel/sysfs.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/kernel/sysfs.c
@@ -74,7 +74,7 @@ static int __init smt_setup(void)
 	val = (unsigned int *)get_property(options, "ibm,smt-snooze-delay",
 					   NULL);
 	if (!smt_snooze_cmdline && val) {
-		for_each_cpu(cpu)
+		for_each_possible_cpu(cpu)
 			per_cpu(smt_snooze_delay, cpu) = *val;
 	}
 
@@ -93,7 +93,7 @@ static int __init setup_smt_snooze_delay
 	smt_snooze_cmdline = 1;
 
 	if (get_option(&str, &snooze)) {
-		for_each_cpu(cpu)
+		for_each_possible_cpu(cpu)
 			per_cpu(smt_snooze_delay, cpu) = snooze;
 	}
 
@@ -347,7 +347,7 @@ static int __init topology_init(void)
 
 	register_cpu_notifier(&sysfs_cpu_nb);
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
 
 #ifdef CONFIG_NUMA
Index: linux-2.6.16-rc6-mm1/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/platforms/pseries/xics.c
@@ -540,7 +540,7 @@ nextnode:
 		ops = &pSeriesLP_ops;
 	else {
 #ifdef CONFIG_SMP
-		for_each_cpu(i) {
+		for_each_possible_cpu(i) {
 			int hard_id;
 
 			/* FIXME: Do this dynamically! --RR */
Index: linux-2.6.16-rc6-mm1/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/platforms/cell/interrupt.c
@@ -284,7 +284,7 @@ void iic_init_IRQ(void)
 	struct iic *iic;
 
 	irq_offset = 0;
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		iic = &per_cpu(iic, cpu);
 		setup_iic(cpu, iic);
 		if (iic->regs)
Index: linux-2.6.16-rc6-mm1/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/powerpc/platforms/cell/pervasive.c
+++ linux-2.6.16-rc6-mm1/arch/powerpc/platforms/cell/pervasive.c
@@ -217,7 +217,7 @@ void __init cell_pervasive_init(void)
 	if (!cpu_has_feature(CPU_FTR_PAUSE_ZERO))
 		return;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		p = &cbe_pervasive[cpu];
 		ret = cbe_find_pmd_mmio(cpu, p);
 		if (ret)
Index: linux-2.6.16-rc6-mm1/include/asm-powerpc/percpu.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/asm-powerpc/percpu.h
+++ linux-2.6.16-rc6-mm1/include/asm-powerpc/percpu.h
@@ -27,7 +27,7 @@
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for_each_cpu(__i)					\
+	for_each_possible_cpu(__i)				\
 		memcpy((pcpudst)+__per_cpu_offset(__i),		\
 		       (src), (size));				\
 } while (0)
