Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422757AbWA1Q2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbWA1Q2q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWA1Q2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:28:46 -0500
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:58257 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965027AbWA1Q2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:28:45 -0500
Date: Sat, 28 Jan 2006 11:26:02 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: __devinit should be __cpuinit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601281128_MC3-1-B6FC-B971@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several places in arch/i386/kernel/cpu and kernel/cpu were using
__devinit when they should have been __cpuinit.  Fixing that saves
~4K when CONFIG_HOTPLUG && !CONFIG_HOTPLUG_CPU.

Noticed by Andrew Morton.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

Andrew, you can drop i386-allow-disabling-x86_feature_sep-at-boot.patch
and I'll send you a new one that applies after this.

 arch/i386/kernel/cpu/common.c          |   32 ++++++++++++++++----------------
 arch/i386/kernel/cpu/cyrix.c           |    2 +-
 arch/i386/kernel/cpu/intel.c           |   12 ++++++------
 arch/i386/kernel/cpu/intel_cacheinfo.c |    2 +-
 kernel/cpu.c                           |    2 +-
 5 files changed, 25 insertions(+), 25 deletions(-)

--- 2.6.16-rc1-mm3-386.orig/arch/i386/kernel/cpu/common.c
+++ 2.6.16-rc1-mm3-386/arch/i386/kernel/cpu/common.c
@@ -21,9 +21,9 @@
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
-static int cachesize_override __devinitdata = -1;
-static int disable_x86_fxsr __devinitdata = 0;
-static int disable_x86_serial_nr __devinitdata = 1;
+static int cachesize_override __cpuinitdata = -1;
+static int disable_x86_fxsr __cpuinitdata = 0;
+static int disable_x86_serial_nr __cpuinitdata = 1;
 
 struct cpu_dev * cpu_devs[X86_VENDOR_NUM] = {};
 
@@ -54,7 +54,7 @@ static int __init cachesize_setup(char *
 }
 __setup("cachesize=", cachesize_setup);
 
-int __devinit get_model_name(struct cpuinfo_x86 *c)
+int __cpuinit get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
 	char *p, *q;
@@ -84,7 +84,7 @@ int __devinit get_model_name(struct cpui
 }
 
 
-void __devinit display_cacheinfo(struct cpuinfo_x86 *c)
+void __cpuinit display_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, ecx, edx, l2size;
 
