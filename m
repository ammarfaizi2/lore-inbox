Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135595AbRDSUEj>; Thu, 19 Apr 2001 16:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135593AbRDSUEb>; Thu, 19 Apr 2001 16:04:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44300 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S135603AbRDSUEL>;
	Thu, 19 Apr 2001 16:04:11 -0400
From: rmk@arm.linux.org.uk
Message-Id: <200104192004.VAA01094@raistlin.arm.linux.org.uk>
Subject: Re: Dead symbol elimination, stage 1
To: esr@thyrsus.com
Date: Thu, 19 Apr 2001 21:04:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (CML2), kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010419135955.A3841@thyrsus.com> from "Eric S. Raymond" at Apr 19, 2001 01:59:55 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

Please apply this patch before doing anything in the ARM tree.

What you will find is that most of your symbols in these files were due
to it being out of date.  However, I'd say the bigger problem is the
symbols that don't exist.

Also, you may not have the full story of the Config.in files - another
reason why you should not touch the architecture specific files.  For
instance, a quick scan of my latest ARM patch reveals:

src@raistlin:[2]:<1009> grep 'diff.*Config.in' rmk1
diff -urN linux-orig/drivers/char/Config.in linux/drivers/char/Config.in
diff -urN linux-orig/drivers/media/video/Config.in linux/drivers/media/video/Config.in
diff -urN linux-orig/drivers/mtd/Config.in linux/drivers/mtd/Config.in
diff -urN linux-orig/drivers/net/Config.in linux/drivers/net/Config.in
diff -urN linux-orig/drivers/net/irda/Config.in linux/drivers/net/irda/Config.in
diff -urN linux-orig/drivers/pcmcia/Config.in linux/drivers/pcmcia/Config.in
diff -urN linux-orig/drivers/sound/Config.in linux/drivers/sound/Config.in
diff -urN linux-orig/drivers/ssi/Config.in linux/drivers/ssi/Config.in
diff -urN linux-orig/drivers/video/Config.in linux/drivers/video/Config.in

So you're probably removing some of the valid symbols in the defconfig
files.  Without going through your changes with a toothpick...

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

diff -urN linux-orig/arch/arm/def-configs/clps7500 linux/arch/arm/def-configs/clps7500
--- linux-orig/arch/arm/def-configs/clps7500	Tue Oct  3 20:08:18 2000
+++ linux/arch/arm/def-configs/clps7500	Tue Feb 13 15:26:10 2001
@@ -2,7 +2,9 @@
 # Automatically generated make config: don't edit
 #
 CONFIG_ARM=y
+# CONFIG_EISA is not set
 # CONFIG_SBUS is not set
+# CONFIG_MCA is not set
 CONFIG_UID16=y
 
 #
@@ -23,6 +25,7 @@
 CONFIG_ARCH_CLPS7500=y
 # CONFIG_ARCH_CO285 is not set
 # CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_FTVPCI is not set
 # CONFIG_ARCH_TBOX is not set
 # CONFIG_ARCH_SHARK is not set
@@ -30,22 +33,51 @@
 # CONFIG_ARCH_INTEGRATOR is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_CLPS711X is not set
+
+#
+# Archimedes/A5000 Implementations
+#
+
+#
+# Footbridge Implementations
+#
+
+#
+# SA11x0 Implementations
+#
+
+#
+# CLPS711X/EP721X Implementations
+#
 # CONFIG_ARCH_ACORN is not set
 # CONFIG_FOOTBRIDGE is not set
 # CONFIG_FOOTBRIDGE_HOST is not set
 # CONFIG_FOOTBRIDGE_ADDIN is not set
 CONFIG_CPU_32=y
 # CONFIG_CPU_26 is not set
+
+#
+# Processor Type
+#
 CONFIG_CPU_32v3=y
-CONFIG_CPU_ARM7=y
+# CONFIG_CPU_32v4 is not set
+# CONFIG_CPU_ARM610 is not set
+CONFIG_CPU_ARM710=y
+# CONFIG_CPU_ARM720T is not set
+# CONFIG_CPU_ARM920T is not set
+# CONFIG_CPU_ARM1020 is not set
+# CONFIG_CPU_SA110 is not set
+# CONFIG_CPU_SA1100 is not set
 # CONFIG_DISCONTIGMEM is not set
-# CONFIG_PCI is not set
-# CONFIG_ISA is not set
-# CONFIG_ISA_DMA is not set
 
 #
 # General setup
 #
+CONFIG_ANGELBOOT=y
+# CONFIG_PCI is not set
+CONFIG_ISA=y
+# CONFIG_ISA_DMA is not set
 # CONFIG_HOTPLUG is not set
 # CONFIG_PCMCIA is not set
 CONFIG_NET=y
@@ -60,7 +92,7 @@
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_PM is not set
 # CONFIG_ARTHUR is not set
-CONFIG_CMDLINE="root=/dev/nfs rw"
+CONFIG_CMDLINE="mem=16M root=nfs"
 # CONFIG_ALIGNMENT_TRAP is not set
 
 #
@@ -81,34 +113,35 @@
 # Memory Technology Devices (MTD)
 #
 CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
 # CONFIG_MTD_DOC1000 is not set
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOCPROBE is not set
+
+#
+# RAM/ROM Device Drivers
+#
 # CONFIG_MTD_SLRAM is not set
-# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_PMC551_BUGFIX is not set
+# CONFIG_MTD_PMC551_DEBUG is not set
 # CONFIG_MTD_MTDRAM is not set
 
 #
-# MTD drivers for mapped chips
+# Linearly Mapped Flash Device Drivers
 #
 # CONFIG_MTD_CFI is not set
-# CONFIG_MTD_CFI_INTELEXT is not set
-# CONFIG_MTD_CFI_AMDSTD is not set
-# CONFIG_MTD_JEDEC is not set
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
-# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_JEDEC is not set
 
 #
 # Drivers for chip mappings
 #
