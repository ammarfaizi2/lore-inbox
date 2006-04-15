Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWDODLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWDODLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 23:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWDODLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 23:11:09 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:239 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030217AbWDODKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 23:10:49 -0400
Subject: [PATCH 03/08] percpu -v2 static updates
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 23:10:47 -0400
Message-Id: <1145070647.27407.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_STATIC_PER_CPU instead of "static DEFINE_PER_CPU".

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc1/kernel/timer.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/timer.c	2006-04-14 15:43:49.000000000 -0400
+++ linux-2.6.17-rc1/kernel/timer.c	2006-04-14 15:58:26.000000000 -0400
@@ -81,7 +81,7 @@ struct tvec_t_base_s {
 } ____cacheline_aligned_in_smp;
 
 typedef struct tvec_t_base_s tvec_base_t;
-static DEFINE_PER_CPU(tvec_base_t *, tvec_bases);
+DEFINE_STATIC_PER_CPU(tvec_base_t *, tvec_bases);
 tvec_base_t boot_tvec_bases;
 EXPORT_SYMBOL(boot_tvec_bases);
 
Index: linux-2.6.17-rc1/arch/arm/kernel/smp.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/arm/kernel/smp.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/arm/kernel/smp.c	2006-04-14 16:03:43.000000000 -0400
@@ -56,7 +56,7 @@ struct ipi_data {
 	unsigned long bits;
 };
 
