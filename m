Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUKLIkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUKLIkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 03:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbUKLIkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 03:40:37 -0500
Received: from mail.renesas.com ([202.234.163.13]:45698 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262488AbUKLIe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 03:34:27 -0500
Date: Fri, 12 Nov 2004 17:34:14 +0900 (JST)
Message-Id: <20041112.173414.28782636.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc1-bk21] [m32r] Update defconfig files
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch is for updating defconfig files for m32r.
All defconfig files are regenerated for 2.6.10-rc1-bk21.

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/defconfig                       |  152 +++++-
 arch/m32r/m32700ut/defconfig.m32700ut.smp |  130 ++++-
 arch/m32r/m32700ut/defconfig.m32700ut.up  |  130 ++++-
 arch/m32r/mappi/defconfig.nommu           |  109 +++-
 arch/m32r/mappi/defconfig.smp             |  104 +++-
 arch/m32r/mappi/defconfig.up              |  104 +++-
 arch/m32r/mappi2/defconfig.vdec2          |  698 ++++++++++++++++++++++++++++++
 arch/m32r/oaks32r/defconfig.nommu         |   93 +++
 arch/m32r/opsput/defconfig.opsput         |  114 +++-
 9 files changed, 1424 insertions(+), 210 deletions(-)


diff -ruNp a/arch/m32r/defconfig b/arch/m32r/defconfig
--- a/arch/m32r/defconfig	2004-10-19 06:54:37.000000000 +0900
+++ b/arch/m32r/defconfig	2004-11-12 17:18:24.000000000 +0900
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-bk21
+# Fri Nov 12 16:08:49 2004
 #
 CONFIG_M32R=y
 CONFIG_UID16=y
@@ -11,10 +13,12 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
@@ -24,17 +28,20 @@ CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -44,6 +51,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
@@ -78,33 +86,26 @@ CONFIG_PREEMPT=y
 # CONFIG_SMP is not set
 
 #
-# M32R drivers
-#
-# CONFIG_M32RPCC is not set
-CONFIG_M32R_CFC=y
-CONFIG_M32700UT_CFC=y
-CONFIG_CFC_NUM=1
-# CONFIG_MTD_M32R is not set
-CONFIG_M32R_SMC91111=y
-CONFIG_M32700UT_DS1302=y
-
-#
-# Power management options (ACPI, APM)
-#
-# CONFIG_PM is not set
-
-#
 # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 #
 # CONFIG_PCI is not set
 # CONFIG_ISA is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
 #
-CONFIG_PCMCIA=y
+CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_PCMCIA_OBSOLETE is not set
+CONFIG_PCMCIA=y
+
+#
+# PC-card bridges
+#
 # CONFIG_TCIC is not set
+# CONFIG_M32R_PCC is not set
+CONFIG_M32R_CFC=y
+CONFIG_M32R_CFC_NUM=1
 
 #
 # PCI Hotplug Support
@@ -151,6 +152,16 @@ CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -170,7 +181,6 @@ CONFIG_BLK_DEV_IDECD=m
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
 # CONFIG_IDE_TASK_IOCTL is not set
-# CONFIG_IDE_TASKFILE_IO is not set
 
 #
 # IDE chipset support/bugfixes
@@ -213,9 +223,8 @@ CONFIG_SCSI_MULTI_LUN=y
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -271,6 +280,9 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -290,7 +302,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -307,7 +318,50 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_NETDEVICES is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_SMC91X=y
+# CONFIG_NE2000 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
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
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
@@ -342,6 +396,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -355,7 +410,9 @@ CONFIG_SERIO_SERPORT=y
 #
 # Character devices
 #
-# CONFIG_VT is not set
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -368,13 +425,12 @@ CONFIG_SERIO_SERPORT=y
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_M32R_SIO is not set
+CONFIG_SERIAL_M32R_SIO=y
+CONFIG_SERIAL_M32R_SIO_CONSOLE=y
 CONFIG_SERIAL_M32R_PLDSIO=y