-# CONFIG_MTD_MIXMEM is not set
-# CONFIG_MTD_NORA is not set
-# CONFIG_MTD_OCTAGON is not set
-# CONFIG_MTD_PNC2000 is not set
-# CONFIG_MTD_RPXLITE is not set
-# CONFIG_MTD_VMAX is not set
 
 #
 # User modules and translation layers for MTD devices
@@ -122,7 +155,6 @@
 # Plug and Play configuration
 #
 # CONFIG_PNP is not set
-# CONFIG_ISAPNP is not set
 
 #
 # Block devices
@@ -130,20 +162,12 @@
 # CONFIG_BLK_DEV_FD is not set
 # CONFIG_BLK_DEV_XD is not set
 # CONFIG_PARIDE is not set
-# CONFIG_BLK_CPQ_DA is not set
-# CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_LOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_LVM is not set
-# CONFIG_BLK_DEV_MD is not set
-# CONFIG_MD_LINEAR is not set
-# CONFIG_MD_RAID0 is not set
-# CONFIG_MD_RAID1 is not set
-# CONFIG_MD_RAID5 is not set
+CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
-CONFIG_BLK_DEV_FLD7500=y
+# CONFIG_BLK_DEV_FLD7500 is not set
 
 #
 # Networking options
@@ -159,10 +183,8 @@
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_ALIAS is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_IPV6 is not set
@@ -179,6 +201,7 @@
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
 # CONFIG_LLC is not set
+# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 # CONFIG_NET_FASTROUTE is not set
@@ -201,6 +224,7 @@
 CONFIG_DUMMY=y
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
 # CONFIG_NET_SB1000 is not set
 
 #
@@ -213,16 +237,19 @@
 # CONFIG_NET_VENDOR_RACAL is not set
 # CONFIG_AT1700 is not set
 # CONFIG_DEPCA is not set
+# CONFIG_HP100 is not set
 # CONFIG_NET_ISA is not set
-# CONFIG_NET_PCI is not set
+CONFIG_NET_PCI=y
+# CONFIG_AC3200 is not set
+# CONFIG_APRICOT is not set
+CONFIG_CS89x0=y
+# CONFIG_ZNET is not set
 # CONFIG_NET_POCKET is not set
 
 #
 # Ethernet (1000 Mbit)
 #
-# CONFIG_YELLOWFIN is not set
-# CONFIG_ACENIC is not set
-# CONFIG_SK98LIN is not set
+# CONFIG_ACENIC_OMIT_TIGON_I is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PLIP is not set
@@ -283,10 +310,6 @@
 # I2O device support
 #
 # CONFIG_I2O is not set
-# CONFIG_I2O_BLOCK is not set
-# CONFIG_I2O_LAN is not set
-# CONFIG_I2O_SCSI is not set
-# CONFIG_I2O_PROC is not set
 
 #
 # ISDN subsystem
@@ -294,6 +317,11 @@
 # CONFIG_ISDN is not set
 
 #
+# Input core support
+#
+# CONFIG_INPUT is not set
+
+#
 # Character devices
 #
 CONFIG_VT=y
@@ -305,7 +333,7 @@
 CONFIG_UNIX98_PTYS=y
 CONFIG_UNIX98_PTY_COUNT=256
 CONFIG_PRINTER=y
-CONFIG_LP_CONSOLE=y
+# CONFIG_LP_CONSOLE is not set
 # CONFIG_PPDEV is not set
 
 #
@@ -322,16 +350,38 @@
 #
 # Mice
 #
-# CONFIG_BUSMOUSE is not set
+CONFIG_BUSMOUSE=y
+# CONFIG_ATIXL_BUSMOUSE is not set
+# CONFIG_LOGIBUSMOUSE is not set
+# CONFIG_MS_BUSMOUSE is not set
 CONFIG_MOUSE=y
-CONFIG_PSMOUSE=y
+# CONFIG_PSMOUSE is not set
 # CONFIG_82C710_MOUSE is not set
 # CONFIG_PC110_PAD is not set
 
 #
 # Joysticks
 #
-# CONFIG_JOYSTICK is not set
+
+#
+# Game port support
+#
+
+#
+# Gameport joysticks
+#
+
+#
+# Serial port support
+#
+
+#
+# Serial port joysticks
+#
+
+#
+# Parallel port joysticks
+#
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -341,11 +391,6 @@
 CONFIG_CLPS7500_FLASH=y
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
-
-#
-# Video For Linux
-#
-# CONFIG_VIDEO_DEV is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
@@ -353,45 +398,38 @@
 # CONFIG_DRM is not set
 
 #
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
 # File systems
 #
 # CONFIG_QUOTA is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_ADFS_FS is not set
-# CONFIG_ADFS_FS_RW is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_FAT_FS is not set
-# CONFIG_MSDOS_FS is not set
-# CONFIG_UMSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_JFFS_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_RAMFS is not set
 # CONFIG_ISO9660_FS is not set
-# CONFIG_JOLIET is not set
 CONFIG_MINIX_FS=y
 # CONFIG_NTFS_FS is not set
-# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
-# CONFIG_DEVFS_MOUNT is not set
-# CONFIG_DEVFS_DEBUG is not set
-# CONFIG_DEVPTS_FS is not set
+CONFIG_DEVPTS_FS=y
 # CONFIG_QNX4FS_FS is not set
-# CONFIG_QNX4FS_RW is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
-# CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_UFS_FS_WRITE is not set
 
 #
 # Network File Systems
@@ -401,21 +439,10 @@
 # CONFIG_NFS_V3 is not set
 CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
