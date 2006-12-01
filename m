Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759150AbWLAGwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759150AbWLAGwK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759233AbWLAGwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:52:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22276 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1759150AbWLAGwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:52:06 -0500
Date: Fri, 1 Dec 2006 07:52:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] the scheduled removal of X86_SPEEDSTEP_CENTRINO_ACPI
Message-ID: <20061201065211.GN11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled removal of X86_SPEEDSTEP_CENTRINO_ACPI.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt        |   21 -
 arch/i386/kernel/cpu/cpufreq/Kconfig              |   19 
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |  280 --------------
 arch/x86_64/kernel/cpufreq/Kconfig                |    7 
 4 files changed, 21 insertions(+), 306 deletions(-)

--- linux-2.6.19-rc6-mm2/Documentation/feature-removal-schedule.txt.old	2006-12-01 07:23:15.000000000 +0100
+++ linux-2.6.19-rc6-mm2/Documentation/feature-removal-schedule.txt	2006-12-01 07:23:26.000000000 +0100
@@ -261,24 +261,3 @@
 
 ---------------------------
 
-What:	ACPI hooks (X86_SPEEDSTEP_CENTRINO_ACPI) in speedstep-centrino driver
-When:	December 2006
-Why:	Speedstep-centrino driver with ACPI hooks and acpi-cpufreq driver are
-	functionally very much similar. They talk to ACPI in same way. Only
-	difference between them is the way they do frequency transitions.
-	One uses MSRs and the other one uses IO ports. Functionaliy of
-	speedstep_centrino with ACPI hooks is now merged into acpi-cpufreq.
-	That means one common driver will support all Intel Enhanced Speedstep
-	capable CPUs. That means less confusion over name of
-	speedstep-centrino driver (with that driver supposed to be used on
-	non-centrino platforms). That means less duplication of code and
-	less maintenance effort and no possibility of these two drivers
-	going out of sync.
-	Current users of speedstep_centrino with ACPI hooks are requested to
-	switch over to acpi-cpufreq driver. speedstep-centrino will continue
-	to work using older non-ACPI static table based scheme even after this
-	date.
-
-Who:	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
-
----------------------------
--- linux-2.6.19-rc6-mm2/arch/i386/kernel/cpu/cpufreq/Kconfig.old	2006-12-01 07:23:38.000000000 +0100
+++ linux-2.6.19-rc6-mm2/arch/i386/kernel/cpu/cpufreq/Kconfig	2006-12-01 07:24:02.000000000 +0100
@@ -109,7 +109,7 @@
 config X86_SPEEDSTEP_CENTRINO
 	tristate "Intel Enhanced SpeedStep"
 	select CPU_FREQ_TABLE
-	select X86_SPEEDSTEP_CENTRINO_TABLE if (!X86_SPEEDSTEP_CENTRINO_ACPI)
+	select X86_SPEEDSTEP_CENTRINO_TABLE
 	help
 	  This adds the CPUFreq driver for Enhanced SpeedStep enabled
 	  mobile CPUs.  This means Intel Pentium M (Centrino) CPUs. However,
@@ -121,21 +121,6 @@
 
 	  If in doubt, say N.
 
-config X86_SPEEDSTEP_CENTRINO_ACPI
-	bool "Use ACPI tables to decode valid frequency/voltage (deprecated)"
-	depends on X86_SPEEDSTEP_CENTRINO && ACPI_PROCESSOR
-	depends on !(X86_SPEEDSTEP_CENTRINO = y && ACPI_PROCESSOR = m)
-	default y
-	help
-	  This is deprecated and this functionality is now merged into
-	  acpi_cpufreq (X86_ACPI_CPUFREQ). Use that driver instead of
-	  speedstep_centrino.
-	  Use primarily the information provided in the BIOS ACPI tables
-	  to determine valid CPU frequency and voltage pairings. It is
-	  required for the driver to work on non-Banias CPUs.
-
-	  If in doubt, say Y.
-
 config X86_SPEEDSTEP_CENTRINO_TABLE
 	bool "Built-in tables for Banias CPUs"
 	depends on X86_SPEEDSTEP_CENTRINO
@@ -222,7 +207,7 @@
 config X86_ACPI_CPUFREQ_PROC_INTF
 	bool "/proc/acpi/processor/../performance interface (deprecated)"
 	depends on PROC_FS
