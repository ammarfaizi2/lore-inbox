Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268736AbTGZTqI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269232AbTGZTqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:46:07 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:3785 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S268736AbTGZTpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:45:55 -0400
Date: Sat, 26 Jul 2003 22:00:59 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] kill surplus menu in IDE Kconfig
Message-ID: <20030726200059.GC16160@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$subj

Patch against -bk3.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2003-07-26 20:43:37.000000000 +0200
+++ b/drivers/ide/Kconfig	2003-07-26 21:01:41.000000000 +0200
@@ -52,6 +52,8 @@
 
 	  If unsure, say Y.
 
+comment "Please see Documentation/ide.txt for help/info on IDE drives"
+
 config IDE_MAX_HWIFS 
 	int "Max IDE interfaces"
 	depends on ALPHA && IDE
@@ -61,12 +63,28 @@
 	  be supported by the driver. Make sure it is at least as high as
 	  the number of IDE interfaces in your system.
 
-menu "IDE, ATA and ATAPI Block devices"
-	depends on IDE!=n
+config BLK_DEV_HD_ONLY
+	bool "Old hard disk (MFM/RLL/IDE) driver"
+	depends on IDE
+	---help---
+	  There are two drivers for MFM/RLL/IDE hard disks. Most people use
+	  the newer enhanced driver, but this old one is still around for two
+	  reasons. Some older systems have strange timing problems and seem to
+	  work only with the old driver (which itself does not work with some
+	  newer systems). The other reason is that the old driver is smaller,
+	  since it lacks the enhanced functionality of the new one. This makes
+	  it a good choice for systems with very tight memory restrictions, or
+	  for systems with only older MFM/RLL/ESDI drives. Choosing the old
+	  driver can save 13 KB or so of kernel memory.
+
+	  If you are unsure, then just choose the Enhanced IDE/MFM/RLL driver
+	  instead of this one. For more detailed information, read the
+	  Disk-HOWTO, available from
+	  <http://www.tldp.org/docs.html#howto>.
 
 config BLK_DEV_IDE
 	tristate "Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support"
-	depends on IDE
+	depends on IDE!=n && BLK_DEV_HD_ONLY=n
 	---help---
 	  If you say Y here, you will use the full-featured IDE driver to
 	  control up to ten ATA/IDE interfaces, each being able to serve a
@@ -97,11 +115,11 @@
 	  could say N here, and select the "Old hard disk driver" below
 	  instead to save about 13 KB of memory in the kernel.
 
-comment "Please see Documentation/ide.txt for help/info on IDE drives"
+if BLK_DEV_IDE
 
 config BLK_DEV_HD_IDE
 	bool "Use old disk-only driver on primary interface"
-	depends on BLK_DEV_IDE && X86 && X86_PC9800!=y
+	depends on X86 && X86_PC9800!=y
 	---help---
 	  There are two drivers for MFM/RLL/IDE disks.  Most people use just
 	  the new enhanced driver by itself.  This option however installs the
@@ -119,7 +137,7 @@
 
 config BLK_DEV_HD_IDE98
 	bool "Use old disk-only driver on primary interface"
-	depends on BLK_DEV_IDE && X86 && X86_PC9800
+	depends on X86 && X86_PC9800
 	---help---
 	  There are two drivers for MFM/RLL/IDE disks.  Most people use just
 	  the new enhanced driver by itself.  This option however installs the
@@ -142,7 +160,6 @@
 
 config BLK_DEV_IDEDISK
 	tristate "Include IDE/ATA-2 DISK support"
-	depends on BLK_DEV_IDE
 	---help---
 	  This will include enhanced support for MFM/RLL/IDE hard disks.  If
 	  you have a MFM/RLL/IDE disk, and there is no special reason to use
@@ -183,14 +200,13 @@
 
 config BLK_DEV_IDECS
 	tristate "PCMCIA IDE support"
-	depends on BLK_DEV_IDE && PCMCIA
+	depends on PCMCIA
 	help
 	  Support for outboard IDE disks, tape drives, and CD-ROM drives
 	  connected through a  PCMCIA card.
 
 config BLK_DEV_IDECD
 	tristate "Include IDE/ATAPI CDROM support"
-	depends on BLK_DEV_IDE
 	---help---
 	  If you have a CD-ROM drive using the ATAPI protocol, say Y. ATAPI is
 	  a newer protocol used by IDE CD-ROM and TAPE drives, similar to the
@@ -216,7 +232,6 @@
 #dep_tristate '  Include IDE/ATAPI TAPE support' CONFIG_BLK_DEV_IDETAPE $CONFIG_BLK_DEV_IDE
 config BLK_DEV_IDEFLOPPY
 	tristate "Include IDE/ATAPI FLOPPY support"
-	depends on BLK_DEV_IDE
 	---help---
 	  If you have an IDE floppy drive which uses the ATAPI protocol,
 	  answer Y.  ATAPI is a newer protocol used by IDE CD-ROM/tape/floppy
@@ -241,7 +256,7 @@
 
 config BLK_DEV_IDESCSI
 	tristate "SCSI emulation support"