-CONFIG_SERIAL_M32R_PLDSIO_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -387,6 +443,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_WATCHDOG is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
+CONFIG_DS1302=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
@@ -429,8 +486,8 @@ CONFIG_VIDEO_DEV=y
 # Video Adapters
 #
 # CONFIG_VIDEO_CPIA is not set
-CONFIG_M32R_AR=y
-CONFIG_M32R_AR_VGA=y
+CONFIG_VIDEO_M32R_AR=y
+CONFIG_VIDEO_M32R_AR_M64278=y
 
 #
 # Radio Adapters
@@ -445,7 +502,28 @@ CONFIG_M32R_AR_VGA=y
 #
 # Graphics support
 #
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_VIRTUAL is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+
+#
+# Logo configuration
+#
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_MONO=y
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
 
 #
 # Sound
@@ -455,6 +533,8 @@ CONFIG_M32R_AR_VGA=y
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -482,6 +562,7 @@ CONFIG_REISERFS_FS=m
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -515,6 +596,7 @@ CONFIG_DEVFS_MOUNT=y
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
@@ -549,6 +631,7 @@ CONFIG_LOCKD_V4=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -620,6 +703,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -ruNp a/arch/m32r/m32700ut/defconfig.m32700ut.smp b/arch/m32r/m32700ut/defconfig.m32700ut.smp
--- a/arch/m32r/m32700ut/defconfig.m32700ut.smp	2004-10-19 06:54:31.000000000 +0900
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.smp	2004-11-12 16:08:46.000000000 +0900
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-bk21
+# Fri Nov 12 16:08:45 2004
 #
 CONFIG_M32R=y
 CONFIG_UID16=y
@@ -10,10 +12,12 @@ CONFIG_GENERIC_ISA_DMA=y
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
+CONFIG_LOCK_KERNEL=y
 
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
@@ -23,17 +27,20 @@ CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -43,6 +50,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 CONFIG_STOP_MACHINE=y
 
@@ -81,33 +89,26 @@ CONFIG_NR_CPUS=2
 # CONFIG_NUMA is not set
 
 #
-# M32R drivers
-#
-# CONFIG_M32RPCC is not set
-CONFIG_M32R_CFC=y
-CONFIG_M32700UT_CFC=y
-CONFIG_CFC_NUM=1
-# CONFIG_MTD_M32R is not set
-CONFIG_M32R_SMC91111=y
-CONFIG_M32700UT_DS1302=y
-
-#
-# Power management options (ACPI, APM)
-#
-# CONFIG_PM is not set
-
-#
 # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 #
 # CONFIG_PCI is not set
 # CONFIG_ISA is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
 #
-CONFIG_PCMCIA=y
+CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_PCMCIA_OBSOLETE is not set
+CONFIG_PCMCIA=y
+
+#
+# PC-card bridges
+#
 # CONFIG_TCIC is not set
+# CONFIG_M32R_PCC is not set
+CONFIG_M32R_CFC=y
+CONFIG_M32R_CFC_NUM=1
 
 #
 # PCI Hotplug Support
@@ -154,6 +155,16 @@ CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -173,7 +184,6 @@ CONFIG_BLK_DEV_IDECD=m
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
 # CONFIG_IDE_TASK_IOCTL is not set
-# CONFIG_IDE_TASKFILE_IO is not set
 
 #
 # IDE chipset support/bugfixes
@@ -216,9 +226,8 @@ CONFIG_SCSI_MULTI_LUN=y
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -274,6 +283,9 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -293,7 +305,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -310,7 +321,50 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_NETDEVICES is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_SMC91X=y
+# CONFIG_NE2000 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
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
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
@@ -345,6 +399,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -373,13 +428,12 @@ CONFIG_HW_CONSOLE=y
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_M32R_SIO is not set
+CONFIG_SERIAL_M32R_SIO=y
+CONFIG_SERIAL_M32R_SIO_CONSOLE=y
 CONFIG_SERIAL_M32R_PLDSIO=y
-CONFIG_SERIAL_M32R_PLDSIO_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -392,6 +446,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_WATCHDOG is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
+CONFIG_DS1302=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
@@ -434,8 +489,8 @@ CONFIG_VIDEO_DEV=y
 # Video Adapters
 #
 # CONFIG_VIDEO_CPIA is not set