-# CONFIG_NFSD_V3 is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
-# CONFIG_NCPFS_PACKET_SIGNING is not set
-# CONFIG_NCPFS_IOCTL_LOCKING is not set
-# CONFIG_NCPFS_STRONG is not set
-# CONFIG_NCPFS_NFS_NS is not set
-# CONFIG_NCPFS_OS2_NS is not set
-# CONFIG_NCPFS_SMALLDOS is not set
-# CONFIG_NCPFS_MOUNT_SUBDIR is not set
-# CONFIG_NCPFS_NDS_DOMAINS is not set
-# CONFIG_NCPFS_NLS is not set
-# CONFIG_NCPFS_EXTRAS is not set
 
 #
 # Partition Types
@@ -430,11 +457,14 @@
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
+# CONFIG_SMB_NLS is not set
 # CONFIG_NLS is not set
 
 #
 # Console drivers
 #
+CONFIG_PC_KEYB=y
+CONFIG_PC_KEYMAP=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FB=y
 
@@ -445,15 +475,14 @@
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FB_ACORN=y
 # CONFIG_CHRONTEL_7003 is not set
-# CONFIG_FB_CYBER2000 is not set
 # CONFIG_FB_VIRTUAL is not set
 CONFIG_FBCON_ADVANCED=y
-# CONFIG_FBCON_MFB is not set
-# CONFIG_FBCON_CFB2 is not set
-# CONFIG_FBCON_CFB4 is not set
+CONFIG_FBCON_MFB=y
+CONFIG_FBCON_CFB2=y
+CONFIG_FBCON_CFB4=y
 CONFIG_FBCON_CFB8=y
-# CONFIG_FBCON_CFB16 is not set
-# CONFIG_FBCON_CFB24 is not set
+CONFIG_FBCON_CFB16=y
+CONFIG_FBCON_CFB24=y
 # CONFIG_FBCON_CFB32 is not set
 # CONFIG_FBCON_AFB is not set
 # CONFIG_FBCON_ILBM is not set
@@ -487,4 +516,4 @@
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
-# CONFIG_DEBUG_LL is not set
+CONFIG_DEBUG_LL=y
diff -urN linux-orig/arch/arm/def-configs/integrator linux/arch/arm/def-configs/integrator
--- linux-orig/arch/arm/def-configs/integrator	Tue Dec 12 23:59:48 2000
+++ linux/arch/arm/def-configs/integrator	Tue Jan 30 16:05:03 2001
@@ -25,6 +25,7 @@
 # CONFIG_ARCH_CLPS7500 is not set
 # CONFIG_ARCH_CO285 is not set
 # CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
 CONFIG_ARCH_INTEGRATOR=y
 # CONFIG_ARCH_RPC is not set
@@ -56,18 +57,28 @@
 #
 # Processor Type
 #
+# CONFIG_CPU_32v3 is not set
 CONFIG_CPU_32v4=y
-CONFIG_CPU_ARM720=y
-CONFIG_CPU_ARM920=y
+# CONFIG_CPU_ARM610 is not set
+# CONFIG_CPU_ARM710 is not set
+CONFIG_CPU_ARM720T=y
+CONFIG_CPU_ARM920T=y
 CONFIG_CPU_ARM920_CPU_IDLE=y
 CONFIG_CPU_ARM920_I_CACHE_ON=y
 CONFIG_CPU_ARM920_D_CACHE_ON=y
 # CONFIG_CPU_ARM920_WRITETHROUGH is not set
+# CONFIG_CPU_ARM1020 is not set
+# CONFIG_CPU_SA110 is not set
+# CONFIG_CPU_SA1100 is not set
 # CONFIG_DISCONTIGMEM is not set
 
 #
 # General setup
 #
+
+#
+# Please ensure that you have read the help on the next option
+#
 # CONFIG_ANGELBOOT is not set
 CONFIG_PCI_INTEGRATOR=y
 CONFIG_PCI=y
@@ -103,23 +114,32 @@
 # Memory Technology Devices (MTD)
 #
 CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
 # CONFIG_MTD_DOC1000 is not set
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOCPROBE is not set
+
+#
+# RAM/ROM Device Drivers
+#
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PMC551 is not set
 # CONFIG_MTD_MTDRAM is not set
 
 #
-# MTD drivers for mapped chips
+# Linearly Mapped Flash Device Drivers
 #
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 # CONFIG_MTD_CFI_AMDSTD is not set
-# CONFIG_MTD_JEDEC is not set
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
+# CONFIG_MTD_JEDEC is not set
 # CONFIG_MTD_PHYSMAP is not set
 
 #
@@ -347,6 +367,8 @@
 CONFIG_SERIAL_AMBA=y
 CONFIG_SERIAL_INTEGRATOR=y
 CONFIG_SERIAL_AMBA_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_UNIX98_PTY_COUNT=256
 
@@ -403,6 +425,8 @@
 # CONFIG_QUOTA is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_REISERFS_CHECK is not set
 # CONFIG_ADFS_FS is not set
 # CONFIG_ADFS_FS_RW is not set
 # CONFIG_AFFS_FS is not set
@@ -457,8 +481,6 @@
 # CONFIG_NCPFS_NFS_NS is not set
 # CONFIG_NCPFS_OS2_NS is not set
 # CONFIG_NCPFS_SMALLDOS is not set
-# CONFIG_NCPFS_MOUNT_SUBDIR is not set
-# CONFIG_NCPFS_NDS_DOMAINS is not set
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
 
@@ -475,6 +497,7 @@
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
+# CONFIG_SMB_NLS is not set
 # CONFIG_NLS is not set
 
 #
@@ -503,7 +526,7 @@
 #
 # Kernel hacking
 #
-CONFIG_FRAME_POINTER=y
+# CONFIG_NO_FRAME_POINTER is not set
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
diff -urN linux-orig/arch/arm/defconfig linux/arch/arm/defconfig
--- linux-orig/arch/arm/defconfig	Wed May 31 13:12:12 2000
+++ linux/arch/arm/defconfig	Tue Jan 30 16:04:09 2001
@@ -2,50 +2,80 @@
 # Automatically generated make config: don't edit
 #
 CONFIG_ARM=y