-	depends on BLK_DEV_IDE && SCSI
+	depends on SCSI
 	---help---
 	  This will provide SCSI host adapter emulation for IDE ATAPI devices,
 	  and will allow you to use a SCSI device driver instead of a native
@@ -267,7 +282,6 @@
 
 config IDE_TASK_IOCTL
 	bool "IDE Taskfile Access"
-	depends on BLK_DEV_IDE
 	help
 	  This is a direct raw access to the media.  It is a complex but
 	  elegant solution to test and validate the domain of the hardware and
@@ -278,7 +292,7 @@
 
 config IDE_TASKFILE_IO
 	bool 'IDE Taskfile IO (EXPERIMENTAL)'
-	depends on BLK_DEV_IDE && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	default n
 	---help---
 	  Use new taskfile IO code.
@@ -286,11 +300,10 @@
 	  It is safe to say Y to this question, in most cases.
 
 comment "IDE chipset support/bugfixes"
-	depends on BLK_DEV_IDE
 
 config BLK_DEV_CMD640
 	bool "CMD640 chipset bugfix/support"
-	depends on BLK_DEV_IDE && X86
+	depends on X86
 	---help---
 	  The CMD-Technologies CMD640 IDE chip is used on many common 486 and
 	  Pentium motherboards, usually in combination with a "Neptune" or
@@ -324,7 +337,7 @@
 
 config BLK_DEV_IDEPNP
 	bool "PNP EIDE support"
-	depends on BLK_DEV_IDE && PNP
+	depends on PNP
 	help
 	  If you have a PnP (Plug and Play) compatible EIDE card and
 	  would like the kernel to automatically detect and activate
@@ -332,7 +345,6 @@
 
 config BLK_DEV_IDEPCI
 	bool "PCI IDE chipset support" if PCI
-	depends on BLK_DEV_IDE
 	default BLK_DEV_IDEDMA_PMAC if PPC_PMAC && BLK_DEV_IDEDMA_PMAC
 	help
 	  Say Y here for PCI systems which use IDE drive(s).
@@ -472,7 +484,6 @@
 
 config BLK_DEV_IDEDMA
 	bool
-	depends on BLK_DEV_IDE
 	default BLK_DEV_IDEDMA_ICS if ARCH_ACORN
 	default BLK_DEV_IDEDMA_PMAC if PPC_PMAC && BLK_DEV_IDE_PMAC
 	default BLK_DEV_IDEDMA_PCI if PCI && BLK_DEV_IDEPCI
@@ -799,7 +810,7 @@
 
 config BLK_DEV_IDE_PMAC
 	bool "Builtin PowerMac IDE support"
-	depends on BLK_DEV_IDE && PPC_PMAC
+	depends on PPC_PMAC
 	help
 	  This driver provides support for the built-in IDE controller on
 	  most of the recent Apple Power Macintoshes and PowerBooks.
@@ -827,11 +838,11 @@
 
 config BLK_DEV_IDE_SWARM
 	bool "SWARM onboard IDE support"
-	depends on BLK_DEV_IDE && SIBYTE_SWARM
+	depends on SIBYTE_SWARM
 
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
-	depends on BLK_DEV_IDE!=n && ARM && ARCH_ACORN
+	depends on ARM && ARCH_ACORN
 	help
 	  On Acorn systems, say Y here if you wish to use the ICS IDE
 	  interface card.  This is not required for ICS partition support.
@@ -859,14 +870,14 @@
 
 config BLK_DEV_IDE_RAPIDE
 	tristate "RapIDE interface support"
-	depends on BLK_DEV_IDE!=n && ARM && ARCH_ACORN
+	depends on ARM && ARCH_ACORN
 	help
 	  Say Y here if you want to support the Yellowstone RapIDE controller
 	  manufactured for use with Acorn computers.
 
 config BLK_DEV_GAYLE
 	bool "Amiga Gayle IDE interface support"
-	depends on BLK_DEV_IDE && AMIGA
+	depends on AMIGA
 	help
 	  This is the IDE driver for the builtin IDE interface on some Amiga
 	  models. It supports both the `A1200 style' (used in A600 and A1200)
@@ -893,7 +904,7 @@
 
 config BLK_DEV_BUDDHA
 	bool "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)"
-	depends on BLK_DEV_IDE && ZORRO && EXPERIMENTAL
+	depends on ZORRO && EXPERIMENTAL
 	help
 	  This is the IDE driver for the IDE interfaces on the Buddha, 
 	  Catweasel and X-Surf expansion boards.  It supports up to two interfaces 
@@ -905,7 +916,7 @@
 
 config BLK_DEV_FALCON_IDE
 	bool "Falcon IDE interface support"
-	depends on BLK_DEV_IDE && ATARI
+	depends on ATARI
 	help
 	  This is the IDE driver for the builtin IDE interface on the Atari
 	  Falcon. Say Y if you have a Falcon and want to use IDE devices (hard
@@ -914,7 +925,7 @@
 
 config BLK_DEV_MAC_IDE
 	bool "Macintosh Quadra/Powerbook IDE interface support"
-	depends on BLK_DEV_IDE && MAC
+	depends on MAC
 	help
 	  This is the IDE driver for the builtin IDE interface on some m68k
 	  Macintosh models. It supports both the `Quadra style' (used in