-CONFIG_M32R_AR=y
-CONFIG_M32R_AR_VGA=y
+CONFIG_VIDEO_M32R_AR=y
+CONFIG_VIDEO_M32R_AR_M64278=y
 
 #
 # Radio Adapters
@@ -451,14 +506,14 @@ CONFIG_M32R_AR_VGA=y
 # Graphics support
 #
 CONFIG_FB=y
-CONFIG_FB_EPSON_S1D13806=y
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
 # CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_FONTS is not set
@@ -472,7 +527,6 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
-CONFIG_LOGO_M32R_CLUT224=y
 
 #
 # Sound
@@ -482,6 +536,8 @@ CONFIG_LOGO_M32R_CLUT224=y
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -509,6 +565,7 @@ CONFIG_REISERFS_FS=m
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -542,6 +599,7 @@ CONFIG_DEVFS_MOUNT=y
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
@@ -576,6 +634,7 @@ CONFIG_LOCKD_V4=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -647,6 +706,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -ruNp a/arch/m32r/m32700ut/defconfig.m32700ut.up b/arch/m32r/m32700ut/defconfig.m32700ut.up
--- a/arch/m32r/m32700ut/defconfig.m32700ut.up	2004-10-19 06:54:38.000000000 +0900
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.up	2004-11-12 16:08:49.000000000 +0900
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-bk21
+# Fri Nov 12 16:08:49 2004
 #
 CONFIG_M32R=y
 CONFIG_UID16=y
@@ -11,10 +13,12 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
@@ -24,17 +28,20 @@ CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -44,6 +51,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
@@ -78,33 +86,26 @@ CONFIG_PREEMPT=y
 # CONFIG_SMP is not set
 
 #
-# M32R drivers
-#
-# CONFIG_M32RPCC is not set
-CONFIG_M32R_CFC=y
-CONFIG_M32700UT_CFC=y
-CONFIG_CFC_NUM=1
-# CONFIG_MTD_M32R is not set
-CONFIG_M32R_SMC91111=y
-CONFIG_M32700UT_DS1302=y
-
-#
-# Power management options (ACPI, APM)
-#
-# CONFIG_PM is not set
-
-#
 # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 #
 # CONFIG_PCI is not set
 # CONFIG_ISA is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
 #
-CONFIG_PCMCIA=y
+CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_PCMCIA_OBSOLETE is not set
+CONFIG_PCMCIA=y
+
+#
+# PC-card bridges
+#
 # CONFIG_TCIC is not set
+# CONFIG_M32R_PCC is not set
+CONFIG_M32R_CFC=y
+CONFIG_M32R_CFC_NUM=1
 
 #
 # PCI Hotplug Support
@@ -151,6 +152,16 @@ CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -170,7 +181,6 @@ CONFIG_BLK_DEV_IDECD=m
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
 # CONFIG_IDE_TASK_IOCTL is not set
-# CONFIG_IDE_TASKFILE_IO is not set
 
 #
 # IDE chipset support/bugfixes
@@ -213,9 +223,8 @@ CONFIG_SCSI_MULTI_LUN=y
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -271,6 +280,9 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -290,7 +302,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -307,7 +318,50 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_NETDEVICES is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_SMC91X=y
+# CONFIG_NE2000 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
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
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
@@ -342,6 +396,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -370,13 +425,12 @@ CONFIG_HW_CONSOLE=y
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_M32R_SIO is not set
+CONFIG_SERIAL_M32R_SIO=y
+CONFIG_SERIAL_M32R_SIO_CONSOLE=y
 CONFIG_SERIAL_M32R_PLDSIO=y
-CONFIG_SERIAL_M32R_PLDSIO_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -389,6 +443,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_WATCHDOG is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
+CONFIG_DS1302=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
@@ -431,8 +486,8 @@ CONFIG_VIDEO_DEV=y
 # Video Adapters
 #
 # CONFIG_VIDEO_CPIA is not set