+# CONFIG_EISA is not set
+# CONFIG_SBUS is not set
+# CONFIG_MCA is not set
 CONFIG_UID16=y
 
 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+# CONFIG_OBSOLETE is not set
 
 #
-# System and processor type
+# Loadable module support
 #
-# CONFIG_ARCH_ARC is not set
-# CONFIG_ARCH_A5K is not set
-# CONFIG_ARCH_RPC is not set
+# CONFIG_MODULES is not set
+
+#
+# System Type
+#
+# CONFIG_ARCH_ARCA5K is not set
+# CONFIG_ARCH_CLPS7500 is not set
+# CONFIG_ARCH_CO285 is not set
 # CONFIG_ARCH_EBSA110 is not set
-CONFIG_FOOTBRIDGE=y
-CONFIG_HOST_FOOTBRIDGE=y
-# CONFIG_ADDIN_FOOTBRIDGE is not set
-CONFIG_ARCH_EBSA285=y
-# CONFIG_ARCH_CATS is not set
-CONFIG_ARCH_NETWINDER=y
-# CONFIG_ARCH_PERSONAL_SERVER is not set
+# CONFIG_ARCH_FOOTBRIDGE is not set
+CONFIG_ARCH_INTEGRATOR=y
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_CLPS711X is not set
+
+#
+# Archimedes/A5000 Implementations
+#
+
+#
+# Footbridge Implementations
+#
+
+#
+# SA11x0 Implementations
+#
+
+#
+# CLPS711X/EP721X Implementations
+#
 # CONFIG_ARCH_ACORN is not set
+# CONFIG_FOOTBRIDGE is not set
+# CONFIG_FOOTBRIDGE_HOST is not set
+# CONFIG_FOOTBRIDGE_ADDIN is not set
 CONFIG_CPU_32=y
 # CONFIG_CPU_26 is not set
-CONFIG_CPU_32v4=y
-CONFIG_CPU_SA110=y
-CONFIG_PCI=y
-CONFIG_PCI_NAMES=y
-CONFIG_ISA=y
-CONFIG_ISA_DMA=y
-# CONFIG_SBUS is not set
-# CONFIG_PCMCIA is not set
-# CONFIG_ALIGNMENT_TRAP is not set
 
 #
-# Loadable module support
+# Processor Type
 #
-CONFIG_MODULES=y
-# CONFIG_MODVERSIONS is not set
-CONFIG_KMOD=y
+CONFIG_CPU_32v4=y
+CONFIG_CPU_ARM720=y
+CONFIG_CPU_ARM920=y
+CONFIG_CPU_ARM920_CPU_IDLE=y
+CONFIG_CPU_ARM920_I_CACHE_ON=y
+CONFIG_CPU_ARM920_D_CACHE_ON=y
+# CONFIG_CPU_ARM920_WRITETHROUGH is not set
+# CONFIG_DISCONTIGMEM is not set
 
 #
 # General setup
 #
+# CONFIG_ANGELBOOT is not set
+CONFIG_PCI_INTEGRATOR=y
+CONFIG_PCI=y
+# CONFIG_ISA is not set
+# CONFIG_ISA_DMA is not set
+CONFIG_PCI_NAMES=y
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_NET=y
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
@@ -56,296 +86,86 @@
 CONFIG_BINFMT_AOUT=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+# CONFIG_PM is not set
 # CONFIG_ARTHUR is not set
+CONFIG_CMDLINE="root=1f04 mem=32M"
+CONFIG_LEDS=y
+CONFIG_LEDS_TIMER=y
+CONFIG_LEDS_CPU=y
+CONFIG_ALIGNMENT_TRAP=y
 
 #
 # Parallel port support
 #
-CONFIG_PARPORT=y
-CONFIG_PARPORT_PC=y
-CONFIG_PARPORT_PC_FIFO=y
-# CONFIG_PARPORT_PC_SUPERIO is not set
-# CONFIG_PARPORT_ARC is not set
-# CONFIG_PARPORT_AMIGA is not set
-# CONFIG_PARPORT_MFC3 is not set
-# CONFIG_PARPORT_ATARI is not set
-# CONFIG_PARPORT_SUNBPP is not set
-# CONFIG_PARPORT_OTHER is not set
-CONFIG_PARPORT_1284=y
-CONFIG_CMDLINE="root=/dev/hda1 ro mem=32M parport=0x378,7 ide0=autotune"
-CONFIG_LEDS=y
-CONFIG_LEDS_TIMER=y
-# CONFIG_LEDS_CPU is not set
+# CONFIG_PARPORT is not set
 
 #
-# IEEE 1394 (FireWire) support
+# Memory Technology Devices (MTD)
 #
-# CONFIG_IEEE1394 is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DOC1000 is not set
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOCPROBE is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_MTDRAM is not set
 
 #
-# I2O device support
+# MTD drivers for mapped chips
 #
-# CONFIG_I2O is not set
-# CONFIG_I2O_PCI is not set
-# CONFIG_I2O_BLOCK is not set
-# CONFIG_I2O_LAN is not set
-# CONFIG_I2O_SCSI is not set
-# CONFIG_I2O_PROC is not set
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_JEDEC is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_PHYSMAP is not set
+
+#
+# Drivers for chip mappings
+#
+# CONFIG_MTD_MIXMEM is not set
+# CONFIG_MTD_NORA is not set
+# CONFIG_MTD_OCTAGON is not set
+# CONFIG_MTD_PNC2000 is not set
+# CONFIG_MTD_RPXLITE is not set
+# CONFIG_MTD_VMAX is not set
+
+#
+# User modules and translation layers for MTD devices
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+CONFIG_MTD_ARM=y
 
 #
 # Plug and Play configuration
 #