@@ -927,7 +938,7 @@
 
 config BLK_DEV_Q40IDE
 	bool "Q40/Q60 IDE interface support"
-	depends on BLK_DEV_IDE && Q40
+	depends on Q40
 	help
 	  Enable the on-board IDE controller in the Q40/Q60.  This should
 	  normally be on; disable it only if you are running a custom hard
@@ -935,7 +946,7 @@
 
 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
-	depends on BLK_DEV_IDE && 8xx
+	depends on 8xx
 	help
 	  This option provides support for IDE on Motorola MPC8xx Systems.
 	  Please see 'Type of MPC8xx IDE interface' for details.
@@ -975,7 +986,7 @@
 # no isa -> no vlb
 config IDE_CHIPSETS
 	bool "Other IDE chipset support"
-	depends on BLK_DEV_IDE && ISA
+	depends on ISA
 	---help---
 	  Say Y here if you want to include enhanced support for various IDE
 	  interface chipsets used on motherboards and add-on cards. You can
@@ -990,7 +1001,7 @@
 	  People with SCSI-only systems can say N here.
 
 comment "Note: most of these also require special kernel boot parameters"
-	depends on BLK_DEV_IDE && IDE_CHIPSETS
+	depends on IDE_CHIPSETS
 
 config BLK_DEV_4DRIVES
 	bool "Generic 4 drives/port support"
@@ -1004,7 +1015,7 @@
 
 config BLK_DEV_ALI14XX
 	tristate "ALI M14xx support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=ali14xx" kernel
 	  boot parameter.  It enables support for the secondary IDE interface
@@ -1015,7 +1026,7 @@
 
 config BLK_DEV_DTC2278
 	tristate "DTC-2278 support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=dtc2278" kernel
 	  boot parameter. It enables support for the secondary IDE interface
@@ -1025,7 +1036,7 @@
 
 config BLK_DEV_HT6560B
 	tristate "Holtek HT6560B support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=ht6560b" kernel
 	  boot parameter. It enables support for the secondary IDE interface
@@ -1048,7 +1059,7 @@
 
 config BLK_DEV_QD65XX
 	tristate "QDI QD65xx support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=qd65xx" kernel
 	  boot parameter.  It permits faster I/O speeds to be set.  See the
@@ -1057,7 +1068,7 @@
 
 config BLK_DEV_UMC8672
 	tristate "UMC-8672 support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=umc8672" kernel
 	  boot parameter. It enables support for the secondary IDE interface
@@ -1065,25 +1076,6 @@
 	  See the files <file:Documentation/ide.txt> and
 	  <file:drivers/ide/legacy/umc8672.c> for more info.
 
-config BLK_DEV_HD_ONLY
-	bool "Old hard disk (MFM/RLL/IDE) driver"
-	depends on BLK_DEV_IDE=n
-	---help---
-	  There are two drivers for MFM/RLL/IDE hard disks. Most people use
-	  the newer enhanced driver, but this old one is still around for two
-	  reasons. Some older systems have strange timing problems and seem to
-	  work only with the old driver (which itself does not work with some
-	  newer systems). The other reason is that the old driver is smaller,
-	  since it lacks the enhanced functionality of the new one. This makes
-	  it a good choice for systems with very tight memory restrictions, or
-	  for systems with only older MFM/RLL/ESDI drives. Choosing the old
-	  driver can save 13 KB or so of kernel memory.
-
-	  If you are unsure, then just choose the Enhanced IDE/MFM/RLL driver
-	  instead of this one. For more detailed information, read the
-	  Disk-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
 config IDEDMA_AUTO
 	bool
 	depends on IDEDMA_PCI_AUTO || BLK_DEV_IDEDMA_PMAC_AUTO || IDEDMA_ICS_AUTO
@@ -1141,6 +1133,6 @@
 	depends on BLK_DEV_4DRIVES || BLK_DEV_ALI14XX || BLK_DEV_DTC2278 || BLK_DEV_HT6560B || BLK_DEV_PDC4030 || BLK_DEV_QD65XX || BLK_DEV_UMC8672 || BLK_DEV_AEC62XX=y || BLK_DEV_ALI15X3=y || BLK_DEV_AMD74XX=y || BLK_DEV_CMD640 || BLK_DEV_CMD64X=y || BLK_DEV_CS5530=y || BLK_DEV_CY82C693=y || BLK_DEV_HPT34X=y || BLK_DEV_HPT366=y || BLK_DEV_IDE_PMAC || BLK_DEV_IT8172 || BLK_DEV_MPC8xx_IDE || BLK_DEV_NFORCE=y || BLK_DEV_OPTI621=y || BLK_DEV_PDC202XX || BLK_DEV_PIIX=y || BLK_DEV_SVWKS=y || BLK_DEV_SIIMAGE=y || BLK_DEV_SIS5513=y || BLK_DEV_SL82C105=y || BLK_DEV_SLC90E66=y || BLK_DEV_VIA82CXXX=y
 	default y
 
-endmenu
+endif
 
 endmenu
