Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUHQFF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUHQFF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 01:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268104AbUHQFF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 01:05:58 -0400
Received: from [12.177.129.25] ([12.177.129.25]:19908 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268108AbUHQFFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 01:05:02 -0400
Message-Id: <200408170606.i7H66UNj019136@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.8.1-mm1 - UML updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Aug 2004 02:06:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below brings UML up to date with some changes in the rest of the
kernel:
	an updated defconfig
	checksum.h includes in6.h to get a definition of in6_addr
	added a missing cpu_{set,clear} change
	removed include/asm-um/module.h since it's really a link

				Jeff


Index: test/arch/um/defconfig
===================================================================
--- test.orig/arch/um/defconfig	2004-08-17 00:37:33.000000000 -0400
+++ test/arch/um/defconfig	2004-08-17 00:38:31.000000000 -0400
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.8.1-mm1
+# Mon Aug 16 22:34:07 2004
 #
 CONFIG_USERMODE=y
 CONFIG_MMU=y
@@ -17,14 +19,12 @@
 CONFIG_HOSTFS=y
 CONFIG_HPPFS=y
 CONFIG_MCONSOLE=y
-CONFIG_MAGIC_SYSRQ=y
 # CONFIG_HOST_2G_2G is not set
 # CONFIG_UML_SMP is not set
 # CONFIG_SMP is not set
 CONFIG_NEST_LEVEL=0
 CONFIG_KERNEL_HALF_GIGS=1
 # CONFIG_HIGHMEM is not set
-CONFIG_PROC_MM=y
 CONFIG_KERNEL_STACK_ORDER=2
 CONFIG_UML_REAL_TIME_CLOCK=y
 
@@ -33,7 +33,6 @@
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
-CONFIG_STANDALONE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
@@ -41,18 +40,25 @@
 #
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_PAGG is not set
 CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
@@ -63,6 +69,9 @@
 #
 # Generic Driver Options
 #
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_DEBUG_DRIVER is not set
 
 #
 # Character Devices
@@ -79,7 +88,8 @@
 CONFIG_CON_CHAN="xterm"
 CONFIG_SSL_CHAN="pty"
 CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_WATCHDOG is not set
 CONFIG_UML_SOUND=y
 CONFIG_SOUND=y
@@ -130,23 +140,21 @@
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_IPV6 is not set
-# CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
 # CONFIG_NETFILTER is not set
 
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
@@ -161,11 +169,20 @@
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_KGDBOE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NETPOLL_RX is not set
+# CONFIG_NETPOLL_TRAP is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
 CONFIG_DUMMY=y
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
@@ -183,6 +200,20 @@
 #
 # Ethernet (10000 Mbit)
 #
+
+#
+# Token Ring devices
+#
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
 CONFIG_PPP=y
 # CONFIG_PPP_MULTILINK is not set
 # CONFIG_PPP_FILTER is not set
@@ -195,36 +226,8 @@
 # CONFIG_SLIP_COMPRESSED is not set
 # CONFIG_SLIP_SMART is not set
 # CONFIG_SLIP_MODE_SLIP6 is not set
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Token Ring devices
-#
 # CONFIG_SHAPER is not set
-
-#
-# Wan interfaces
-#
-# CONFIG_WAN is not set
-
-#
-# Amateur Radio support
-#
-# CONFIG_HAMRADIO is not set
-
-#
-# IrDA (infrared) support
-#
-# CONFIG_IRDA is not set
-
-#
-# Bluetooth support
-#
-# CONFIG_BT is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # File systems
@@ -236,6 +239,7 @@
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
 # CONFIG_REISERFS_PROC_INFO is not set
+# CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_XFS_FS is not set
 CONFIG_MINIX_FS=y
@@ -261,6 +265,8 @@
 CONFIG_FAT_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -268,6 +274,7 @@
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
 CONFIG_DEVFS_FS=y
 CONFIG_DEVFS_MOUNT=y
 # CONFIG_DEVFS_DEBUG is not set
@@ -288,6 +295,7 @@
 # CONFIG_EFS_FS is not set
 CONFIG_JFFS_FS=y
 CONFIG_JFFS_FS_VERBOSE=0
+# CONFIG_JFFS_PROC_FS is not set
 # CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
@@ -342,6 +350,7 @@
 # CONFIG_NLS_ISO8859_8 is not set
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
 # CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
@@ -360,6 +369,7 @@
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
@@ -370,7 +380,9 @@
 #
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 # CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
 
 #
 # SCSI support
@@ -404,10 +416,19 @@
 #
 # CONFIG_MTD_CFI is not set
 # CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
 
 #
 # Mapping drivers for chip access
@@ -418,6 +439,7 @@
 # Self-contained MTD device drivers
 #
 # CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
 CONFIG_MTD_BLKMTD=y
 
@@ -436,6 +458,7 @@
 #
 # Kernel hacking
 #
+CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_INFO=y
Index: test/arch/um/include/sysdep-i386/checksum.h
===================================================================
--- test.orig/arch/um/include/sysdep-i386/checksum.h	2004-06-16 01:18:59.000000000 -0400
+++ test/arch/um/include/sysdep-i386/checksum.h	2004-08-17 00:38:31.000000000 -0400
@@ -5,6 +5,7 @@
 #ifndef __UM_SYSDEP_CHECKSUM_H
 #define __UM_SYSDEP_CHECKSUM_H
 
+#include "linux/in6.h"
 #include "linux/string.h"
 
 /*
Index: test/arch/um/kernel/skas/Makefile
===================================================================
--- test.orig/arch/um/kernel/skas/Makefile	2004-08-17 00:37:33.000000000 -0400
+++ test/arch/um/kernel/skas/Makefile	2004-08-17 00:38:31.000000000 -0400
@@ -7,7 +7,7 @@
 	process_kern.o syscall_kern.o syscall_user.o time.o tlb.o trap_user.o \
 	uaccess.o sys-$(SUBARCH)/
 
-host-progs	:= util/mk_ptregs
+hostprogs-y	:= util/mk_ptregs
 clean-files	:= include/skas_ptregs.h
 
 USER_OBJS = $(filter %_user.o,$(obj-y)) process.o time.o
Index: test/arch/um/util/Makefile
===================================================================
--- test.orig/arch/um/util/Makefile	2004-08-17 00:37:33.000000000 -0400
+++ test/arch/um/util/Makefile	2004-08-17 00:38:31.000000000 -0400
@@ -1,5 +1,5 @@
-host-progs		:= mk_task mk_constants
-always			:= $(host-progs)
+hostprogs-y		:= mk_task mk_constants
+always			:= $(hostprogs-y)
 
 mk_task-objs		:= mk_task_user.o mk_task_kern.o
 mk_constants-objs	:= mk_constants_user.o mk_constants_kern.o
Index: test/include/asm-um/mmu_context.h
===================================================================
--- test.orig/include/asm-um/mmu_context.h	2004-06-16 01:19:26.000000000 -0400
+++ test/include/asm-um/mmu_context.h	2004-08-17 00:38:31.000000000 -0400
@@ -26,8 +26,8 @@
 	unsigned cpu = smp_processor_id();
 
 	if(prev != next){
-		clear_bit(cpu, &prev->cpu_vm_mask);
-		set_bit(cpu, &next->cpu_vm_mask);
+		cpu_clear(cpu, prev->cpu_vm_mask);
+		cpu_set(cpu, next->cpu_vm_mask);
 		if(next != &init_mm)
 			CHOOSE_MODE((void) 0, 
 				    switch_mm_skas(next->context.skas.mm_fd));
Index: test/include/asm-um/module.h
===================================================================
--- test.orig/include/asm-um/module.h	2004-06-16 01:19:37.000000000 -0400
+++ test/include/asm-um/module.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,13 +0,0 @@
-#ifndef __UM_MODULE_H
-#define __UM_MODULE_H
-
-/* UML is simple */
-struct mod_arch_specific
-{
-};
-
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-
-#endif