-CONFIG_M32R_AR=y
-CONFIG_M32R_AR_VGA=y
+CONFIG_VIDEO_M32R_AR=y
+CONFIG_VIDEO_M32R_AR_M64278=y
 
 #
 # Radio Adapters
@@ -448,14 +503,14 @@ CONFIG_M32R_AR_VGA=y
 # Graphics support
 #
 CONFIG_FB=y
-CONFIG_FB_EPSON_S1D13806=y
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
 # CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_FONTS is not set
@@ -469,7 +524,6 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
-CONFIG_LOGO_M32R_CLUT224=y
 
 #
 # Sound
@@ -479,6 +533,8 @@ CONFIG_LOGO_M32R_CLUT224=y
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -506,6 +562,7 @@ CONFIG_REISERFS_FS=m
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -539,6 +596,7 @@ CONFIG_DEVFS_MOUNT=y
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
@@ -573,6 +631,7 @@ CONFIG_LOCKD_V4=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -644,6 +703,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -ruNp a/arch/m32r/mappi/defconfig.nommu b/arch/m32r/mappi/defconfig.nommu
--- a/arch/m32r/mappi/defconfig.nommu	2004-10-19 06:55:29.000000000 +0900
+++ b/arch/m32r/mappi/defconfig.nommu	2004-11-12 16:08:51.000000000 +0900
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-bk21
+# Fri Nov 12 16:08:51 2004
 #
 CONFIG_M32R=y
 CONFIG_UID16=y
@@ -11,10 +13,12 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
@@ -22,17 +26,20 @@ CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -42,6 +49,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
@@ -76,26 +84,24 @@ CONFIG_PREEMPT=y
 # CONFIG_SMP is not set
 
 #
-# M32R drivers
-#
-# CONFIG_M32RPCC is not set
-CONFIG_M32R_NE2000=y
-
-#
-# Power management options (ACPI, APM)
-#
-# CONFIG_PM is not set
-
-#
 # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 #
 # CONFIG_PCI is not set
 # CONFIG_ISA is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
+#
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_PCMCIA_OBSOLETE is not set
+CONFIG_PCMCIA=y
+
+#
+# PC-card bridges
 #
-# CONFIG_PCMCIA is not set
+# CONFIG_TCIC is not set
+CONFIG_M32R_PCC=y
 
 #
 # PCI Hotplug Support
@@ -144,6 +150,16 @@ CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -199,6 +215,9 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -218,7 +237,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -235,7 +253,48 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_NETDEVICES is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+# CONFIG_NET_ETHERNET is not set
+CONFIG_NE2000=y
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
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
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
@@ -270,6 +329,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -302,7 +362,6 @@ CONFIG_SERIAL_M32R_SIO_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -323,6 +382,11 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -362,6 +426,8 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -381,6 +447,7 @@ CONFIG_EXT2_FS=y
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -443,6 +510,7 @@ CONFIG_LOCKD_V4=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -514,6 +582,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -ruNp a/arch/m32r/mappi/defconfig.smp b/arch/m32r/mappi/defconfig.smp
--- a/arch/m32r/mappi/defconfig.smp	2004-10-19 06:54:37.000000000 +0900
+++ b/arch/m32r/mappi/defconfig.smp	2004-11-12 16:08:53.000000000 +0900
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-bk21
+# Fri Nov 12 16:08:53 2004
 #
 CONFIG_M32R=y
 CONFIG_UID16=y
@@ -12,10 +14,12 @@ CONFIG_EXPERIMENTAL=y
 # CONFIG_CLEAN_COMPILE is not set
 CONFIG_BROKEN=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
@@ -24,17 +28,20 @@ CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -44,6 +51,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 CONFIG_STOP_MACHINE=y
 
@@ -84,28 +92,24 @@ CONFIG_NR_CPUS=2
 # CONFIG_NUMA is not set
 
 #
-# M32R drivers
-#
-CONFIG_M32RPCC=y
-CONFIG_M32R_NE2000=y
-
-#
-# Power management options (ACPI, APM)
-#
-# CONFIG_PM is not set
-
-#
 # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 #
 # CONFIG_PCI is not set
 # CONFIG_ISA is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
 #