-	depends on X86_ACPI_CPUFREQ || X86_SPEEDSTEP_CENTRINO_ACPI || X86_POWERNOW_K7_ACPI || X86_POWERNOW_K8_ACPI
+	depends on X86_ACPI_CPUFREQ || X86_POWERNOW_K7_ACPI || X86_POWERNOW_K8_ACPI
 	help
 	  This enables the deprecated /proc/acpi/processor/../performance
 	  interface. While it is helpful for debugging, the generic,
--- linux-2.6.19-rc6-mm2/arch/x86_64/kernel/cpufreq/Kconfig.old	2006-12-01 07:24:11.000000000 +0100
+++ linux-2.6.19-rc6-mm2/arch/x86_64/kernel/cpufreq/Kconfig	2006-12-01 07:24:21.000000000 +0100
@@ -42,11 +42,6 @@
 
 	  If in doubt, say N.
 
-config X86_SPEEDSTEP_CENTRINO_ACPI
-	bool
-	depends on X86_SPEEDSTEP_CENTRINO
-	default y
-
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	select CPU_FREQ_TABLE
@@ -65,7 +60,7 @@
 config X86_ACPI_CPUFREQ_PROC_INTF
         bool "/proc/acpi/processor/../performance interface (deprecated)"
 	depends on PROC_FS
-	depends on X86_ACPI_CPUFREQ || X86_SPEEDSTEP_CENTRINO_ACPI || X86_POWERNOW_K8_ACPI
+	depends on X86_ACPI_CPUFREQ || X86_POWERNOW_K8_ACPI
 	help
 	  This enables the deprecated /proc/acpi/processor/../performance
 	  interface. While it is helpful for debugging, the generic,
--- linux-2.6.19-rc6-mm2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.old	2006-12-01 07:24:35.000000000 +0100
+++ linux-2.6.19-rc6-mm2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-12-01 07:33:13.000000000 +0100
@@ -21,12 +21,6 @@
 #include <linux/delay.h>
 #include <linux/compiler.h>
 
-#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-#include <linux/acpi.h>
-#include <linux/dmi.h>
-#include <acpi/processor.h>
-#endif
-
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -256,9 +250,7 @@
 		/* Matched a non-match */
 		dprintk("no table support for CPU model \"%s\"\n",
 		       cpu->x86_model_id);
-#ifndef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-		dprintk("try compiling with CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI enabled\n");
-#endif
+		dprintk("try using the acpi-cpufreq driver\n");
 		return -ENOENT;
 	}
 
@@ -344,213 +336,6 @@
 	return clock_freq;
 }
 
