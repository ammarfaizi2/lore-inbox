Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWJXIO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWJXIO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWJXIN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:58 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:27105 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932437AbWJXINZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:25 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 8/8] AVR32: Update defconfig
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 24 Oct 2006 10:12:46 +0200
Message-Id: <11616775663312-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11616775664128-git-send-email-hskinnemoen@atmel.com>
References: <1161677566706-git-send-email-hskinnemoen@atmel.com> <11616775663220-git-send-email-hskinnemoen@atmel.com> <11616775662194-git-send-email-hskinnemoen@atmel.com> <11616775661390-git-send-email-hskinnemoen@atmel.com> <11616775661978-git-send-email-hskinnemoen@atmel.com> <1161677566524-git-send-email-hskinnemoen@atmel.com> <11616775662032-git-send-email-hskinnemoen@atmel.com> <11616775664128-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sync atstk1002_defconfig with latest git, turn off non-existent
drivers and enable a few more userspace-visible options like
SysV IPC and inotify support.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/configs/atstk1002_defconfig |  253 ++++++++++++++++++++------------
 1 files changed, 159 insertions(+), 94 deletions(-)

diff --git a/arch/avr32/configs/atstk1002_defconfig b/arch/avr32/configs/atstk1002_defconfig
index 6c2c5e0..ae92a14 100644
--- a/arch/avr32/configs/atstk1002_defconfig
+++ b/arch/avr32/configs/atstk1002_defconfig
@@ -1,13 +1,14 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Tue Jul 11 12:41:36 2006
+# Linux kernel version: 2.6.19-rc2
+# Fri Oct 20 11:52:37 2006
 #
 CONFIG_AVR32=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -25,16 +26,23 @@ #
 CONFIG_LOCALVERSION=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SWAP=y
-# CONFIG_SYSVIPC is not set
-# CONFIG_POSIX_MQUEUE is not set
-# CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
-# CONFIG_AUDIT is not set
+CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_TASKSTATS=y
+CONFIG_TASK_DELAY_ACCT=y
+# CONFIG_UTS_NS is not set
+CONFIG_AUDIT=y
 # CONFIG_IKCONFIG is not set
-# CONFIG_RELAY is not set
+CONFIG_RELAY=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_TASK_XACCT is not set
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -43,14 +51,15 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 # CONFIG_BASE_FULL is not set
-# CONFIG_FUTEX is not set
-# CONFIG_EPOLL is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-# CONFIG_SLAB is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=1
-CONFIG_SLOB=y
+# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -65,6 +74,7 @@ # CONFIG_KMOD is not set
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
@@ -166,10 +176,12 @@ # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -199,7 +211,6 @@ # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -212,7 +223,6 @@ #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
-# CONFIG_NET_TCPPROBE is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
@@ -239,7 +249,84 @@ # CONFIG_CONNECTOR is not set
 #
 # Memory Technology Devices (MTD)
 #
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
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
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0x8000000
+CONFIG_MTD_PHYSMAP_LEN=0x0
+CONFIG_MTD_PHYSMAP_BANKWIDTH=2
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
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
+# OneNAND Flash Device Drivers
+#
+# CONFIG_MTD_ONENAND is not set
 
 #
 # Parallel port support
@@ -260,11 +347,18 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -274,6 +368,12 @@ # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -305,14 +405,11 @@ CONFIG_TUN=m
 #
 # PHY device support
 #
-# CONFIG_PHYLIB is not set
 
 #
 # Ethernet (10 or 100Mbit)
 #
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_MACB=y
+# CONFIG_NET_ETHERNET is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -341,10 +438,11 @@ # CONFIG_PPP_FILTER is not set
 CONFIG_PPP_ASYNC=m
 # CONFIG_PPP_SYNC_TTY is not set
 CONFIG_PPP_DEFLATE=m
