Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVLOVLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVLOVLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVLOVLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:11:48 -0500
Received: from amdext3.amd.com ([139.95.251.6]:51669 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1750983AbVLOVLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:11:47 -0500
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Thu, 15 Dec 2005 14:12:48 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, info-linux@ldcmail.amd.com
Subject: [PATCH 1/3] Base support for AMD Geode GX/LX processors.
Message-ID: <20051215211248.GE11054@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FBF04590GO588204-01-01
Content-Type: multipart/mixed;
 boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Here's repost of the Geode GX/LX patches - no changes from the
previous posting, if you are keeping track of such things.


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=lx-base.patch
Content-Transfer-Encoding: 7bit

GEODE: Base support for AMD Geode GX/LX processors.

Provide basic support for the AMD Geode GX and LX processors.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 MAINTAINERS                  |    7 +++++++
 arch/i386/Kconfig.cpu        |   14 ++++++++++----
 arch/i386/kernel/cpu/amd.c   |    7 +++++++
 arch/i386/kernel/cpu/cyrix.c |   32 +++++++++++++++++++++++++++++++-
 include/asm-i386/module.h    |    4 +++-
 include/linux/pci_ids.h      |   10 ++++++++++
 6 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index da6973a..b1f9b5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -258,6 +258,13 @@ P:	Ivan Kokshaysky
 M:	ink@jurassic.park.msu.ru
 S:	Maintained for 2.4; PCI support for 2.6.
 
+AMD GEODE PROCESSOR/CHIPSET SUPPORT
+P:      Jordan Crouse
+M:      info-linux@geode.amd.com
+L:	info-linux@geode.amd.com
+W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
+S:	Supported
+
 APM DRIVER
 P:	Stephen Rothwell
 M:	sfr@canb.auug.org.au
diff --git a/arch/i386/Kconfig.cpu b/arch/i386/Kconfig.cpu
index 53bbb3c..79603b3 100644
--- a/arch/i386/Kconfig.cpu
+++ b/arch/i386/Kconfig.cpu
@@ -39,6 +39,7 @@ config M386
 	  - "Winchip-2" for IDT Winchip 2.
 	  - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
 	  - "GeodeGX1" for Geode GX1 (Cyrix MediaGX).
+	  - "Geode GX/LX" For AMD Geode GX and LX processors.
 	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
 	  - "VIA C3-2 for VIA C3-2 "Nehemiah" (model 9 and above).
 
@@ -171,6 +172,11 @@ config MGEODEGX1
 	help
 	  Select this for a Geode GX1 (Cyrix MediaGX) chip.
 
+config MGEODE_LX
+       bool "Geode GX/LX"
+       help
+         Select this for AMD Geode GX and LX processors.
+
 config MCYRIXIII
 	bool "CyrixIII/VIA-C3"
 	help
@@ -220,8 +226,8 @@ config X86_XADD
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4 || X86_GENERIC
-	default "4" if X86_ELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODEGX1
+	default "4" if X86_ELAN || M486 || M386 || MGEODEGX1
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 	default "6" if MK7 || MK8 || MPENTIUMM
 
 config RWSEM_GENERIC_SPINLOCK
@@ -290,12 +296,12 @@ config X86_INTEL_USERCOPY
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MEFFICEON || MGEODE_LX
 	default y
 
 config X86_USE_3DNOW
 	bool
-	depends on MCYRIXIII || MK7
+	depends on MCYRIXIII || MK7 || MGEODE_LX
 	default y
 
 config X86_OOSTORE
diff --git a/arch/i386/kernel/cpu/amd.c b/arch/i386/kernel/cpu/amd.c
index e344ef8..cce0755 100644
--- a/arch/i386/kernel/cpu/amd.c
+++ b/arch/i386/kernel/cpu/amd.c
@@ -161,6 +161,13 @@ static void __init init_amd(struct cpuin
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
diff --git a/arch/i386/kernel/cpu/cyrix.c b/arch/i386/kernel/cpu/cyrix.c
index ff87cc2..60f61b7 100644
--- a/arch/i386/kernel/cpu/cyrix.c
+++ b/arch/i386/kernel/cpu/cyrix.c
@@ -342,6 +342,36 @@ static void __init init_cyrix(struct cpu
 	return;
 }
 
+
+/* This function handles National Semiconductor branded processors */
+
+static void __init init_nsc(struct cpuinfo_x86 *c)
+{
+	int r;
+
+	/* There may be GX1 processors in the wild that are branded
+	 * NSC and not Cyrix.
+	 *
+	 * This function only handles the GX processor, and kicks every
+	 * thing else to the Cyrix init function above - that should
+	 * cover any processors that might have been branded differently
+	 * after NSC aquired Cyrix.
+	 *
+	 * If this breaks your GX1 horribly, please e-mail
+	 * info-linux@ldcmail.amd.com to tell us.
+	 */
+
+	/* Handle the GX (Formally known as the GX2) */
+
+	if ((c->x86 == 5) && (c->x86_model == 5)) {
+		r = get_model_name(c);
+		display_cacheinfo(c);
+	}
+	else
+		init_cyrix(c);
+}
+
+
 /*
  * Cyrix CPUs without cpuid or with cpuid not yet enabled can be detected
  * by the fact that they preserve the flags across the division of 5/2.
@@ -422,7 +452,7 @@ int __init cyrix_init_cpu(void)
 static struct cpu_dev nsc_cpu_dev __initdata = {
 	.c_vendor	= "NSC",
 	.c_ident 	= { "Geode by NSC" },
-	.c_init		= init_cyrix,
+	.c_init		= init_nsc,
 	.c_identify	= generic_identify,
 };
 
diff --git a/include/asm-i386/module.h b/include/asm-i386/module.h
index eb7f2b4..424661d 100644
--- a/include/asm-i386/module.h
+++ b/include/asm-i386/module.h
@@ -52,8 +52,10 @@ struct mod_arch_specific
 #define MODULE_PROC_FAMILY "CYRIXIII "
 #elif defined CONFIG_MVIAC3_2
 #define MODULE_PROC_FAMILY "VIAC3-2 "
-#elif CONFIG_MGEODEGX1
+#elif defined CONFIG_MGEODEGX1
 #define MODULE_PROC_FAMILY "GEODEGX1 "
+#elif defined CONFIG_MGEODE_LX
+#define MODULE_PROC_FAMILY "GEODE "
 #else
 #error unknown processor family
 #endif
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4db67b3..0d8ab6d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -389,6 +389,13 @@
 #define PCI_DEVICE_ID_NS_87410		0xd001
 #define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 
+#define PCI_DEVICE_ID_NS_CS5535_HOST_BRIDGE  0x0028
+#define PCI_DEVICE_ID_NS_CS5535_ISA_BRIDGE   0x002b
+#define PCI_DEVICE_ID_NS_CS5535_IDE          0x002d
+#define PCI_DEVICE_ID_NS_CS5535_AUDIO        0x002e
+#define PCI_DEVICE_ID_NS_CS5535_USB          0x002f
+#define PCI_DEVICE_ID_NS_CS5535_VIDEO        0x0030
+
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202
 #define PCI_DEVICE_ID_TSENG_W32P_b	0x3205
@@ -491,6 +498,9 @@
 
 #define PCI_DEVICE_ID_AMD_CS5536_IDE	0x209A
 
+#define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
+#define PCI_DEVICE_ID_AMD_LX_AES    0x2082
+
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_NX	0x2001

--CUfgB8w4ZwR/yMy5--