-CONFIG_PNP=y
-CONFIG_ISAPNP=y
+# CONFIG_PNP is not set
+# CONFIG_ISAPNP is not set
 
 #
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
 # CONFIG_BLK_DEV_XD is not set
-CONFIG_PARIDE=m
-CONFIG_PARIDE_PARPORT=y
-
-#
-# Parallel IDE high-level drivers
-#
-CONFIG_PARIDE_PD=m
-CONFIG_PARIDE_PCD=m
-CONFIG_PARIDE_PF=m
-CONFIG_PARIDE_PT=m
-CONFIG_PARIDE_PG=m
-
-#
-# Parallel IDE protocol modules
-#
-CONFIG_PARIDE_ATEN=m
-CONFIG_PARIDE_BPCK=m
-CONFIG_PARIDE_COMM=m
-CONFIG_PARIDE_DSTR=m
-CONFIG_PARIDE_FIT2=m
-CONFIG_PARIDE_FIT3=m
-CONFIG_PARIDE_EPAT=m
-CONFIG_PARIDE_EPIA=m
-CONFIG_PARIDE_FRIQ=m
-CONFIG_PARIDE_FRPW=m
-CONFIG_PARIDE_KBIC=m
-CONFIG_PARIDE_KTTI=m
-CONFIG_PARIDE_ON20=m
-CONFIG_PARIDE_ON26=m
+# CONFIG_PARIDE is not set
 # CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
-CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_MD=y
-CONFIG_MD_LINEAR=m
-CONFIG_MD_STRIPED=m
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 
 #
-# Character devices
-#
-CONFIG_VT=y
-CONFIG_VT_CONSOLE=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_CONSOLE=y
-# CONFIG_SERIAL_EXTENDED is not set
-# CONFIG_SERIAL_NONSTANDARD is not set
-CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
-CONFIG_PRINTER=m
-# CONFIG_LP_CONSOLE is not set
-# CONFIG_PPDEV is not set
-
-#
-# I2C support
-#
-# CONFIG_I2C is not set
-
-#
-# Mice
-#
-# CONFIG_BUSMOUSE is not set
-CONFIG_MOUSE=y
-CONFIG_PSMOUSE=y
-# CONFIG_82C710_MOUSE is not set
-# CONFIG_PC110_PAD is not set
-
-#
-# Joysticks
-#
-# CONFIG_JOYSTICK is not set
-# CONFIG_QIC02_TAPE is not set
-
-#
-# Watchdog Cards
-#
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
-# CONFIG_WDT is not set
-CONFIG_SOFT_WATCHDOG=y
-# CONFIG_PCWATCHDOG is not set
-# CONFIG_ACQUIRE_WDT is not set
-# CONFIG_MIXCOMWD is not set
-# CONFIG_21285_WATCHDOG is not set
-CONFIG_977_WATCHDOG=m
-CONFIG_DS1620=y
-CONFIG_NWBUTTON=y
-CONFIG_NWBUTTON_REBOOT=y
-CONFIG_NWFLASH=m
-# CONFIG_NVRAM is not set
-CONFIG_RTC=y
-
-#
-# Video For Linux
-#
-CONFIG_VIDEO_DEV=y
-# CONFIG_I2C_PARPORT is not set
-
-#
-# Radio Adapters
-#
-# CONFIG_RADIO_CADET is not set
-# CONFIG_RADIO_RTRACK is not set
-# CONFIG_RADIO_RTRACK2 is not set
-# CONFIG_RADIO_AZTECH is not set
-# CONFIG_RADIO_GEMTEK is not set
-# CONFIG_RADIO_MIROPCM20 is not set
-# CONFIG_RADIO_SF16FMI is not set
-# CONFIG_RADIO_TERRATEC is not set
-# CONFIG_RADIO_TRUST is not set
-# CONFIG_RADIO_TYPHOON is not set
-# CONFIG_RADIO_ZOLTRIX is not set
-
-#
-# Video Adapters
-#
-# CONFIG_VIDEO_PMS is not set
-# CONFIG_VIDEO_BWQCAM is not set
-# CONFIG_VIDEO_CQCAM is not set
-# CONFIG_VIDEO_SAA5249 is not set
-# CONFIG_TUNER_3036 is not set
-# CONFIG_VIDEO_STRADIS is not set
-# CONFIG_VIDEO_ZORAN is not set
-# CONFIG_VIDEO_BUZ is not set
-# CONFIG_VIDEO_ZR36120 is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
-# CONFIG_FTAPE is not set
-# CONFIG_DRM is not set
-# CONFIG_DRM_TDFX is not set
-# CONFIG_AGP is not set
-
-#
-# USB support
-#
-CONFIG_USB=m
-
-#
-# USB Controllers
-#
-# CONFIG_USB_UHCI is not set
-# CONFIG_USB_UHCI_ALT is not set
-CONFIG_USB_OHCI=m
-
-#
-# Miscellaneous USB options
-#
-CONFIG_USB_DEVICEFS=y
-
-#
-# USB Devices
-#
-CONFIG_USB_PRINTER=m
-# CONFIG_USB_SCANNER is not set
-CONFIG_USB_AUDIO=m
-CONFIG_USB_ACM=m
-# CONFIG_USB_SERIAL is not set
-# CONFIG_USB_CPIA is not set
-# CONFIG_USB_IBMCAM is not set
-# CONFIG_USB_OV511 is not set
-# CONFIG_USB_DC2XX is not set
-# CONFIG_USB_MDC800 is not set
-# CONFIG_USB_STORAGE is not set
-# CONFIG_USB_USS720 is not set
-# CONFIG_USB_DABUSB is not set
-# CONFIG_USB_PLUSB is not set
-# CONFIG_USB_PEGASUS is not set
-# CONFIG_USB_RIO500 is not set
-# CONFIG_USB_DSBR is not set
-
-#
-# USB HID
-#
-# CONFIG_USB_HID is not set
-CONFIG_USB_KBD=m
-CONFIG_USB_MOUSE=m
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_WMFORCE is not set
-CONFIG_INPUT_KEYBDEV=m
-CONFIG_INPUT_MOUSEDEV=m
-CONFIG_INPUT_MOUSEDEV_MIX=y
-# CONFIG_INPUT_MOUSEDEV_DIGITIZER is not set
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
-
-#
-# Console drivers
-#
-CONFIG_VGA_CONSOLE=y
-CONFIG_FB=y
-
-#
-# Frame-buffer support
-#
-CONFIG_FB=y
-CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FB_RIVA is not set
-# CONFIG_FB_CLGEN is not set
-# CONFIG_FB_PM2 is not set
-CONFIG_FB_CYBER2000=y
-# CONFIG_FB_MATROX is not set
-# CONFIG_FB_ATY is not set
-# CONFIG_FB_ATY128 is not set
-# CONFIG_FB_3DFX is not set
-# CONFIG_FB_VIRTUAL is not set
-CONFIG_FBCON_ADVANCED=y
-# CONFIG_FBCON_MFB is not set
-# CONFIG_FBCON_CFB2 is not set
-# CONFIG_FBCON_CFB4 is not set
-CONFIG_FBCON_CFB8=y
-CONFIG_FBCON_CFB16=y
-CONFIG_FBCON_CFB24=y
-# CONFIG_FBCON_CFB32 is not set
-# CONFIG_FBCON_AFB is not set
-# CONFIG_FBCON_ILBM is not set
-# CONFIG_FBCON_IPLAN2P2 is not set
-# CONFIG_FBCON_IPLAN2P4 is not set
-# CONFIG_FBCON_IPLAN2P8 is not set
-# CONFIG_FBCON_MAC is not set
-# CONFIG_FBCON_VGA_PLANES is not set
-CONFIG_FBCON_VGA=y
-# CONFIG_FBCON_HGA is not set
-# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
-CONFIG_FBCON_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
-# CONFIG_FONT_SUN8x16 is not set
-# CONFIG_FONT_SUN12x22 is not set
-# CONFIG_FONT_6x11 is not set
-# CONFIG_FONT_PEARL_8x8 is not set
-CONFIG_FONT_ACORN_8x8=y
-
-#
 # Networking options
 #
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
+# CONFIG_PACKET is not set
 # CONFIG_NETLINK is not set
 # CONFIG_NETFILTER is not set
 # CONFIG_FILTER is not set
