Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVCTT3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVCTT3k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVCTT20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:28:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34565 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261198AbVCTTZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:25:53 -0500
Date: Sun, 20 Mar 2005 20:25:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/x86_64 mpparse.c: kill maxcpus
Message-ID: <20050320192549.GP4449@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we really need a global variable that does only hold the value of 
NR_CPUS?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/mpparse.c     |    7 +++----
 arch/i386/mach-visws/mpparse.c |    6 ++----
 arch/x86_64/kernel/mpparse.c   |    7 +++----
 3 files changed, 8 insertions(+), 12 deletions(-)

--- linux-2.6.11-mm4-full/arch/i386/kernel/mpparse.c.old	2005-03-20 19:54:21.000000000 +0100
+++ linux-2.6.11-mm4-full/arch/i386/kernel/mpparse.c	2005-03-20 19:56:17.000000000 +0100
@@ -37,7 +37,6 @@
 
 /* Have we found an MP table */
 int smp_found_config;
-unsigned int __initdata maxcpus = NR_CPUS;
 
 /*
  * Various Linux-internal data structures created from the
@@ -189,9 +188,9 @@
 		return;
 	}
 
-	if (num_processors >= maxcpus) {
-		printk(KERN_WARNING "WARNING: maxcpus limit of %i reached."
-			" Processor ignored.\n", maxcpus); 
+	if (num_processors >= NR_CPUS) {
+		printk(KERN_WARNING "WARNING: NR_CPUS limit of %i reached."
+			" Processor ignored.\n", NR_CPUS); 
 		return;
 	}
 	num_processors++;
--- linux-2.6.11-mm4-full/arch/i386/mach-visws/mpparse.c.old	2005-03-20 19:56:31.000000000 +0100
+++ linux-2.6.11-mm4-full/arch/i386/mach-visws/mpparse.c	2005-03-20 19:57:03.000000000 +0100
@@ -28,8 +28,6 @@
 /* Bitmask of physically existing CPUs */
 physid_mask_t phys_cpu_present_map;
 
-unsigned int __initdata maxcpus = NR_CPUS;
-
 /*
  * The Visual Workstation is Intel MP compliant in the hardware
  * sense, but it doesn't have a BIOS(-configuration table).
@@ -90,8 +88,8 @@
 		ncpus = CO_CPU_MAX;
 	}
 
-	if (ncpus > maxcpus)
-		ncpus = maxcpus;
+	if (ncpus > NR_CPUS)
+		ncpus = NR_CPUS;
 
 	smp_found_config = 1;
 	while (ncpus--)
--- linux-2.6.11-mm4-full/arch/x86_64/kernel/mpparse.c.old	2005-03-20 19:58:45.000000000 +0100
+++ linux-2.6.11-mm4-full/arch/x86_64/kernel/mpparse.c	2005-03-20 19:59:04.000000000 +0100
@@ -33,7 +33,6 @@
 
 /* Have we found an MP table */
 int smp_found_config;
-unsigned int __initdata maxcpus = NR_CPUS;
 
 int acpi_found_madt;
 
@@ -126,9 +125,9 @@
 			" Processor ignored.\n", NR_CPUS);
 		return;
 	}
-	if (num_processors >= maxcpus) {
-		printk(KERN_WARNING "WARNING: maxcpus limit of %i reached."
-			" Processor ignored.\n", maxcpus);
+	if (num_processors >= NR_CPUS) {
+		printk(KERN_WARNING "WARNING: NR_CPUS limit of %i reached."
+			" Processor ignored.\n", NR_CPUS);
 		return;
 	}
 

