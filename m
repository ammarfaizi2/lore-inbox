Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVGZFTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVGZFTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVGZFTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:19:39 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:34988 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261718AbVGZFSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:18:09 -0400
Date: Tue, 26 Jul 2005 00:17:54 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix building of radstone_ppc7d
Message-ID: <Pine.LNX.4.61.0507260017100.7138@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated radstone_ppc7d_defconfig to include the ds1337 driver which
is used by the platform code.  This fixes the link error when building.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit dc5a25603c1f8984f10f9e93d91b4d95b2ce6d9d
tree 84b86f1b54b4d703a447aa6650ffe4a3e398ed13
parent b9540327726da964f8ac27185d01ccf244ea8e46
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 00:08:58 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 00:08:58 -0500

 arch/ppc/configs/radstone_ppc7d_defconfig |  234 +++++++++++++++++------------
 1 files changed, 135 insertions(+), 99 deletions(-)

diff --git a/arch/ppc/configs/radstone_ppc7d_defconfig b/arch/ppc/configs/radstone_ppc7d_defconfig
--- a/arch/ppc/configs/radstone_ppc7d_defconfig
+++ b/arch/ppc/configs/radstone_ppc7d_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11
-# Tue Mar 15 14:31:19 2005
+# Linux kernel version: 2.6.13-rc3
+# Tue Jul 26 00:02:09 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -11,6 +11,7 @@ CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
 CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 
 #
 # Code maturity level options
@@ -18,6 +19,7 @@ CONFIG_GENERIC_NVRAM=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -35,6 +37,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_EMBEDDED=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -67,9 +71,12 @@ CONFIG_6xx=y
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_E200 is not set
 # CONFIG_E500 is not set
+CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
 # CONFIG_TAU is not set
+# CONFIG_KEXEC is not set
 # CONFIG_CPU_FREQ is not set
 CONFIG_PPC_GEN550=y
 # CONFIG_PM is not set
@@ -84,21 +91,18 @@ CONFIG_PPC_STD_MMU=y
 # CONFIG_KATANA is not set
 # CONFIG_WILLOW is not set
 # CONFIG_CPCI690 is not set
-# CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
 # CONFIG_CHESTNUT is not set
 # CONFIG_SPRUCE is not set
+# CONFIG_HDPU is not set
 # CONFIG_EV64260 is not set
 # CONFIG_LOPEC is not set
-# CONFIG_MCPN765 is not set
 # CONFIG_MVME5100 is not set
 # CONFIG_PPLUS is not set
 # CONFIG_PRPMC750 is not set
 # CONFIG_PRPMC800 is not set
 # CONFIG_SANDPOINT is not set
 CONFIG_RADSTONE_PPC7D=y
-# CONFIG_ADIR is not set
-# CONFIG_K2 is not set
 # CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
 # CONFIG_EST8260 is not set
@@ -121,10 +125,18 @@ CONFIG_MV64X60_NEW_BASE=0xfef00000
 # CONFIG_SMP is not set
 # CONFIG_PREEMPT is not set
 # CONFIG_HIGHMEM is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,9600"
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
@@ -155,6 +167,69 @@ CONFIG_TASK_SIZE=0x80000000
 CONFIG_BOOT_LOAD=0x00800000
 
 #
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
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
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+CONFIG_BRIDGE=y
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
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+
+#
 # Device Drivers
 #
 
@@ -203,6 +278,7 @@ CONFIG_MTD_CFI_I1=y
 CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
 CONFIG_MTD_CFI_INTELEXT=y
 # CONFIG_MTD_CFI_AMDSTD is not set
 # CONFIG_MTD_CFI_STAA is not set
@@ -210,13 +286,13 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_XIP is not set
 
 #
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 # CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
@@ -299,6 +375,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
+# CONFIG_CHR_DEV_SCH is not set
 
 #
 # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
@@ -331,7 +408,6 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
-# CONFIG_SCSI_EATA_PIO is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_GDTH is not set
 # CONFIG_SCSI_IPS is not set
@@ -343,7 +419,6 @@ CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
 CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
 # CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
 # CONFIG_SCSI_IPR is not set
-# CONFIG_SCSI_QLOGIC_ISP is not set
 # CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 CONFIG_SCSI_QLA2XXX=y