@@ -125,7 +125,7 @@ void __devinit display_cacheinfo(struct 
 /* in particular, if CPUID levels 0x80000002..4 are supported, this isn't used */
 
 /* Look up CPU names by table lookup. */
-static char __devinit *table_lookup_model(struct cpuinfo_x86 *c)
+static char __cpuinit *table_lookup_model(struct cpuinfo_x86 *c)
 {
 	struct cpu_model_info *info;
 
@@ -146,7 +146,7 @@ static char __devinit *table_lookup_mode
 }
 
 
-static void __devinit get_cpu_vendor(struct cpuinfo_x86 *c, int early)
+static void __cpuinit get_cpu_vendor(struct cpuinfo_x86 *c, int early)
 {
 	char *v = c->x86_vendor_id;
 	int i;
@@ -197,7 +197,7 @@ static inline int flag_is_changeable_p(u
 
 
 /* Probe for the CPUID instruction */
-static int __devinit have_cpuid_p(void)
+static int __cpuinit have_cpuid_p(void)
 {
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
@@ -241,7 +241,7 @@ static void __init early_cpu_detect(void
 	}
 }
 
-void __devinit generic_identify(struct cpuinfo_x86 * c)
+void __cpuinit generic_identify(struct cpuinfo_x86 * c)
 {
 	u32 tfms, xlvl;
 	int junk;
@@ -294,7 +294,7 @@ void __devinit generic_identify(struct c
 #endif
 }
 
-static void __devinit squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
+static void __cpuinit squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_PN) && disable_x86_serial_nr ) {
 		/* Disable processor serial number */
@@ -322,7 +322,7 @@ __setup("serialnumber", x86_serial_nr_se
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
-void __devinit identify_cpu(struct cpuinfo_x86 *c)
+void __cpuinit identify_cpu(struct cpuinfo_x86 *c)
 {
 	int i;
 
@@ -440,7 +440,7 @@ void __devinit identify_cpu(struct cpuin
 }
 
 #ifdef CONFIG_X86_HT
-void __devinit detect_ht(struct cpuinfo_x86 *c)
+void __cpuinit detect_ht(struct cpuinfo_x86 *c)
 {
 	u32 	eax, ebx, ecx, edx;
 	int 	index_msb, core_bits;
@@ -487,7 +487,7 @@ void __devinit detect_ht(struct cpuinfo_
 }
 #endif
 
-void __devinit print_cpu_info(struct cpuinfo_x86 *c)
+void __cpuinit print_cpu_info(struct cpuinfo_x86 *c)
 {
 	char *vendor = NULL;
 
@@ -510,7 +510,7 @@ void __devinit print_cpu_info(struct cpu
 		printk("\n");
 }
 
-cpumask_t cpu_initialized __devinitdata = CPU_MASK_NONE;
+cpumask_t cpu_initialized __cpuinitdata = CPU_MASK_NONE;
 
 /* This is hacky. :)
  * We're emulating future behavior.
@@ -557,7 +557,7 @@ void __init early_cpu_init(void)
  * and IDT. We reload them nevertheless, this function acts as a
  * 'CPU state barrier', nothing should get across.
  */
-void __devinit cpu_init(void)
+void __cpuinit cpu_init(void)
 {
 	int cpu = smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
@@ -637,7 +637,7 @@ void __devinit cpu_init(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-void __devinit cpu_uninit(void)
+void __cpuinit cpu_uninit(void)
 {
 	int cpu = raw_smp_processor_id();
 	cpu_clear(cpu, cpu_initialized);
--- 2.6.16-rc1-mm3-386.orig/arch/i386/kernel/cpu/cyrix.c
+++ 2.6.16-rc1-mm3-386/arch/i386/kernel/cpu/cyrix.c
@@ -345,7 +345,7 @@ static void __init init_cyrix(struct cpu
 /*
  * Handle National Semiconductor branded processors
  */
-static void __devinit init_nsc(struct cpuinfo_x86 *c)
+static void __cpuinit init_nsc(struct cpuinfo_x86 *c)
 {
 	/* There may be GX1 processors in the wild that are branded
 	 * NSC and not Cyrix.
--- 2.6.16-rc1-mm3-386.orig/arch/i386/kernel/cpu/intel.c
+++ 2.6.16-rc1-mm3-386/arch/i386/kernel/cpu/intel.c
@@ -29,7 +29,7 @@ extern int trap_init_f00f_bug(void);
 struct movsl_mask movsl_mask __read_mostly;
 #endif
 
-void __devinit early_intel_workaround(struct cpuinfo_x86 *c)
+void __cpuinit early_intel_workaround(struct cpuinfo_x86 *c)
 {
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return;
@@ -44,7 +44,7 @@ void __devinit early_intel_workaround(st
  *	This is called before we do cpu ident work
  */
  
-int __devinit ppro_with_ram_bug(void)
+int __cpuinit ppro_with_ram_bug(void)
 {
 	/* Uses data from early_cpu_detect now */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
@@ -62,7 +62,7 @@ int __devinit ppro_with_ram_bug(void)
  * P4 Xeon errata 037 workaround.
  * Hardware prefetcher may cause stale data to be loaded into the cache.
  */
-static void __devinit Intel_errata_workarounds(struct cpuinfo_x86 *c)
+static void __cpuinit Intel_errata_workarounds(struct cpuinfo_x86 *c)
 {
 	unsigned long lo, hi;
 
@@ -81,7 +81,7 @@ static void __devinit Intel_errata_worka
 /*
  * find out the number of processor cores on the die
  */
-static int __devinit num_cpu_cores(struct cpuinfo_x86 *c)
+static int __cpuinit num_cpu_cores(struct cpuinfo_x86 *c)
 {
 	unsigned int eax, ebx, ecx, edx;
 
@@ -96,7 +96,7 @@ static int __devinit num_cpu_cores(struc
 		return 1;
 }
 
-static void __devinit init_intel(struct cpuinfo_x86 *c)
+static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 {
 	unsigned int l2 = 0;
 	char *p = NULL;
@@ -205,7 +205,7 @@ static unsigned int intel_size_cache(str
 	return size;
 }
 
-static struct cpu_dev intel_cpu_dev __devinitdata = {
+static struct cpu_dev intel_cpu_dev __cpuinitdata = {
 	.c_vendor	= "Intel",
 	.c_ident 	= { "GenuineIntel" },
 	.c_models = {
--- 2.6.16-rc1-mm3-386.orig/arch/i386/kernel/cpu/intel_cacheinfo.c
+++ 2.6.16-rc1-mm3-386/arch/i386/kernel/cpu/intel_cacheinfo.c
@@ -318,7 +318,7 @@ static void __cpuinit cache_shared_cpu_m
 		}
 	}
 }
-static void __devinit cache_remove_shared_cpu_map(unsigned int cpu, int index)
+static void __cpuinit cache_remove_shared_cpu_map(unsigned int cpu, int index)
 {
 	struct _cpuid4_info	*this_leaf, *sibling_leaf;
 	int sibling;
--- 2.6.16-rc1-mm3-386.orig/kernel/cpu.c
+++ 2.6.16-rc1-mm3-386/kernel/cpu.c
@@ -198,7 +198,7 @@ out:
 }
 #endif /*CONFIG_HOTPLUG_CPU*/
 
-int __devinit cpu_up(unsigned int cpu)
+int __cpuinit cpu_up(unsigned int cpu)
 {
 	int ret;
 	void *hcpu = (void *)(long)cpu;
-- 
Chuck
