Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUATV6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUATV6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:58:00 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38120 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265803AbUATV5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:57:14 -0500
Date: Tue, 20 Jan 2004 22:57:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.1-mm5 (compile stats)
Message-ID: <20040120215705.GG12027@fs.tum.de>
References: <20040120000535.7fb8e683.akpm@osdl.org> <1074614919.31724.0.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074614919.31724.0.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 08:08:40AM -0800, John Cherry wrote:

> The patch for better i386 CPU selection still impacts the allnoconfig
> build.
> In this case, there is no default CPU.  Kconfig patches should be tested
> against defconfig, allnoconfig, allyesconfig, and allmodconfig.
>...

I'm testing all my patches with both a complete non-modular and a 
completely modular .config [1], and additionally I mix these testings 
with using CONFIG_SMP=n and/or using gcc 2.95 which often find even more 
problems.

Regarding defconfig:
Although several options were added and/or changed, there was not a 
single update to the i386 defconfig since August last year.
Below is a patch that updates defconfig for 2.6.1-mm5.

Regarding allnoconfig:
allnoconfig is a completely pathological case. It says "n" to support 
for ISA, MCA and PCI, and neither networking nor any block devices.
Besides, it says "n" to ELF, a.out and other binary formats.
Demanding that allnoconfig should compile (although the resulting kernel 
is completely useless) sounds a bit like demanding that no change in the 
kernel is allowed to cause regressions in the dbench results...
It is useful to omit a common option like e.g. PCI and check whether the 
kernel still compiles, but allnoconfig removes nearly everything and 
compiles such a small part of the kernel, that it's hardly useful.

cu
Adrian

[1] roughly similar to allyesconfig and allmodconfig, but selected
    by hand


--- linux-2.6.1-mm5/arch/i386/defconfig.old	2004-01-20 22:45:19.000000000 +0100
+++ linux-2.6.1-mm5/arch/i386/defconfig	2004-01-20 22:45:41.000000000 +0100
@@ -10,7 +10,8 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_BROKEN is not set
+CONFIG_CLEAN_COMPILE=y
+CONFIG_STANDALONE=y
 
 #
 # General setup
@@ -20,6 +21,8 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=15
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 CONFIG_FUTEX=y
@@ -27,6 +30,8 @@
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
 # Loadable module support
@@ -41,6 +46,7 @@
 # Processor type and features
 #
 CONFIG_X86_PC=y
+# CONFIG_X86_ELAN is not set
 # CONFIG_X86_VOYAGER is not set
 # CONFIG_X86_NUMAQ is not set
 # CONFIG_X86_SUMMIT is not set
@@ -48,44 +54,55 @@
 # CONFIG_X86_VISWS is not set
 # CONFIG_X86_GENERICARCH is not set
 # CONFIG_X86_ES7000 is not set
-# CONFIG_M386 is not set
-# CONFIG_M486 is not set
-# CONFIG_M586 is not set
-# CONFIG_M586TSC is not set
-# CONFIG_M586MMX is not set
-# CONFIG_M686 is not set
-# CONFIG_MPENTIUMII is not set
-# CONFIG_MPENTIUMIII is not set
-CONFIG_MPENTIUM4=y
-# CONFIG_MK6 is not set
-# CONFIG_MK7 is not set
-# CONFIG_MK8 is not set
-# CONFIG_MELAN is not set
-# CONFIG_MCRUSOE is not set
-# CONFIG_MWINCHIPC6 is not set
-# CONFIG_MWINCHIP2 is not set
-# CONFIG_MWINCHIP3D is not set
-# CONFIG_MCYRIXIII is not set
-# CONFIG_MVIAC3_2 is not set
-# CONFIG_X86_GENERIC is not set
-CONFIG_X86_CMPXCHG=y
-CONFIG_X86_XADD=y
+
+#
+# Processor support
+#
+
+#
+# Select all processors your kernel should support
+#
+CONFIG_CPU_386=y
+CONFIG_CPU_486=y
+CONFIG_CPU_586=y
+CONFIG_CPU_586TSC=y
+CONFIG_CPU_586MMX=y
+CONFIG_CPU_686=y
+CONFIG_CPU_PENTIUMII=y
+CONFIG_CPU_PENTIUMIII=y
+CONFIG_CPU_PENTIUMM=y
+CONFIG_CPU_PENTIUM4=y
+CONFIG_CPU_K6=y
+CONFIG_CPU_K7=y
+CONFIG_CPU_K8=y
+CONFIG_CPU_CRUSOE=y
+CONFIG_CPU_WINCHIPC6=y
+CONFIG_CPU_WINCHIP2=y
+CONFIG_CPU_WINCHIP3D=y
+CONFIG_CPU_CYRIXIII=y
+CONFIG_CPU_VIAC3_2=y
+CONFIG_CPU_INTEL=y
+CONFIG_CPU_WINCHIP=y
 CONFIG_X86_L1_CACHE_SHIFT=7
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
-CONFIG_X86_WP_WORKS_OK=y
-CONFIG_X86_INVLPG=y
-CONFIG_X86_BSWAP=y
-CONFIG_X86_POPAD_OK=y
-CONFIG_X86_GOOD_APIC=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_X86_PPRO_FENCE=y
+CONFIG_X86_F00F_BUG=y
+CONFIG_X86_ALIGNMENT_16=y
+CONFIG_X86_BAD_APIC=y
 CONFIG_X86_INTEL_USERCOPY=y