@@ -352,6 +427,7 @@ CONFIG_SCSI_QLA2XXX=y
 # CONFIG_SCSI_QLA2300 is not set
 # CONFIG_SCSI_QLA2322 is not set
 # CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_NSP32 is not set
@@ -366,6 +442,8 @@ CONFIG_SCSI_QLA2XXX=y
 # Fusion MPT device support
 #
 # CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -382,71 +460,8 @@ CONFIG_SCSI_QLA2XXX=y
 #
 
 #
-# Networking support
+# Network device support
 #
-CONFIG_NET=y
-
-#
-# Networking options
-#
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_ARPD is not set
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_TUNNEL is not set
-CONFIG_IP_TCPDIAG=y
-# CONFIG_IP_TCPDIAG_IPV6 is not set
-# CONFIG_IPV6 is not set
-# CONFIG_NETFILTER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-CONFIG_BRIDGE=y
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
@@ -511,9 +526,11 @@ CONFIG_E100=y
 # CONFIG_YELLOWFIN is not set
 CONFIG_R8169=y
 CONFIG_R8169_NAPI=y
+# CONFIG_SKGE is not set
 CONFIG_SK98LIN=y
 # CONFIG_VIA_VELOCITY is not set
 CONFIG_TIGON3=y
+# CONFIG_BNX2 is not set
 CONFIG_MV643XX_ETH=y
 CONFIG_MV643XX_ETH_0=y
 CONFIG_MV643XX_ETH_1=y
@@ -546,6 +563,8 @@ CONFIG_MV643XX_ETH_1=y
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
@@ -598,7 +617,6 @@ CONFIG_SERIO_SERPORT=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
@@ -623,6 +641,7 @@ CONFIG_SERIAL_MPSC=y
 # CONFIG_SERIAL_MPSC_CONSOLE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -690,11 +709,11 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_AMD8111 is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_ISA is not set
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
-# CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_SCx200_ACB is not set
@@ -707,16 +726,41 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_VOODOO3 is not set
 # CONFIG_I2C_PCA_ISA is not set
 CONFIG_I2C_MV64XXX=y
+CONFIG_I2C_SENSOR=y
 
 #
-# Hardware Sensors Chip support
+# Miscellaneous I2C Chip support
 #
-CONFIG_I2C_SENSOR=y
+CONFIG_SENSORS_DS1337=y
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
 # CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_FSCHER is not set
 # CONFIG_SENSORS_FSCPOS is not set
@@ -732,33 +776,18 @@ CONFIG_I2C_SENSOR=y
 # CONFIG_SENSORS_LM85 is not set
 # CONFIG_SENSORS_LM87 is not set
 CONFIG_SENSORS_LM90=y
+# CONFIG_SENSORS_LM92 is not set
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_PC87360 is not set
-# CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_SIS5595 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83L785TS is not set
 # CONFIG_SENSORS_W83627HF is not set
-
-#
-# Other I2C Chip support
-#
-# CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_PCF8574 is not set
-# CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_RTC8564 is not set
-# CONFIG_SENSORS_M41T00 is not set
-# CONFIG_I2C_DEBUG_CORE is not set
-# CONFIG_I2C_DEBUG_ALGO is not set
-# CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
-
-#
-# Dallas's 1-wire bus
-#
-# CONFIG_W1 is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
 # Misc devices
@@ -813,14 +842,20 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_INFINIBAND is not set
 
 #
+# SN Devices
+#
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
 
 #
 # XFS support
@@ -828,6 +863,7 @@ CONFIG_EXT2_FS=y
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
@@ -854,7 +890,6 @@ CONFIG_ISO9660_FS=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_DEVFS_FS is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_XATTR is not set
@@ -874,8 +909,7 @@ CONFIG_RAMFS=y
 # CONFIG_JFFS_FS is not set
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
-# CONFIG_JFFS2_FS_NAND is not set
-# CONFIG_JFFS2_FS_NOR_ECC is not set
+CONFIG_JFFS2_FS_WRITEBUFFER=y
 # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_RTIME=y
@@ -892,12 +926,14 @@ CONFIG_JFFS2_RTIME=y
 #
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