@@ -356,16 +176,10 @@
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_IP_ROUTER is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-CONFIG_IP_ALIAS=y
+# CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
-
-#
-# (it is safe to leave these untouched)
-#
-CONFIG_SKB_LARGE=y
 # CONFIG_IPV6 is not set
 # CONFIG_KHTTPD is not set
 # CONFIG_ATM is not set
@@ -376,10 +190,11 @@
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
 # CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_BRIDGE is not set
 # CONFIG_LLC is not set
+# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 # CONFIG_NET_FASTROUTE is not set
@@ -391,16 +206,6 @@
 # CONFIG_NET_SCHED is not set
 
 #
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
 # Network device support
 #
 CONFIG_NETDEVICES=y
@@ -412,68 +217,59 @@
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
 # CONFIG_NET_SB1000 is not set
 
 #
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-# CONFIG_ARM_AM79C961A is not set
-CONFIG_NET_VENDOR_3COM=y
-# CONFIG_EL1 is not set
-# CONFIG_EL2 is not set
-# CONFIG_ELPLUS is not set
-# CONFIG_EL16 is not set
-# CONFIG_EL3 is not set
-# CONFIG_3C515 is not set
-CONFIG_VORTEX=y
+# CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_LANCE is not set
 # CONFIG_NET_VENDOR_SMC is not set
 # CONFIG_NET_VENDOR_RACAL is not set
 # CONFIG_AT1700 is not set
 # CONFIG_DEPCA is not set
+# CONFIG_HP100 is not set
 # CONFIG_NET_ISA is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
-# CONFIG_AC3200 is not set
 # CONFIG_APRICOT is not set
 # CONFIG_CS89x0 is not set
+CONFIG_TULIP=y
 # CONFIG_DE4X5 is not set
-CONFIG_TULIP=m
 # CONFIG_DGRS is not set
 # CONFIG_DM9102 is not set
-# CONFIG_EEPRO100 is not set
+CONFIG_EEPRO100=y
+CONFIG_EEPRO100_PM=y
 # CONFIG_LNE390 is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
 # CONFIG_NE3210 is not set
-CONFIG_NE2K_PCI=y
-# CONFIG_RTL8129 is not set
+# CONFIG_ES3210 is not set
 # CONFIG_8139TOO is not set
+# CONFIG_RTL8129 is not set
 # CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
-# CONFIG_ES3210 is not set
-# CONFIG_EPIC100 is not set
+# CONFIG_WINBOND_840 is not set
+# CONFIG_HAPPYMEAL is not set
 # CONFIG_NET_POCKET is not set
 
 #
 # Ethernet (1000 Mbit)
 #
-# CONFIG_YELLOWFIN is not set
 # CONFIG_ACENIC is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
-# CONFIG_PLIP is not set
-CONFIG_PPP=m
-CONFIG_PPP_ASYNC=m
-# CONFIG_PPP_SYNC_TTY is not set
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_SLIP=m
-CONFIG_SLIP_COMPRESSED=y
-CONFIG_SLIP_SMART=y
-CONFIG_SLIP_MODE_SLIP6=y
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
 
 #
 # Wireless LAN (non-hamradio)
@@ -494,71 +290,21 @@
 # CONFIG_WAN is not set
 
 #
-# ATA/IDE/MFM/RLL support
+# Amateur Radio support
 #
-CONFIG_IDE=y
+# CONFIG_HAMRADIO is not set
 
 #
