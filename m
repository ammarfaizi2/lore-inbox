Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269882AbUJMWZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269882AbUJMWZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269893AbUJMWZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:25:25 -0400
Received: from fmr03.intel.com ([143.183.121.5]:4827 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S269882AbUJMWXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:23:55 -0400
Message-Id: <200410132222.i9DMMl626057@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: Enable config_schedstats for all arches
Date: Wed, 13 Oct 2004 15:23:53 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSxc1IPjRbqr5VKS7W6A9vKsSmaMg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Config option CONFIG_SCHEDSTATS is currently enabled via arch
specific Kconfig.debug. Only x86 and ppc arches has code to
turn it on.  Why not put it in generic lib/Kconfig.debug so
it is done once to enable everyone?


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

diff -Nur linux-2.6.9-rc4/arch/i386/Kconfig.debug linux-2.6.9-rc4.new/arch/i386/Kconfig.debug
--- linux-2.6.9-rc4/arch/i386/Kconfig.debug	2004-10-10 19:57:59.000000000 -0700
+++ linux-2.6.9-rc4.new/arch/i386/Kconfig.debug	2004-10-13 14:00:23.000000000 -0700
@@ -55,18 +55,6 @@
 	  on the VM subsystem for higher order allocations. This option
 	  will also use IRQ stacks to compensate for the reduced stackspace.

-config SCHEDSTATS
-	bool "Collect scheduler statistics"
-	depends on DEBUG_KERNEL && PROC_FS
-	help
-	  If you say Y here, additional code will be inserted into the
-	  scheduler and related routines to collect statistics about
-	  scheduler behavior and provide them in /proc/schedstat.  These
-	  stats may be useful for both tuning and debugging the scheduler
-	  If you aren't debugging the scheduler or trying to tune a specific
-	  application, you can say N to avoid the very slight overhead
-	  this adds.
-
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
diff -Nur linux-2.6.9-rc4/arch/ppc/Kconfig.debug linux-2.6.9-rc4.new/arch/ppc/Kconfig.debug
--- linux-2.6.9-rc4/arch/ppc/Kconfig.debug	2004-10-10 19:58:49.000000000 -0700
+++ linux-2.6.9-rc4.new/arch/ppc/Kconfig.debug	2004-10-13 15:03:12.000000000 -0700
@@ -53,18 +53,6 @@
 	  Unless you are intending to debug the kernel with one of these
 	  machines, say N here.

-config SCHEDSTATS
-	bool "Collect scheduler statistics"
-	depends on DEBUG_KERNEL && PROC_FS
-	help
-	  If you say Y here, additional code will be inserted into the
-	  scheduler and related routines to collect statistics about
-	  scheduler behavior and provide them in /proc/schedstat.  These
-	  stats may be useful for both tuning and debugging the scheduler
-	  If you aren't debugging the scheduler or trying to tune a specific
-	  application, you can say N to avoid the very slight overhead
-	  this adds.
-
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
 	depends PPC_OF
diff -Nur linux-2.6.9-rc4/arch/ppc64/Kconfig.debug linux-2.6.9-rc4.new/arch/ppc64/Kconfig.debug
--- linux-2.6.9-rc4/arch/ppc64/Kconfig.debug	2004-10-10 19:58:49.000000000 -0700
+++ linux-2.6.9-rc4.new/arch/ppc64/Kconfig.debug	2004-10-13 15:03:28.000000000 -0700
@@ -44,16 +44,4 @@
 	  for handling hard and soft interrupts.  This can help avoid
 	  overflowing the process kernel stacks.

-config SCHEDSTATS
-	bool "Collect scheduler statistics"
-	depends on DEBUG_KERNEL && PROC_FS
-	help
-	  If you say Y here, additional code will be inserted into the
-	  scheduler and related routines to collect statistics about
-	  scheduler behavior and provide them in /proc/schedstat.  These
-	  stats may be useful for both tuning and debugging the scheduler
-	  If you aren't debugging the scheduler or trying to tune a specific
-	  application, you can say N to avoid the very slight overhead
-	  this adds.
-
 endmenu
diff -Nur linux-2.6.9-rc4/arch/x86_64/Kconfig.debug linux-2.6.9-rc4.new/arch/x86_64/Kconfig.debug
--- linux-2.6.9-rc4/arch/x86_64/Kconfig.debug	2004-10-10 19:57:06.000000000 -0700
+++ linux-2.6.9-rc4.new/arch/x86_64/Kconfig.debug	2004-10-13 15:03:40.000000000 -0700
@@ -18,18 +18,6 @@
 	  Fill __init and __initdata at the end of boot. This helps debugging
 	  illegal uses of __init and __initdata after initialization.

-config SCHEDSTATS
-	bool "Collect scheduler statistics"
-	depends on DEBUG_KERNEL && PROC_FS
-	help
-	  If you say Y here, additional code will be inserted into the
-	  scheduler and related routines to collect statistics about
-	  scheduler behavior and provide them in /proc/schedstat.  These
-	  stats may be useful for both tuning and debugging the scheduler
-	  If you aren't debugging the scheduler or trying to tune a specific
-	  application, you can say N to avoid the very slight overhead
-	  this adds.
-
 config IOMMU_DEBUG
        depends on GART_IOMMU && DEBUG_KERNEL
        bool "Enable IOMMU debugging"
diff -Nur linux-2.6.9-rc4/lib/Kconfig.debug linux-2.6.9-rc4.new/lib/Kconfig.debug
--- linux-2.6.9-rc4/lib/Kconfig.debug	2004-10-10 19:58:41.000000000 -0700
+++ linux-2.6.9-rc4.new/lib/Kconfig.debug	2004-10-13 14:00:50.000000000 -0700
@@ -28,6 +28,18 @@
 	  Enables console device to interpret special characters as
 	  commands to dump state information.

+config SCHEDSTATS
+	bool "Collect scheduler statistics"
+	depends on DEBUG_KERNEL && PROC_FS
+	help
+	  If you say Y here, additional code will be inserted into the
+	  scheduler and related routines to collect statistics about
+	  scheduler behavior and provide them in /proc/schedstat.  These
+	  stats may be useful for both tuning and debugging the scheduler
+	  If you aren't debugging the scheduler or trying to tune a specific
+	  application, you can say N to avoid the very slight overhead
+	  this adds.
+
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SPARC32
|| SPARC64 || USERMODE || X86_64)