-static DEFINE_PER_CPU(struct ipi_data, ipi_data) = {
+DEFINE_STATIC_PER_CPU(struct ipi_data, ipi_data) = {
 	.lock	= SPIN_LOCK_UNLOCKED,
 };
 
Index: linux-2.6.17-rc1/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/i386/kernel/process.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/i386/kernel/process.c	2006-04-14 16:03:43.000000000 -0400
@@ -77,7 +77,7 @@ unsigned long thread_saved_pc(struct tas
  */
 void (*pm_idle)(void);
 EXPORT_SYMBOL(pm_idle);
-static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
+DEFINE_STATIC_PER_CPU(unsigned int, cpu_idle_state);
 
 void disable_hlt(void)
 {
Index: linux-2.6.17-rc1/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/i386/mach-voyager/voyager_smp.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/i386/mach-voyager/voyager_smp.c	2006-04-14 16:03:43.000000000 -0400
@@ -225,9 +225,9 @@ static int cpucount = 0;
 static __u32 trampoline_base;
 
 /* The per cpu profile stuff - used in smp_local_timer_interrupt */
-static DEFINE_PER_CPU(int, prof_multiplier) = 1;
-static DEFINE_PER_CPU(int, prof_old_multiplier) = 1;
-static DEFINE_PER_CPU(int, prof_counter) =  1;
+DEFINE_STATIC_PER_CPU(int, prof_multiplier) = 1;
+DEFINE_STATIC_PER_CPU(int, prof_old_multiplier) = 1;
+DEFINE_STATIC_PER_CPU(int, prof_counter) =  1;
 
 /* the map used to check if a CPU has booted */
 static __u32 cpu_booted_map;
Index: linux-2.6.17-rc1/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/ia64/kernel/process.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/ia64/kernel/process.c	2006-04-14 16:03:43.000000000 -0400
@@ -54,7 +54,7 @@
 #include "sigframe.h"
 
 void (*ia64_mark_idle)(int);
-static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
+DEFINE_STATIC_PER_CPU(unsigned int, cpu_idle_state);
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
Index: linux-2.6.17-rc1/arch/ia64/kernel/smp.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/ia64/kernel/smp.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc1/arch/ia64/kernel/smp.c	2006-04-14 16:03:43.000000000 -0400
@@ -68,7 +68,7 @@ static volatile struct call_data_struct 
 #define IPI_CPU_STOP		1
 
 /* This needs to be cacheline aligned because it is written to by *other* CPUs.  */
-static DEFINE_PER_CPU(u64, ipi_operation) ____cacheline_aligned;
+DEFINE_STATIC_PER_CPU(u64, ipi_operation) ____cacheline_aligned;
 
 extern void cpu_halt (void);
 
Index: linux-2.6.17-rc1/arch/mips/kernel/smp.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/mips/kernel/smp.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/mips/kernel/smp.c	2006-04-14 16:03:43.000000000 -0400
@@ -425,7 +425,7 @@ void flush_tlb_one(unsigned long vaddr)
 	local_flush_tlb_one(vaddr);
 }
 
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
+DEFINE_STATIC_PER_CPU(struct cpu, cpu_devices);
 
 static int __init topology_init(void)
 {
Index: linux-2.6.17-rc1/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/kernel/process.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/powerpc/kernel/process.c	2006-04-14 16:03:43.000000000 -0400
@@ -234,7 +234,7 @@ int set_dabr(unsigned long dabr)
 
 #ifdef CONFIG_PPC64
 DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
-static DEFINE_PER_CPU(unsigned long, current_dabr);
+DEFINE_STATIC_PER_CPU(unsigned long, current_dabr);
 #endif
 
 struct task_struct *__switch_to(struct task_struct *prev,
Index: linux-2.6.17-rc1/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/kernel/sysfs.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/powerpc/kernel/sysfs.c	2006-04-14 16:03:43.000000000 -0400
@@ -21,7 +21,7 @@
 #include <asm/machdep.h>
 #include <asm/smp.h>
 
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
+DEFINE_STATIC_PER_CPU(struct cpu, cpu_devices);
 
 /* SMT stuff */
 
@@ -108,7 +108,7 @@ __setup("smt-snooze-delay=", setup_smt_s
  * it the first time we write to the PMCs.
  */
 
-static DEFINE_PER_CPU(char, pmcs_enabled);
+DEFINE_STATIC_PER_CPU(char, pmcs_enabled);
 
 void ppc64_enable_pmcs(void)
 {
Index: linux-2.6.17-rc1/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/kernel/time.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/powerpc/kernel/time.c	2006-04-14 16:03:43.000000000 -0400
@@ -238,7 +238,7 @@ struct cpu_purr_data {
 	spinlock_t lock;
 };
 
-static DEFINE_PER_CPU(struct cpu_purr_data, cpu_purr_data);
+DEFINE_STATIC_PER_CPU(struct cpu_purr_data, cpu_purr_data);
 
 static void snapshot_tb_and_purr(void *data)
 {
Index: linux-2.6.17-rc1/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/cell/interrupt.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/powerpc/platforms/cell/interrupt.c	2006-04-14 16:03:43.000000000 -0400
@@ -59,7 +59,7 @@ struct iic {
 	u8 target_id;
 };
 
-static DEFINE_PER_CPU(struct iic, iic);
+DEFINE_STATIC_PER_CPU(struct iic, iic);
 
 void iic_local_enable(void)
 {
Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/iommu.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/iommu.c	2006-04-14 16:03:43.000000000 -0400
@@ -132,7 +132,7 @@ static void tce_build_pSeriesLP(struct i
 	}
 }
 
-static DEFINE_PER_CPU(void *, tce_page) = NULL;
+DEFINE_STATIC_PER_CPU(void *, tce_page) = NULL;
 
 static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
Index: linux-2.6.17-rc1/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/s390/kernel/smp.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/s390/kernel/smp.c	2006-04-14 16:03:43.000000000 -0400
@@ -861,7 +861,7 @@ int setup_profiling_timer(unsigned int m
         return 0;
 }
 
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
+DEFINE_STATIC_PER_CPU(struct cpu, cpu_devices);
 
 static int __init topology_init(void)
 {
Index: linux-2.6.17-rc1/arch/sparc64/kernel/pci_sun4v.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/sparc64/kernel/pci_sun4v.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/sparc64/kernel/pci_sun4v.c	2006-04-14 16:03:43.000000000 -0400
@@ -34,7 +34,7 @@ struct pci_iommu_batch {
 	unsigned long	npages;		/* Number of pages in list.	*/
 };
 
-static DEFINE_PER_CPU(struct pci_iommu_batch, pci_iommu_batch);
+DEFINE_STATIC_PER_CPU(struct pci_iommu_batch, pci_iommu_batch);
 
 /* Interrupts must be disabled.  */
 static inline void pci_iommu_batch_start(struct pci_dev *pdev, unsigned long prot, unsigned long entry)
Index: linux-2.6.17-rc1/arch/sparc64/kernel/time.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/sparc64/kernel/time.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/sparc64/kernel/time.c	2006-04-14 16:03:43.000000000 -0400
@@ -1056,7 +1056,7 @@ struct freq_table {
 	unsigned long clock_tick_ref;
 	unsigned int ref_freq;
 };
-static DEFINE_PER_CPU(struct freq_table, sparc64_freq_table) = { 0, 0 };
+DEFINE_STATIC_PER_CPU(struct freq_table, sparc64_freq_table) = { 0, 0 };
 
 unsigned long sparc64_get_clock_tick(unsigned int cpu)
 {
Index: linux-2.6.17-rc1/arch/x86_64/kernel/mce.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/mce.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/x86_64/kernel/mce.c	2006-04-14 16:03:43.000000000 -0400
@@ -556,7 +556,7 @@ static struct sysdev_class mce_sysclass 
 	set_kset_name("machinecheck"),
 };
 
-static DEFINE_PER_CPU(struct sys_device, device_mce);
+DEFINE_STATIC_PER_CPU(struct sys_device, device_mce);
 
 /* Why are there no generic functions for this? */
 #define ACCESSOR(name, var, start) \
Index: linux-2.6.17-rc1/arch/x86_64/kernel/mce_amd.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/mce_amd.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc1/arch/x86_64/kernel/mce_amd.c	2006-04-14 16:03:43.000000000 -0400
@@ -61,7 +61,7 @@ static unsigned char shared_bank[NR_BANK
 };
 #endif
 
-static DEFINE_PER_CPU(unsigned char, bank_map);	/* see which banks are on */
+DEFINE_STATIC_PER_CPU(unsigned char, bank_map);	/* see which banks are on */
 
 /*
  * CPU Initialization
@@ -170,7 +170,7 @@ static struct sysdev_class threshold_sys
 	set_kset_name("threshold"),
 };
 
-static DEFINE_PER_CPU(struct sys_device, device_threshold);
+DEFINE_STATIC_PER_CPU(struct sys_device, device_threshold);
 
 struct threshold_attr {
         struct attribute attr;
@@ -178,7 +178,7 @@ struct threshold_attr {
         ssize_t(*store) (struct threshold_bank *, const char *, size_t count);
 };
 
-static DEFINE_PER_CPU(struct threshold_bank *, threshold_banks[NR_BANKS]);
+DEFINE_STATIC_PER_CPU(struct threshold_bank *, threshold_banks[NR_BANKS]);
 
 static cpumask_t affinity_set(unsigned int cpu)
 {
Index: linux-2.6.17-rc1/arch/x86_64/kernel/mce_intel.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/mce_intel.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc1/arch/x86_64/kernel/mce_intel.c	2006-04-14 16:03:43.000000000 -0400
@@ -12,7 +12,7 @@
 #include <asm/hw_irq.h>
 #include <asm/idle.h>
 
-static DEFINE_PER_CPU(unsigned long, next_check);
+DEFINE_STATIC_PER_CPU(unsigned long, next_check);
 
 asmlinkage void smp_thermal_interrupt(void)
 {
Index: linux-2.6.17-rc1/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/nmi.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/x86_64/kernel/nmi.c	2006-04-14 16:03:43.000000000 -0400
@@ -449,9 +449,9 @@ void setup_apic_nmi_watchdog(void)
  * have to check the current processor.
  */
 
-static DEFINE_PER_CPU(unsigned, last_irq_sum);
-static DEFINE_PER_CPU(local_t, alert_counter);
-static DEFINE_PER_CPU(int, nmi_touch);
+DEFINE_STATIC_PER_CPU(unsigned, last_irq_sum);
+DEFINE_STATIC_PER_CPU(local_t, alert_counter);
+DEFINE_STATIC_PER_CPU(int, nmi_touch);
 
 void touch_nmi_watchdog (void)
 {
Index: linux-2.6.17-rc1/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/process.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/x86_64/kernel/process.c	2006-04-14 16:03:43.000000000 -0400
@@ -64,7 +64,7 @@ EXPORT_SYMBOL(boot_option_idle_override)
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
-static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
+DEFINE_STATIC_PER_CPU(unsigned int, cpu_idle_state);
 
 static ATOMIC_NOTIFIER_HEAD(idle_notifier);
 
@@ -81,7 +81,7 @@ void idle_notifier_unregister(struct not
 EXPORT_SYMBOL(idle_notifier_unregister);
 
 enum idle_state { CPU_IDLE, CPU_NOT_IDLE };
-static DEFINE_PER_CPU(enum idle_state, idle_state) = CPU_NOT_IDLE;
+DEFINE_STATIC_PER_CPU(enum idle_state, idle_state) = CPU_NOT_IDLE;
 
 void enter_idle(void)
 {
Index: linux-2.6.17-rc1/arch/x86_64/kernel/smp.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/smp.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/arch/x86_64/kernel/smp.c	2006-04-14 16:03:43.000000000 -0400
@@ -65,7 +65,7 @@ union smp_flush_state {
 /* State is put into the per CPU data section, but padded
    to a full cache line because other CPUs can access it and we don't
    want false sharing in the per cpu data segment. */
-static DEFINE_PER_CPU(union smp_flush_state, flush_state);
+DEFINE_STATIC_PER_CPU(union smp_flush_state, flush_state);
 
 /*
  * We cannot call mmdrop() because we are in interrupt context, 
Index: linux-2.6.17-rc1/block/blktrace.c
===================================================================
--- linux-2.6.17-rc1.orig/block/blktrace.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/block/blktrace.c	2006-04-14 16:03:44.000000000 -0400
@@ -25,7 +25,7 @@
 #include <linux/debugfs.h>
 #include <asm/uaccess.h>
 
-static DEFINE_PER_CPU(unsigned long long, blk_trace_cpu_offset) = { 0, };
+DEFINE_STATIC_PER_CPU(unsigned long long, blk_trace_cpu_offset) = { 0, };
 static unsigned int blktrace_seq __read_mostly = 1;
 
 /*
Index: linux-2.6.17-rc1/block/ll_rw_blk.c
===================================================================
--- linux-2.6.17-rc1.orig/block/ll_rw_blk.c	2006-04-13 20:41:42.000000000 -0400
+++ linux-2.6.17-rc1/block/ll_rw_blk.c	2006-04-14 16:03:44.000000000 -0400
@@ -71,7 +71,7 @@ unsigned long blk_max_low_pfn, blk_max_p
 EXPORT_SYMBOL(blk_max_low_pfn);
 EXPORT_SYMBOL(blk_max_pfn);
 
-static DEFINE_PER_CPU(struct list_head, blk_cpu_done);
+DEFINE_STATIC_PER_CPU(struct list_head, blk_cpu_done);
 
 /* Amount of time in which a process may batch requests */
 #define BLK_BATCH_TIME	(HZ/50UL)
Index: linux-2.6.17-rc1/drivers/char/random.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/char/random.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc1/drivers/char/random.c	2006-04-14 16:03:44.000000000 -0400
@@ -273,7 +273,7 @@ static int random_write_wakeup_thresh = 
 
 static int trickle_thresh __read_mostly = INPUT_POOL_WORDS * 28;
 
-static DEFINE_PER_CPU(int, trickle_count) = 0;
+DEFINE_STATIC_PER_CPU(int, trickle_count) = 0;
 
 /*
  * A pool of size .poolwords is stirred with a primitive polynomial
Index: linux-2.6.17-rc1/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/connector/cn_proc.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc1/drivers/connector/cn_proc.c	2006-04-14 16:03:44.000000000 -0400
@@ -36,7 +36,7 @@ static atomic_t proc_event_num_listeners
 static struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
 
 /* proc_event_counts is used as the sequence number of the netlink message */
-static DEFINE_PER_CPU(__u32, proc_event_counts) = { 0 };
+DEFINE_STATIC_PER_CPU(__u32, proc_event_counts) = { 0 };
 
 static inline void get_seq(__u32 *ts, int *cpu)
 {
Index: linux-2.6.17-rc1/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/cpufreq/cpufreq_conservative.c	2006-04-13 20:41:43.000000000 -0400
+++ linux-2.6.17-rc1/drivers/cpufreq/cpufreq_conservative.c	2006-04-14 16:03:44.000000000 -0400
@@ -68,7 +68,7 @@ struct cpu_dbs_info_s {
 	unsigned int		down_skip;
 	unsigned int		requested_freq;
 };
-static DEFINE_PER_CPU(struct cpu_dbs_info_s, cpu_dbs_info);
+DEFINE_STATIC_PER_CPU(struct cpu_dbs_info_s, cpu_dbs_info);
 
 static unsigned int dbs_enable;	/* number of CPUs using this policy */
 
Index: linux-2.6.17-rc1/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/cpufreq/cpufreq_ondemand.c	2006-04-13 20:41:43.000000000 -0400
+++ linux-2.6.17-rc1/drivers/cpufreq/cpufreq_ondemand.c	2006-04-14 16:03:44.000000000 -0400
@@ -67,7 +67,7 @@ struct cpu_dbs_info_s {
 	unsigned int prev_cpu_idle_down;
 	unsigned int enable;
 };
-static DEFINE_PER_CPU(struct cpu_dbs_info_s, cpu_dbs_info);
+DEFINE_STATIC_PER_CPU(struct cpu_dbs_info_s, cpu_dbs_info);
 
 static unsigned int dbs_enable;	/* number of CPUs using this policy */
 
Index: linux-2.6.17-rc1/drivers/net/loopback.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/net/loopback.c	2006-04-13 20:41:46.000000000 -0400
+++ linux-2.6.17-rc1/drivers/net/loopback.c	2006-04-14 16:03:44.000000000 -0400
@@ -58,7 +58,7 @@
 #include <linux/tcp.h>
 #include <linux/percpu.h>
 
-static DEFINE_PER_CPU(struct net_device_stats, loopback_stats);
+DEFINE_STATIC_PER_CPU(struct net_device_stats, loopback_stats);
 
 #define LOOPBACK_OVERHEAD (128 + MAX_HEADER + 16 + 16)
 
Index: linux-2.6.17-rc1/drivers/s390/s390mach.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/s390/s390mach.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc1/drivers/s390/s390mach.c	2006-04-14 16:03:44.000000000 -0400
@@ -157,7 +157,7 @@ struct mcck_struct {
 	unsigned long long mcck_code;
 };
 
-static DEFINE_PER_CPU(struct mcck_struct, cpu_mcck);
+DEFINE_STATIC_PER_CPU(struct mcck_struct, cpu_mcck);
 
 /*
  * Main machine check handler function. Will be called with interrupts enabled
Index: linux-2.6.17-rc1/drivers/scsi/scsi.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/scsi/scsi.c	2006-04-13 20:41:48.000000000 -0400
+++ linux-2.6.17-rc1/drivers/scsi/scsi.c	2006-04-14 16:03:44.000000000 -0400
@@ -716,7 +716,7 @@ void scsi_init_cmd_from_req(struct scsi_
 /*
  * Per-CPU I/O completion queue.
  */
-static DEFINE_PER_CPU(struct list_head, scsi_done_q);
+DEFINE_STATIC_PER_CPU(struct list_head, scsi_done_q);
 
 /**
  * scsi_done - Enqueue the finished SCSI command into the done queue.
Index: linux-2.6.17-rc1/fs/buffer.c
===================================================================
--- linux-2.6.17-rc1.orig/fs/buffer.c	2006-04-13 20:41:49.000000000 -0400
+++ linux-2.6.17-rc1/fs/buffer.c	2006-04-14 16:03:44.000000000 -0400
@@ -1325,7 +1325,7 @@ struct bh_lru {
 	struct buffer_head *bhs[BH_LRU_SIZE];
 };
 
-static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
+DEFINE_STATIC_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
 
 #ifdef CONFIG_SMP
 #define bh_lru_lock()	local_irq_disable()
@@ -3066,7 +3066,7 @@ struct bh_accounting {
 	int ratelimit;		/* Limit cacheline bouncing */
 };
 
-static DEFINE_PER_CPU(struct bh_accounting, bh_accounting) = {0, 0};
+DEFINE_STATIC_PER_CPU(struct bh_accounting, bh_accounting) = {0, 0};
 
 static void recalc_bh_state(void)
 {
Index: linux-2.6.17-rc1/fs/file.c
===================================================================
--- linux-2.6.17-rc1.orig/fs/file.c	2006-04-13 20:41:50.000000000 -0400
+++ linux-2.6.17-rc1/fs/file.c	2006-04-14 16:03:44.000000000 -0400
@@ -31,7 +31,7 @@ struct fdtable_defer {
  * the work_struct in fdtable itself which avoids a 64 byte (i386) increase in
  * this per-task structure.
  */
-static DEFINE_PER_CPU(struct fdtable_defer, fdtable_defer_list);
+DEFINE_STATIC_PER_CPU(struct fdtable_defer, fdtable_defer_list);
 
 
 /*
Index: linux-2.6.17-rc1/kernel/hrtimer.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/hrtimer.c	2006-04-14 14:26:26.000000000 -0400
+++ linux-2.6.17-rc1/kernel/hrtimer.c	2006-04-14 16:03:44.000000000 -0400
@@ -82,7 +82,7 @@ EXPORT_SYMBOL_GPL(ktime_get_real);
 
 #define MAX_HRTIMER_BASES 2
 
-static DEFINE_PER_CPU(struct hrtimer_base, hrtimer_bases[MAX_HRTIMER_BASES]) =
+DEFINE_STATIC_PER_CPU(struct hrtimer_base, hrtimer_bases[MAX_HRTIMER_BASES]) =
 {
 	{
 		.index = CLOCK_REALTIME,
Index: linux-2.6.17-rc1/kernel/kprobes.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/kprobes.c	2006-04-13 20:41:55.000000000 -0400
+++ linux-2.6.17-rc1/kernel/kprobes.c	2006-04-14 16:03:44.000000000 -0400
@@ -50,7 +50,7 @@ static struct hlist_head kretprobe_inst_
 
 DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
 DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
-static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
+DEFINE_STATIC_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
 
 #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
 /*
Index: linux-2.6.17-rc1/kernel/profile.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/profile.c	2006-04-13 20:41:55.000000000 -0400
+++ linux-2.6.17-rc1/kernel/profile.c	2006-04-14 16:03:44.000000000 -0400
@@ -43,8 +43,8 @@ static unsigned long prof_len, prof_shif
 static int prof_on __read_mostly;
 static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
-static DEFINE_PER_CPU(int, cpu_profile_flip);
+DEFINE_STATIC_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
+DEFINE_STATIC_PER_CPU(int, cpu_profile_flip);
 static DEFINE_MUTEX(profile_flip_mutex);
 #endif /* CONFIG_SMP */
 
Index: linux-2.6.17-rc1/kernel/rcupdate.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/rcupdate.c	2006-04-13 20:41:55.000000000 -0400
+++ linux-2.6.17-rc1/kernel/rcupdate.c	2006-04-14 16:03:44.000000000 -0400
@@ -67,7 +67,7 @@ DEFINE_PER_CPU(struct rcu_data, rcu_data
 DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
 
 /* Fake initialization required by compiler */
-static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
+DEFINE_STATIC_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 static int blimit = 10;
 static int qhimark = 10000;
 static int qlowmark = 100;
Index: linux-2.6.17-rc1/kernel/rcutorture.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/rcutorture.c	2006-04-13 20:41:55.000000000 -0400
+++ linux-2.6.17-rc1/kernel/rcutorture.c	2006-04-14 16:03:44.000000000 -0400
@@ -95,9 +95,9 @@ static struct rcu_torture *rcu_torture_c
 static long rcu_torture_current_version = 0;
 static struct rcu_torture rcu_tortures[10 * RCU_TORTURE_PIPE_LEN];
 static DEFINE_SPINLOCK(rcu_torture_lock);
-static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_count) =
+DEFINE_STATIC_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_count) =
 	{ 0 };
-static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch) =
+DEFINE_STATIC_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch) =
 	{ 0 };
 static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1];
 atomic_t n_rcu_torture_alloc;
Index: linux-2.6.17-rc1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/sched.c	2006-04-14 15:43:35.000000000 -0400
+++ linux-2.6.17-rc1/kernel/sched.c	2006-04-14 16:03:44.000000000 -0400
@@ -263,7 +263,7 @@ struct runqueue {
 #endif
 };
 
-static DEFINE_PER_CPU(struct runqueue, runqueues);
+DEFINE_STATIC_PER_CPU(struct runqueue, runqueues);
 
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
@@ -5594,7 +5594,7 @@ static cpumask_t sched_domain_node_span(
  * can switch it on easily if needed.
  */
 #ifdef CONFIG_SCHED_SMT
-static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
+DEFINE_STATIC_PER_CPU(struct sched_domain, cpu_domains);
 static struct sched_group sched_group_cpus[NR_CPUS];
 static int cpu_to_cpu_group(int cpu)
 {
@@ -5603,7 +5603,7 @@ static int cpu_to_cpu_group(int cpu)
 #endif
 
 #ifdef CONFIG_SCHED_MC
-static DEFINE_PER_CPU(struct sched_domain, core_domains);
+DEFINE_STATIC_PER_CPU(struct sched_domain, core_domains);
 static struct sched_group sched_group_core[NR_CPUS];
 #endif
 
@@ -5619,7 +5619,7 @@ static int cpu_to_core_group(int cpu)
 }
 #endif
 
-static DEFINE_PER_CPU(struct sched_domain, phys_domains);
+DEFINE_STATIC_PER_CPU(struct sched_domain, phys_domains);
 static struct sched_group sched_group_phys[NR_CPUS];
 static int cpu_to_phys_group(int cpu)
 {
@@ -5639,10 +5639,10 @@ static int cpu_to_phys_group(int cpu)
  * groups, so roll our own. Now each node has its own list of groups which
  * gets dynamically allocated.
  */
-static DEFINE_PER_CPU(struct sched_domain, node_domains);
+DEFINE_STATIC_PER_CPU(struct sched_domain, node_domains);
 static struct sched_group **sched_group_nodes_bycpu[NR_CPUS];
 
-static DEFINE_PER_CPU(struct sched_domain, allnodes_domains);
+DEFINE_STATIC_PER_CPU(struct sched_domain, allnodes_domains);
 static struct sched_group *sched_group_allnodes_bycpu[NR_CPUS];
 
 static int cpu_to_allnodes_group(int cpu)
Index: linux-2.6.17-rc1/kernel/softirq.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/softirq.c	2006-04-13 22:37:57.000000000 -0400
+++ linux-2.6.17-rc1/kernel/softirq.c	2006-04-14 16:03:44.000000000 -0400
@@ -44,7 +44,7 @@ EXPORT_SYMBOL(irq_stat);
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
 
-static DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
+DEFINE_STATIC_PER_CPU(struct task_struct *, ksoftirqd);
 
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
@@ -218,8 +218,8 @@ struct tasklet_head
 
 /* Some compilers disobey section attribute on statics when not
    initialized -- RR */
-static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec) = { NULL };
-static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec) = { NULL };
+DEFINE_STATIC_PER_CPU(struct tasklet_head, tasklet_vec) = { NULL };
+DEFINE_STATIC_PER_CPU(struct tasklet_head, tasklet_hi_vec) = { NULL };
 
 void fastcall __tasklet_schedule(struct tasklet_struct *t)
 {
Index: linux-2.6.17-rc1/kernel/softlockup.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/softlockup.c	2006-04-13 20:41:55.000000000 -0400
+++ linux-2.6.17-rc1/kernel/softlockup.c	2006-04-14 16:03:44.000000000 -0400
@@ -16,9 +16,9 @@
 
 static DEFINE_SPINLOCK(print_lock);
 
-static DEFINE_PER_CPU(unsigned long, touch_timestamp);
-static DEFINE_PER_CPU(unsigned long, print_timestamp);
-static DEFINE_PER_CPU(struct task_struct *, watchdog_task);
+DEFINE_STATIC_PER_CPU(unsigned long, touch_timestamp);
+DEFINE_STATIC_PER_CPU(unsigned long, print_timestamp);
+DEFINE_STATIC_PER_CPU(struct task_struct *, watchdog_task);
 
 static int did_panic = 0;
 
Index: linux-2.6.17-rc1/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc1.orig/mm/page-writeback.c	2006-04-14 15:43:49.000000000 -0400
+++ linux-2.6.17-rc1/mm/page-writeback.c	2006-04-14 16:03:44.000000000 -0400
@@ -272,7 +272,7 @@ static void balance_dirty_pages(struct a
 void balance_dirty_pages_ratelimited_nr(struct address_space *mapping,
 					unsigned long nr_pages_dirtied)
 {
-	static DEFINE_PER_CPU(unsigned long, ratelimits) = 0;
+	DEFINE_STATIC_PER_CPU(unsigned long, ratelimits) = 0;
 	unsigned long ratelimit;
 	unsigned long *p;
 
Index: linux-2.6.17-rc1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc1.orig/mm/page_alloc.c	2006-04-13 22:37:57.000000000 -0400
+++ linux-2.6.17-rc1/mm/page_alloc.c	2006-04-14 16:03:44.000000000 -0400
@@ -1221,7 +1221,7 @@ static void show_node(struct zone *zone)
  * The result is unavoidably approximate - it can change
  * during and after execution of this function.
  */
-static DEFINE_PER_CPU(struct page_state, page_states) = {0};
+DEFINE_STATIC_PER_CPU(struct page_state, page_states) = {0};
 
 atomic_t nr_pagecache = ATOMIC_INIT(0);
 EXPORT_SYMBOL(nr_pagecache);
Index: linux-2.6.17-rc1/mm/slab.c
===================================================================
--- linux-2.6.17-rc1.orig/mm/slab.c	2006-04-13 20:41:55.000000000 -0400
+++ linux-2.6.17-rc1/mm/slab.c	2006-04-14 16:03:44.000000000 -0400
@@ -697,7 +697,7 @@ static enum {
 	FULL
 } g_cpucache_up;
 
-static DEFINE_PER_CPU(struct work_struct, reap_work);
+DEFINE_STATIC_PER_CPU(struct work_struct, reap_work);
 
 static void free_block(struct kmem_cache *cachep, void **objpp, int len,
 			int node);
@@ -824,7 +824,7 @@ static void __slab_error(const char *fun
  * objects freed on different nodes from which they were allocated) and the
  * flushing of remote pcps by calling drain_node_pages.
  */
-static DEFINE_PER_CPU(unsigned long, reap_node);
+DEFINE_STATIC_PER_CPU(unsigned long, reap_node);
 
 static void init_reap_node(int cpu)
 {
Index: linux-2.6.17-rc1/mm/swap.c
===================================================================
--- linux-2.6.17-rc1.orig/mm/swap.c	2006-04-13 22:37:57.000000000 -0400
+++ linux-2.6.17-rc1/mm/swap.c	2006-04-14 16:03:44.000000000 -0400
@@ -136,8 +136,8 @@ EXPORT_SYMBOL(mark_page_accessed);
  * lru_cache_add: add a page to the page lists
  * @page: the page to add
  */
-static DEFINE_PER_CPU(struct pagevec, lru_add_pvecs) = { 0, };
-static DEFINE_PER_CPU(struct pagevec, lru_add_active_pvecs) = { 0, };
+DEFINE_STATIC_PER_CPU(struct pagevec, lru_add_pvecs) = { 0, };
+DEFINE_STATIC_PER_CPU(struct pagevec, lru_add_active_pvecs) = { 0, };
 
 void fastcall lru_cache_add(struct page *page)
 {
@@ -444,7 +444,7 @@ EXPORT_SYMBOL(pagevec_lookup_tag);
  */
 #define ACCT_THRESHOLD	max(16, NR_CPUS * 2)
 
-static DEFINE_PER_CPU(long, committed_space) = 0;
+DEFINE_STATIC_PER_CPU(long, committed_space) = 0;
 
 void vm_acct_memory(long pages)
 {
Index: linux-2.6.17-rc1/net/core/flow.c
===================================================================
--- linux-2.6.17-rc1.orig/net/core/flow.c	2006-04-13 20:41:56.000000000 -0400
+++ linux-2.6.17-rc1/net/core/flow.c	2006-04-14 16:03:44.000000000 -0400
@@ -41,7 +41,7 @@ atomic_t flow_cache_genid = ATOMIC_INIT(
 
 static u32 flow_hash_shift;
 #define flow_hash_size	(1 << flow_hash_shift)
-static DEFINE_PER_CPU(struct flow_cache_entry **, flow_tables) = { NULL };
+DEFINE_STATIC_PER_CPU(struct flow_cache_entry **, flow_tables) = { NULL };
 
 #define flow_table(cpu) (per_cpu(flow_tables, cpu))
 
@@ -54,7 +54,7 @@ struct flow_percpu_info {
 	u32 hash_rnd;
 	int count;
 } ____cacheline_aligned;
-static DEFINE_PER_CPU(struct flow_percpu_info, flow_hash_info) = { 0 };
+DEFINE_STATIC_PER_CPU(struct flow_percpu_info, flow_hash_info) = { 0 };
 
 #define flow_hash_rnd_recalc(cpu) \
 	(per_cpu(flow_hash_info, cpu).hash_rnd_recalc)
@@ -71,7 +71,7 @@ struct flow_flush_info {
 	atomic_t cpuleft;
 	struct completion completion;
 };
-static DEFINE_PER_CPU(struct tasklet_struct, flow_flush_tasklets) = { NULL };
+DEFINE_STATIC_PER_CPU(struct tasklet_struct, flow_flush_tasklets) = { NULL };
 
 #define flow_flush_tasklet(cpu) (&per_cpu(flow_flush_tasklets, cpu))
 
Index: linux-2.6.17-rc1/net/core/utils.c
===================================================================
--- linux-2.6.17-rc1.orig/net/core/utils.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc1/net/core/utils.c	2006-04-14 16:03:44.000000000 -0400
@@ -67,7 +67,7 @@ struct nrnd_state {
 	u32 s1, s2, s3;
 };
 
-static DEFINE_PER_CPU(struct nrnd_state, net_rand_state);
+DEFINE_STATIC_PER_CPU(struct nrnd_state, net_rand_state);
 
 static u32 __net_random(struct nrnd_state *state)
 {
Index: linux-2.6.17-rc1/net/ipv4/icmp.c
===================================================================
--- linux-2.6.17-rc1.orig/net/ipv4/icmp.c	2006-04-13 20:41:57.000000000 -0400
+++ linux-2.6.17-rc1/net/ipv4/icmp.c	2006-04-14 16:03:44.000000000 -0400
@@ -230,7 +230,7 @@ static const struct icmp_control icmp_po
  *
  *	On SMP we have one ICMP socket per-cpu.
  */
-static DEFINE_PER_CPU(struct socket *, __icmp_socket) = NULL;
+DEFINE_STATIC_PER_CPU(struct socket *, __icmp_socket) = NULL;
 #define icmp_socket	__get_cpu_var(__icmp_socket)
 
 static __inline__ int icmp_xmit_lock(void)
Index: linux-2.6.17-rc1/net/ipv4/route.c
===================================================================
--- linux-2.6.17-rc1.orig/net/ipv4/route.c	2006-04-13 20:41:57.000000000 -0400
+++ linux-2.6.17-rc1/net/ipv4/route.c	2006-04-14 16:03:44.000000000 -0400
@@ -242,7 +242,7 @@ static unsigned			rt_hash_mask;
 static int			rt_hash_log;
 static unsigned int		rt_hash_rnd;
 
-static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
+DEFINE_STATIC_PER_CPU(struct rt_cache_stat, rt_cache_stat);
 #define RT_CACHE_STAT_INC(field) \
 	(per_cpu(rt_cache_stat, raw_smp_processor_id()).field++)
 
Index: linux-2.6.17-rc1/net/ipv6/icmp.c
===================================================================
--- linux-2.6.17-rc1.orig/net/ipv6/icmp.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc1/net/ipv6/icmp.c	2006-04-14 16:03:44.000000000 -0400
@@ -77,7 +77,7 @@ DEFINE_SNMP_STAT(struct icmpv6_mib, icmp
  *
  *	On SMP we have one ICMP socket per-cpu.
  */
-static DEFINE_PER_CPU(struct socket *, __icmpv6_socket) = NULL;
+DEFINE_STATIC_PER_CPU(struct socket *, __icmpv6_socket) = NULL;
 #define icmpv6_socket	__get_cpu_var(__icmpv6_socket)
 
 static int icmpv6_rcv(struct sk_buff **pskb);
Index: linux-2.6.17-rc1/net/socket.c
===================================================================
--- linux-2.6.17-rc1.orig/net/socket.c	2006-04-13 20:41:58.000000000 -0400
+++ linux-2.6.17-rc1/net/socket.c	2006-04-14 16:03:44.000000000 -0400
@@ -203,7 +203,7 @@ static __inline__ void net_family_read_u
  *	Statistics counters of the socket lists
  */
 
-static DEFINE_PER_CPU(int, sockets_in_use) = 0;
+DEFINE_STATIC_PER_CPU(int, sockets_in_use) = 0;
 
 /*
  *	Support routines. Move socket addresses back and forth across the kernel/user