-CONFIG_PCMCIA=y
+CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_PCMCIA_OBSOLETE is not set
+CONFIG_PCMCIA=y
+
+#
+# PC-card bridges
+#
 # CONFIG_TCIC is not set
+CONFIG_M32R_PCC=y
 
 #
 # PCI Hotplug Support
@@ -213,6 +217,16 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -231,7 +245,6 @@ CONFIG_BLK_DEV_IDECD=m
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_IDE_TASK_IOCTL is not set
-# CONFIG_IDE_TASKFILE_IO is not set
 
 #
 # IDE chipset support/bugfixes
@@ -291,6 +304,9 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -310,7 +326,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -327,7 +342,48 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_NETDEVICES is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+# CONFIG_NET_ETHERNET is not set
+CONFIG_NE2000=y
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
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
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
@@ -365,6 +421,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -397,7 +454,6 @@ CONFIG_SERIAL_M32R_SIO_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -462,6 +518,8 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -481,6 +539,7 @@ CONFIG_EXT2_FS=y
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -513,6 +572,7 @@ CONFIG_DEVFS_MOUNT=y
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
@@ -558,6 +618,7 @@ CONFIG_LOCKD_V4=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -629,6 +690,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -ruNp a/arch/m32r/mappi/defconfig.up b/arch/m32r/mappi/defconfig.up
--- a/arch/m32r/mappi/defconfig.up	2004-10-19 06:53:50.000000000 +0900
+++ b/arch/m32r/mappi/defconfig.up	2004-11-12 16:08:55.000000000 +0900
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-bk21
+# Fri Nov 12 16:08:55 2004
 #
 CONFIG_M32R=y
 CONFIG_UID16=y
@@ -12,10 +14,12 @@ CONFIG_EXPERIMENTAL=y
 # CONFIG_CLEAN_COMPILE is not set
 CONFIG_BROKEN=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
@@ -24,17 +28,20 @@ CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -44,6 +51,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
@@ -80,28 +88,24 @@ CONFIG_PREEMPT=y
 # CONFIG_SMP is not set
 
 #
-# M32R drivers
-#
-CONFIG_M32RPCC=y
-CONFIG_M32R_NE2000=y
-
-#
-# Power management options (ACPI, APM)
-#
-# CONFIG_PM is not set
-
-#
 # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 #
 # CONFIG_PCI is not set
 # CONFIG_ISA is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
 #
-CONFIG_PCMCIA=y
+CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_PCMCIA_OBSOLETE is not set
+CONFIG_PCMCIA=y
+
+#
+# PC-card bridges
+#
 # CONFIG_TCIC is not set
+CONFIG_M32R_PCC=y
 
 #
 # PCI Hotplug Support
@@ -209,6 +213,16 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -227,7 +241,6 @@ CONFIG_BLK_DEV_IDECD=m
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_IDE_TASK_IOCTL is not set
-# CONFIG_IDE_TASKFILE_IO is not set
 
 #
 # IDE chipset support/bugfixes
