Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVGUE6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVGUE6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 00:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVGUE6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 00:58:14 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:63149 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261629AbVGUE5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 00:57:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Add defconfigs
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050721045730.6E72C418@mctpc71>
Date: Thu, 21 Jul 2005 13:57:30 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/Makefile                     |    7 
 arch/v850/README                       |   62 ++-
 arch/v850/configs/rte-ma1-cb_defconfig |  605 +++++++++++++++++++++++++++++++++
 arch/v850/configs/rte-me2-cb_defconfig |  453 ++++++++++++++++++++++++
 arch/v850/configs/sim_defconfig        |  442 ++++++++++++++++++++++++
 5 files changed, 1542 insertions(+), 27 deletions(-)

diff -ruN -X../cludes linux-2.6.12-uc0/arch/v850/Makefile linux-2.6.12-uc0-v850-20050721/arch/v850/Makefile
--- linux-2.6.12-uc0/arch/v850/Makefile	2003-07-28 10:13:57.643115000 +0900
+++ linux-2.6.12-uc0-v850-20050721/arch/v850/Makefile	2005-07-21 11:34:48.550867000 +0900
@@ -1,8 +1,8 @@
 #
 # arch/v850/Makefile
 #
-#  Copyright (C) 2001,02,03  NEC Corporation
-#  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+#  Copyright (C) 2001,02,03,05  NEC Corporation
+#  Copyright (C) 2001,02,03,05  Miles Bader <miles@gnu.org>
 #
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies. Remember to do have actions
@@ -22,6 +22,9 @@
 CFLAGS += -fno-builtin
 CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
 
+# By default, build a kernel that runs on the gdb v850 simulator.
+KBUILD_DEFCONFIG := sim_defconfig
+
 # This prevents the linker from consolidating the .gnu.linkonce.this_module
 # section into .text (which the v850 default linker script for -r does for
 # some reason)
diff -ruN -X../cludes linux-2.6.12-uc0/arch/v850/README linux-2.6.12-uc0-v850-20050721/arch/v850/README
--- linux-2.6.12-uc0/arch/v850/README	2003-07-28 10:13:57.663116000 +0900
+++ linux-2.6.12-uc0-v850-20050721/arch/v850/README	2005-07-21 11:48:07.674661000 +0900
@@ -1,31 +1,43 @@
 This port to the NEC V850E processor supports the following platforms:
 
-   + The gdb v850e simulator (CONFIG_V850E_SIM).
+   "sim"
+	The gdb v850e simulator (CONFIG_V850E_SIM).
 
-   + The Midas labs RTE-V850E/MA1-CB and RTE-V850E/NB85E-CB evaluation boards
-     (CONFIG_RTE_CB_MA1 and CONFIG_RTE_CB_NB85E).  This support has only been
-     tested when running with the Multi-debugger monitor ROM (for the Green
-     Hills Multi debugger).  The optional NEC Solution Gear RTE-MOTHER-A
-     motherboard is also supported, which allows PCI boards to be used
-     (CONFIG_RTE_MB_A_PCI).
-
-   + The Midas labs RTE-V850E/ME2-CB evaluation board (CONFIG_RTE_CB_ME2).
-     This has only been tested using a kernel downloaded via an ICE connection
-     using the Multi debugger.  Support for the RTE-MOTHER-A is present, but
-     hasn't been tested (unlike the other Midas labs cpu boards, the
-     RTE-V850E/ME2-CB includes an ethernet adaptor).
-
-   + The NEC AS85EP1 V850E evaluation chip/board (CONFIG_V850E_AS85EP1).
-
-   + The NEC `Anna' (board/chip) implementation of the V850E2 processor
-     (CONFIG_V850E2_ANNA).
-
-   + The sim85e2c and sim85e2s simulators, which are verilog simulations of
-     the V850E2 NA85E2C/NA85E2S cpu cores (CONFIG_V850E2_SIM85E2C and
-     CONFIG_V850E2_SIM85E2S).
-
-   + A FPGA implementation of the V850E2 NA85E2C cpu core
-     (CONFIG_V850E2_FPGA85E2C).
+   "rte-ma1-cb"
+	The Midas labs RTE-V850E/MA1-CB and RTE-V850E/NB85E-CB evaluation
+	boards (CONFIG_RTE_CB_MA1 and CONFIG_RTE_CB_NB85E).  This support
+	has only been tested when running with the Multi-debugger monitor
+	ROM (for the Green Hills Multi debugger).  The optional NEC
+	Solution Gear RTE-MOTHER-A motherboard is also supported, which
+	allows PCI boards to be used (CONFIG_RTE_MB_A_PCI).
+
+   "rte-me2-cb"
+	The Midas labs RTE-V850E/ME2-CB evaluation board (CONFIG_RTE_CB_ME2).
+     	This has only been tested using a kernel downloaded via an ICE
+     	connection using the Multi debugger.  Support for the RTE-MOTHER-A is
+     	present, but hasn't been tested (unlike the other Midas labs cpu
+     	boards, the RTE-V850E/ME2-CB includes an ethernet adaptor).
+
+   "as85ep1"
+	The NEC AS85EP1 V850E evaluation chip/board (CONFIG_V850E_AS85EP1).
+
+   "anna"
+	The NEC `Anna' (board/chip) implementation of the V850E2 processor
+	(CONFIG_V850E2_ANNA).
+
+   "sim85e2c", "sim85e2s"
+   	The sim85e2c and sim85e2s simulators, which are verilog simulations
+	of the V850E2 NA85E2C/NA85E2S cpu cores (CONFIG_V850E2_SIM85E2C and
+	CONFIG_V850E2_SIM85E2S).
+
+   "fpga85e2c"
+	A FPGA implementation of the V850E2 NA85E2C cpu core
+	(CONFIG_V850E2_FPGA85E2C).
+
+To get a default kernel configuration for a particular platform, you can
+use a <platform>_defconfig make target (e.g., "make rte-me2-cb_defconfig");
+to see which default configurations are possible, look in the directory
+"arch/v850/configs".
 
 Porting to anything with a V850E/MA1 or MA2 processor should be simple.
 See the file <asm-v850/machdep.h> and the files it includes for an example of