-CONFIG_X86_USE_PPRO_CHECKSUM=y
-# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_X86_4G is not set
+# CONFIG_X86_SWITCH_PAGETABLES is not set
+# CONFIG_X86_4G_VM_LAYOUT is not set
+# CONFIG_X86_UACCESS_INDIRECT is not set
+# CONFIG_X86_HIGH_ENTRY is not set
+# CONFIG_HPET_TIMER is not set
+# CONFIG_HPET_EMULATE_RTC is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
+# CONFIG_SCHED_SMT is not set
 CONFIG_PREEMPT=y
 CONFIG_X86_LOCAL_APIC=y
 CONFIG_X86_IO_APIC=y
-CONFIG_X86_TSC=y
 CONFIG_X86_MCE=y
 CONFIG_X86_MCE_NONFATAL=y
 CONFIG_X86_MCE_P4THERMAL=y
@@ -100,20 +117,22 @@
 # CONFIG_HIGHMEM64G is not set
 # CONFIG_MATH_EMULATION is not set
 CONFIG_MTRR=y
-CONFIG_HAVE_DEC_LOCK=y
+# CONFIG_EFI is not set
+# CONFIG_REGPARM is not set
 
 #
 # Power management options (ACPI, APM)
 #
 CONFIG_PM=y
 # CONFIG_SOFTWARE_SUSPEND is not set
+# CONFIG_PM_DISK is not set
 
 #
 # ACPI (Advanced Configuration and Power Interface) Support
 #
-CONFIG_ACPI_HT=y
 CONFIG_ACPI=y
 CONFIG_ACPI_BOOT=y
+CONFIG_ACPI_INTERPRETER=y
 CONFIG_ACPI_SLEEP=y
 CONFIG_ACPI_SLEEP_PROC_FS=y
 CONFIG_ACPI_AC=y
@@ -126,11 +145,12 @@
 # CONFIG_ACPI_TOSHIBA is not set
 # CONFIG_ACPI_DEBUG is not set
 CONFIG_ACPI_BUS=y
-CONFIG_ACPI_INTERPRETER=y
 CONFIG_ACPI_EC=y
 CONFIG_ACPI_POWER=y
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
+# CONFIG_ACPI_RELAXED_AML is not set
+# CONFIG_X86_PM_TIMER is not set
 
 #
 # APM (Advanced Power Management) BIOS Support
@@ -151,6 +171,7 @@
 CONFIG_PCI_GOANY=y
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
+# CONFIG_PCI_USE_VECTOR is not set
 CONFIG_PCI_LEGACY_PROC=y
 CONFIG_PCI_NAMES=y
 CONFIG_ISA=y
@@ -173,13 +194,15 @@
 #
 # Executable file formats
 #
-CONFIG_KCORE_ELF=y
-# CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_AOUT=y
 CONFIG_BINFMT_MISC=y
 
 #
+# Device Drivers
+#
+
+#
 # Generic Driver Options
 #
 # CONFIG_FW_LOADER is not set
@@ -252,6 +275,7 @@
 #
 # IDE chipset support/bugfixes
 #
+CONFIG_IDE_GENERIC=y
 CONFIG_BLK_DEV_CMD640=y
 # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
 # CONFIG_BLK_DEV_IDEPNP is not set
@@ -262,7 +286,6 @@
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_RZ1000=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-# CONFIG_BLK_DEV_IDE_TCQ is not set
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
@@ -300,11 +323,13 @@
 # SCSI device support
 #
 CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y
 
 #
 # SCSI support type (disk, tape, CD-ROM)
 #
 CONFIG_BLK_DEV_SD=y
