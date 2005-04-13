Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVDMDft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVDMDft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVDMDda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 23:33:30 -0400
Received: from fmr19.intel.com ([134.134.136.18]:41421 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262606AbVDMDX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 23:23:29 -0400
Subject: Re: [PATCH 3/6]init call cleanup
From: Li Shaohua <shaohua.li@intel.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200504121132.30027@bilbo.math.uni-mannheim.de>
References: <200504121132.30027@bilbo.math.uni-mannheim.de>
Content-Type: text/plain
Message-Id: <1113362416.7148.35.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Apr 2005 11:20:17 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 17:32, Rolf Eike Beer wrote:
> Li Shaohua wrote:
> > Trival patch for CPU hotplug. In CPU identify  part, only did cleaup
> for
> > intel CPUs. Need do for other CPUs if they support S3 SMP.
> >
> > @@ -405,7 +405,7 @@ void __init init_bsp_APIC(void)
> >       apic_write_around(APIC_LVT1, value);
> >  }
> >
> > -void __init setup_local_APIC (void)
> > +void __devinit setup_local_APIC (void)
>                                   ^
> 
> >  {
> >       unsigned long oldvalue, value, ver, maxlvt;
> >
> 
> Please remove this space while you are at it.
> 
> > @@ -556,7 +556,7 @@ void __init early_cpu_init(void)
> >   * and IDT. We reload them nevertheless, this function acts as a
> >   * 'CPU state barrier', nothing should get across.
> >   */
> > -void __init cpu_init (void)
> > +void __devinit cpu_init (void)
> >  {
> >       int cpu = smp_processor_id();
> >       struct tss_struct * t = &per_cpu(init_tss, cpu);
> 
> This one too.
Removed the space at two places as suggested.

Thanks,
Shaohua

Trival patch for CPU hotplug. In CPU identify  part, only did cleaup for intel
CPUs. Need do for other CPUs if they support S3 SMP.

---

 linux-2.6.11-root/arch/i386/kernel/apic.c                |   14 +++----
 linux-2.6.11-root/arch/i386/kernel/cpu/common.c          |   30 +++++++--------
 linux-2.6.11-root/arch/i386/kernel/cpu/intel.c           |   12 +++---
 linux-2.6.11-root/arch/i386/kernel/cpu/intel_cacheinfo.c |    4 +-
 linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/mce.c      |    4 +-
 linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p4.c       |    4 +-
 linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p5.c       |    2 -
 linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p6.c       |    2 -
 linux-2.6.11-root/arch/i386/kernel/process.c             |    2 -
 linux-2.6.11-root/arch/i386/kernel/setup.c               |    2 -
 linux-2.6.11-root/arch/i386/kernel/smpboot.c             |   18 ++++-----
 linux-2.6.11-root/arch/i386/kernel/timers/timer_tsc.c    |    2 -
 12 files changed, 48 insertions(+), 48 deletions(-)

diff -puN arch/i386/kernel/apic.c~init_call_cleanup arch/i386/kernel/apic.c
--- linux-2.6.11/arch/i386/kernel/apic.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/apic.c	2005-04-13 10:57:55.817365288 +0800
@@ -405,7 +405,7 @@ void __init init_bsp_APIC(void)
 	apic_write_around(APIC_LVT1, value);
 }
 
-void __init setup_local_APIC (void)
+void __devinit setup_local_APIC(void)
 {
 	unsigned long oldvalue, value, ver, maxlvt;
 
@@ -676,7 +676,7 @@ static struct sys_device device_lapic = 
 	.cls	= &lapic_sysclass,
 };
 
-static void __init apic_pm_activate(void)
+static void __devinit apic_pm_activate(void)
 {
 	apic_pm_state.active = 1;
 }
@@ -877,7 +877,7 @@ fake_ioapic_page:
  * but we do not accept timer interrupts yet. We only allow the BP
  * to calibrate.
  */
-static unsigned int __init get_8254_timer_count(void)
+static unsigned int __devinit get_8254_timer_count(void)
 {
 	extern spinlock_t i8253_lock;
 	unsigned long flags;
@@ -896,7 +896,7 @@ static unsigned int __init get_8254_time
 }
 
 /* next tick in 8254 can be caught by catching timer wraparound */
-static void __init wait_8254_wraparound(void)
+static void __devinit wait_8254_wraparound(void)
 {
 	unsigned int curr_count, prev_count;
 
@@ -916,7 +916,7 @@ static void __init wait_8254_wraparound(
  * Default initialization for 8254 timers. If we use other timers like HPET,
  * we override this later
  */
-void (*wait_timer_tick)(void) __initdata = wait_8254_wraparound;
+void (*wait_timer_tick)(void) __devinitdata = wait_8254_wraparound;
 
 /*
  * This function sets up the local APIC timer, with a timeout of
@@ -952,7 +952,7 @@ static void __setup_APIC_LVTT(unsigned i
 	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
 }
 
-static void __init setup_APIC_timer(unsigned int clocks)
+static void __devinit setup_APIC_timer(unsigned int clocks)
 {
 	unsigned long flags;
 
@@ -1065,7 +1065,7 @@ void __init setup_boot_APIC_clock(void)
 	local_irq_enable();
 }
 
-void __init setup_secondary_APIC_clock(void)
+void __devinit setup_secondary_APIC_clock(void)
 {
 	setup_APIC_timer(calibration_result);
 }
diff -puN arch/i386/kernel/cpu/common.c~init_call_cleanup arch/i386/kernel/cpu/common.c
--- linux-2.6.11/arch/i386/kernel/cpu/common.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/common.c	2005-04-13 10:58:25.777810608 +0800
@@ -24,9 +24,9 @@ EXPORT_PER_CPU_SYMBOL(cpu_gdt_table);
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
-static int cachesize_override __initdata = -1;
-static int disable_x86_fxsr __initdata = 0;
-static int disable_x86_serial_nr __initdata = 1;
+static int cachesize_override __devinitdata = -1;
+static int disable_x86_fxsr __devinitdata = 0;
+static int disable_x86_serial_nr __devinitdata = 1;
 
 struct cpu_dev * cpu_devs[X86_VENDOR_NUM] = {};
 
@@ -59,7 +59,7 @@ static int __init cachesize_setup(char *
 }
 __setup("cachesize=", cachesize_setup);
 
-int __init get_model_name(struct cpuinfo_x86 *c)
+int __devinit get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
 	char *p, *q;
@@ -89,7 +89,7 @@ int __init get_model_name(struct cpuinfo
 }
 
 
-void __init display_cacheinfo(struct cpuinfo_x86 *c)
+void __devinit display_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, ecx, edx, l2size;
 
@@ -130,7 +130,7 @@ void __init display_cacheinfo(struct cpu
 /* in particular, if CPUID levels 0x80000002..4 are supported, this isn't used */
 
 /* Look up CPU names by table lookup. */
-static char __init *table_lookup_model(struct cpuinfo_x86 *c)
+static char __devinit *table_lookup_model(struct cpuinfo_x86 *c)
 {
 	struct cpu_model_info *info;
 
@@ -151,7 +151,7 @@ static char __init *table_lookup_model(s
 }
 
 
-void __init get_cpu_vendor(struct cpuinfo_x86 *c, int early)
+void __devinit get_cpu_vendor(struct cpuinfo_x86 *c, int early)
 {
 	char *v = c->x86_vendor_id;
 	int i;
@@ -202,7 +202,7 @@ static inline int flag_is_changeable_p(u
 
 
 /* Probe for the CPUID instruction */
-static int __init have_cpuid_p(void)
+static int __devinit have_cpuid_p(void)
 {
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
@@ -245,7 +245,7 @@ static void __init early_cpu_detect(void
 	early_intel_workaround(c);
 }
 
-void __init generic_identify(struct cpuinfo_x86 * c)
+void __devinit generic_identify(struct cpuinfo_x86 * c)
 {
 	u32 tfms, xlvl;
 	int junk;
@@ -292,7 +292,7 @@ void __init generic_identify(struct cpui
 	}
 }
 
-static void __init squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
+static void __devinit squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_PN) && disable_x86_serial_nr ) {
 		/* Disable processor serial number */
@@ -320,7 +320,7 @@ __setup("serialnumber", x86_serial_nr_se
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
-void __init identify_cpu(struct cpuinfo_x86 *c)
+void __devinit identify_cpu(struct cpuinfo_x86 *c)
 {
 	int i;
 
@@ -431,7 +431,7 @@ void __init identify_cpu(struct cpuinfo_
 }
 
 #ifdef CONFIG_X86_HT
-void __init detect_ht(struct cpuinfo_x86 *c)
+void __devinit detect_ht(struct cpuinfo_x86 *c)
 {
 	u32 	eax, ebx, ecx, edx;
 	int 	index_msb, tmp;
@@ -486,7 +486,7 @@ void __init detect_ht(struct cpuinfo_x86
 }
 #endif
 
-void __init print_cpu_info(struct cpuinfo_x86 *c)
+void __devinit print_cpu_info(struct cpuinfo_x86 *c)
 {
 	char *vendor = NULL;
 
@@ -509,7 +509,7 @@ void __init print_cpu_info(struct cpuinf
 		printk("\n");
 }
 
-cpumask_t cpu_initialized __initdata = CPU_MASK_NONE;
+cpumask_t cpu_initialized __devinitdata = CPU_MASK_NONE;
 
 /* This is hacky. :)
  * We're emulating future behavior.
@@ -556,7 +556,7 @@ void __init early_cpu_init(void)
  * and IDT. We reload them nevertheless, this function acts as a
  * 'CPU state barrier', nothing should get across.
  */
-void __init cpu_init (void)
+void __devinit cpu_init(void)
 {
 	int cpu = smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
diff -puN arch/i386/kernel/cpu/intel.c~init_call_cleanup arch/i386/kernel/cpu/intel.c
--- linux-2.6.11/arch/i386/kernel/cpu/intel.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/intel.c	2005-04-12 10:37:07.000000000 +0800
@@ -28,7 +28,7 @@ extern int trap_init_f00f_bug(void);
 struct movsl_mask movsl_mask;
 #endif
 
-void __init early_intel_workaround(struct cpuinfo_x86 *c)
+void __devinit early_intel_workaround(struct cpuinfo_x86 *c)
 {
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return;
@@ -43,7 +43,7 @@ void __init early_intel_workaround(struc
  *	This is called before we do cpu ident work
  */
  
-int __init ppro_with_ram_bug(void)
+int __devinit ppro_with_ram_bug(void)
 {
 	/* Uses data from early_cpu_detect now */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
@@ -61,7 +61,7 @@ int __init ppro_with_ram_bug(void)
  * P4 Xeon errata 037 workaround.
  * Hardware prefetcher may cause stale data to be loaded into the cache.
  */
-static void __init Intel_errata_workarounds(struct cpuinfo_x86 *c)
+static void __devinit Intel_errata_workarounds(struct cpuinfo_x86 *c)
 {
 	unsigned long lo, hi;
 
@@ -80,7 +80,7 @@ static void __init Intel_errata_workarou
 /*
  * find out the number of processor cores on the die
  */
-static int __init num_cpu_cores(struct cpuinfo_x86 *c)
+static int __devinit num_cpu_cores(struct cpuinfo_x86 *c)
 {
 	unsigned int eax;
 
@@ -98,7 +98,7 @@ static int __init num_cpu_cores(struct c
 		return 1;
 }
 
-static void __init init_intel(struct cpuinfo_x86 *c)
+static void __devinit init_intel(struct cpuinfo_x86 *c)
 {
 	unsigned int l2 = 0;
 	char *p = NULL;
@@ -204,7 +204,7 @@ static unsigned int intel_size_cache(str
 	return size;
 }
 
-static struct cpu_dev intel_cpu_dev __initdata = {
+static struct cpu_dev intel_cpu_dev __devinitdata = {
 	.c_vendor	= "Intel",
 	.c_ident 	= { "GenuineIntel" },
 	.c_models = {
diff -puN arch/i386/kernel/cpu/intel_cacheinfo.c~init_call_cleanup arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.11/arch/i386/kernel/cpu/intel_cacheinfo.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-04-12 10:37:07.000000000 +0800
@@ -28,7 +28,7 @@ struct _cache_table
 };
 
 /* all the cache descriptor types we care about (no TLB or trace cache entries) */
-static struct _cache_table cache_table[] __initdata =
+static struct _cache_table cache_table[] __devinitdata =
 {
 	{ 0x06, LVL_1_INST, 8 },	/* 4-way set assoc, 32 byte line size */
 	{ 0x08, LVL_1_INST, 16 },	/* 4-way set assoc, 32 byte line size */
@@ -160,7 +160,7 @@ static int __init find_num_cache_leaves(
 	return retval;
 }
 
-unsigned int __init init_intel_cacheinfo(struct cpuinfo_x86 *c)
+unsigned int __devinit init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
diff -puN arch/i386/kernel/cpu/mcheck/mce.c~init_call_cleanup arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6.11/arch/i386/kernel/cpu/mcheck/mce.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/mce.c	2005-04-12 10:37:07.000000000 +0800
@@ -16,7 +16,7 @@
 
 #include "mce.h"
 
-int mce_disabled __initdata = 0;
+int mce_disabled __devinitdata = 0;
 int nr_mce_banks;
 
 EXPORT_SYMBOL_GPL(nr_mce_banks);	/* non-fatal.o */
@@ -31,7 +31,7 @@ static fastcall void unexpected_machine_
 void fastcall (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
 /* This has to be run for each processor */
-void __init mcheck_init(struct cpuinfo_x86 *c)
+void __devinit mcheck_init(struct cpuinfo_x86 *c)
 {
 	if (mce_disabled==1)
 		return;
diff -puN arch/i386/kernel/cpu/mcheck/p4.c~init_call_cleanup arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.11/arch/i386/kernel/cpu/mcheck/p4.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p4.c	2005-04-12 10:37:07.000000000 +0800
@@ -78,7 +78,7 @@ fastcall void smp_thermal_interrupt(stru
 }
 
 /* P4/Xeon Thermal regulation detect and init */
-static void __init intel_init_thermal(struct cpuinfo_x86 *c)
+static void __devinit intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	unsigned int cpu = smp_processor_id();
@@ -232,7 +232,7 @@ static fastcall void intel_machine_check
 }
 
 
-void __init intel_p4_mcheck_init(struct cpuinfo_x86 *c)
+void __devinit intel_p4_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
diff -puN arch/i386/kernel/cpu/mcheck/p5.c~init_call_cleanup arch/i386/kernel/cpu/mcheck/p5.c
--- linux-2.6.11/arch/i386/kernel/cpu/mcheck/p5.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p5.c	2005-04-12 10:37:07.000000000 +0800
@@ -29,7 +29,7 @@ static fastcall void pentium_machine_che
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
-void __init intel_p5_mcheck_init(struct cpuinfo_x86 *c)
+void __devinit intel_p5_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	
diff -puN arch/i386/kernel/cpu/mcheck/p6.c~init_call_cleanup arch/i386/kernel/cpu/mcheck/p6.c
--- linux-2.6.11/arch/i386/kernel/cpu/mcheck/p6.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/mcheck/p6.c	2005-04-12 10:37:07.000000000 +0800
@@ -80,7 +80,7 @@ static fastcall void intel_machine_check
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
-void __init intel_p6_mcheck_init(struct cpuinfo_x86 *c)
+void __devinit intel_p6_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
diff -puN arch/i386/kernel/process.c~init_call_cleanup arch/i386/kernel/process.c
--- linux-2.6.11/arch/i386/kernel/process.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/process.c	2005-04-13 10:56:58.856024728 +0800
@@ -256,7 +256,7 @@ static void mwait_idle(void)
 	}
 }
 
-void __init select_idle_routine(const struct cpuinfo_x86 *c)
+void __devinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_MWAIT)) {
 		printk("monitor/mwait feature present.\n");
diff -puN arch/i386/kernel/setup.c~init_call_cleanup arch/i386/kernel/setup.c
--- linux-2.6.11/arch/i386/kernel/setup.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/setup.c	2005-04-12 10:37:07.000000000 +0800
@@ -66,7 +66,7 @@ void __init find_max_pfn(void);
    address, and must not be in the .bss segment! */
 unsigned long init_pg_tables_end __initdata = ~0UL;
 
-int disable_pse __initdata = 0;
+int disable_pse __devinitdata = 0;
 
 /*
  * Machine setup..
diff -puN arch/i386/kernel/smpboot.c~init_call_cleanup arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-04-13 10:56:58.857024576 +0800
@@ -59,7 +59,7 @@
 #include <smpboot_hooks.h>
 
 /* Set if we find a B stepping CPU */
-static int __initdata smp_b_stepping;
+static int __devinitdata smp_b_stepping;
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -107,7 +107,7 @@ DEFINE_PER_CPU(int, cpu_state) = { 0 };
  * has made sure it's suitably aligned.
  */
 
-static unsigned long __init setup_trampoline(void)
+static unsigned long __devinit setup_trampoline(void)
 {
 	memcpy(trampoline_base, trampoline_data, trampoline_end - trampoline_data);
 	return virt_to_phys(trampoline_base);
@@ -137,7 +137,7 @@ void __init smp_alloc_memory(void)
  * a given CPU
  */
 
-static void __init smp_store_cpu_info(int id)
+static void __devinit smp_store_cpu_info(int id)
 {
 	struct cpuinfo_x86 *c = cpu_data + id;
 
@@ -331,7 +331,7 @@ extern void calibrate_delay(void);
 
 static atomic_t init_deasserted;
 
-static void __init smp_callin(void)
+static void __devinit smp_callin(void)
 {
 	int cpuid, phys_id;
 	unsigned long timeout;
@@ -457,7 +457,7 @@ set_cpu_sibling_map(int cpu)
 /*
  * Activate a secondary processor.
  */
-static void __init start_secondary(void *unused)
+static void __devinit start_secondary(void *unused)
 {
 	/*
 	 * Dont put anything before smp_callin(), SMP
@@ -502,7 +502,7 @@ static void __init start_secondary(void 
  * from the task structure
  * This function must not return.
  */
-void __init initialize_secondary(void)
+void __devinit initialize_secondary(void)
 {
 	/*
 	 * We don't actually need to load the full TSS,
@@ -617,7 +617,7 @@ static inline void __inquire_remote_apic
  * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
  * won't ... remember to clear down the APIC, etc later.
  */
-static int __init
+static int __devinit
 wakeup_secondary_cpu(int logical_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
@@ -663,7 +663,7 @@ wakeup_secondary_cpu(int logical_apicid,
 #endif	/* WAKE_SECONDARY_VIA_NMI */
 
 #ifdef WAKE_SECONDARY_VIA_INIT
-static int __init
+static int __devinit
 wakeup_secondary_cpu(int phys_apicid, unsigned long start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
@@ -799,7 +799,7 @@ wakeup_secondary_cpu(int phys_apicid, un
 
 extern cpumask_t cpu_initialized;
 
-static int __init do_boot_cpu(int apicid)
+static int __devinit do_boot_cpu(int apicid)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
diff -puN arch/i386/kernel/timers/timer_tsc.c~init_call_cleanup arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.11/arch/i386/kernel/timers/timer_tsc.c~init_call_cleanup	2005-04-12 10:37:07.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/timers/timer_tsc.c	2005-04-12 10:37:07.000000000 +0800
@@ -33,7 +33,7 @@ static struct timer_opts timer_tsc;
 
 static inline void cpufreq_delayed_get(void);
 
-int tsc_disable __initdata = 0;
+int tsc_disable __devinitdata = 0;
 
 extern spinlock_t i8253_lock;
 
_


