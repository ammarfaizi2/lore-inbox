Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVA2WXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVA2WXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVA2WWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:22:06 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:25775 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261578AbVA2WTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:19:50 -0500
Date: Sat, 29 Jan 2005 23:19:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: cpufreq@lists.linux.org.uk
Subject: [PATCH 3/8] Kconfig: cleanup cpufreq menu
Message-ID: <Pine.LNX.4.61.0501292319140.7641@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This properly indents the cpufreq menu.
Remove CPU_FREQ_TABLE as visible option and use select instead.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/i386/kernel/cpu/cpufreq/Kconfig |   54 +++++++++++++++--------------------
 drivers/cpufreq/Kconfig              |   20 ++++++------
 2 files changed, 34 insertions(+), 40 deletions(-)

Index: linux-2.6.11/arch/i386/kernel/cpu/cpufreq/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/cpu/cpufreq/Kconfig	2005-01-29 22:50:43.507928466 +0100
+++ linux-2.6.11/arch/i386/kernel/cpu/cpufreq/Kconfig	2005-01-29 22:55:57.343872448 +0100
@@ -6,22 +6,14 @@ menu "CPU Frequency scaling"
 
 source "drivers/cpufreq/Kconfig"
 
-config CPU_FREQ_TABLE
-       tristate "CPU frequency table helpers"
-       depends on CPU_FREQ
-       default y
-       help
-         Many CPUFreq drivers use these helpers, so only say N here if
-	 the CPUFreq driver of your choice doesn't need these helpers.
-
-	 If in doubt, say Y.
+if CPU_FREQ
 
 comment "CPUFreq processor drivers"
-       depends on CPU_FREQ
 
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
-	depends on CPU_FREQ_TABLE && ACPI_PROCESSOR
+	select CPU_FREQ_TABLE
+	depends on ACPI_PROCESSOR
 	help
 	  This driver adds a CPUFreq driver which utilizes the ACPI
 	  Processor Performance States.
@@ -32,7 +24,8 @@ config X86_ACPI_CPUFREQ
 
 config ELAN_CPUFREQ
 	tristate "AMD Elan"
-	depends on CPU_FREQ_TABLE && X86_ELAN
+	select CPU_FREQ_TABLE
+	depends on X86_ELAN
 	---help---
 	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
 	  processors.
@@ -47,7 +40,7 @@ config ELAN_CPUFREQ
 
 config X86_POWERNOW_K6
 	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
-	depends on CPU_FREQ_TABLE
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
 	  AMD K6-3+ processors.
@@ -58,7 +51,7 @@ config X86_POWERNOW_K6
 
 config X86_POWERNOW_K7
 	tristate "AMD Mobile Athlon/Duron PowerNow!"
-	depends on CPU_FREQ_TABLE
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for mobile AMD K7 mobile processors.
 
@@ -68,12 +61,14 @@ config X86_POWERNOW_K7
 
 config X86_POWERNOW_K7_ACPI
 	bool
-	depends on ((X86_POWERNOW_K7 = "m" && ACPI_PROCESSOR) || (X86_POWERNOW_K7 = "y" && ACPI_PROCESSOR = "y"))
+	depends on X86_POWERNOW_K7 && ACPI_PROCESSOR
+	depends on !(X86_POWERNOW_K7 = y && ACPI_PROCESSOR = m)
 	default y
 
 config X86_POWERNOW_K8
 	tristate "AMD Opteron/Athlon64 PowerNow!"
-	depends on CPU_FREQ_TABLE && EXPERIMENTAL
+	select CPU_FREQ_TABLE
+	depends on EXPERIMENTAL
 	help
 	  This adds the CPUFreq driver for mobile AMD Opteron/Athlon64 processors.
 
@@ -83,12 +78,12 @@ config X86_POWERNOW_K8
 
 config X86_POWERNOW_K8_ACPI
 	bool
-	depends on ((X86_POWERNOW_K8 = "m" && ACPI_PROCESSOR) || (X86_POWERNOW_K8 = "y" && ACPI_PROCESSOR = "y"))
+	depends on X86_POWERNOW_K8 && ACPI_PROCESSOR
+	depends on !(X86_POWERNOW_K8 = y && ACPI_PROCESSOR = m)
 	default y
 
 config X86_GX_SUSPMOD
 	tristate "Cyrix MediaGX/NatSemi Geode Suspend Modulation"