+CONFIG_MAX_SD_DISKS=256
 # CONFIG_CHR_DEV_ST is not set
 # CONFIG_CHR_DEV_OSST is not set
 # CONFIG_BLK_DEV_SR is not set
@@ -330,11 +355,10 @@
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
-# CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
+# CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
 # CONFIG_SCSI_DMX3191D is not set
@@ -346,22 +370,21 @@
 # CONFIG_SCSI_GENERIC_NCR5380 is not set
 # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
 # CONFIG_SCSI_IPS is not set
-# CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
 # CONFIG_SCSI_PPA is not set
 # CONFIG_SCSI_IMM is not set
 # CONFIG_SCSI_NCR53C406A is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
-# CONFIG_SCSI_SYM53C8XX is not set
 # CONFIG_SCSI_PAS16 is not set
-# CONFIG_SCSI_PCI2000 is not set
-# CONFIG_SCSI_PCI2220I is not set
 # CONFIG_SCSI_PSI240I is not set
 # CONFIG_SCSI_QLOGIC_FAS is not set
 # CONFIG_SCSI_QLOGIC_ISP is not set
 # CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
-# CONFIG_SCSI_SEAGATE is not set
+CONFIG_SCSI_QLA2XXX_CONFIG=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA23XX is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
@@ -402,7 +425,7 @@
 #
 
 #
-# Texas Instruments PCILynx requires I2C bit-banging
+# Texas Instruments PCILynx requires I2C
 #
 CONFIG_IEEE1394_OHCI1394=y
 
@@ -459,7 +482,9 @@
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
-# CONFIG_LLC is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
 # CONFIG_NET_DIVERT is not set
@@ -487,14 +512,13 @@
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-# CONFIG_ETHERTAP is not set
 # CONFIG_NET_SB1000 is not set
 
 #
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_NET_VENDOR_3COM is not set
@@ -517,6 +541,7 @@
 # CONFIG_AC3200 is not set
 # CONFIG_APRICOT is not set
 # CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
 # CONFIG_CS89x0 is not set
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
@@ -530,6 +555,7 @@
 # CONFIG_8139TOO_TUNE_TWISTER is not set
 # CONFIG_8139TOO_8129 is not set
 # CONFIG_8139_OLD_RX_RESET is not set
+CONFIG_8139_RXBUF_IDX=2
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -567,11 +593,13 @@
 # CONFIG_NET_RADIO is not set
 
 #
-# Token Ring devices (depends on LLC=y)
+# Token Ring devices
 #
+# CONFIG_TR is not set
 # CONFIG_NET_FC is not set
 # CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # Wan interfaces
@@ -589,6 +617,16 @@
 # CONFIG_IRDA is not set
 
 #
+# Bluetooth support
+#
+# CONFIG_BT is not set
+# CONFIG_KGDBOE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NETPOLL_RX is not set
+# CONFIG_NETPOLL_TRAP is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
 # ISDN subsystem
 #
 # CONFIG_ISDN_BOOL is not set
@@ -659,6 +697,7 @@
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_CONSOLE is not set
 # CONFIG_SERIAL_8250_ACPI is not set
+CONFIG_SERIAL_8250_NR_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
@@ -673,20 +712,6 @@
 # CONFIG_TIPAR is not set
 
 #
-# I2C support
-#
-# CONFIG_I2C is not set
-
-#
-# I2C Hardware Sensors Mainboard support
-#
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
-
-#
 # Mice
 #
 # CONFIG_BUSMOUSE is not set
@@ -713,7 +738,6 @@
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_FTAPE is not set
 CONFIG_AGP=y
 # CONFIG_AGP_ALI is not set
 # CONFIG_AGP_ATI is not set
@@ -732,11 +756,17 @@
 # CONFIG_DRM_I810 is not set
 CONFIG_DRM_I830=y
 # CONFIG_DRM_MGA is not set
+# CONFIG_DRM_SIS is not set
 # CONFIG_MWAVE is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_HANGCHECK_TIMER is not set
 
 #
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -747,138 +777,6 @@
 # CONFIG_DVB is not set
 
 #
