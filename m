Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVCVSBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVCVSBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCVSAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:00:54 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:35497 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261499AbVCVR4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:39 -0500
Subject: [patch 06/12] uml: disable more hardware kconfig opt and rename USERMODE to UML
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:31 +0100
Message-Id: <20050322162131.7FC529766B@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Disable some hardware-only configuration options when configuring for ARCH=um.

By the way, we rename CONFIG_USERMODE to CONFIG_UML, as requested some time ago by the
UML maintainer Jeff Dike.

We also update defconfig as a consequence of all this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig       |    3 --
 linux-2.6.11-paolo/arch/um/defconfig     |   43 +++++--------------------------
 linux-2.6.11-paolo/drivers/block/Kconfig |   10 +++----
 linux-2.6.11-paolo/drivers/char/Kconfig  |    2 -
 linux-2.6.11-paolo/drivers/net/Kconfig   |    8 +++--
 linux-2.6.11-paolo/init/Kconfig          |    2 -
 6 files changed, 20 insertions(+), 48 deletions(-)

diff -puN arch/um/Kconfig~uml-disable-more-hardware-kconfig-opt arch/um/Kconfig
--- linux-2.6.11/arch/um/Kconfig~uml-disable-more-hardware-kconfig-opt	2005-03-21 15:25:45.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig	2005-03-21 15:25:45.000000000 +0100
@@ -3,7 +3,7 @@ config GENERIC_HARDIRQS
 	bool
 	default y
 
-config USERMODE
+config UML
 	bool
 	default y
 
@@ -244,7 +244,6 @@ config KERNEL_HALF_GIGS
 
 config HIGHMEM
 	bool "Highmem support"
-	depends on BROKEN
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
diff -puN drivers/block/Kconfig~uml-disable-more-hardware-kconfig-opt drivers/block/Kconfig
--- linux-2.6.11/drivers/block/Kconfig~uml-disable-more-hardware-kconfig-opt	2005-03-21 15:25:45.000000000 +0100
+++ linux-2.6.11-paolo/drivers/block/Kconfig	2005-03-21 15:25:45.000000000 +0100
@@ -6,7 +6,7 @@ menu "Block devices"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on (!ARCH_S390 && !M68K && !IA64 && !USERMODE) || Q40 || (SUN3X && BROKEN)
+	depends on (!ARCH_S390 && !M68K && !IA64 && !UML) || Q40 || (SUN3X && BROKEN)
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
@@ -210,7 +210,7 @@ config BLK_DEV_UMEM
 
 config BLK_DEV_UBD
 	bool "Virtual block device"
-	depends on USERMODE
+	depends on UML
 	---help---
           The User-Mode Linux port includes a driver called UBD which will let
           you access arbitrary files on the host computer as block devices.
@@ -243,7 +243,7 @@ config BLK_DEV_COW_COMMON
 
 config MMAPPER
 	tristate "Example IO memory driver (BROKEN)"
-	depends on USERMODE && BROKEN
+	depends on UML && BROKEN
 	---help---
           The User-Mode Linux port can provide support for IO Memory
           emulation with this option.  This allows a host file to be
@@ -455,7 +455,7 @@ config INITRAMFS_ROOT_GID
 #for instance.
 config LBD
 	bool "Support for Large Block Devices"
-	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH || USERMODE
+	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH || UML
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device
@@ -463,7 +463,7 @@ config LBD
 
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"
-	depends on !USERMODE
+	depends on !UML
 	help
 	  If you have a CDROM drive that supports packet writing, say Y to
 	  include preliminary support. It should work with any MMC/Mt Fuji
diff -puN drivers/char/Kconfig~uml-disable-more-hardware-kconfig-opt drivers/char/Kconfig
--- linux-2.6.11/drivers/char/Kconfig~uml-disable-more-hardware-kconfig-opt	2005-03-21 15:25:45.000000000 +0100
+++ linux-2.6.11-paolo/drivers/char/Kconfig	2005-03-21 15:25:45.000000000 +0100
@@ -59,7 +59,7 @@ config VT_CONSOLE
 
 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !USERMODE
+	depends on VT && !S390 && !UML
 	default y
 
 config SERIAL_NONSTANDARD
