Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbULGSbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbULGSbg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbULGSbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:31:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59124 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261881AbULGS3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:29:25 -0500
Message-ID: <41B5F670.6060306@mvista.com>
Date: Tue, 07 Dec 2004 11:29:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH][PPC32] Support for Force CPCI-690 board
Content-Type: multipart/mixed;
 boundary="------------020008070203090800080906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020008070203090800080906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for the Force CPCI-690 cPCI board.

The patch depends on the Marvell host bridge support patch (mv64x60).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------020008070203090800080906
Content-Type: text/plain;
 name="cpci690.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpci690.patch"

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2004-12-06 16:31:13 -07:00
+++ b/arch/ppc/Kconfig	2004-12-06 16:31:13 -07:00
@@ -509,6 +509,11 @@
 config WILLOW
 	bool "Cogent-Willow"
 
+config CPCI690
+	bool "Force-CPCI690"
+	help
+	  Select CPCI690 if configuring a Force CPCI690 cPCI board.
+
 config PCORE
 	bool "Force-PowerCore"
 
@@ -699,7 +704,7 @@
 
 config GT64260
 	bool
-	depends on EV64260
+	depends on EV64260 || CPCI690
 	default y
 
 config MV64360
diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile	2004-12-06 16:31:13 -07:00
+++ b/arch/ppc/boot/simple/Makefile	2004-12-06 16:31:13 -07:00
@@ -47,6 +47,12 @@
 # See arch/ppc/kconfig and arch/ppc/platforms/Kconfig
 # for definition of what platform each config option refer to.
 #----------------------------------------------------------------------------
+      zimage-$(CONFIG_CPCI690)		:= zImage-STRIPELF
+zimageinitrd-$(CONFIG_CPCI690)		:= zImage.initrd-STRIPELF
+     extra.o-$(CONFIG_CPCI690)		:= misc-cpci690.o mv64x60_stub.o
+         end-$(CONFIG_CPCI690)		:= cpci690
+   cacheflag-$(CONFIG_CPCI690)		:= -include $(clear_L2_L3)
+
       zimage-$(CONFIG_IBM_OPENBIOS)	:= zImage-TREE
 zimageinitrd-$(CONFIG_IBM_OPENBIOS)	:= zImage.initrd-TREE
          end-$(CONFIG_IBM_OPENBIOS)	:= treeboot