-# File systems
-#
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-# CONFIG_EXT3_FS_SECURITY is not set
-CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
-# CONFIG_REISERFS_FS is not set
-# CONFIG_JFS_FS is not set
-# CONFIG_XFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
-# CONFIG_QUOTA is not set
-# CONFIG_AUTOFS_FS is not set
-CONFIG_AUTOFS4_FS=y
-
-#
-# CD-ROM/DVD Filesystems
-#
-CONFIG_ISO9660_FS=y
-CONFIG_JOLIET=y
-# CONFIG_ZISOFS is not set
-CONFIG_UDF_FS=y
-
-#
-# DOS/FAT/NT Filesystems
-#
-CONFIG_FAT_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-# CONFIG_NTFS_FS is not set
-
-#
-# Pseudo filesystems
-#
-CONFIG_PROC_FS=y
-# CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
-# CONFIG_DEVPTS_FS_XATTR is not set
-CONFIG_TMPFS=y
-CONFIG_RAMFS=y
-
-#
-# Miscellaneous filesystems
-#
-# CONFIG_ADFS_FS is not set
-# CONFIG_AFFS_FS is not set
-# CONFIG_HFS_FS is not set
-# CONFIG_BEFS_FS is not set
-# CONFIG_BFS_FS is not set
-# CONFIG_EFS_FS is not set
-# CONFIG_CRAMFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_SYSV_FS is not set
-# CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
-CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
-# CONFIG_NFS_V4 is not set
-CONFIG_NFSD=y
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
-CONFIG_LOCKD=y
-CONFIG_EXPORTFS=y
-CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
-# CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
-# CONFIG_NCP_FS is not set
-# CONFIG_CODA_FS is not set
-# CONFIG_INTERMEZZO_FS is not set
-# CONFIG_AFS_FS is not set
-
-#
-# Partition Types
-#
-# CONFIG_PARTITION_ADVANCED is not set
-CONFIG_MSDOS_PARTITION=y
-CONFIG_NLS=y
-
-#
-# Native Language Support
-#
-CONFIG_NLS_DEFAULT="iso8859-1"
-CONFIG_NLS_CODEPAGE_437=y
-# CONFIG_NLS_CODEPAGE_737 is not set
-# CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
-# CONFIG_NLS_CODEPAGE_852 is not set
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
-# CONFIG_NLS_CODEPAGE_936 is not set
-# CONFIG_NLS_CODEPAGE_950 is not set
-# CONFIG_NLS_CODEPAGE_932 is not set
-# CONFIG_NLS_CODEPAGE_949 is not set
-# CONFIG_NLS_CODEPAGE_874 is not set
-# CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
-# CONFIG_NLS_CODEPAGE_1251 is not set
-CONFIG_NLS_ISO8859_1=y
-# CONFIG_NLS_ISO8859_2 is not set
-# CONFIG_NLS_ISO8859_3 is not set
-# CONFIG_NLS_ISO8859_4 is not set
-# CONFIG_NLS_ISO8859_5 is not set
-# CONFIG_NLS_ISO8859_6 is not set
-# CONFIG_NLS_ISO8859_7 is not set
-# CONFIG_NLS_ISO8859_9 is not set
-# CONFIG_NLS_ISO8859_13 is not set
-# CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
-# CONFIG_NLS_KOI8_R is not set
-# CONFIG_NLS_KOI8_U is not set
-# CONFIG_NLS_UTF8 is not set
-
-#
 # Graphics support
 #
 # CONFIG_FB is not set
@@ -1057,7 +955,6 @@
 #
 # USB Network adaptors
 #
-# CONFIG_USB_AX8817X is not set
 # CONFIG_USB_CATC is not set
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
@@ -1080,15 +977,148 @@
 # CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_GADGET is not set
 
 #
-# Bluetooth support
+# File systems
 #
-# CONFIG_BT is not set
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+# CONFIG_ZISOFS is not set
+CONFIG_UDF_FS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS=y
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_HUGETLBFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
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
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+CONFIG_NFSD=y
+# CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_TCP is not set
+CONFIG_LOCKD=y
+CONFIG_EXPORTFS=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_GSS is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
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
+CONFIG_NLS_CODEPAGE_437=y
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
+CONFIG_NLS_ISO8859_1=y
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
 
 #
 # Profiling support
@@ -1099,6 +1129,7 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_LOCKMETER is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_FRAME_POINTER=y
 CONFIG_X86_EXTRA_IRQS=y
@@ -1118,8 +1149,9 @@
 #
 # Library routines
 #
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=y
 CONFIG_X86_SMP=y
 CONFIG_X86_HT=y
 CONFIG_X86_BIOS_REBOOT=y
 CONFIG_X86_TRAMPOLINE=y
+CONFIG_PC=y
