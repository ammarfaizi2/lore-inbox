Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbWFMAfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWFMAfB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWFMAfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:35:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:63979 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932704AbWFMAet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:34:49 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/16] 64bit Resource: finally enable 64bit resource sizes
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 12 Jun 2006 17:31:18 -0700
Message-Id: <11501587343689-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11501587303683-git-send-email-greg@kroah.com>
References: <20060613003033.GA10717@kroah.com> <11501586781628-git-send-email-greg@kroah.com> <1150158683636-git-send-email-greg@kroah.com> <11501586871870-git-send-email-greg@kroah.com> <11501586902008-git-send-email-greg@kroah.com> <11501586942938-git-send-email-greg@kroah.com> <11501586982289-git-send-email-greg@kroah.com> <11501587011194-git-send-email-greg@kroah.com> <11501587043722-git-send-email-greg@kroah.com> <11501587082203-git-send-email-greg@kroah.com> <11501587122736-git-send-email-greg@kroah.com> <11501587153872-git-send-email-greg@kroah.com> <11501587193060-git-send-email-greg@kroah.com> <11501587223213-git-send-email-greg@kroah.com> <11501587273612-git-send-email-greg@kroah.com> <11501587303683-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Introduce the Kconfig entry and actually switch to a 64bit value, if
wanted, for resource_size_t.

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/arm/Kconfig       |    7 +++++++
 arch/arm26/Kconfig     |    7 +++++++
 arch/cris/Kconfig      |    7 +++++++
 arch/frv/Kconfig       |    7 +++++++
 arch/i386/Kconfig      |    7 +++++++
 arch/m32r/Kconfig      |    7 +++++++
 arch/m68k/Kconfig      |    7 +++++++
 arch/m68knommu/Kconfig |    7 +++++++
 arch/mips/Kconfig      |    8 ++++++++
 arch/parisc/Kconfig    |    8 ++++++++
 arch/powerpc/Kconfig   |    8 ++++++++
 arch/ppc/Kconfig       |    7 +++++++
 arch/s390/Kconfig      |    8 ++++++++
 arch/sh/Kconfig        |    7 +++++++
 arch/sparc/Kconfig     |    7 +++++++
 arch/v850/Kconfig      |    7 +++++++
 arch/xtensa/Kconfig    |    7 +++++++
 include/linux/types.h  |    7 ++++++-
 kernel/resource.c      |   11 ++++++++++-
 19 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 08b7cc9..9248a69 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -518,6 +518,13 @@ config NODES_SHIFT
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config LEDS
 	bool "Timer and CPU usage LEDs"
 	depends on ARCH_CDB89712 || ARCH_CO285 || ARCH_EBSA110 || \
diff --git a/arch/arm26/Kconfig b/arch/arm26/Kconfig
index cf4ebf4..919f745 100644
--- a/arch/arm26/Kconfig
+++ b/arch/arm26/Kconfig
@@ -187,6 +187,13 @@ config CMDLINE
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 source "net/Kconfig"
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 856b665..91c0d3a 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -80,6 +80,13 @@ config PREEMPT
 
 source mm/Kconfig
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 menu "Hardware setup"
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 95a3892..f929b05 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -80,6 +80,13 @@ config HIGHPTE
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 choice
 	prompt "uClinux kernel load address"
 	depends on !MMU
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8dfa305..34542cb 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -754,6 +754,13 @@ config PHYSICAL_START
 
 	  Don't change this unless you know what you are doing.
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && !X86_PAE
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 41fd490..24d6a1d 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -188,6 +188,13 @@ config ARCH_DISCONTIGMEM_ENABLE
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config IRAM_START
 	hex "Internal memory start address (hex)"
 	default "00f00000" if !CHIP_M32104
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 805b81f..22dcaa5 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -368,6 +368,13 @@ config 060_WRITETHROUGH
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 menu "General setup"
diff --git a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
index 3cde682..e71fbe7 100644
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -605,6 +605,13 @@ endchoice
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e8ff09f..cf5defc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1653,6 +1653,14 @@ config NR_CPUS
 
 source "kernel/Kconfig.preempt"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on 32BIT
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config RTC_DS1742
 	bool "DS1742 BRAM/RTC support"
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 910fb3a..591b49b 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -217,6 +217,14 @@ source "kernel/Kconfig.preempt"
 source "kernel/Kconfig.hz"
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on !64BIT
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config COMPAT
 	def_bool y
 	depends on 64BIT
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6729c98..9444dfa 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -626,6 +626,14 @@ config CRASH_DUMP
 
 	  Don't change this unless you know what you are doing.
 
+config RESOURCES_32BIT
+        bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+        depends on EXPERIMENTAL
+	depends on PPC32
+        help
+          By default resources are 64 bit. This option allows memory and IO
+          resources to be 32 bit to optimize code size.
+
 config EMBEDDEDBOOT
 	bool
 	depends on 8xx || 8260
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index e9a8f5d..c174d05 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -953,6 +953,13 @@ source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 source "fs/Kconfig.binfmt"
 
 config PREP_RESIDUAL
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 01c5c08..785b2f6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -218,6 +218,14 @@ config WARN_STACK_SIZE
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on !64BIT
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2bcecf4..dc1decb 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -532,6 +532,13 @@ config NODES_SHIFT
 	default "1"
 	depends on NEED_MULTIPLE_NODES
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9431e96..cd3cca3 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -67,6 +67,13 @@ config SPARC32
 	  maintains both the SPARC32 and SPARC64 ports; its web page is
 	  available at <http://www.ultralinux.org/>.
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 # Global things across all Sun machines.
 config ISA
 	bool
diff --git a/arch/v850/Kconfig b/arch/v850/Kconfig
index 37ec644..9aab649 100644
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -235,6 +235,13 @@ menu "Processor type and features"
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index dbeb350..46ede7f 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -99,6 +99,13 @@ config MATH_EMULATION
 config HIGHMEM
 	bool "High memory support"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 menu "Platform options"
diff --git a/include/linux/types.h b/include/linux/types.h
index 047eb8b..27835d5 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -179,9 +179,14 @@ #endif
 #ifdef __KERNEL__
 typedef unsigned __bitwise__ gfp_t;
 
-typedef unsigned long resource_size_t;
+#ifdef CONFIG_RESOURCES_32BIT
+typedef __u32 resource_size_t;
+#else
+typedef __u64 resource_size_t;
 #endif
 
+#endif	/* __KERNEL__ */
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 	__kernel_ino_t		f_tinode;
diff --git a/kernel/resource.c b/kernel/resource.c
index ad90a70..09b85c4 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,7 +23,11 @@ #include <asm/io.h>
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
-	.start	= 0x0000,
+#ifdef CONFIG_RESOURCES_32BIT
+	.start	= 0x0000UL,
+#else
+	.start	= 0x0000ULL,
+#endif
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
@@ -32,8 +36,13 @@ EXPORT_SYMBOL(ioport_resource);
 
 struct resource iomem_resource = {
 	.name	= "PCI mem",
+#ifdef CONFIG_RESOURCES_32BIT
 	.start	= 0UL,
 	.end	= ~0UL,
+#else
+	.start	= 0ULL,
+	.end	= ~0ULL,
+#endif
 	.flags	= IORESOURCE_MEM,
 };
 
-- 
1.4.0