-	depends on CPU_FREQ
 	help
 	 This add the CPUFreq driver for NatSemi Geode processors which
 	 support suspend modulation.
@@ -99,7 +94,7 @@ config X86_GX_SUSPMOD
 
 config X86_SPEEDSTEP_CENTRINO
 	tristate "Intel Enhanced SpeedStep"
-	depends on CPU_FREQ_TABLE
+	select CPU_FREQ_TABLE
 	select X86_SPEEDSTEP_CENTRINO_TABLE if (!X86_SPEEDSTEP_CENTRINO_ACPI)
 	help
 	  This adds the CPUFreq driver for Enhanced SpeedStep enabled
@@ -114,8 +109,8 @@ config X86_SPEEDSTEP_CENTRINO
 
 config X86_SPEEDSTEP_CENTRINO_ACPI
 	bool "Use ACPI tables to decode valid frequency/voltage pairs"
-	depends on X86_SPEEDSTEP_CENTRINO
-	depends on ((X86_SPEEDSTEP_CENTRINO = "m" && ACPI_PROCESSOR) || (X86_SPEEDSTEP_CENTRINO = "y" && ACPI_PROCESSOR = "y"))
+	depends on X86_SPEEDSTEP_CENTRINO && ACPI_PROCESSOR
+	depends on !(X86_SPEEDSTEP_CENTRINO = y && ACPI_PROCESSOR = m)
 	default y
 	help
 	  Use primarily the information provided in the BIOS ACPI tables
@@ -136,7 +131,7 @@ config X86_SPEEDSTEP_CENTRINO_TABLE
 
 config X86_SPEEDSTEP_ICH
 	tristate "Intel Speedstep on ICH-M chipsets (ioport interface)"
-	depends on CPU_FREQ_TABLE
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for certain mobile Intel Pentium III
 	  (Coppermine), all mobile Intel Pentium III-M (Tualatin) and all
@@ -149,7 +144,8 @@ config X86_SPEEDSTEP_ICH
 
 config X86_SPEEDSTEP_SMI
 	tristate "Intel SpeedStep on 440BX/ZX/MX chipsets (SMI interface)"
-	depends on CPU_FREQ_TABLE && EXPERIMENTAL
+	select CPU_FREQ_TABLE
+	depends on EXPERIMENTAL
 	help
 	  This adds the CPUFreq driver for certain mobile Intel Pentium III
 	  (Coppermine), all mobile Intel Pentium III-M (Tualatin)  
@@ -161,7 +157,7 @@ config X86_SPEEDSTEP_SMI
 
 config X86_P4_CLOCKMOD
 	tristate "Intel Pentium 4 clock modulation"
-	depends on CPU_FREQ_TABLE
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
 	  processors.
@@ -172,7 +168,7 @@ config X86_P4_CLOCKMOD
 
 config X86_CPUFREQ_NFORCE2
 	tristate "nVidia nForce2 FSB changing"
-	depends on CPU_FREQ && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  This adds the CPUFreq driver for FSB changing on nVidia nForce2
 	  platforms.
@@ -183,7 +179,6 @@ config X86_CPUFREQ_NFORCE2
 
 config X86_LONGRUN
 	tristate "Transmeta LongRun"
-	depends on CPU_FREQ
 	help
 	  This adds the CPUFreq driver for Transmeta Crusoe and Efficeon processors
 	  which support LongRun.
@@ -194,7 +189,7 @@ config X86_LONGRUN
 
 config X86_LONGHAUL
 	tristate "VIA Cyrix III Longhaul"
-	depends on CPU_FREQ_TABLE
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for VIA Samuel/CyrixIII, 
 	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 
@@ -205,7 +200,6 @@ config X86_LONGHAUL
 	  If in doubt, say N.
 
 comment "shared options"
-	depends on CPU_FREQ
 
 config X86_ACPI_CPUFREQ_PROC_INTF
         bool "/proc/acpi/processor/../performance interface (deprecated)"
@@ -220,8 +214,7 @@ config X86_ACPI_CPUFREQ_PROC_INTF
 
 config X86_SPEEDSTEP_LIB
 	tristate