@@ -287,6 +300,9 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -306,7 +322,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -323,7 +338,48 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_NETDEVICES is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+# CONFIG_NET_ETHERNET is not set
+CONFIG_NE2000=y
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
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
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
@@ -361,6 +417,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -393,7 +450,6 @@ CONFIG_SERIAL_M32R_SIO_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -458,6 +514,8 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -477,6 +535,7 @@ CONFIG_EXT2_FS=y
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -509,6 +568,7 @@ CONFIG_DEVFS_MOUNT=y
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
@@ -554,6 +614,7 @@ CONFIG_LOCKD_V4=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -625,6 +686,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -ruNp a/arch/m32r/mappi2/defconfig.vdec2 b/arch/m32r/mappi2/defconfig.vdec2
--- a/arch/m32r/mappi2/defconfig.vdec2	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/m32r/mappi2/defconfig.vdec2	2004-11-12 16:08:58.000000000 +0900
@@ -0,0 +1,698 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-bk21
+# Fri Nov 12 16:08:58 2004
+#
+CONFIG_M32R=y
+CONFIG_UID16=y
+CONFIG_GENERIC_ISA_DMA=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
+CONFIG_IKCONFIG=y
+# CONFIG_IKCONFIG_PROC is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
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
+# Processor type and features
+#
+# CONFIG_PLAT_MAPPI is not set
+# CONFIG_PLAT_USRV is not set
+# CONFIG_PLAT_M32700UT is not set
+# CONFIG_PLAT_OPSPUT is not set
+# CONFIG_PLAT_OAKS32R is not set
+CONFIG_PLAT_MAPPI2=y
+# CONFIG_CHIP_M32700 is not set
+# CONFIG_CHIP_M32102 is not set
+CONFIG_CHIP_VDEC2=y
+# CONFIG_CHIP_OPSP is not set
+CONFIG_MMU=y
+CONFIG_TLB_ENTRIES=16
+CONFIG_ISA_M32R2=y
+CONFIG_BUS_CLOCK=50000000
+CONFIG_TIMER_DIVIDE=128
+# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_MEMORY_START=0x08000000
+CONFIG_MEMORY_SIZE=0x01000000
+CONFIG_NOHIGHMEM=y
+# CONFIG_DISCONTIGMEM is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_PREEMPT=y
+# CONFIG_HAVE_DEC_LOCK is not set
+# CONFIG_SMP is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
+#
+# CONFIG_PCI is not set
+# CONFIG_ISA is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_PCMCIA_OBSOLETE is not set
+CONFIG_PCMCIA=y
+
+#
+# PC-card bridges
+#
+# CONFIG_TCIC is not set
+# CONFIG_M32R_CFC is not set
+
+#
+# PCI Hotplug Support
+#
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
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
+# CONFIG_FW_LOADER is not set
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
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+CONFIG_BLK_DEV_IDECS=y
+CONFIG_BLK_DEV_IDECD=m
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_BLK_DEV_IDESCSI is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+# CONFIG_IDE_ARM is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=m
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=m
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=m
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=m
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_QLOGIC_1280_1040 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# PCMCIA SCSI adapter support
+#
+# CONFIG_PCMCIA_AHA152X is not set
+# CONFIG_PCMCIA_FDOMAIN is not set
+# CONFIG_PCMCIA_NINJA_SCSI is not set
+# CONFIG_PCMCIA_QLOGIC is not set
+# CONFIG_PCMCIA_SYM53C500 is not set
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
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
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
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_SMC91X=y
+# CONFIG_NE2000 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
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
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
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
+# CONFIG_INPUT_MOUSEDEV is not set
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
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
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
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_M32R_SIO=y
+CONFIG_SERIAL_M32R_SIO_CONSOLE=y
+# CONFIG_SERIAL_M32R_PLDSIO is not set
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
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
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
+CONFIG_VIDEO_DEV=y
+
+#
+# Video For Linux
+#
+
+#
+# Video Adapters
+#
+# CONFIG_VIDEO_CPIA is not set
+# CONFIG_VIDEO_M32R_AR is not set
+
+#
+# Radio Adapters
+#
+# CONFIG_RADIO_MAESTRO is not set
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
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
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
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=m
+CONFIG_JBD_DEBUG=y
+CONFIG_FS_MBCACHE=y
+CONFIG_REISERFS_FS=m
+# CONFIG_REISERFS_CHECK is not set
+# CONFIG_REISERFS_PROC_INFO is not set
+# CONFIG_REISERFS_FS_XATTR is not set
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
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+# CONFIG_ZISOFS is not set
+CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_DEVFS_FS=y
+CONFIG_DEVFS_MOUNT=y
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
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+# CONFIG_EXPORTFS is not set
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
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
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
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
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_FRAME_POINTER is not set
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
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
diff -ruNp a/arch/m32r/oaks32r/defconfig.nommu b/arch/m32r/oaks32r/defconfig.nommu
--- a/arch/m32r/oaks32r/defconfig.nommu	2004-10-19 06:53:06.000000000 +0900
+++ b/arch/m32r/oaks32r/defconfig.nommu	2004-11-12 16:09:00.000000000 +0900
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-bk21
+# Fri Nov 12 16:09:00 2004
 #
 CONFIG_M32R=y
 CONFIG_UID16=y