-# IDE, ATA and ATAPI Block devices
+# IrDA (infrared) support
 #
-CONFIG_BLK_DEV_IDE=y
+# CONFIG_IRDA is not set
 
 #
-# Please see Documentation/ide.txt for help/info on IDE drives
+# ATA/IDE/MFM/RLL support
 #
-# CONFIG_BLK_DEV_HD_IDE is not set
+# CONFIG_IDE is not set
+# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
-CONFIG_BLK_DEV_IDEDISK=y
-CONFIG_IDEDISK_MULTI_MODE=y
-# CONFIG_BLK_DEV_IDECS is not set
-# CONFIG_BLK_DEV_IDECD is not set
-# CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_BLK_DEV_IDESCSI is not set
-
-#
-# IDE chipset support/bugfixes
-#
-# CONFIG_BLK_DEV_CMD640 is not set
-# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
-# CONFIG_BLK_DEV_ISAPNP is not set
-# CONFIG_BLK_DEV_RZ1000 is not set
-CONFIG_BLK_DEV_IDEPCI=y
-# CONFIG_IDEPCI_SHARE_IRQ is not set
-CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_OFFBOARD=y
-CONFIG_IDEDMA_PCI_AUTO=y
-CONFIG_BLK_DEV_IDEDMA=y
-CONFIG_IDEDMA_PCI_EXPERIMENTAL=y
-# CONFIG_IDEDMA_PCI_WIP is not set
-# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
-# CONFIG_BLK_DEV_AEC62XX is not set
-# CONFIG_AEC62XX_TUNING is not set
-# CONFIG_BLK_DEV_ALI15X3 is not set
-# CONFIG_WDC_ALI15X3 is not set
-# CONFIG_BLK_DEV_AMD7409 is not set
-# CONFIG_AMD7409_OVERRIDE is not set
-# CONFIG_BLK_DEV_CMD64X is not set
-# CONFIG_CMD64X_RAID is not set
-CONFIG_BLK_DEV_CY82C693=y
-# CONFIG_BLK_DEV_CS5530 is not set
-# CONFIG_BLK_DEV_HPT34X is not set
-# CONFIG_HPT34X_AUTODMA is not set
-# CONFIG_BLK_DEV_HPT366 is not set
-# CONFIG_HPT366_FIP is not set
-# CONFIG_HPT366_MODE3 is not set
-# CONFIG_BLK_DEV_NS87415 is not set
-# CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_PDC202XX=y
-# CONFIG_PDC202XX_BURST is not set
-# CONFIG_PDC202XX_MASTER is not set
-# CONFIG_BLK_DEV_SIS5513 is not set
-# CONFIG_BLK_DEV_TRM290 is not set
-# CONFIG_BLK_DEV_VIA82CXXX is not set
-CONFIG_BLK_DEV_SL82C105=y
-# CONFIG_IDE_CHIPSETS is not set
-CONFIG_IDEDMA_AUTO=y
-CONFIG_BLK_DEV_IDE_MODES=y
 
 #
 # SCSI support
@@ -566,72 +312,115 @@
 # CONFIG_SCSI is not set
 
 #
-# Sound
+# IEEE 1394 (FireWire) support
 #
-CONFIG_SOUND=m
-# CONFIG_SOUND_CMPCI is not set
-# CONFIG_SOUND_ES1370 is not set
-# CONFIG_SOUND_ES1371 is not set
-# CONFIG_SOUND_ESSSOLO1 is not set
-# CONFIG_SOUND_MAESTRO is not set
-# CONFIG_SOUND_SONICVIBES is not set
-# CONFIG_SOUND_TRIDENT is not set
-# CONFIG_SOUND_MSNDCLAS is not set
-# CONFIG_SOUND_MSNDPIN is not set
-CONFIG_SOUND_OSS=m
-# CONFIG_SOUND_TRACEINIT is not set
-# CONFIG_SOUND_DMAP is not set
-# CONFIG_SOUND_AD1816 is not set
-# CONFIG_SOUND_SGALAXY is not set
-# CONFIG_SOUND_ADLIB is not set
-# CONFIG_SOUND_ACI_MIXER is not set
-# CONFIG_SOUND_CS4232 is not set
-# CONFIG_SOUND_SSCAPE is not set
-# CONFIG_SOUND_GUS is not set
-# CONFIG_SOUND_VMIDI is not set
-# CONFIG_SOUND_TRIX is not set
-# CONFIG_SOUND_MSS is not set
-# CONFIG_SOUND_MPU401 is not set
-# CONFIG_SOUND_NM256 is not set
-# CONFIG_SOUND_MAD16 is not set
-# CONFIG_SOUND_PAS is not set
-# CONFIG_PAS_JOYSTICK is not set
-# CONFIG_SOUND_PSS is not set
-# CONFIG_SOUND_SOFTOSS is not set
-CONFIG_SOUND_SB=m
-# CONFIG_SOUND_AWE32_SYNTH is not set
-# CONFIG_SOUND_WAVEFRONT is not set
-# CONFIG_SOUND_MAUI is not set
-# CONFIG_SOUND_VIA82CXXX is not set
-# CONFIG_SOUND_YM3812 is not set
-# CONFIG_SOUND_OPL3SA1 is not set
-# CONFIG_SOUND_OPL3SA2 is not set
-# CONFIG_SOUND_UART6850 is not set
-# CONFIG_SOUND_AEDSP16 is not set
-# CONFIG_SOUND_VIDC is not set
-CONFIG_SOUND_WAVEARTIST=m
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+# CONFIG_I2O_PCI is not set
+# CONFIG_I2O_BLOCK is not set
+# CONFIG_I2O_LAN is not set
+# CONFIG_I2O_SCSI is not set
+# CONFIG_I2O_PROC is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Input core support
+#
+# CONFIG_INPUT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+# CONFIG_SERIAL is not set
+# CONFIG_SERIAL_EXTENDED is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+CONFIG_SERIAL_AMBA=y
+CONFIG_SERIAL_INTEGRATOR=y
+CONFIG_SERIAL_AMBA_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_UNIX98_PTY_COUNT=256
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Mice
+#
+# CONFIG_BUSMOUSE is not set
+CONFIG_MOUSE=y
+CONFIG_PSMOUSE=y
+# CONFIG_82C710_MOUSE is not set
+# CONFIG_PC110_PAD is not set
+
+#
+# Joysticks
+#
+# CONFIG_JOYSTICK is not set
+
+#
+# Input core support is needed for joysticks
+#
+# CONFIG_QIC02_TAPE is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_INTEL_RNG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
 
 #
 # File systems
 #
 # CONFIG_QUOTA is not set