diff -ruN -X../cludes linux-2.6.12-uc0/arch/v850/configs/rte-me2-cb_defconfig linux-2.6.12-uc0-v850-20050721/arch/v850/configs/rte-me2-cb_defconfig
--- linux-2.6.12-uc0/arch/v850/configs/rte-me2-cb_defconfig	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.12-uc0-v850-20050721/arch/v850/configs/rte-me2-cb_defconfig	2005-07-21 11:30:56.192738000 +0900
@@ -0,0 +1,453 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.12-uc0
+# Thu Jul 21 11:30:08 2005
+#
+# CONFIG_MMU is not set
+# CONFIG_UID16 is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+# CONFIG_ISA is not set
+# CONFIG_ISAPNP is not set
+# CONFIG_EISA is not set
+# CONFIG_MCA is not set
+CONFIG_V850=y
+
+#
+# Processor type and features
+#
+# CONFIG_V850E_SIM is not set
+# CONFIG_RTE_CB_MA1 is not set
+# CONFIG_RTE_CB_NB85E is not set
+CONFIG_RTE_CB_ME2=y
+# CONFIG_V850E_AS85EP1 is not set
+# CONFIG_V850E2_SIM85E2C is not set
+# CONFIG_V850E2_SIM85E2S is not set
+# CONFIG_V850E2_FPGA85E2C is not set
+# CONFIG_V850E2_ANNA is not set
+CONFIG_V850E=y
+CONFIG_V850E_ME2=y
+CONFIG_RTE_CB=y
+# CONFIG_RTE_MB_A_PCI is not set
+# CONFIG_PCI is not set
+CONFIG_V850E_INTC=y
+CONFIG_V850E_TIMER_D=y
+CONFIG_V850E_CACHE=y
+# CONFIG_V850E2_CACHE is not set
+# CONFIG_NO_CACHE is not set
+# CONFIG_ROM_KERNEL is not set
+CONFIG_ZERO_BSS=y
+# CONFIG_V850E_HIGHRES_TIMER is not set
+# CONFIG_RESET_GUARD is not set
+CONFIG_LARGE_ALLOCS=y
+
+#
+# Code maturity level options
+#
+# CONFIG_EXPERIMENTAL is not set
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_SYSCTL is not set
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_BASE_SMALL=1
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
+#
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_FLAT=y
+# CONFIG_BINFMT_ZFLAT is not set
+# CONFIG_BINFMT_SHARED_FLAT is not set
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_PARTITIONS is not set
+
+#
+# User Modules And Translation Layers
+#
+# CONFIG_MTD_CHAR is not set
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
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
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+
+#
+# Self-contained MTD device drivers
+#
+CONFIG_MTD_SLRAM=y
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+
+#
+# Disk device support
+#
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Networking support
+#
+# CONFIG_NET is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=1
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_V850E_UART is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+CONFIG_ROMFS_FS=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_SYSFS=y
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_NO_KERNEL_MSG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
diff -ruN -X../cludes linux-2.6.12-uc0/arch/v850/configs/sim_defconfig linux-2.6.12-uc0-v850-20050721/arch/v850/configs/sim_defconfig
--- linux-2.6.12-uc0/arch/v850/configs/sim_defconfig	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.12-uc0-v850-20050721/arch/v850/configs/sim_defconfig	2005-07-21 11:31:03.852667000 +0900
@@ -0,0 +1,442 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.12-uc0
+# Thu Jul 21 11:29:27 2005
+#
+# CONFIG_MMU is not set
+# CONFIG_UID16 is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+# CONFIG_ISA is not set
+# CONFIG_ISAPNP is not set
+# CONFIG_EISA is not set
+# CONFIG_MCA is not set
+CONFIG_V850=y
+
+#
+# Processor type and features
+#
+CONFIG_V850E_SIM=y
+# CONFIG_RTE_CB_MA1 is not set
+# CONFIG_RTE_CB_NB85E is not set
+# CONFIG_RTE_CB_ME2 is not set
+# CONFIG_V850E_AS85EP1 is not set
+# CONFIG_V850E2_SIM85E2C is not set
+# CONFIG_V850E2_SIM85E2S is not set
+# CONFIG_V850E2_FPGA85E2C is not set
+# CONFIG_V850E2_ANNA is not set
+CONFIG_V850E=y
+# CONFIG_PCI is not set
+# CONFIG_V850E_INTC is not set
+# CONFIG_V850E_TIMER_D is not set
+# CONFIG_V850E_CACHE is not set
+# CONFIG_V850E2_CACHE is not set
+CONFIG_NO_CACHE=y
+CONFIG_ZERO_BSS=y
+# CONFIG_RESET_GUARD is not set
+CONFIG_LARGE_ALLOCS=y
+
+#
+# Code maturity level options
+#
+# CONFIG_EXPERIMENTAL is not set
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_SYSCTL is not set
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_BASE_SMALL=1
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
+#
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_FLAT=y
+# CONFIG_BINFMT_ZFLAT is not set
+# CONFIG_BINFMT_SHARED_FLAT is not set
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_PARTITIONS is not set
+
+#
+# User Modules And Translation Layers
+#
+# CONFIG_MTD_CHAR is not set
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
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
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+
+#
+# Self-contained MTD device drivers
+#
+CONFIG_MTD_SLRAM=y
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+
+#
+# Disk device support
+#
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Networking support
+#
+# CONFIG_NET is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+CONFIG_ROMFS_FS=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_SYSFS=y
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_NO_KERNEL_MSG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
diff -ruN -X../cludes linux-2.6.12-uc0/arch/v850/configs/rte-ma1-cb_defconfig linux-2.6.12-uc0-v850-20050721/arch/v850/configs/rte-ma1-cb_defconfig
--- linux-2.6.12-uc0/arch/v850/configs/rte-ma1-cb_defconfig	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.12-uc0-v850-20050721/arch/v850/configs/rte-ma1-cb_defconfig	2005-07-21 12:45:27.366492000 +0900
@@ -0,0 +1,605 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.12-uc0
+# Thu Jul 21 11:08:27 2005
+#
+# CONFIG_MMU is not set
+# CONFIG_UID16 is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+# CONFIG_ISA is not set
+# CONFIG_ISAPNP is not set
+# CONFIG_EISA is not set
+# CONFIG_MCA is not set
+CONFIG_V850=y
+
+#
+# Processor type and features
+#
+# CONFIG_V850E_SIM is not set
+CONFIG_RTE_CB_MA1=y
+# CONFIG_RTE_CB_NB85E is not set
+# CONFIG_RTE_CB_ME2 is not set
+# CONFIG_V850E_AS85EP1 is not set
+# CONFIG_V850E2_SIM85E2C is not set
+# CONFIG_V850E2_SIM85E2S is not set
+# CONFIG_V850E2_FPGA85E2C is not set
+# CONFIG_V850E2_ANNA is not set
+CONFIG_V850E=y
+CONFIG_V850E_MA1=y
+CONFIG_RTE_CB=y
+CONFIG_RTE_CB_MULTI=y
+CONFIG_RTE_CB_MULTI_DBTRAP=y
+# CONFIG_RTE_CB_MA1_KSRAM is not set
+CONFIG_RTE_MB_A_PCI=y
+CONFIG_RTE_GBUS_INT=y
+CONFIG_PCI=y
+CONFIG_V850E_INTC=y
+CONFIG_V850E_TIMER_D=y
+# CONFIG_V850E_CACHE is not set
+# CONFIG_V850E2_CACHE is not set
+CONFIG_NO_CACHE=y
+CONFIG_ZERO_BSS=y
+# CONFIG_V850E_HIGHRES_TIMER is not set
+# CONFIG_RESET_GUARD is not set
+CONFIG_LARGE_ALLOCS=y
+
+#
+# Code maturity level options
+#
+# CONFIG_EXPERIMENTAL is not set
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_SYSCTL is not set
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_BASE_SMALL=1
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
+#
+# CONFIG_PCI_LEGACY_PROC is not set
+# CONFIG_PCI_NAMES is not set
+# CONFIG_PCI_DEBUG is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_FLAT=y
+# CONFIG_BINFMT_ZFLAT is not set
+# CONFIG_BINFMT_SHARED_FLAT is not set
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_PARTITIONS is not set
+
+#
+# User Modules And Translation Layers
+#
+# CONFIG_MTD_CHAR is not set
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
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
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+CONFIG_MTD_SLRAM=y
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# Disk device support
+#
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_PACKET is not set
+# CONFIG_UNIX is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_IP_TCPDIAG is not set
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_SMC is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NE2000 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_DGRS is not set
+CONFIG_EEPRO100=y
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
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
+# CONFIG_FDDI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_V850E_UART=y
+CONFIG_V850E_UART_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+CONFIG_ROMFS_FS=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_SYSFS=y
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_SUNRPC=y
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_NO_KERNEL_MSG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
