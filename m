Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVKVANO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVKVANO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVKVANO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:13:14 -0500
Received: from fmr23.intel.com ([143.183.121.15]:6892 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964780AbVKVANN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:13:13 -0500
Message-Id: <20051122000204.890352000@araj-sfield-2>
References: <20051121233914.979360000@araj-sfield-2>
Date: Mon, 21 Nov 2005 15:39:16 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@muc.de, gregkh@suse.de, venkatesh.pallipadi@intel.com
Subject: [patch 2/2] Convert bigsmp to use flat physical mode
Content-Disposition: inline; filename=choose-bigsmp-with-cpu-hotplug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we are using hotplug enabled kernel, then make bigsmp the default mode.


Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
-------------------------------------------------------
 arch/i386/kernel/mpparse.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

Index: linux-2.6.15-rc1-mm2/arch/i386/kernel/mpparse.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/arch/i386/kernel/mpparse.c
+++ linux-2.6.15-rc1-mm2/arch/i386/kernel/mpparse.c
@@ -38,6 +38,12 @@
 int smp_found_config;
 unsigned int __initdata maxcpus = NR_CPUS;
 
+#ifdef CONFIG_HOTPLUG_CPU
+#define CPU_HOTPLUG_ENABLED	(1)
+#else
+#define CPU_HOTPLUG_ENABLED	(0)
+#endif
+
 /*
  * Various Linux-internal data structures created from the
  * MP-table.
@@ -219,9 +225,10 @@ static void __devinit MP_processor_info 
 	cpu_set(num_processors, cpu_possible_map);
 	num_processors++;
 
-	if ((num_processors > 8) &&
-	    APIC_XAPIC(ver) &&
-	    (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL))
+	if (APIC_XAPIC(ver) &&
+		(CPU_HOTPLUG_ENABLED ||
+		((num_processors > 8) &&
+	    		(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL))))
 		def_to_bigsmp = 1;
 	else
 		def_to_bigsmp = 0;

--