@@ -11,10 +13,12 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
@@ -22,16 +26,19 @@ CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -41,6 +48,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
@@ -71,25 +79,19 @@ CONFIG_PREEMPT=y
 # CONFIG_SMP is not set
 
 #
-# M32R drivers
-#
-CONFIG_M32R_NE2000=y
-
-#
-# Power management options (ACPI, APM)
-#
-# CONFIG_PM is not set
-
-#
 # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 #
 # CONFIG_PCI is not set
 # CONFIG_ISA is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PC-card bridges
 #
-# CONFIG_PCMCIA is not set
 
 #
 # PCI Hotplug Support
@@ -138,6 +140,16 @@ CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -193,6 +205,9 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -212,7 +227,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -229,7 +243,43 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_NETDEVICES is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+# CONFIG_NET_ETHERNET is not set
+CONFIG_NE2000=y
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
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
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
@@ -264,6 +314,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -296,7 +347,6 @@ CONFIG_SERIAL_M32R_SIO_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -356,6 +406,8 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -375,6 +427,7 @@ CONFIG_EXT2_FS=y
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -435,6 +488,7 @@ CONFIG_LOCKD_V4=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -506,6 +560,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -ruNp a/arch/m32r/opsput/defconfig.opsput b/arch/m32r/opsput/defconfig.opsput
--- a/arch/m32r/opsput/defconfig.opsput	2004-10-19 06:53:45.000000000 +0900
+++ b/arch/m32r/opsput/defconfig.opsput	2004-11-12 16:09:02.000000000 +0900
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-bk21
+# Fri Nov 12 16:09:02 2004
 #
 CONFIG_M32R=y
 CONFIG_UID16=y
@@ -15,6 +17,7 @@ CONFIG_BROKEN_ON_SMP=y
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
@@ -24,17 +27,20 @@ CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
-CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -44,6 +50,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
@@ -77,29 +84,25 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_SMP is not set
 
 #
-# M32R drivers
-#
-# CONFIG_M32R_CFC is not set
-CONFIG_M32R_SMC91111=y
-CONFIG_M32700UT_DS1302=y
-
-#
-# Power management options (ACPI, APM)
-#
-# CONFIG_PM is not set
-
-#
 # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 #
 # CONFIG_PCI is not set
 # CONFIG_ISA is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
 #
-CONFIG_PCMCIA=y
+CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_PCMCIA_OBSOLETE is not set
+CONFIG_PCMCIA=y
+
+#
+# PC-card bridges
+#
 # CONFIG_TCIC is not set
+CONFIG_M32R_CFC=y
+CONFIG_M32R_CFC_NUM=1
 
 #
 # PCI Hotplug Support
@@ -147,6 +150,16 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -185,9 +198,8 @@ CONFIG_SCSI_MULTI_LUN=y
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -243,6 +255,9 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -262,7 +277,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -279,7 +293,50 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_NETDEVICES is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_SMC91X=y
+# CONFIG_NE2000 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
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
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
@@ -314,6 +371,7 @@ CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -340,13 +398,12 @@ CONFIG_SERIO_SERPORT=y
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_M32R_SIO is not set
+CONFIG_SERIAL_M32R_SIO=y
+CONFIG_SERIAL_M32R_SIO_CONSOLE=y
 CONFIG_SERIAL_M32R_PLDSIO=y
-CONFIG_SERIAL_M32R_PLDSIO_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -359,6 +416,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_WATCHDOG is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
+CONFIG_DS1302=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
@@ -411,6 +469,8 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -438,6 +498,7 @@ CONFIG_REISERFS_FS=m
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -471,6 +532,7 @@ CONFIG_DEVFS_MOUNT=y
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
@@ -505,6 +567,7 @@ CONFIG_LOCKD_V4=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -583,6 +646,7 @@ CONFIG_DEBUG_INFO=y
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