diff -puN drivers/net/Kconfig~uml-disable-more-hardware-kconfig-opt drivers/net/Kconfig
--- linux-2.6.11/drivers/net/Kconfig~uml-disable-more-hardware-kconfig-opt	2005-03-21 15:25:45.000000000 +0100
+++ linux-2.6.11-paolo/drivers/net/Kconfig	2005-03-21 15:25:45.000000000 +0100
@@ -158,7 +158,7 @@ endif
 #
 
 menu "Ethernet (10 or 100Mbit)"
-	depends on NETDEVICES
+	depends on NETDEVICES && !UML
 
 config NET_ETHERNET
 	bool "Ethernet (10 or 100Mbit)"
@@ -1790,7 +1790,7 @@ endmenu
 #
 
 menu "Ethernet (1000 Mbit)"
-	depends on NETDEVICES
+	depends on NETDEVICES && !UML
 
 config ACENIC
 	tristate "Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support"
@@ -2100,7 +2100,7 @@ endmenu
 #
 
 menu "Ethernet (10000 Mbit)"
-	depends on NETDEVICES
+	depends on NETDEVICES && !UML
 
 config IXGB
 	tristate "Intel(R) PRO/10GbE support"
@@ -2179,11 +2179,13 @@ config 2BUFF_MODE
 
 endmenu
 
+if !UML
 source "drivers/net/tokenring/Kconfig"
 
 source "drivers/net/wireless/Kconfig"
 
 source "drivers/net/pcmcia/Kconfig"
+endif
 
 source "drivers/net/wan/Kconfig"
 
diff -puN init/Kconfig~uml-disable-more-hardware-kconfig-opt init/Kconfig
--- linux-2.6.11/init/Kconfig~uml-disable-more-hardware-kconfig-opt	2005-03-21 15:25:45.000000000 +0100
+++ linux-2.6.11-paolo/init/Kconfig	2005-03-21 15:25:45.000000000 +0100
@@ -421,7 +421,7 @@ config OBSOLETE_MODPARM
 
 config MODVERSIONS
 	bool "Module versioning support (EXPERIMENTAL)"
-	depends on MODULES && EXPERIMENTAL && !USERMODE
+	depends on MODULES && EXPERIMENTAL && !UML
 	help
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
diff -puN arch/um/defconfig~uml-disable-more-hardware-kconfig-opt arch/um/defconfig
--- linux-2.6.11/arch/um/defconfig~uml-disable-more-hardware-kconfig-opt	2005-03-21 15:25:45.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/defconfig	2005-03-21 15:25:45.000000000 +0100
@@ -1,10 +1,10 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11
-# Fri Mar  4 15:38:53 2005
+# Linux kernel version: 2.6.12-rc1-bk1
+# Sun Mar 20 16:53:00 2005
 #
 CONFIG_GENERIC_HARDIRQS=y
-CONFIG_USERMODE=y
+CONFIG_UML=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
@@ -31,6 +31,7 @@ CONFIG_MCONSOLE=y
 # CONFIG_SMP is not set
 CONFIG_NEST_LEVEL=0
 CONFIG_KERNEL_HALF_GIGS=1
+# CONFIG_HIGHMEM is not set
 CONFIG_KERNEL_STACK_ORDER=2
 CONFIG_UML_REAL_TIME_CLOCK=y
 
@@ -61,7 +62,6 @@ CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_BASE_FULL=y
-CONFIG_BASE_SMALL=0
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
@@ -70,6 +70,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -215,38 +216,6 @@ CONFIG_DUMMY=m
 CONFIG_TUN=m
 
 #
-# Ethernet (10 or 100Mbit)
-#
-# CONFIG_NET_ETHERNET is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# PCMCIA network device support
-#
-# CONFIG_NET_PCMCIA is not set
-
-#
-# PCMCIA network device support
-#
-# CONFIG_NET_PCMCIA is not set
-
-#
 # Wan interfaces
 #
 # CONFIG_WAN is not set
@@ -431,7 +400,9 @@ CONFIG_CRC32=m
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 CONFIG_DEBUG_KERNEL=y
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
_
