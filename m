Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbTBPMeL>; Sun, 16 Feb 2003 07:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTBPMeL>; Sun, 16 Feb 2003 07:34:11 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:30148 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266564AbTBPMds>; Sun, 16 Feb 2003 07:33:48 -0500
Date: Sun, 16 Feb 2003 13:41:49 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq: move x86 Kconfig entries to extra file (Marc-Christian Petersen)
Message-ID: <20030216124149.GB28689@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move x86 CPU_FREQ config choices to extra file & menu. (Marc-Christian Petersen)

diff -ruN linux-original/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-original/arch/i386/Kconfig	2003-02-16 09:28:31.000000000 +0100
+++ linux/arch/i386/Kconfig	2003-02-16 09:37:17.000000000 +0100
@@ -956,158 +956,7 @@
 	  a work-around for a number of buggy BIOSes. Switch this option on if
 	  your computer crashes instead of powering off properly.
 
-config CPU_FREQ
-	bool "CPU Frequency scaling"
-	help
-	  Clock scaling allows you to change the clock speed of CPUs on the
-	  fly. This is a nice method to save battery power on notebooks,
-	  because the lower the clock speed, the less power the CPU consumes.
-
-	  For more information, take a look at linux/Documentation/cpufreq or
-	  at <http://www.brodo.de/cpufreq/>
-
-	  If in doubt, say N.
-
-config CPU_FREQ_PROC_INTF
-	tristate "/proc/cpufreq interface (DEPRECATED)"
-	depends on CPU_FREQ && PROC_FS
-	help
-	  This enables the /proc/cpufreq interface for controlling
-	  CPUFreq. Please note that it is recommended to use the sysfs
-	  interface instead (which is built automatically). 
-	  
-	  For details, take a look at linux/Documentation/cpufreq. 
-	  
-	  If in doubt, say N.
-
-config CPU_FREQ_24_API
-	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
-	depends on CPU_FREQ
-	help
-	  This enables the /proc/sys/cpu/ sysctl interface for controlling
-	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
-	  uses a sysfs interface instead. Please note that some drivers do 
-	  not work well with the 2.4. /proc/sys/cpu sysctl interface,
-	  so if in doubt, say N here.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config CPU_FREQ_TABLE
-       tristate "CPU frequency table helpers"
-       depends on CPU_FREQ
-       default y
-       help
-         Many CPUFreq drivers use these helpers, so only say N here if
-	 the CPUFreq driver of your choice doesn't need these helpers.
-
-	 If in doubt, say Y.
-
-config X86_ACPI_CPUFREQ
-	tristate "ACPI Processor P-States driver"
-	depends on CPU_FREQ_TABLE && ACPI_PROCESSOR
-	help
-	  This driver adds a CPUFreq driver which utilizes the ACPI
-	  Processor Performance States.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_POWERNOW_K6
-	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
-	depends on CPU_FREQ_TABLE
-	help
-	  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
-	  AMD K6-3+ processors.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_POWERNOW_K7
-	tristate "AMD Mobile Athlon/Duron PowerNow!"
-	depends on CPU_FREQ_TABLE
-	help
-	  This adds the CPUFreq driver for mobile AMD K7 mobile processors.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config ELAN_CPUFREQ
-	tristate "AMD Elan"
-	depends on CPU_FREQ_TABLE && MELAN
-	---help---
-	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
-	  processors.
-
-	  You need to specify the processor maximum speed as boot
-	  parameter: elanfreq=maxspeed (in kHz) or as module
-	  parameter "max_freq".
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_LONGHAUL
-	tristate "VIA Cyrix III Longhaul"
-	depends on CPU_FREQ
-	help
-	  This adds the CPUFreq driver for VIA Samuel/CyrixIII, 
-	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 
-	  processors.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_SPEEDSTEP
-	tristate "Intel Speedstep"
-	depends on CPU_FREQ_TABLE
-	help
-	  This adds the CPUFreq driver for certain mobile Intel Pentium III
-	  (Coppermine), all mobile Intel Pentium III-M (Tulatin) and all
-	  mobile Intel Pentium 4 P4-Ms.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_P4_CLOCKMOD
-	tristate "Intel Pentium 4 clock modulation"
-	depends on CPU_FREQ_TABLE
-	help
-	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
-	  processors.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_LONGRUN
-	tristate "Transmeta LongRun"
-	depends on CPU_FREQ
-	help
-	  This adds the CPUFreq driver for Transmeta Crusoe processors which
-	  support LongRun.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_GX_SUSPMOD
-	tristate "Cyrix MediaGX/NatSemi Geode Suspend Modulation"
-	depends on CPU_FREQ
-	help
-	 This add the CPUFreq driver for NatSemi Geode processors which
-	 support suspend modulation.
-
-	 For details, take a look at linux/Documentation/cpufreq.
-
-	 If in doubt, say N.
-
+source "arch/i386/kernel/cpu/cpufreq/Kconfig"
 
 endmenu
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/Kconfig linux/arch/i386/kernel/cpu/cpufreq/Kconfig
--- linux-original/arch/i386/kernel/cpu/cpufreq/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-02-16 09:41:10.000000000 +0100
@@ -0,0 +1,152 @@
+#
+# CPU Frequency scaling
+#
+
+menu "CPU Frequency scaling"
+
+config CPU_FREQ
+	bool "CPU Frequency scaling"
+	help
+	  Clock scaling allows you to change the clock speed of CPUs on the
+	  fly. This is a nice method to save battery power on notebooks,
+	  because the lower the clock speed, the less power the CPU consumes.
+
+	  For more information, take a look at linux/Documentation/cpufreq or
+	  at <http://www.brodo.de/cpufreq/>
+
+	  If in doubt, say N.
+
+source "drivers/cpufreq/Kconfig"
+
+config CPU_FREQ_24_API
+	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
+	depends on CPU_FREQ
+	help
+	  This enables the /proc/sys/cpu/ sysctl interface for controlling
+	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
+	  uses a sysfs interface instead. Please note that some drivers do 
+	  not work well with the 2.4. /proc/sys/cpu sysctl interface,
+	  so if in doubt, say N here.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config CPU_FREQ_TABLE
+       tristate "CPU frequency table helpers"
+       depends on CPU_FREQ
+       default y
+       help
+         Many CPUFreq drivers use these helpers, so only say N here if
+	 the CPUFreq driver of your choice doesn't need these helpers.
+
+	 If in doubt, say Y.
+
+comment "CPUFreq processor drivers"
+       depends on CPU_FREQ
+
+config X86_ACPI_CPUFREQ
+	tristate "ACPI Processor P-States driver"
+	depends on CPU_FREQ_TABLE && ACPI_PROCESSOR
+	help
+	  This driver adds a CPUFreq driver which utilizes the ACPI
+	  Processor Performance States.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config ELAN_CPUFREQ
+	tristate "AMD Elan"
+	depends on CPU_FREQ_TABLE && MELAN
+	---help---
+	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
+	  processors.
+
+	  You need to specify the processor maximum speed as boot
+	  parameter: elanfreq=maxspeed (in kHz) or as module
+	  parameter "max_freq".
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_POWERNOW_K6
+	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
+	depends on CPU_FREQ_TABLE
+	help
+	  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
+	  AMD K6-3+ processors.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_POWERNOW_K7
+	tristate "AMD Mobile Athlon/Duron PowerNow!"
+	depends on CPU_FREQ_TABLE
+	help
+	  This adds the CPUFreq driver for mobile AMD K7 mobile processors.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_GX_SUSPMOD
+	tristate "Cyrix MediaGX/NatSemi Geode Suspend Modulation"
+	depends on CPU_FREQ
+	help
+	 This add the CPUFreq driver for NatSemi Geode processors which
+	 support suspend modulation.
+
+	 For details, take a look at linux/Documentation/cpufreq.
+
+	 If in doubt, say N.
+
+config X86_SPEEDSTEP
+	tristate "Intel Speedstep"
+	depends on CPU_FREQ_TABLE
+	help
+	  This adds the CPUFreq driver for certain mobile Intel Pentium III
+	  (Coppermine), all mobile Intel Pentium III-M (Tulatin) and all
+	  mobile Intel Pentium 4 P4-Ms.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_P4_CLOCKMOD
+	tristate "Intel Pentium 4 clock modulation"
+	depends on CPU_FREQ_TABLE
+	help
+	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
+	  processors.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_LONGRUN
+	tristate "Transmeta LongRun"
+	depends on CPU_FREQ
+	help
+	  This adds the CPUFreq driver for Transmeta Crusoe processors which
+	  support LongRun.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_LONGHAUL
+	tristate "VIA Cyrix III Longhaul"
+	depends on CPU_FREQ
+	help
+	  This adds the CPUFreq driver for VIA Samuel/CyrixIII, 
+	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 
+	  processors.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+endmenu