-
-#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-
-static struct acpi_processor_performance *acpi_perf_data[NR_CPUS];
-
-/*
- * centrino_cpu_early_init_acpi - Do the preregistering with ACPI P-States
- * library
- *
- * Before doing the actual init, we need to do _PSD related setup whenever
- * supported by the BIOS. These are handled by this early_init routine.
- */
-static int centrino_cpu_early_init_acpi(void)
-{
-	unsigned int	i, j;
-	struct acpi_processor_performance	*data;
-
-	for_each_possible_cpu(i) {
-		data = kzalloc(sizeof(struct acpi_processor_performance), 
-				GFP_KERNEL);
-		if (!data) {
-			for_each_possible_cpu(j) {
-				kfree(acpi_perf_data[j]);
-				acpi_perf_data[j] = NULL;
-			}
-			return (-ENOMEM);
-		}
-		acpi_perf_data[i] = data;
-	}
-
-	acpi_processor_preregister_performance(acpi_perf_data);
-	return 0;
-}
-
-
-#ifdef CONFIG_SMP
-/*
- * Some BIOSes do SW_ANY coordination internally, either set it up in hw
- * or do it in BIOS firmware and won't inform about it to OS. If not
- * detected, this has a side effect of making CPU run at a different speed
- * than OS intended it to run at. Detect it and handle it cleanly.
- */
-static int bios_with_sw_any_bug;
-static int sw_any_bug_found(struct dmi_system_id *d)
-{
-	bios_with_sw_any_bug = 1;
-	return 0;
-}
-
-static struct dmi_system_id sw_any_bug_dmi_table[] = {
-	{
-		.callback = sw_any_bug_found,
-		.ident = "Supermicro Server X6DLP",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Supermicro"),
-			DMI_MATCH(DMI_BIOS_VERSION, "080010"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X6DLP"),
-		},
-	},
-	{ }
-};
-#endif
-
-/*
- * centrino_cpu_init_acpi - register with ACPI P-States library
- *
- * Register with the ACPI P-States library (part of drivers/acpi/processor.c)
- * in order to determine correct frequency and voltage pairings by reading
- * the _PSS of the ACPI DSDT or SSDT tables.
- */
-static int centrino_cpu_init_acpi(struct cpufreq_policy *policy)
-{
-	unsigned long			cur_freq;
-	int				result = 0, i;
-	unsigned int			cpu = policy->cpu;
-	struct acpi_processor_performance	*p;
-
-	p = acpi_perf_data[cpu];
-
-	/* register with ACPI core */
-	if (acpi_processor_register_performance(p, cpu)) {
-		dprintk(PFX "obtaining ACPI data failed\n");
-		return -EIO;
-	}
-
-	policy->shared_type = p->shared_type;
-	/*
-	 * Will let policy->cpus know about dependency only when software 
-	 * coordination is required.
-	 */
-	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL ||
-	    policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
-		policy->cpus = p->shared_cpu_map;
-	}
-
-#ifdef CONFIG_SMP
-	dmi_check_system(sw_any_bug_dmi_table);
-	if (bios_with_sw_any_bug && cpus_weight(policy->cpus) == 1) {
-		policy->shared_type = CPUFREQ_SHARED_TYPE_ALL;
-		policy->cpus = cpu_core_map[cpu];
-	}
-#endif
-
-	/* verify the acpi_data */
-	if (p->state_count <= 1) {
-		dprintk("No P-States\n");
-		result = -ENODEV;
-		goto err_unreg;
-	}
-
-	if ((p->control_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) ||
-	    (p->status_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE)) {
-		dprintk("Invalid control/status registers (%x - %x)\n",
-			p->control_register.space_id, p->status_register.space_id);
-		result = -EIO;
-		goto err_unreg;
-	}
-
-	for (i=0; i<p->state_count; i++) {
-		if (p->states[i].control != p->states[i].status) {
-			dprintk("Different control (%llu) and status values (%llu)\n",
-				p->states[i].control, p->states[i].status);
-			result = -EINVAL;
-			goto err_unreg;
-		}
-
-		if (!p->states[i].core_frequency) {
-			dprintk("Zero core frequency for state %u\n", i);
-			result = -EINVAL;
-			goto err_unreg;
-		}
-
-		if (p->states[i].core_frequency > p->states[0].core_frequency) {
-			dprintk("P%u has larger frequency (%llu) than P0 (%llu), skipping\n", i,
-				p->states[i].core_frequency, p->states[0].core_frequency);
-			p->states[i].core_frequency = 0;
-			continue;
-		}
-	}
-
-	centrino_model[cpu] = kzalloc(sizeof(struct cpu_model), GFP_KERNEL);
-	if (!centrino_model[cpu]) {
-		result = -ENOMEM;
-		goto err_unreg;
-	}
-
-	centrino_model[cpu]->model_name=NULL;
-	centrino_model[cpu]->max_freq = p->states[0].core_frequency * 1000;
-	centrino_model[cpu]->op_points =  kmalloc(sizeof(struct cpufreq_frequency_table) *
-					     (p->state_count + 1), GFP_KERNEL);
-        if (!centrino_model[cpu]->op_points) {
-                result = -ENOMEM;
-                goto err_kfree;
-        }
-
-        for (i=0; i<p->state_count; i++) {
-		centrino_model[cpu]->op_points[i].index = p->states[i].control;
-		centrino_model[cpu]->op_points[i].frequency = p->states[i].core_frequency * 1000;
-		dprintk("adding state %i with frequency %u and control value %04x\n", 
-			i, centrino_model[cpu]->op_points[i].frequency, centrino_model[cpu]->op_points[i].index);
-	}
-	centrino_model[cpu]->op_points[p->state_count].frequency = CPUFREQ_TABLE_END;
-
-	cur_freq = get_cur_freq(cpu);
-
-	for (i=0; i<p->state_count; i++) {
-		if (!p->states[i].core_frequency) {
-			dprintk("skipping state %u\n", i);
-			centrino_model[cpu]->op_points[i].frequency = CPUFREQ_ENTRY_INVALID;
-			continue;
-		}
-		
-		if (extract_clock(centrino_model[cpu]->op_points[i].index, cpu, 0) !=
-		    (centrino_model[cpu]->op_points[i].frequency)) {
-			dprintk("Invalid encoded frequency (%u vs. %u)\n",
-				extract_clock(centrino_model[cpu]->op_points[i].index, cpu, 0),
-				centrino_model[cpu]->op_points[i].frequency);
-			result = -EINVAL;
-			goto err_kfree_all;
-		}
-
-		if (cur_freq == centrino_model[cpu]->op_points[i].frequency)
-			p->state = i;
-	}
-
-	/* notify BIOS that we exist */
-	acpi_processor_notify_smm(THIS_MODULE);
-	printk("speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPI"
-			"config is deprecated.\n "
-			"Use X86_ACPI_CPUFREQ (acpi-cpufreq instead.\n" );
-
-	return 0;
-
- err_kfree_all:
-	kfree(centrino_model[cpu]->op_points);
- err_kfree:
-	kfree(centrino_model[cpu]);
- err_unreg:
-	acpi_processor_unregister_performance(p, cpu);
-	dprintk(PFX "invalid ACPI data\n");
-	return (result);
-}
-#else
-static inline int centrino_cpu_init_acpi(struct cpufreq_policy *policy) { return -ENODEV; }
-static inline int centrino_cpu_early_init_acpi(void) { return 0; }
-#endif
-
 static int centrino_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpuinfo_x86 *cpu = &cpu_data[policy->cpu];