-CONFIG_AUTOFS_FS=y
+# CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
-CONFIG_ADFS_FS=y
+# CONFIG_ADFS_FS is not set
 # CONFIG_ADFS_FS_RW is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_BFS_FS is not set
-CONFIG_FAT_FS=m
-CONFIG_MSDOS_FS=m
+# CONFIG_FAT_FS is not set
+# CONFIG_MSDOS_FS is not set
 # CONFIG_UMSDOS_FS is not set
-CONFIG_VFAT_FS=m
+# CONFIG_VFAT_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
 # CONFIG_CRAMFS is not set
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
+# CONFIG_RAMFS is not set
+# CONFIG_ISO9660_FS is not set
+# CONFIG_JOLIET is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
@@ -639,77 +428,77 @@
 # CONFIG_DEVFS_DEBUG is not set
 CONFIG_DEVPTS_FS=y
 # CONFIG_QNX4FS_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_QNX4FS_RW is not set
+CONFIG_ROMFS_FS=y
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
+# CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
+# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
+# CONFIG_UFS_FS_WRITE is not set
 
 #
 # Network File Systems
 #
 # CONFIG_CODA_FS is not set
 CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
 CONFIG_ROOT_NFS=y
-CONFIG_NFSD=m
+# CONFIG_NFSD is not set
 # CONFIG_NFSD_V3 is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
+# CONFIG_NCPFS_PACKET_SIGNING is not set
+# CONFIG_NCPFS_IOCTL_LOCKING is not set
+# CONFIG_NCPFS_STRONG is not set
+# CONFIG_NCPFS_NFS_NS is not set
+# CONFIG_NCPFS_OS2_NS is not set
+# CONFIG_NCPFS_SMALLDOS is not set
+# CONFIG_NCPFS_MOUNT_SUBDIR is not set
+# CONFIG_NCPFS_NDS_DOMAINS is not set
+# CONFIG_NCPFS_NLS is not set
+# CONFIG_NCPFS_EXTRAS is not set
 
 #
 # Partition Types
 #
 CONFIG_PARTITION_ADVANCED=y
-CONFIG_ACORN_PARTITION=y
-# CONFIG_ACORN_PARTITION_ICS is not set
-CONFIG_ACORN_PARTITION_ADFS=y
-# CONFIG_ACORN_PARTITION_POWERTEC is not set
-# CONFIG_ACORN_PARTITION_RISCIX is not set
+# CONFIG_ACORN_PARTITION is not set
 # CONFIG_OSF_PARTITION is not set
 # CONFIG_AMIGA_PARTITION is not set
 # CONFIG_ATARI_PARTITION is not set
 # CONFIG_MAC_PARTITION is not set
-CONFIG_MSDOS_PARTITION=y
-# CONFIG_BSD_DISKLABEL is not set
-# CONFIG_SOLARIS_X86_PARTITION is not set
-# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_MSDOS_PARTITION is not set
 # CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
-CONFIG_NLS=y
+# CONFIG_NLS is not set
 
 #
-# Native Language Support
+# Console drivers
+#
+CONFIG_KMI_KEYB=y
+CONFIG_PC_KEYMAP=y
+CONFIG_VGA_CONSOLE=y
+# CONFIG_FB is not set
+
+#
+# Frame-buffer support
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
 #
-CONFIG_NLS_CODEPAGE_437=m
-# CONFIG_NLS_CODEPAGE_737 is not set
-# CONFIG_NLS_CODEPAGE_775 is not set
-CONFIG_NLS_CODEPAGE_850=m
-CONFIG_NLS_CODEPAGE_852=m
-# CONFIG_NLS_CODEPAGE_855 is not set
-# CONFIG_NLS_CODEPAGE_857 is not set
-# CONFIG_NLS_CODEPAGE_860 is not set
-# CONFIG_NLS_CODEPAGE_861 is not set
-# CONFIG_NLS_CODEPAGE_862 is not set
-# CONFIG_NLS_CODEPAGE_863 is not set
-# CONFIG_NLS_CODEPAGE_864 is not set
-# CONFIG_NLS_CODEPAGE_865 is not set
-# CONFIG_NLS_CODEPAGE_866 is not set
-# CONFIG_NLS_CODEPAGE_869 is not set
-# CONFIG_NLS_CODEPAGE_874 is not set
-CONFIG_NLS_ISO8859_1=m
-CONFIG_NLS_ISO8859_2=m
-# CONFIG_NLS_ISO8859_3 is not set
-# CONFIG_NLS_ISO8859_4 is not set
-# CONFIG_NLS_ISO8859_5 is not set
-# CONFIG_NLS_ISO8859_6 is not set
-# CONFIG_NLS_ISO8859_7 is not set
-# CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_ISO8859_9 is not set
-# CONFIG_NLS_ISO8859_14 is not set
-CONFIG_NLS_ISO8859_15=m
-# CONFIG_NLS_KOI8_R is not set
+# CONFIG_USB is not set
 
 #
 # Kernel hacking
@@ -719,4 +508,4 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
-# CONFIG_DEBUG_LL is not set
+CONFIG_DEBUG_LL=y