-# CONFIG_PPP_BSDCOMP is not set
+CONFIG_PPP_BSDCOMP=m
 # CONFIG_PPP_MPPE is not set
 # CONFIG_PPPOE is not set
 # CONFIG_SLIP is not set
+CONFIG_SLHC=m
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -417,7 +515,6 @@ #
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -427,23 +524,13 @@ # CONFIG_I2C is not set
 #
 # SPI support
 #
-CONFIG_SPI=y
-# CONFIG_SPI_DEBUG is not set
-CONFIG_SPI_MASTER=y
-
-#
-# SPI Master Controller Drivers
-#
-CONFIG_SPI_ATMEL=m
-# CONFIG_SPI_BITBANG is not set
-
-#
-# SPI Protocol Masters
-#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
 
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -452,14 +539,9 @@ # CONFIG_HWMON is not set
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -470,28 +552,8 @@ #
 # Graphics support
 #
 # CONFIG_FIRMWARE_EDID is not set
-CONFIG_FB=m
-CONFIG_FB_CFB_FILLRECT=m
-CONFIG_FB_CFB_COPYAREA=m
-CONFIG_FB_CFB_IMAGEBLIT=m
-# CONFIG_FB_MACMODES is not set
-# CONFIG_FB_BACKLIGHT is not set
-# CONFIG_FB_MODE_HELPERS is not set
-# CONFIG_FB_TILEBLITTING is not set
-CONFIG_FB_SIDSA=m
-CONFIG_FB_SIDSA_DEFAULT_BPP=24
-# CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_VIRTUAL is not set
-
-#
-# Logo configuration
-#
-# CONFIG_LOGO is not set
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
-# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
-CONFIG_LCD_CLASS_DEVICE=m
-CONFIG_LCD_DEVICE=y
-CONFIG_LCD_LTV350QV=m
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -561,18 +623,21 @@ #
 #
 # File systems
 #
-CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS=m
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 CONFIG_MINIX_FS=m
-CONFIG_ROMFS_FS=m
-# CONFIG_INOTIFY is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_AUTOFS_FS is not set
@@ -600,8 +665,10 @@ # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 CONFIG_CONFIGFS_FS=m
@@ -616,6 +683,16 @@ # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -626,26 +703,10 @@ # CONFIG_UFS_FS is not set
 #
 # Network File Systems
 #
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-# CONFIG_NFS_V3_ACL is not set
-# CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
-CONFIG_ROOT_NFS=y
-CONFIG_LOCKD=y
-CONFIG_LOCKD_V4=y
-CONFIG_NFS_COMMON=y
-CONFIG_SUNRPC=y
-# CONFIG_RPCSEC_GSS_KRB5 is not set
-# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
-CONFIG_CIFS=m
-# CONFIG_CIFS_STATS is not set
-# CONFIG_CIFS_WEAK_PW_HASH is not set
-# CONFIG_CIFS_XATTR is not set
-# CONFIG_CIFS_DEBUG2 is not set
-# CONFIG_CIFS_EXPERIMENTAL is not set
+# CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -665,7 +726,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=m
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
-CONFIG_NLS_CODEPAGE_850=m
+# CONFIG_NLS_CODEPAGE_850 is not set
 # CONFIG_NLS_CODEPAGE_852 is not set
 # CONFIG_NLS_CODEPAGE_855 is not set
 # CONFIG_NLS_CODEPAGE_857 is not set
@@ -705,13 +766,17 @@ #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
-CONFIG_PRINTK_TIME=y
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_MUTEXES is not set
 # CONFIG_DEBUG_RWSEMS is not set
@@ -722,11 +787,13 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FRAME_POINTER=y
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
-CONFIG_KPROBES=y
+# CONFIG_KPROBES is not set
 
 #
 # Security options
@@ -740,15 +807,13 @@ #
 # CONFIG_CRYPTO is not set
 
 #
-# Hardware crypto devices
-#
-
-#
 # Library routines
 #
 CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
+CONFIG_AUDIT_GENERIC=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
-- 
1.4.1.1