@@ -566,27 +351,25 @@
 	if (cpu_has(cpu, X86_FEATURE_CONSTANT_TSC))
 		centrino_driver.flags |= CPUFREQ_CONST_LOOPS;
 
-	if (centrino_cpu_init_acpi(policy)) {
-		if (policy->cpu != 0)
-			return -ENODEV;
+	if (policy->cpu != 0)
+		return -ENODEV;
 
-		for (i = 0; i < N_IDS; i++)
-			if (centrino_verify_cpu_id(cpu, &cpu_ids[i]))
-				break;
-
-		if (i != N_IDS)
-			centrino_cpu[policy->cpu] = &cpu_ids[i];
-
-		if (!centrino_cpu[policy->cpu]) {
-			dprintk("found unsupported CPU with "
-			"Enhanced SpeedStep: send /proc/cpuinfo to "
-			MAINTAINER "\n");
-			return -ENODEV;
-		}
+	for (i = 0; i < N_IDS; i++)
+		if (centrino_verify_cpu_id(cpu, &cpu_ids[i]))
+			break;
 
-		if (centrino_cpu_init_table(policy)) {
-			return -ENODEV;
-		}
+	if (i != N_IDS)
+		centrino_cpu[policy->cpu] = &cpu_ids[i];
+
+	if (!centrino_cpu[policy->cpu]) {
+		dprintk("found unsupported CPU with "
+		"Enhanced SpeedStep: send /proc/cpuinfo to "
+		MAINTAINER "\n");
+		return -ENODEV;
+	}
+
+	if (centrino_cpu_init_table(policy)) {
+		return -ENODEV;
 	}
 
 	/* Check to see if Enhanced SpeedStep is enabled, and try to
@@ -632,20 +415,6 @@
 
 	cpufreq_frequency_table_put_attr(cpu);
 
-#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-	if (!centrino_model[cpu]->model_name) {
-		static struct acpi_processor_performance *p;
-
-		if (acpi_perf_data[cpu]) {
-			p = acpi_perf_data[cpu];
-			dprintk("unregistering and freeing ACPI data\n");
-			acpi_processor_unregister_performance(p, cpu);
-			kfree(centrino_model[cpu]->op_points);
-			kfree(centrino_model[cpu]);
-		}
-	}
-#endif
-
 	centrino_model[cpu] = NULL;
 
 	return 0;
@@ -839,25 +608,12 @@
 	if (!cpu_has(cpu, X86_FEATURE_EST))
 		return -ENODEV;
 
-	centrino_cpu_early_init_acpi();
-
 	return cpufreq_register_driver(&centrino_driver);
 }
 
 static void __exit centrino_exit(void)
 {
-#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-	unsigned int j;
-#endif
-	
 	cpufreq_unregister_driver(&centrino_driver);
-
-#ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-	for_each_possible_cpu(j) {
-		kfree(acpi_perf_data[j]);
-		acpi_perf_data[j] = NULL;
-	}
-#endif
 }
 
 MODULE_AUTHOR ("Jeremy Fitzhardinge <jeremy@goop.org>");