diff -Nru a/arch/ppc/boot/simple/misc-cpci690.c b/arch/ppc/boot/simple/misc-cpci690.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/boot/simple/misc-cpci690.c	2004-12-06 16:31:13 -07:00
@@ -0,0 +1,15 @@
+/*
+ * arch/ppc/boot/simple/misc-cpci690.c
+ * 
+ * Add birec data for Force CPCI690 board.
+ *
+ * Author: Mark A. Greer <source@mvista.com>
+ *
+ * 2003 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/types.h>
+long	mv64x60_mpsc_clk_freq = 133000000;
diff -Nru a/arch/ppc/configs/cpci690_defconfig b/arch/ppc/configs/cpci690_defconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/configs/cpci690_defconfig	2004-12-06 16:31:13 -07:00
@@ -0,0 +1,686 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc2
+# Fri Dec  3 15:56:10 2004
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+CONFIG_6xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_E500 is not set
+CONFIG_ALTIVEC=y
+# CONFIG_TAU is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_PPC_STD_MMU=y
+# CONFIG_NOT_COHERENT_CACHE is not set
+
+#
+# Platform options
+#
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_APUS is not set
+# CONFIG_KATANA is not set
+# CONFIG_DMV182 is not set
+# CONFIG_WILLOW is not set
+CONFIG_CPCI690=y
+# CONFIG_PCORE is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_EV64260 is not set
+# CONFIG_DB64360 is not set
+# CONFIG_CHESTNUT is not set
+# CONFIG_SPRUCE is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MCPN765 is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_PRPMC880 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_ADIR is not set
+# CONFIG_K2 is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBC82xx is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX8260 is not set
+# CONFIG_TQM8260 is not set
+# CONFIG_ADS8272 is not set
+# CONFIG_LITE5200 is not set
+
+#
+# Set bridge options
+#
+CONFIG_MV64X60_BASE=0xf1000000
+CONFIG_MV64X60_NEW_BASE=0xf1000000
+CONFIG_GT64260=y
+CONFIG_MV64X60=y
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyMM0,9600 ip=on"
+
+#
+# Bus options
+#
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_LEGACY_PROC=y
+CONFIG_PCI_NAMES=y
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
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
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
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
+
+#
+# Tulip family network device support
+#
+CONFIG_NET_TULIP=y
+# CONFIG_DE2104X is not set
+CONFIG_TULIP=y
+# CONFIG_TULIP_MWI is not set
+# CONFIG_TULIP_MMIO is not set
+# CONFIG_TULIP_NAPI is not set
+# CONFIG_DE4X5 is not set
+# CONFIG_WINBOND_840 is not set
+# CONFIG_DM9102 is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+CONFIG_EEPRO100=y
+# CONFIG_EEPRO100_PIO is not set
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
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
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
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
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_SERIO is not set
+# CONFIG_SERIO_I8042 is not set
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
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
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
+CONFIG_SERIAL_MPSC=y
+CONFIG_SERIAL_MPSC_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
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
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
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
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
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
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_DEVFS_FS=y
+# CONFIG_DEVFS_MOUNT is not set
+# CONFIG_DEVFS_DEBUG is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
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
+CONFIG_NFS_V4=y
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+# CONFIG_EXPORTFS is not set
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
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
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
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
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_TEST is not set
diff -Nru a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile	2004-12-06 16:31:13 -07:00
+++ b/arch/ppc/platforms/Makefile	2004-12-06 16:31:13 -07:00
@@ -23,6 +23,7 @@
 obj-$(CONFIG_ADIR)		+= adir_setup.o adir_pic.o adir_pci.o
 obj-$(CONFIG_PQ2ADS)		+= pq2ads.o
 obj-$(CONFIG_TQM8260)		+= tqm8260_setup.o
+obj-$(CONFIG_CPCI690)		+= cpci690.o
 obj-$(CONFIG_EV64260)		+= ev64260.o
 obj-$(CONFIG_GEMINI)		+= gemini_pci.o gemini_setup.o gemini_prom.o
 obj-$(CONFIG_K2)		+= k2.o
diff -Nru a/arch/ppc/platforms/cpci690.c b/arch/ppc/platforms/cpci690.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/cpci690.c	2004-12-06 16:31:13 -07:00
@@ -0,0 +1,493 @@
+/*
+ * arch/ppc/platforms/cpci690.c
+ *
+ * Board setup routines for the Force CPCI690 board.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2003 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This programr
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+#include <linux/irq.h>
+#include <linux/fs.h>
+#include <linux/seq_file.h>
+#include <linux/console.h>
+#include <linux/initrd.h>
+#include <linux/root_dev.h>
+#include <linux/mv643xx.h>
+#include <asm/bootinfo.h>
+#include <asm/machdep.h>
+#include <asm/todc.h>
+#include <asm/time.h>
+#include <asm/mv64x60.h>
+#include <platforms/cpci690.h>
+
+#define BOARD_VENDOR	"Force"
+#define BOARD_MACHINE	"CPCI690"
+
+/* Set IDE controllers into Native mode? */
+#define SET_PCI_IDE_NATIVE
+
+static struct mv64x60_handle	bh;
+static u32 cpci690_br_base;
+
+static const unsigned int cpu_7xx[16] = { /* 7xx & 74xx (but not 745x) */
+	18, 15, 14, 2, 4, 13, 5, 9, 6, 11, 8, 10, 16, 12, 7, 0
+};
+
+TODC_ALLOC();
+
+static int __init
+cpci690_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	struct pci_controller	*hose = pci_bus_to_hose(dev->bus->number);
+
+	if (hose->index == 0) {
+		static char pci_irq_table[][4] =
+		/*
+		 *	PCI IDSEL/INTPIN->INTLINE
+		 * 	   A   B   C   D
+		 */
+		{
+			{ 90, 91, 88, 89}, /* IDSEL 30/20 - Sentinel */
+		};
+
+		const long min_idsel = 20, max_idsel = 20, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	}
+	else {
+		static char pci_irq_table[][4] =
+		/*
+		 *	PCI IDSEL/INTPIN->INTLINE
+		 * 	   A   B   C   D
+		 */
+		{
+			{ 93, 94, 95, 92}, /* IDSEL 28/18 - PMC slot 2 */
+			{  0,  0,  0,  0}, /* IDSEL 29/19 - Not used */
+			{ 94, 95, 92, 93}, /* IDSEL 30/20 - PMC slot 1 */
+		};
+
+		const long min_idsel = 18, max_idsel = 20, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	}
+}
+
+static int
+cpci690_get_bus_speed(void)
+{
+	return 133333333;
+}
+
+static int
+cpci690_get_cpu_speed(void)
+{
+	unsigned long	hid1;
+
+	hid1 = mfspr(HID1) >> 28;
+	return cpci690_get_bus_speed() * cpu_7xx[hid1]/2;
+}
+
+#define	KB	(1024UL)
+#define	MB	(1024UL * KB)
+#define	GB	(1024UL * MB)
+
+unsigned long __init
+cpci690_find_end_of_memory(void)
+{
+	u32		mem_ctlr_size;
+	static u32	board_size;
+	static u8	first_time = 1;
+
+	if (first_time) {
+		/* Using cpci690_set_bat() mapping ==> virt addr == phys addr */
+		switch (in_8((u8 *) (cpci690_br_base +
+			CPCI690_BR_MEM_CTLR)) & 0x07) {
+		case 0x01:
+			board_size = 256*MB;
+			break;
+		case 0x02:
+			board_size = 512*MB;
+			break;
+		case 0x03:
+			board_size = 768*MB;
+			break;
+		case 0x04:
+			board_size = 1*GB;
+			break;
+		case 0x05:
+			board_size = 1*GB + 512*MB;
+			break;
+		case 0x06:
+			board_size = 2*GB;
+			break;
+		default:
+			board_size = 0xffffffff; /* use mem ctlr size */
+		} /* switch */
+
+		mem_ctlr_size =  mv64x60_get_mem_size(CONFIG_MV64X60_NEW_BASE,
+			MV64x60_TYPE_GT64260A);
+
+		/* Check that mem ctlr & board reg agree.  If not, pick MIN. */
+		if (board_size != mem_ctlr_size) {
+			printk(KERN_WARNING "Board register & memory controller"
+				"mem size disagree (board reg: 0x%lx, "
+				"mem ctlr: 0x%lx)\n",
+				(ulong)board_size, (ulong)mem_ctlr_size);
+			board_size = min(board_size, mem_ctlr_size);
+		}
+
+		first_time = 0;
+	} /* if */
+
+	return board_size;
+}
+
+static void __init
+cpci690_setup_bridge(void)
+{
+	struct mv64x60_setup_info	si;
+	int				i;
+
+	memset(&si, 0, sizeof(si));
+
+	si.phys_reg_base = CONFIG_MV64X60_NEW_BASE;
+
+	si.pci_0.enable_bus = 1;
+	si.pci_0.pci_io.cpu_base = CPCI690_PCI0_IO_START_PROC_ADDR;
+	si.pci_0.pci_io.pci_base_hi = 0;
+	si.pci_0.pci_io.pci_base_lo = CPCI690_PCI0_IO_START_PCI_ADDR;
+	si.pci_0.pci_io.size = CPCI690_PCI0_IO_SIZE;
+	si.pci_0.pci_io.swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_0.pci_mem[0].cpu_base = CPCI690_PCI0_MEM_START_PROC_ADDR;
+	si.pci_0.pci_mem[0].pci_base_hi = CPCI690_PCI0_MEM_START_PCI_HI_ADDR;
+	si.pci_0.pci_mem[0].pci_base_lo = CPCI690_PCI0_MEM_START_PCI_LO_ADDR;
+	si.pci_0.pci_mem[0].size = CPCI690_PCI0_MEM_SIZE;
+	si.pci_0.pci_mem[0].swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_0.pci_cmd_bits = 0;
+	si.pci_0.latency_timer = 0x80;
+
+	si.pci_1.enable_bus = 1;
+	si.pci_1.pci_io.cpu_base = CPCI690_PCI1_IO_START_PROC_ADDR;
+	si.pci_1.pci_io.pci_base_hi = 0;
+	si.pci_1.pci_io.pci_base_lo = CPCI690_PCI1_IO_START_PCI_ADDR;
+	si.pci_1.pci_io.size = CPCI690_PCI1_IO_SIZE;
+	si.pci_1.pci_io.swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_1.pci_mem[0].cpu_base = CPCI690_PCI1_MEM_START_PROC_ADDR;
+	si.pci_1.pci_mem[0].pci_base_hi = CPCI690_PCI1_MEM_START_PCI_HI_ADDR;
+	si.pci_1.pci_mem[0].pci_base_lo = CPCI690_PCI1_MEM_START_PCI_LO_ADDR;
+	si.pci_1.pci_mem[0].size = CPCI690_PCI1_MEM_SIZE;
+	si.pci_1.pci_mem[0].swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_1.pci_cmd_bits = 0;
+	si.pci_1.latency_timer = 0x80;
+
+	for (i=0; i<MV64x60_CPU2MEM_WINDOWS; i++) {
+		si.cpu_prot_options[i] = 0;
+		si.cpu_snoop_options[i] = GT64260_CPU_SNOOP_WB;
+		si.pci_0.acc_cntl_options[i] =
+			GT64260_PCI_ACC_CNTL_DREADEN |
+			GT64260_PCI_ACC_CNTL_RDPREFETCH |
+			GT64260_PCI_ACC_CNTL_RDLINEPREFETCH |
+			GT64260_PCI_ACC_CNTL_RDMULPREFETCH |
+			GT64260_PCI_ACC_CNTL_SWAP_NONE |
+			GT64260_PCI_ACC_CNTL_MBURST_32_BTYES;
+		si.pci_0.snoop_options[i] = GT64260_PCI_SNOOP_WB;
+		si.pci_1.acc_cntl_options[i] =
+			GT64260_PCI_ACC_CNTL_DREADEN |
+			GT64260_PCI_ACC_CNTL_RDPREFETCH |
+			GT64260_PCI_ACC_CNTL_RDLINEPREFETCH |
+			GT64260_PCI_ACC_CNTL_RDMULPREFETCH |
+			GT64260_PCI_ACC_CNTL_SWAP_NONE |
+			GT64260_PCI_ACC_CNTL_MBURST_32_BTYES;
+		si.pci_1.snoop_options[i] = GT64260_PCI_SNOOP_WB;
+	}
+
+        /* Lookup PCI host bridges */
+        if (mv64x60_init(&bh, &si))
+                printk(KERN_ERR "Bridge initialization failed.\n");
+
+	pci_dram_offset = 0; /* System mem at same addr on PCI & cpu bus */
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = cpci690_map_irq;
+	ppc_md.pci_exclude_device = mv64x60_pci_exclude_device;
+
+	mv64x60_set_bus(&bh, 0, 0);
+	bh.hose_a->first_busno = 0;
+	bh.hose_a->last_busno = 0xff;
+	bh.hose_a->last_busno = pciauto_bus_scan(bh.hose_a, 0);
+
+	bh.hose_b->first_busno = bh.hose_a->last_busno + 1;
+	mv64x60_set_bus(&bh, 1, bh.hose_b->first_busno);
+	bh.hose_b->last_busno = 0xff;
+	bh.hose_b->last_busno = pciauto_bus_scan(bh.hose_b,
+		bh.hose_b->first_busno);
+
+	return;
+}
+
+static void __init
+cpci690_setup_peripherals(void)
+{
+	/* Set up windows to CPLD, RTC/TODC, IPMI. */
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_0_WIN, CPCI690_BR_BASE,
+		CPCI690_BR_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_0_WIN);
+	cpci690_br_base = (u32)ioremap(CPCI690_BR_BASE, CPCI690_BR_SIZE);
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_1_WIN, CPCI690_TODC_BASE,
+		CPCI690_TODC_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_1_WIN);
+	TODC_INIT(TODC_TYPE_MK48T35, 0, 0,
+			ioremap(CPCI690_TODC_BASE, CPCI690_TODC_SIZE), 8);
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_2_WIN, CPCI690_IPMI_BASE,
+		CPCI690_IPMI_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_2_WIN);
+
+	mv64x60_set_bits(&bh, MV64x60_PCI0_ARBITER_CNTL, (1<<31));
+	mv64x60_set_bits(&bh, MV64x60_PCI1_ARBITER_CNTL, (1<<31));
+
+        mv64x60_set_bits(&bh, MV64x60_CPU_MASTER_CNTL, (1<<9)); /* Only 1 cpu */
+
+	/*
+	 * Turn off timer/counters.  Not turning off watchdog timer because
+	 * can't read its reg on the 64260A so don't know if we'll be enabling
+	 * or disabling.
+	 */
+	mv64x60_clr_bits(&bh, MV64x60_TIMR_CNTR_0_3_CNTL,
+			((1<<0) | (1<<8) | (1<<16) | (1<<24)));
+	mv64x60_clr_bits(&bh, GT64260_TIMR_CNTR_4_7_CNTL,
+			((1<<0) | (1<<8) | (1<<16) | (1<<24)));
+
+	/*
+	 * Set MPSC Multiplex RMII
+	 * NOTE: ethernet driver modifies bit 0 and 1
+	 */
+	mv64x60_write(&bh, GT64260_MPP_SERIAL_PORTS_MULTIPLEX, 0x00001102);
+
+#define GPP_EXTERNAL_INTERRUPTS \
+		((1<<24) | (1<<25) | (1<<26) | (1<<27) | \
+		 (1<<28) | (1<<29) | (1<<30) | (1<<31))
+	/* PCI interrupts are inputs */
+	mv64x60_clr_bits(&bh, MV64x60_GPP_IO_CNTL, GPP_EXTERNAL_INTERRUPTS);
+	/* PCI interrupts are active low */
+	mv64x60_set_bits(&bh, MV64x60_GPP_LEVEL_CNTL, GPP_EXTERNAL_INTERRUPTS);
+
+	/* Clear any pending interrupts for these inputs and enable them. */
+	mv64x60_write(&bh, MV64x60_GPP_INTR_CAUSE, ~GPP_EXTERNAL_INTERRUPTS);
+	mv64x60_set_bits(&bh, MV64x60_GPP_INTR_MASK, GPP_EXTERNAL_INTERRUPTS);
+
+	/* Route MPP interrupt inputs to GPP */
+	mv64x60_write(&bh, MV64x60_MPP_CNTL_2, 0x00000000);
+	mv64x60_write(&bh, MV64x60_MPP_CNTL_3, 0x00000000);
+
+	return;
+}
+
+static int __init
+cpci690_fixup_pd(void)
+{
+#if defined(CONFIG_SERIAL_MPSC)
+	struct list_head	*entry;
+	struct platform_device	*pd;
+	struct device		*dev;
+	struct mpsc_pd_dd	*dd;
+
+	list_for_each(entry, &platform_bus_type.devices.list) {
+		dev = container_of(entry, struct device, bus_list);
+		pd = container_of(dev, struct platform_device, dev);
+
+		if (!strncmp(pd->name, MPSC_CTLR_NAME, BUS_ID_SIZE)) {
+			dd = (struct mpsc_pd_dd *) dev_get_drvdata(&pd->dev);
+
+			dd->max_idle = 40;
+			dd->default_baud = 9600;
+			dd->brg_clk_src = 8;
+			dd->brg_clk_freq = 133000000;
+		}
+	}
+#endif
+
+	return 0;
+}
+
+subsys_initcall(cpci690_fixup_pd);
+
+static void __init
+cpci690_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("cpci690_setup_arch: enter", 0);
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef   CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_SDA2;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("cpci690_setup_arch: Enabling L2 cache", 0);
+
+	/* Enable L2 and L3 caches (if 745x) */
+	_set_L2CR(_get_L2CR() | L2CR_L2E);
+	_set_L3CR(_get_L3CR() | L3CR_L3E);
+
+	if (ppc_md.progress)
+		ppc_md.progress("cpci690_setup_arch: Initializing bridge", 0);
+
+	cpci690_setup_bridge();		/* set up PCI bridge(s) */
+	cpci690_setup_peripherals();	/* set up chip selects/GPP/MPP etc */
+
+	if (ppc_md.progress)
+		ppc_md.progress("cpci690_setup_arch: bridge init complete", 0);
+
+	printk(KERN_INFO "%s %s port (C) 2003 MontaVista Software, Inc. "
+		"(source@mvista.com)\n", BOARD_VENDOR, BOARD_MACHINE);
+
+	if (ppc_md.progress)
+		ppc_md.progress("cpci690_setup_arch: exit", 0);
+
+	return;
+}
+
+static void
+cpci690_reset_board(void)
+{
+	u32	i = 10000;
+
+	local_irq_disable();
+	out_8((u8 *)(cpci690_br_base + CPCI690_BR_SW_RESET), 0x11);
+
+	while (i != 0) i++;
+	panic("restart failed\n");
+}
+
+static void
+cpci690_restart(char *cmd)
+{
+	cpci690_reset_board();
+}
+
+static void
+cpci690_halt(void)
+{
+	while (1);
+	/* NOTREACHED */
+}
+
+static void
+cpci690_power_off(void)
+{
+	cpci690_halt();
+	/* NOTREACHED */
+}
+
+static int
+cpci690_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: " BOARD_VENDOR "\n");
+	seq_printf(m, "machine\t\t: " BOARD_MACHINE "\n");
+	seq_printf(m, "cpu MHz\t\t: %d\n", cpci690_get_cpu_speed()/1000/1000);
+	seq_printf(m, "bus MHz\t\t: %d\n", cpci690_get_bus_speed()/1000/1000);
+
+	return 0;
+}
+
+static void __init
+cpci690_calibrate_decr(void)
+{
+	ulong freq;
+
+	freq = cpci690_get_bus_speed()/4;
+
+	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       freq/1000000, freq%1000000);
+
+	tb_ticks_per_jiffy = freq / HZ;
+	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+
+	return;
+}
+
+static __inline__ void
+cpci690_set_bat(u32 addr, u32 size)
+{
+	addr &= 0xfffe0000;
+	size &= 0x1ffe0000;
+	size = ((size >> 17) - 1) << 2;
+
+	mb();
+	mtspr(DBAT1U, addr | size | 0x2); /* Vs == 1; Vp == 0 */
+	mtspr(DBAT1L, addr | 0x2a); /* WIMG bits == 0101; PP == r/w access */
+	mb();
+
+	return;
+}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+static void __init
+cpci690_map_io(void)
+{
+	io_block_mapping(CONFIG_MV64X60_NEW_BASE, CONFIG_MV64X60_NEW_BASE,
+		128 * KB, _PAGE_IO);
+}
+#endif
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+#ifdef CONFIG_BLK_DEV_INITRD
+	initrd_start=initrd_end=0;
+	initrd_below_start_ok=0;
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+	parse_bootinfo(find_bootinfo());
+
+	loops_per_jiffy = cpci690_get_cpu_speed() / HZ;
+
+	isa_mem_base = 0;
+
+	ppc_md.setup_arch = cpci690_setup_arch;
+	ppc_md.show_cpuinfo = cpci690_show_cpuinfo;
+	ppc_md.init_IRQ = gt64260_init_irq;
+	ppc_md.get_irq = gt64260_get_irq;
+	ppc_md.restart = cpci690_restart;
+	ppc_md.power_off = cpci690_power_off;
+	ppc_md.halt = cpci690_halt;
+	ppc_md.find_end_of_memory = cpci690_find_end_of_memory;
+	ppc_md.time_init = todc_time_init;
+	ppc_md.set_rtc_time = todc_set_rtc_time;
+	ppc_md.get_rtc_time = todc_get_rtc_time;
+	ppc_md.nvram_read_val = todc_direct_read_val;
+	ppc_md.nvram_write_val = todc_direct_write_val;
+	ppc_md.calibrate_decr = cpci690_calibrate_decr;
+
+	/*
+	 * Need to map in board regs (used by cpci690_find_end_of_memory())
+	 * and the bridge's regs (used by progress);
+	 */
+	cpci690_set_bat(CPCI690_BR_BASE, 32 * MB);
+	cpci690_br_base = CPCI690_BR_BASE;
+
+#ifdef	CONFIG_SERIAL_TEXT_DEBUG
+	ppc_md.setup_io_mappings = cpci690_map_io;
+	ppc_md.progress = mv64x60_mpsc_progress;
+	mv64x60_progress_init(CONFIG_MV64X60_NEW_BASE);
+#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
+#ifdef	CONFIG_KGDB
+	ppc_md.setup_io_mappings = cpci690_map_io;
+	ppc_md.early_serial_map = cpci690_early_serial_map;
+#endif	/* CONFIG_KGDB */
+
+	return;
+}
diff -Nru a/arch/ppc/platforms/cpci690.h b/arch/ppc/platforms/cpci690.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/cpci690.h	2004-12-06 16:31:13 -07:00
@@ -0,0 +1,73 @@
+/*
+ * arch/ppc/platforms/cpci690.h
+ *
+ * Definitions for Force CPCI690
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2003 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+/*
+ * The GT64260 has 2 PCI buses each with 1 window from the CPU bus to
+ * PCI I/O space and 4 windows from the CPU bus to PCI MEM space.
+ */
+
+#ifndef __PPC_PLATFORMS_CPCI690_H
+#define __PPC_PLATFORMS_CPCI690_H
+
+/*
+ * Define bd_t to pass in the MAC addresses used by the GT64260's enet ctlrs.
+ */
+#define	CPCI690_BI_MAGIC		0xFE8765DC
+
+typedef struct board_info {
+	u32	bi_magic;
+	u8	bi_enetaddr[3][6];
+} bd_t;
+
+/* PCI bus Resource setup */
+#define CPCI690_PCI0_MEM_START_PROC_ADDR	0x80000000
+#define CPCI690_PCI0_MEM_START_PCI_HI_ADDR	0x00000000
+#define CPCI690_PCI0_MEM_START_PCI_LO_ADDR	0x80000000
+#define CPCI690_PCI0_MEM_SIZE			0x10000000
+#define CPCI690_PCI0_IO_START_PROC_ADDR		0xa0000000
+#define CPCI690_PCI0_IO_START_PCI_ADDR		0x00000000
+#define CPCI690_PCI0_IO_SIZE			0x01000000
+
+#define CPCI690_PCI1_MEM_START_PROC_ADDR	0x90000000
+#define CPCI690_PCI1_MEM_START_PCI_HI_ADDR	0x00000000
+#define CPCI690_PCI1_MEM_START_PCI_LO_ADDR	0x90000000
+#define CPCI690_PCI1_MEM_SIZE			0x10000000
+#define CPCI690_PCI1_IO_START_PROC_ADDR		0xa1000000
+#define CPCI690_PCI1_IO_START_PCI_ADDR		0x01000000
+#define CPCI690_PCI1_IO_SIZE			0x01000000
+
+/* Board Registers */
+#define	CPCI690_BR_BASE				0xf0000000
+#define	CPCI690_BR_SIZE_ACTUAL			0x8
+#define	CPCI690_BR_SIZE			max(GT64260_WINDOW_SIZE_MIN,	\
+						CPCI690_BR_SIZE_ACTUAL)
+#define	CPCI690_BR_LED_CNTL			0x00
+#define	CPCI690_BR_SW_RESET			0x01
+#define	CPCI690_BR_MISC_STATUS			0x02
+#define	CPCI690_BR_SWITCH_STATUS		0x03
+#define	CPCI690_BR_MEM_CTLR			0x04
+#define	CPCI690_BR_LAST_RESET_1			0x05
+#define	CPCI690_BR_LAST_RESET_2			0x06
+
+#define	CPCI690_TODC_BASE			0xf0100000
+#define	CPCI690_TODC_SIZE_ACTUAL		0x8000 /* Size or NVRAM + RTC */
+#define	CPCI690_TODC_SIZE		max(GT64260_WINDOW_SIZE_MIN,	\
+						CPCI690_TODC_SIZE_ACTUAL)
+#define	CPCI690_MAC_OFFSET			0x7c10 /* MAC in RTC NVRAM */
+
+#define	CPCI690_IPMI_BASE			0xf0200000
+#define	CPCI690_IPMI_SIZE_ACTUAL		0x10 /* 16 bytes of IPMI */
+#define	CPCI690_IPMI_SIZE		max(GT64260_WINDOW_SIZE_MIN,	\
+						CPCI690_IPMI_SIZE_ACTUAL)
+
+#endif /* __PPC_PLATFORMS_CPCI690_H */
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2004-12-06 16:31:13 -07:00
+++ b/arch/ppc/syslib/Makefile	2004-12-06 16:31:13 -07:00
@@ -39,6 +39,7 @@
 obj-$(CONFIG_PPC_PREP)		+= open_pic.o indirect_pci.o i8259.o todc_time.o
 obj-$(CONFIG_ADIR)		+= i8259.o indirect_pci.o pci_auto.o \
 					todc_time.o
+obj-$(CONFIG_CPCI690)		+= todc_time.o pci_auto.o
 obj-$(CONFIG_EBONY)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_EV64260)		+= todc_time.o pci_auto.o
 obj-$(CONFIG_GEMINI)		+= open_pic.o indirect_pci.o
@@ -77,6 +78,9 @@
 ifeq ($(CONFIG_PPC_GEN550),y)
 obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
+endif
+ifeq ($(CONFIG_SERIAL_MPSC_CONSOLE),y)
+obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= mv64x60_dbg.o
 endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_MPC10X_BRIDGE)     += mpc10x_common.o indirect_pci.o

--------------020008070203090800080906--

