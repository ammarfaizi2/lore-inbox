Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVJCRdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVJCRdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVJCRdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:33:39 -0400
Received: from amdext4.amd.com ([163.181.251.6]:24759 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932477AbVJCRdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:33:38 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Mon, 3 Oct 2005 11:50:32 -0600
From: "Jordan Crouse" <jordan.crouse@AMD.COM>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com
Subject: [PATCH 2/7] AMD Geode GX/LX support
Message-ID: <20051003175032.GD29264@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5FB4E22RW1374376-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Geode LX processor, including CPU 
identification, config options, and PCI IDs.  Please apply against 
linux-2.4.15-rc2-mm2.

Signed off by:  Jordan Crouse (jordan.crouse@amd.com)

Index: linux-2.6.14-rc2-mm2/arch/i386/Kconfig
===================================================================
--- linux-2.6.14-rc2-mm2.orig/arch/i386/Kconfig
+++ linux-2.6.14-rc2-mm2/arch/i386/Kconfig
@@ -189,7 +189,7 @@ config M386
 	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
 	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
 	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
-	  - "Geode GX" for AMD Geode GX processors
+	  - "Geode GX/LX" for AMD Geode GX and LX processors
 	  - "Crusoe" for the Transmeta Crusoe series.
 	  - "Efficeon" for the Transmeta Efficeon series.
 	  - "Winchip-C6" for original IDT Winchip.
@@ -291,8 +291,17 @@ config MK8
 config MGEODE_GX
 	bool "Geode GX"
 	help
-	  Select this for AMD Geode GX processors.  Enables use of some extended
-	  instructions, and passes appropriate optimization flags to GCC.
+	  Select this for AMD Geode GX and LX processors.
+	  Enables use of some extended instructions, and
+	  passes appropriate optimization flags to GCC.
+
+config MGEODE_LX
+	bool "Geode LX"
+	help
+	  Select this for AMD Geode LX processors.
+	  Enables use of some extended instructions, allows
+	  you to use various on-chip devices, and passes appropriate
+	  optimization flags to GCC.
 
 config MCRUSOE
 	bool "Crusoe"
@@ -384,7 +393,7 @@ config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || X86_GENERIC
 	default "4" if X86_ELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODEGX1 || MGEODE_GX
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODEGX1 || MGEODE_GX || MGEODE_LX
 	default "6" if MK7 || MK8 || MPENTIUMM
 
 config RWSEM_GENERIC_SPINLOCK
@@ -453,12 +462,12 @@ config X86_INTEL_USERCOPY
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON || MGEODE_GX
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON || MGEODE_GX || MGEODE_LX
 	default y
 
 config X86_USE_3DNOW
 	bool
-	depends on MCYRIXIII || MK7 || MGEODE_GX
+	depends on MCYRIXIII || MK7 || MGEODE_GX || MGEODE_LX
 	default y
 
 config X86_OOSTORE
@@ -539,7 +548,7 @@ source "kernel/Kconfig.preempt"
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors"
-	depends on !SMP && !(X86_VISWS || X86_VOYAGER || MGEODE_GX)
+	depends on !SMP && !(X86_VISWS || X86_VOYAGER || MGEODE_GX || MGEODE_LX)
 	help
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -756,7 +765,7 @@ config HIGHMEM4G
 
 config HIGHMEM64G
 	bool "64GB"
-	depends on !MGEODE_GX
+	depends on !MGEODE_GX && !MGEODE_LX
 	help
 	  Select this if you have a 32-bit processor and more than 4
 	  gigabytes of physical RAM.
Index: linux-2.6.14-rc2-mm2/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux-2.6.14-rc2-mm2.orig/arch/i386/kernel/cpu/amd.c
+++ linux-2.6.14-rc2-mm2/arch/i386/kernel/cpu/amd.c
@@ -145,6 +145,13 @@ static void __init init_amd(struct cpuin
 					set_bit(X86_FEATURE_K6_MTRR, c->x86_capability);
 				break;
 			}
+
+			if ( c->x86_model == 10 ) {
+				/* AMD Geode LX is model 10 */
+				/* placeholder for any needed mods */
+				break;
+			}
+
 			break;
 
 		case 6: /* An Athlon/Duron */
Index: linux-2.6.14-rc2-mm2/include/asm-i386/module.h
===================================================================
--- linux-2.6.14-rc2-mm2.orig/include/asm-i386/module.h
+++ linux-2.6.14-rc2-mm2/include/asm-i386/module.h
@@ -38,6 +38,8 @@ struct mod_arch_specific
 #define MODULE_PROC_FAMILY "K8 "
 #elif defined CONFIG_MGEODE_GX
 #define MODULE_PROC_FAMILY "GEODE_GX "
+#elif defined CONFIG_MGEODE_LX
+#define MODULE_PROC_FAMILY "GEODE_GX "
 #elif defined CONFIG_X86_ELAN
 #define MODULE_PROC_FAMILY "ELAN "
 #elif defined CONFIG_MCRUSOE
Index: linux-2.6.14-rc2-mm2/include/linux/pci_ids.h
===================================================================
--- linux-2.6.14-rc2-mm2.orig/include/linux/pci_ids.h
+++ linux-2.6.14-rc2-mm2/include/linux/pci_ids.h
@@ -546,6 +546,9 @@
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
 #define PCI_DEVICE_ID_AMD_8131_APIC     0x7450
 
+#define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
+#define PCI_DEVICE_ID_AMD_LX_AES    0x2082
+
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_NX	0x2001