-	depends on (X86_SPEEDSTEP_ICH || X86_SPEEDSTEP_SMI || X86_P4_CLOCKMOD)
-	default (X86_SPEEDSTEP_ICH || X86_SPEEDSTEP_SMI || X86_P4_CLOCKMOD)
+	default X86_SPEEDSTEP_ICH || X86_SPEEDSTEP_SMI || X86_P4_CLOCKMOD
 
 config X86_SPEEDSTEP_RELAXED_CAP_CHECK
 	bool "Relaxed speedstep capability checks"
@@ -233,5 +226,6 @@ config X86_SPEEDSTEP_RELAXED_CAP_CHECK
 	  option lets the probing code bypass some of those checks if the
 	  parameter "relaxed_check=1" is passed to the module.
 
+endif	# CPU_FREQ
 
 endmenu
Index: linux-2.6.11/drivers/cpufreq/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/cpufreq/Kconfig	2005-01-29 22:50:43.507928466 +0100
+++ linux-2.6.11/drivers/cpufreq/Kconfig	2005-01-29 22:55:57.343872448 +0100
@@ -13,9 +13,13 @@ config CPU_FREQ
 
 	  If in doubt, say N.
 
+if CPU_FREQ
+
+config CPU_FREQ_TABLE
+       def_tristate m
+
 config CPU_FREQ_DEBUG
 	bool "Enable CPUfreq debugging"
-	depends on CPU_FREQ
 	help
 	  Say Y here to enable CPUfreq subsystem (including drivers)
 	  debugging. You will need to activate it via the kernel
@@ -29,7 +33,7 @@ config CPU_FREQ_DEBUG
 
 config CPU_FREQ_STAT
        tristate "CPU frequency translation statistics"
-       depends on CPU_FREQ && CPU_FREQ_TABLE
+       select CPU_FREQ_TABLE
        default y
        help
          This driver exports CPU frequency statistics information through sysfs
@@ -37,17 +41,15 @@ config CPU_FREQ_STAT
 
 config CPU_FREQ_STAT_DETAILS
        bool "CPU frequency translation statistics details"
-       depends on CPU_FREQ && CPU_FREQ_STAT
-       default n
+       depends on CPU_FREQ_STAT
        help
          This will show detail CPU frequency translation table in sysfs file
          system
 
 choice
 	prompt "Default CPUFreq governor"
-	depends on CPU_FREQ
-	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE if !CPU_FREQ_SA1100 && !CPU_FREQ_SA1110
 	default CPU_FREQ_DEFAULT_GOV_USERSPACE if CPU_FREQ_SA1100 || CPU_FREQ_SA1110
+	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
 	  This option sets which CPUFreq governor shall be loaded at
 	  startup. If in doubt, select 'performance'.
@@ -73,7 +75,6 @@ endchoice
 
 config CPU_FREQ_GOV_PERFORMANCE
        tristate "'performance' governor"
-       depends on CPU_FREQ
        help
 	  This cpufreq governor sets the frequency statically to the
 	  highest available CPU frequency.
@@ -82,7 +83,6 @@ config CPU_FREQ_GOV_PERFORMANCE
 
 config CPU_FREQ_GOV_POWERSAVE
        tristate "'powersave' governor"
-       depends on CPU_FREQ
        help
 	  This cpufreq governor sets the frequency statically to the
 	  lowest available CPU frequency.
@@ -91,7 +91,6 @@ config CPU_FREQ_GOV_POWERSAVE
 
 config CPU_FREQ_GOV_USERSPACE
        tristate "'userspace' governor for userspace frequency scaling"
-       depends on CPU_FREQ 
        help
 	  Enable this cpufreq governor when you either want to set the
 	  CPU frequency manually or when an userspace program shall
@@ -104,7 +103,6 @@ config CPU_FREQ_GOV_USERSPACE
 
 config CPU_FREQ_GOV_ONDEMAND
 	tristate "'ondemand' cpufreq policy governor"
-	depends on CPU_FREQ
 	help
 	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
 	  The governor does a periodic polling and 
@@ -116,3 +114,5 @@ config CPU_FREQ_GOV_ONDEMAND
 	  For details, take a look at linux/Documentation/cpu-freq.
 
 	  If in doubt, say N.
+
+endif	# CPU_FREQ
