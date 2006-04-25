Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWDYCfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWDYCfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWDYCfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:35:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:33248 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751538AbWDYCfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:35:23 -0400
From: sekharan@us.ibm.com
To: akpm@osdl.org, torvalds@osdl.org
Cc: sekharan@us.ibm.com, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu
Date: Mon, 24 Apr 2006 19:35:21 -0700
Message-Id: <20060425023521.7529.33946.sendpatchset@localhost.localdomain>
In-Reply-To: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
References: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
Subject: [PATCH 2/3] Remove __devinit and __cpuinit from notifier_call definitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Few of the notifier_chain_register() callers use __init in the definition
of notifier_call.  It is incorrect as the function definition should be
available after the initializations (they do not unregister them during
initializations).

This patch fixes all such usages to _not_ have the notifier_call __init
section.
--
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 arch/i386/kernel/cpu/intel_cacheinfo.c |    2 +-
 arch/i386/kernel/cpuid.c               |    2 +-
 arch/i386/kernel/msr.c                 |    2 +-
 arch/ia64/kernel/palinfo.c             |    2 +-
 arch/ia64/kernel/salinfo.c             |    2 +-
 arch/ia64/kernel/topology.c            |    2 +-
 arch/powerpc/kernel/sysfs.c            |    2 +-
 arch/x86_64/kernel/mce.c               |    2 +-
 arch/x86_64/kernel/mce_amd.c           |    2 +-
 drivers/base/topology.c                |    2 +-
 drivers/cpufreq/cpufreq.c              |    2 +-
 kernel/hrtimer.c                       |    2 +-
 kernel/profile.c                       |    2 +-
 kernel/rcupdate.c                      |    2 +-
 kernel/softirq.c                       |    2 +-
 kernel/softlockup.c                    |    2 +-
 kernel/timer.c                         |    2 +-
 kernel/workqueue.c                     |    2 +-
 mm/page_alloc.c                        |    2 +-
 mm/slab.c                              |    2 +-
 mm/vmscan.c                            |    2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

Index: linux-2617-rc2/arch/i386/kernel/cpuid.c
===================================================================
--- linux-2617-rc2.orig/arch/i386/kernel/cpuid.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/arch/i386/kernel/cpuid.c	2006-04-24 08:35:08.000000000 -0700
@@ -168,7 +168,7 @@ static int cpuid_class_device_create(int
 	return err;
 }
 
-static int __devinit cpuid_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
+static int cpuid_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
 
Index: linux-2617-rc2/arch/i386/kernel/msr.c
===================================================================
--- linux-2617-rc2.orig/arch/i386/kernel/msr.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/arch/i386/kernel/msr.c	2006-04-24 08:35:08.000000000 -0700
@@ -251,7 +251,7 @@ static int msr_class_device_create(int i
 	return err;
 }
 
-static int __devinit msr_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
+static int msr_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
 
Index: linux-2617-rc2/arch/ia64/kernel/palinfo.c
===================================================================
--- linux-2617-rc2.orig/arch/ia64/kernel/palinfo.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/arch/ia64/kernel/palinfo.c	2006-04-24 08:35:08.000000000 -0700
@@ -959,7 +959,7 @@ remove_palinfo_proc_entries(unsigned int
 	}
 }
 
-static int __devinit palinfo_cpu_callback(struct notifier_block *nfb,
+static int palinfo_cpu_callback(struct notifier_block *nfb,
 								unsigned long action,
 								void *hcpu)
 {
Index: linux-2617-rc2/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2617-rc2.orig/arch/powerpc/kernel/sysfs.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/arch/powerpc/kernel/sysfs.c	2006-04-24 08:35:08.000000000 -0700
@@ -279,7 +279,7 @@ static void unregister_cpu_online(unsign
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static int __devinit sysfs_cpu_notify(struct notifier_block *self,
+static int sysfs_cpu_notify(struct notifier_block *self,
 				      unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned int)(long)hcpu;
Index: linux-2617-rc2/kernel/hrtimer.c
===================================================================
--- linux-2617-rc2.orig/kernel/hrtimer.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/kernel/hrtimer.c	2006-04-24 08:35:08.000000000 -0700
@@ -836,7 +836,7 @@ static void migrate_hrtimers(int cpu)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static int __devinit hrtimer_cpu_notify(struct notifier_block *self,
+static int hrtimer_cpu_notify(struct notifier_block *self,
 					unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
Index: linux-2617-rc2/kernel/profile.c
===================================================================
--- linux-2617-rc2.orig/kernel/profile.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/kernel/profile.c	2006-04-24 08:35:08.000000000 -0700
@@ -299,7 +299,7 @@ out:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int __devinit profile_cpu_callback(struct notifier_block *info,
+static int profile_cpu_callback(struct notifier_block *info,
 					unsigned long action, void *__cpu)
 {
 	int node, cpu = (unsigned long)__cpu;
Index: linux-2617-rc2/kernel/rcupdate.c
===================================================================
--- linux-2617-rc2.orig/kernel/rcupdate.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/kernel/rcupdate.c	2006-04-24 10:21:20.000000000 -0700
@@ -520,7 +520,7 @@ static void __devinit rcu_online_cpu(int
 	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
 }
 
-static int __devinit rcu_cpu_notify(struct notifier_block *self, 
+static int rcu_cpu_notify(struct notifier_block *self,
 				unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
Index: linux-2617-rc2/kernel/softirq.c
===================================================================
--- linux-2617-rc2.orig/kernel/softirq.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/kernel/softirq.c	2006-04-24 10:19:15.000000000 -0700
@@ -446,7 +446,7 @@ static void takeover_tasklets(unsigned i
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static int __devinit cpu_callback(struct notifier_block *nfb,
+static int cpu_callback(struct notifier_block *nfb,
 				  unsigned long action,
 				  void *hcpu)
 {
Index: linux-2617-rc2/kernel/timer.c
===================================================================
--- linux-2617-rc2.orig/kernel/timer.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/kernel/timer.c	2006-04-24 10:21:43.000000000 -0700
@@ -1314,7 +1314,7 @@ static void __devinit migrate_timers(int
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static int __devinit timer_cpu_notify(struct notifier_block *self, 
+static int timer_cpu_notify(struct notifier_block *self,
 				unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
Index: linux-2617-rc2/kernel/workqueue.c
===================================================================
--- linux-2617-rc2.orig/kernel/workqueue.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/kernel/workqueue.c	2006-04-24 08:35:08.000000000 -0700
@@ -547,7 +547,7 @@ static void take_over_work(struct workqu
 }
 
 /* We're holding the cpucontrol mutex here */
-static int __devinit workqueue_cpu_callback(struct notifier_block *nfb,
+static int workqueue_cpu_callback(struct notifier_block *nfb,
 				  unsigned long action,
 				  void *hcpu)
 {
Index: linux-2617-rc2/mm/slab.c
===================================================================
--- linux-2617-rc2.orig/mm/slab.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/mm/slab.c	2006-04-24 08:35:08.000000000 -0700
@@ -1036,7 +1036,7 @@ static inline void free_alien_cache(stru
 
 #endif
 
-static int __devinit cpuup_callback(struct notifier_block *nfb,
+static int cpuup_callback(struct notifier_block *nfb,
 				    unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
Index: linux-2617-rc2/arch/ia64/kernel/topology.c
===================================================================
--- linux-2617-rc2.orig/arch/ia64/kernel/topology.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/arch/ia64/kernel/topology.c	2006-04-24 08:35:08.000000000 -0700
@@ -429,7 +429,7 @@ static int __cpuinit cache_remove_dev(st
  * When a cpu is hot-plugged, do a check and initiate
  * cache kobject if necessary
  */
-static int __cpuinit cache_cpu_callback(struct notifier_block *nfb,
+static int cache_cpu_callback(struct notifier_block *nfb,
 		unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
Index: linux-2617-rc2/arch/i386/kernel/cpu/intel_cacheinfo.c
===================================================================
--- linux-2617-rc2.orig/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-04-24 08:35:08.000000000 -0700
@@ -642,7 +642,7 @@ static void __cpuexit cache_remove_dev(s
 	return;
 }
 
-static int __cpuinit cacheinfo_cpu_callback(struct notifier_block *nfb,
+static int cacheinfo_cpu_callback(struct notifier_block *nfb,
 					unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
Index: linux-2617-rc2/arch/x86_64/kernel/mce_amd.c
===================================================================
--- linux-2617-rc2.orig/arch/x86_64/kernel/mce_amd.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/arch/x86_64/kernel/mce_amd.c	2006-04-24 08:35:08.000000000 -0700
@@ -482,7 +482,7 @@ static void threshold_remove_device(unsi
 #endif
 
 /* get notified when a cpu comes on/off */
-static __cpuinit int threshold_cpu_callback(struct notifier_block *nfb,
+static int threshold_cpu_callback(struct notifier_block *nfb,
 					    unsigned long action, void *hcpu)
 {
 	/* cpu was unsigned int to begin with */
Index: linux-2617-rc2/drivers/base/topology.c
===================================================================
--- linux-2617-rc2.orig/drivers/base/topology.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/drivers/base/topology.c	2006-04-24 08:35:08.000000000 -0700
@@ -107,7 +107,7 @@ static int __cpuinit topology_remove_dev
 	return 0;
 }
 
-static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
+static int topology_cpu_callback(struct notifier_block *nfb,
 		unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
Index: linux-2617-rc2/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2617-rc2.orig/drivers/cpufreq/cpufreq.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/drivers/cpufreq/cpufreq.c	2006-04-24 08:35:08.000000000 -0700
@@ -1497,7 +1497,7 @@ int cpufreq_update_policy(unsigned int c
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 
-static int __cpuinit cpufreq_cpu_callback(struct notifier_block *nfb,
+static int cpufreq_cpu_callback(struct notifier_block *nfb,
 					unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
Index: linux-2617-rc2/mm/page_alloc.c
===================================================================
--- linux-2617-rc2.orig/mm/page_alloc.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/mm/page_alloc.c	2006-04-24 08:35:08.000000000 -0700
@@ -1960,7 +1960,7 @@ static inline void free_zone_pagesets(in
 	}
 }
 
-static int __cpuinit pageset_cpuup_callback(struct notifier_block *nfb,
+static int pageset_cpuup_callback(struct notifier_block *nfb,
 		unsigned long action,
 		void *hcpu)
 {
Index: linux-2617-rc2/mm/vmscan.c
===================================================================
--- linux-2617-rc2.orig/mm/vmscan.c	2006-04-24 08:34:25.000000000 -0700
+++ linux-2617-rc2/mm/vmscan.c	2006-04-24 08:35:08.000000000 -0700
@@ -1328,7 +1328,7 @@ repeat:
    not required for correctness.  So if the last cpu in a node goes
    away, we get changed to run anywhere: as the first one comes back,
    restore their cpu bindings. */
-static int __devinit cpu_callback(struct notifier_block *nfb,
+static int cpu_callback(struct notifier_block *nfb,
 				  unsigned long action, void *hcpu)
 {
 	pg_data_t *pgdat;
Index: linux-2617-rc2/kernel/softlockup.c
===================================================================
--- linux-2617-rc2.orig/kernel/softlockup.c	2006-04-24 07:00:06.000000000 -0700
+++ linux-2617-rc2/kernel/softlockup.c	2006-04-24 10:19:33.000000000 -0700
@@ -104,7 +104,7 @@ static int watchdog(void * __bind_cpu)
 /*
  * Create/destroy watchdog threads as CPUs come and go:
  */
-static int __devinit
+static int
 cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
Index: linux-2617-rc2/arch/ia64/kernel/salinfo.c
===================================================================
--- linux-2617-rc2.orig/arch/ia64/kernel/salinfo.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2617-rc2/arch/ia64/kernel/salinfo.c	2006-04-24 09:48:39.000000000 -0700
@@ -572,7 +572,7 @@ static struct file_operations salinfo_da
 };
 
 #ifdef	CONFIG_HOTPLUG_CPU
-static int __devinit
+static int
 salinfo_cpu_callback(struct notifier_block *nb, unsigned long action, void *hcpu)
 {
 	unsigned int i, cpu = (unsigned long)hcpu;
Index: linux-2617-rc2/arch/x86_64/kernel/mce.c
===================================================================
--- linux-2617-rc2.orig/arch/x86_64/kernel/mce.c	2006-04-19 10:17:08.000000000 -0700
+++ linux-2617-rc2/arch/x86_64/kernel/mce.c	2006-04-24 09:49:08.000000000 -0700
@@ -629,7 +629,7 @@ static __cpuinit void mce_remove_device(
 #endif
 
 /* Get notified when a cpu comes on/off. Be hotplug friendly. */
-static __cpuinit int
+static int
 mce_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
