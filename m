Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267811AbTBROCj>; Tue, 18 Feb 2003 09:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267817AbTBROCj>; Tue, 18 Feb 2003 09:02:39 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:27289 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267811AbTBROCQ>; Tue, 18 Feb 2003 09:02:16 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.62]: 2/3: Make SCSI low-level drivers also a seperate, complete selectable submenu
Date: Tue, 18 Feb 2003 14:02:10 +0100
User-Agent: KMail/1.4.3
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Message-Id: <200302181354.02278.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_MJ9IE51A6B8IVTDUDL33"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_MJ9IE51A6B8IVTDUDL33
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

so you can disable all SCSI lowlevel drivers at once.
--------------Boundary-00=_MJ9IE51A6B8IVTDUDL33
Content-Type: text/x-diff;
  charset="us-ascii";
  name="scsi-menu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="scsi-menu.patch"

diff -Naurp linux-2.5.62-vanilla/drivers/scsi/Kconfig linux-2.5.62-mcp1/drivers/scsi/Kconfig
--- linux-2.5.62-vanilla/drivers/scsi/Kconfig	2003-02-10 19:38:53.000000000 +0100
+++ linux-2.5.62-mcp1/drivers/scsi/Kconfig	2003-02-18 13:45:28.000000000 +0100
@@ -173,27 +173,34 @@ config SCSI_LOGGING
 menu "SCSI low-level drivers"
 	depends on SCSI!=n
 
+config SCSI_LOWLEVEL
+	bool "SCSI low-level drivers"
+	---help---
+	  This enables a list of SCSI low-level drivers.
+
+	  If unsure, say N.
+
 config SGIWD93_SCSI
 	tristate "SGI WD93C93 SCSI Driver"
-	depends on SGI_IP22 && SCSI
+	depends on SGI_IP22 && SCSI && SCSI_LOWLEVEL
   	help
 	  If you have a Western Digital WD93 SCSI controller on
 	  an SGI MIPS system, say Y.  Otherwise, say N.
 
 config SCSI_DECNCR
 	tristate "DEC NCR53C94 Scsi Driver"
-	depends on DECSTATION && TC && SCSI
+	depends on DECSTATION && TC && SCSI && SCSI_LOWLEVEL
 	help
 	  Say Y here to support the NCR53C94 SCSI controller chips on IOASIC
 	  based TURBOchannel DECstations and TURBOchannel PMAZ-A cards.
 
 config SCSI_DECSII
 	tristate "DEC SII Scsi Driver"
-	depends on DECSTATION && SCSI
+	depends on DECSTATION && SCSI && SCSI_LOWLEVEL
 
 config BLK_DEV_3W_XXXX_RAID
 	tristate "3ware Hardware ATA-RAID support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	help
 	  3ware is the only hardware ATA-Raid product in Linux to date.
 	  This card is 2,4, or 8 channel master mode support only.
@@ -206,7 +213,7 @@ config BLK_DEV_3W_XXXX_RAID
 
 config SCSI_7000FASST
 	tristate "7000FASST SCSI support"
-	depends on SCSI && ISA
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	help
 	  This driver supports the Western Digital 7000 SCSI host adapter
 	  family.  Some information is in the source:
@@ -219,7 +226,7 @@ config SCSI_7000FASST
 
 config SCSI_ACARD
 	tristate "ACARD SCSI support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	help
 	  This driver supports the ACARD 870U/W SCSI host adapter.
 
@@ -230,7 +237,7 @@ config SCSI_ACARD
 
 config SCSI_AHA152X
 	tristate "Adaptec AHA152X/2825 support"
-	depends on ISA && SCSI
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is a driver for the AHA-1510, AHA-1520, AHA-1522, and AHA-2825
 	  SCSI host adapters. It also works for the AVA-1505, but the IRQ etc.
@@ -247,7 +254,7 @@ config SCSI_AHA152X
 
 config SCSI_AHA1542
 	tristate "Adaptec AHA1542 support"
-	depends on ISA && SCSI
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for a SCSI host adapter.  It is explained in section
 	  3.4 of the SCSI-HOWTO, available from
@@ -263,7 +270,7 @@ config SCSI_AHA1542
 
 config SCSI_AHA1740
 	tristate "Adaptec AHA1740 support"
-	depends on EISA && SCSI
+	depends on EISA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for a SCSI host adapter.  It is explained in section
 	  3.5 of the SCSI-HOWTO, available from
@@ -278,12 +285,13 @@ config SCSI_AHA1740
 
 config SCSI_AACRAID
 	tristate "Adaptec AACRAID support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SCSI && PCI
+	depends on EXPERIMENTAL && PCI && SCSI && SCSI_LOWLEVEL
 
 source "drivers/scsi/aic7xxx/Kconfig.aic7xxx"
 
 config SCSI_AIC7XXX_OLD
 	tristate "Adaptec AIC7xxx support (old driver)"
+	depends on SCSI && SCSI_LOWLEVEL
 	help
 	  WARNING This driver is an older aic7xxx driver and is no longer
 	  under active development.  Adaptec, Inc. is writing a new driver to
@@ -328,7 +336,7 @@ source "drivers/scsi/aic7xxx/Kconfig.aic
 # All the I2O code and drivers do not seem to be 64bit safe.
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on !X86_64 && SCSI
+	depends on !X86_64 && SCSI && SCSI_LOWLEVEL
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
@@ -342,7 +350,7 @@ config SCSI_DPT_I2O
 
 config SCSI_ADVANSYS
 	tristate "AdvanSys SCSI support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	help
 	  This is a driver for all SCSI host adapters manufactured by
 	  AdvanSys. It is documented in the kernel source in
@@ -356,7 +364,7 @@ config SCSI_ADVANSYS
 
 config SCSI_IN2000
 	tristate "Always IN2000 SCSI support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for an ISA bus SCSI host adapter.  You'll find more
 	  information in <file:Documentation/scsi/in2000.txt>. If it doesn't work
@@ -371,7 +379,7 @@ config SCSI_IN2000
 # does not use pci dma and seems to be isa/onboard only for old machines
 config SCSI_AM53C974
 	tristate "AM53/79C974 PCI SCSI support"
-	depends on !X86_64 && SCSI && PCI
+	depends on !X86_64 && PCI && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for the AM53/79C974 SCSI host adapters.  Please read
 	  <file:Documentation/scsi/AM53C974.txt> for details.  Also, the
@@ -389,7 +397,7 @@ config SCSI_AM53C974
 
 config SCSI_MEGARAID
 	tristate "AMI MegaRAID support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	help
 	  This driver supports the AMI MegaRAID 418, 428, 438, 466, 762, 490
 	  and 467 SCSI host adapters.
@@ -401,7 +409,7 @@ config SCSI_MEGARAID
 
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for BusLogic MultiMaster and FlashPoint SCSI Host
 	  Adapters. Consult the SCSI-HOWTO, available from
@@ -419,7 +427,7 @@ config SCSI_BUSLOGIC
 
 config SCSI_OMIT_FLASHPOINT
 	bool "Omit FlashPoint support"
-	depends on SCSI_BUSLOGIC
+	depends on SCSI_BUSLOGIC && SCSI_LOWLEVEL
 	help
 	  This option allows you to omit the FlashPoint support from the
 	  BusLogic SCSI driver. The FlashPoint SCCB Manager code is
@@ -428,14 +436,14 @@ config SCSI_OMIT_FLASHPOINT
 
 config SCSI_CPQFCTS
 	tristate "Compaq Fibre Channel 64-bit/66Mhz HBA support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	help
 	  Say Y here to compile in support for the Compaq StorageWorks Fibre
 	  Channel 64-bit/66Mhz Host Bus Adapter.
 
 config SCSI_DMX3191D
 	tristate "DMX3191D SCSI support"
-	depends on SCSI && PCI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for Domex DMX3191D SCSI Host Adapters.
 
@@ -446,7 +454,7 @@ config SCSI_DMX3191D
 
 config SCSI_DTC3280
 	tristate "DTC3180/3280 SCSI support"
-	depends on SCSI && ISA
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for DTC 3180/3280 SCSI Host Adapters.  Please read
 	  the SCSI-HOWTO, available from
@@ -460,7 +468,7 @@ config SCSI_DTC3280
 
 config SCSI_EATA
 	tristate "EATA ISA/EISA/PCI (DPT and generic EATA/DMA-compliant boards) support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	---help---
 	  This driver supports all EATA/DMA-compliant SCSI host adapters.  DPT
 	  ISA and all EISA I/O addresses are probed looking for the "EATA"
@@ -514,7 +522,7 @@ config SCSI_EATA_MAX_TAGS
 
 config SCSI_EATA_DMA
 	tristate "EATA-DMA [Obsolete] (DPT, NEC, AT&T, SNI, AST, Olivetti, Alphatronix) support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for the EATA-DMA protocol compliant SCSI Host
 	  Adapters like the SmartCache III/IV, SmartRAID controller families
@@ -532,7 +540,7 @@ config SCSI_EATA_DMA
 
 config SCSI_EATA_PIO
 	tristate "EATA-PIO (old DPT PM2001, PM2012A) support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	---help---
 	  This driver supports all EATA-PIO protocol compliant SCSI Host
 	  Adapters like the DPT PM2001 and the PM2012A.  EATA-DMA compliant
@@ -548,7 +556,7 @@ config SCSI_EATA_PIO
 
 config SCSI_FUTURE_DOMAIN
 	tristate "Future Domain 16xx SCSI/AHA-2920A support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for Future Domain's 16-bit SCSI host adapters
 	  (TMC-1660/1680, TMC-1650/1670, TMC-3260, TMC-1610M/MER/MEX) and
@@ -569,7 +577,7 @@ config SCSI_FUTURE_DOMAIN
 
 config SCSI_FD_MCS
 	tristate "Future Domain MCS-600/700 SCSI support"
-	depends on MCA && SCSI
+	depends on MCA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for Future Domain MCS 600/700 MCA SCSI adapters.
 	  Some PS/2 computers are equipped with IBM Fast SCSI Adapter/A which
@@ -584,7 +592,7 @@ config SCSI_FD_MCS
 
 config SCSI_GDTH
 	tristate "Intel/ICP (former GDT SCSI Disk Array) RAID Controller support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	---help---
 	  Formerly called GDT SCSI Disk Array Controller Support.
 
@@ -600,7 +608,7 @@ config SCSI_GDTH
 
 config SCSI_GENERIC_NCR5380
 	tristate "Generic NCR5380/53c400 SCSI PIO support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is a driver for the old NCR 53c80 series of SCSI controllers
 	  on boards using PIO. Most boards such as the Trantor T130 fit this
@@ -621,7 +629,7 @@ config SCSI_GENERIC_NCR5380
 
 config SCSI_GENERIC_NCR5380_MMIO
 	tristate "Generic NCR5380/53c400 SCSI MMIO support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is a driver for the old NCR 53c80 series of SCSI controllers
 	  on boards using memory mapped I/O. 
@@ -637,7 +645,7 @@ config SCSI_GENERIC_NCR5380_MMIO
 
 config SCSI_GENERIC_NCR53C400
 	bool "Enable NCR53c400 extensions"
-	depends on SCSI_GENERIC_NCR5380
+	depends on SCSI_GENERIC_NCR5380 && SCSI_LOWLEVEL
 	help
 	  This enables certain optimizations for the NCR53c400 SCSI cards.
 	  You might as well try it out.  Note that this driver will only probe
@@ -648,7 +656,7 @@ config SCSI_GENERIC_NCR53C400
 
 config SCSI_IBMMCA
 	tristate "IBMMCA SCSI support"
-	depends on MCA && SCSI
+	depends on MCA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for the IBM SCSI adapter found in many of the PS/2
 	  series computers.  These machines have an MCA bus, so you need to
@@ -720,7 +728,7 @@ config IBMMCA_SCSI_DEV_RESET
 
 config SCSI_IPS
 	tristate "IBM ServeRAID support"
-	depends on X86 && SCSI && PCI
+	depends on X86 && PCI && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for the IBM ServeRAID hardware RAID controllers.
 	  See <http://www.developer.ibm.com/welcome/netfinity/serveraid.html>
@@ -736,7 +744,7 @@ config SCSI_IPS
 
 config SCSI_INITIO
 	tristate "Initio 9100U(W) support"
-	depends on SCSI && PCI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for the Initio 91XXU(W) SCSI host adapter.  Please
 	  read the SCSI-HOWTO, available from
@@ -749,7 +757,7 @@ config SCSI_INITIO
 
 config SCSI_INIA100
 	tristate "Initio INI-A100U2W support"
-	depends on SCSI && PCI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for the Initio INI-A100U2W SCSI host adapter.
 	  Please read the SCSI-HOWTO, available from
@@ -762,7 +770,7 @@ config SCSI_INIA100
 
 config SCSI_PPA
 	tristate "IOMEGA parallel port (ppa - older drives)"
-	depends on SCSI && PARPORT
+	depends on SCSI && PARPORT && SCSI_LOWLEVEL
 	---help---
 	  This driver supports older versions of IOMEGA's parallel port ZIP
 	  drive (a 100 MB removable media device).
@@ -791,7 +799,7 @@ config SCSI_PPA
 
 config SCSI_IMM
 	tristate "IOMEGA parallel port (imm - newer drives)"
-	depends on SCSI && PARPORT
+	depends on SCSI && PARPORT && SCSI_LOWLEVEL
 	---help---
 	  This driver supports newer versions of IOMEGA's parallel port ZIP
 	  drive (a 100 MB removable media device).
@@ -820,7 +828,7 @@ config SCSI_IMM
 
 config SCSI_IZIP_EPP16
 	bool "ppa/imm option - Use slow (but safe) EPP-16"
-	depends on PARPORT && (SCSI_PPA || SCSI_IMM)
+	depends on PARPORT && (SCSI_PPA || SCSI_IMM) && SCSI_LOWLEVEL
 	---help---
 	  EPP (Enhanced Parallel Port) is a standard for parallel ports which
 	  allows them to act as expansion buses that can handle up to 64
@@ -835,7 +843,7 @@ config SCSI_IZIP_EPP16
 
 config SCSI_IZIP_SLOW_CTR
 	bool "ppa/imm option - Assume slow parport control register"
-	depends on PARPORT && (SCSI_PPA || SCSI_IMM)
+	depends on PARPORT && (SCSI_PPA || SCSI_IMM) && SCSI_LOWLEVEL
 	help
 	  Some parallel ports are known to have excessive delays between
 	  changing the parallel port control register and good data being
@@ -849,7 +857,7 @@ config SCSI_IZIP_SLOW_CTR
 
 config SCSI_NCR53C406A
 	tristate "NCR53c406a SCSI support"
-	depends on SCSI && ISA
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for the NCR53c406a SCSI host adapter.  For user
 	  configurable parameters, check out <file:drivers/scsi/NCR53c406a.c>
@@ -863,7 +871,7 @@ config SCSI_NCR53C406A
 
 config SCSI_NCR_D700
 	tristate "NCR Dual 700 MCA SCSI support"
-	depends on MCA && SCSI
+	depends on MCA && SCSI && SCSI_LOWLEVEL
 	help
 	  This is a driver for the MicroChannel Dual 700 card produced by
 	  NCR and commonly used in 345x/35xx/4100 class machines.  It always
@@ -879,7 +887,7 @@ config 53C700_IO_MAPPED
 
 config SCSI_LASI700
 	tristate "HP LASI SCSI support for 53c700/710"
-	depends on PARISC && SCSI
+	depends on PARISC && SCSI && SCSI_LOWLEVEL
 	help
 	  This is a driver for the lasi baseboard in some parisc machines
 	  which is based on the 53c700 chip.  Will also support LASI subsystems
@@ -899,7 +907,7 @@ config 53C700_LE_ON_BE
 
 config SCSI_NCR53C7xx
 	tristate "NCR53c7,8xx SCSI support"
-	depends on SCSI && PCI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is a driver for the 53c7 and 8xx NCR family of SCSI
 	  controllers, not to be confused with the NCR 5380 controllers.  It
@@ -953,7 +961,7 @@ config SCSI_NCR53C7xx_DISCONNECT
 
 config SCSI_SYM53C8XX_2
 	tristate "SYM53C8XX Version 2 SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This driver supports the whole NCR53C8XX/SYM53C8XX family of 
 	  PCI-SCSI controllers. It also supports the subset of LSI53C10XX 
@@ -969,7 +977,7 @@ config SCSI_SYM53C8XX_2
 
 config SCSI_ZALON
 	tristate "Zalon SCSI support"
-	depends on GSC && SCSI
+	depends on GSC && SCSI && SCSI_LOWLEVEL
 	help
 	  The Zalon is a GSC/HSC bus interface chip that sits between the
 	  PA-RISC processor and the NCR 53c720 SCSI controller on C100,
@@ -979,7 +987,7 @@ config SCSI_ZALON
 
 config SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
 	int "DMA addressing mode"
-	depends on SCSI_SYM53C8XX_2
+	depends on SCSI_SYM53C8XX_2 && SCSI_LOWLEVEL
 	default "1"
 	---help---
 	  This option only applies to PCI-SCSI chip that are PCI DAC capable 
@@ -1006,7 +1014,7 @@ config SCSI_SYM53C8XX_DMA_ADDRESSING_MOD
 
 config SCSI_SYM53C8XX_DEFAULT_TAGS
 	int "default tagged command queue depth"
-	depends on SCSI_SYM53C8XX_2
+	depends on SCSI_SYM53C8XX_2 && SCSI_LOWLEVEL
 	default "16"
 	help
 	  This is the default value of the command queue depth the driver will 
@@ -1016,7 +1024,7 @@ config SCSI_SYM53C8XX_DEFAULT_TAGS
 
 config SCSI_SYM53C8XX_MAX_TAGS
 	int "maximum number of queued commands"
-	depends on SCSI_SYM53C8XX_2
+	depends on SCSI_SYM53C8XX_2 && SCSI_LOWLEVEL
 	default "64"
 	help
 	  This option allows you to specify the maximum number of commands
@@ -1026,14 +1034,14 @@ config SCSI_SYM53C8XX_MAX_TAGS
 
 config SCSI_SYM53C8XX_IOMAPPED
 	bool "use normal IO"
-	depends on SCSI_SYM53C8XX_2
+	depends on SCSI_SYM53C8XX_2 && SCSI_LOWLEVEL
 	help
 	  If you say Y here, the driver will preferently use normal IO rather than 
 	  memory mapped IO.
 
 config SCSI_NCR53C8XX
 	tristate "NCR53C8XX SCSI support"
-	depends on PCI && SCSI_SYM53C8XX_2!=y && SCSI
+	depends on PCI && SCSI_SYM53C8XX_2!=y && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is the BSD ncr driver adapted to Linux for the NCR53C8XX family
 	  of PCI-SCSI controllers.  This driver supports parity checking,
@@ -1054,7 +1062,7 @@ config SCSI_NCR53C8XX
 
 config SCSI_SYM53C8XX
 	tristate "SYM53C8XX SCSI support"
-	depends on PCI && SCSI_SYM53C8XX_2!=y && SCSI
+	depends on PCI && SCSI_SYM53C8XX_2!=y && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This driver supports all the features of recent 53C8XX chips (used
 	  in PCI SCSI controllers), notably the hardware phase mismatch
@@ -1081,7 +1089,7 @@ config SCSI_SYM53C8XX
 
 config SCSI_NCR53C8XX_DEFAULT_TAGS
 	int "default tagged command queue depth"
-	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON)
+	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON) && SCSI_LOWLEVEL
 	default "8"
 	---help---
 	  "Tagged command queuing" is a feature of SCSI-2 which improves
@@ -1107,7 +1115,7 @@ config SCSI_NCR53C8XX_DEFAULT_TAGS
 
 config SCSI_NCR53C8XX_MAX_TAGS
 	int "maximum number of queued commands"
-	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON)
+	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON) && SCSI_LOWLEVEL
 	default "32"
 	---help---
 	  This option allows you to specify the maximum number of commands
@@ -1124,7 +1132,7 @@ config SCSI_NCR53C8XX_MAX_TAGS
 
 config SCSI_NCR53C8XX_SYNC
 	int "synchronous transfers frequency in MHz"
-	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON)
+	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON) && SCSI_LOWLEVEL
 	default "20"
 	---help---
 	  The SCSI Parallel Interface-2 Standard defines 5 classes of transfer
@@ -1158,7 +1166,7 @@ config SCSI_NCR53C8XX_SYNC
 
 config SCSI_NCR53C8XX_PROFILE
 	bool "enable profiling"
-	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON)
+	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON) && SCSI_LOWLEVEL
 	help
 	  This option allows you to enable profiling information gathering.
 	  These statistics are not very accurate due to the low frequency
@@ -1169,7 +1177,7 @@ config SCSI_NCR53C8XX_PROFILE
 
 config SCSI_NCR53C8XX_IOMAPPED
 	bool "use normal IO"
-	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX) && !SCSI_ZALON
+	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX) && !SCSI_ZALON && SCSI_LOWLEVEL
 	help
 	  If you say Y here, the driver will use normal IO, as opposed to
 	  memory mapped IO. Memory mapped IO has less latency than normal IO
@@ -1182,7 +1190,7 @@ config SCSI_NCR53C8XX_IOMAPPED
 
 config SCSI_NCR53C8XX_PQS_PDS
 	bool "include support for the NCR PQS/PDS SCSI card"
-	depends on (SCSI_NCR53C8XX || SCSI_SYM53C8XX) && SCSI_SYM53C8XX
+	depends on (SCSI_NCR53C8XX || SCSI_SYM53C8XX) && SCSI_SYM53C8XX && SCSI_LOWLEVEL
 	help
 	  Say Y here if you have a special SCSI adapter produced by NCR
 	  corporation called a PCI Quad SCSI or PCI Dual SCSI. You do not need
@@ -1194,7 +1202,7 @@ config SCSI_NCR53C8XX_PQS_PDS
 
 config SCSI_NCR53C8XX_NO_DISCONNECT
 	bool "not allow targets to disconnect"
-	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON) && SCSI_NCR53C8XX_DEFAULT_TAGS=0
+	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON) && SCSI_NCR53C8XX_DEFAULT_TAGS=0 && SCSI_LOWLEVEL
 	help
 	  This option is only provided for safety if you suspect some SCSI
 	  device of yours to not support properly the target-disconnect
@@ -1204,7 +1212,7 @@ config SCSI_NCR53C8XX_NO_DISCONNECT
 
 config SCSI_NCR53C8XX_SYMBIOS_COMPAT
 	bool "assume boards are SYMBIOS compatible (EXPERIMENTAL)"
-	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON) && EXPERIMENTAL
+	depends on PCI && SCSI_SYM53C8XX_2!=y && (SCSI_NCR53C8XX || SCSI_SYM53C8XX || SCSI_ZALON) && EXPERIMENTAL && SCSI_LOWLEVEL && SCSI_LOWLEVEL
 	---help---
 	  This option allows you to enable some features depending on GPIO
 	  wiring. These General Purpose Input/Output pins can be used for
@@ -1224,7 +1232,7 @@ config SCSI_NCR53C8XX_SYMBIOS_COMPAT
 
 config SCSI_MCA_53C9X
 	tristate "NCR MCA 53C9x SCSI support"
-	depends on MCA && SCSI
+	depends on MCA && SCSI && SCSI_LOWLEVEL
 	help
 	  Some MicroChannel machines, notably the NCR 35xx line, use a SCSI
 	  controller based on the NCR 53C94.  This driver will allow use of
@@ -1237,7 +1245,7 @@ config SCSI_MCA_53C9X
 
 config SCSI_PAS16
 	tristate "PAS16 SCSI support"
-	depends on SCSI && ISA
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for a SCSI host adapter.  It is explained in section
 	  3.10 of the SCSI-HOWTO, available from
@@ -1252,7 +1260,7 @@ config SCSI_PAS16
 
 config SCSI_PCI2000
 	tristate "PCI2000 support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for the PCI2000I EIDE interface card which acts as a
 	  SCSI host adapter.  Please read the SCSI-HOWTO, available from
@@ -1265,7 +1273,7 @@ config SCSI_PCI2000
 
 config SCSI_PCI2220I
 	tristate "PCI2220i support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for the PCI2220i EIDE interface card which acts as a
 	  SCSI host adapter.  Please read the SCSI-HOWTO, available from
@@ -1278,7 +1286,7 @@ config SCSI_PCI2220I
 
 config SCSI_PSI240I
 	tristate "PSI240i support"
-	depends on SCSI && ISA
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for the PSI240i EIDE interface card which acts as a
 	  SCSI host adapter.  Please read the SCSI-HOWTO, available from
@@ -1291,7 +1299,7 @@ config SCSI_PSI240I
 
 config SCSI_QLOGIC_FAS
 	tristate "Qlogic FAS SCSI support"
-	depends on SCSI && ISA
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is a driver for the ISA, VLB, and PCMCIA versions of the Qlogic
 	  FastSCSI! cards as well as any other card based on the FASXX chip
@@ -1313,7 +1321,7 @@ config SCSI_QLOGIC_FAS
 
 config SCSI_QLOGIC_ISP
 	tristate "Qlogic ISP SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This driver works for all QLogic PCI SCSI host adapters (IQ-PCI,
 	  IQ-PCI-10, IQ_PCI-D) except for the PCI-basic card.  (This latter
@@ -1333,7 +1341,7 @@ config SCSI_QLOGIC_ISP
 
 config SCSI_QLOGIC_FC
 	tristate "Qlogic ISP FC SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	help
 	  This is a driver for the QLogic ISP2100 SCSI-FCP host adapter.
 
@@ -1352,7 +1360,7 @@ config SCSI_QLOGIC_FC_FIRMWARE
 
 config SCSI_QLOGIC_1280
 	tristate "Qlogic QLA 1280 SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	help
 	  Say Y if you have a QLogic ISP1x80/1x160 SCSI host adapter.
 
@@ -1363,7 +1371,7 @@ config SCSI_QLOGIC_1280
 
 config SCSI_SEAGATE
 	tristate "Seagate ST-02 and Future Domain TMC-8xx SCSI support"
-	depends on X86 && ISA && SCSI
+	depends on X86 && ISA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  These are 8-bit SCSI controllers; the ST-01 is also supported by
 	  this driver.  It is explained in section 3.9 of the SCSI-HOWTO,
@@ -1379,7 +1387,7 @@ config SCSI_SEAGATE
 # definitely looks note 64bit safe:
 config SCSI_SIM710
 	tristate "Simple 53c710 SCSI support (Compaq, NCR machines)"
-	depends on (EISA || MCA && !X86_64) && SCSI
+	depends on (EISA || MCA && !X86_64) && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This driver for NCR53c710 based SCSI host adapters.
 
@@ -1392,7 +1400,7 @@ config 53C700_IO_MAPPED
 
 config SCSI_SYM53C416
 	tristate "Symbios 53c416 SCSI support"
-	depends on SCSI && ISA
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for the sym53c416 SCSI host adapter, the SCSI
 	  adapter that comes with some HP scanners. This driver requires that
@@ -1413,7 +1421,7 @@ config SCSI_SYM53C416
 
 config SCSI_DC390T
 	tristate "Tekram DC390(T) and Am53/79C974 SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This driver supports PCI SCSI host adapters based on the Am53C974A
 	  chip, e.g. Tekram DC390(T), DawiControl 2974 and some onboard
@@ -1450,7 +1458,7 @@ config SCSI_DC390T_NOGENSUPP
 
 config SCSI_T128
 	tristate "Trantor T128/T128F/T228 SCSI support"
-	depends on SCSI && ISA
+	depends on ISA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for a SCSI host adapter. It is explained in section
 	  3.11 of the SCSI-HOWTO, available from
@@ -1467,7 +1475,7 @@ config SCSI_T128
 
 config SCSI_U14_34F
 	tristate "UltraStor 14F/34F support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for the UltraStor 14F and 34F SCSI-2 host adapters.
 	  The source at <file:drivers/scsi/u14-34f.c> contains some
@@ -1518,7 +1526,7 @@ config SCSI_U14_34F_MAX_TAGS
 
 config SCSI_ULTRASTOR
 	tristate "UltraStor SCSI support"
-	depends on X86 && ISA && SCSI
+	depends on X86 && ISA && SCSI && SCSI_LOWLEVEL
 	---help---
 	  This is support for the UltraStor 14F, 24F and 34F SCSI-2 host
 	  adapter family.  This driver is explained in section 3.12 of the
@@ -1537,7 +1545,7 @@ config SCSI_ULTRASTOR
 
 config SCSI_NSP32
 	tristate "Workbit NinjaSCSI-32Bi/UDE support"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	help
 	  This is support for the Workbit NinjaSCSI-32Bi/UDE PCI/Cardbus
 	  SCSI host adapter. Please read the SCSI-HOWTO, available from
@@ -1550,7 +1558,7 @@ config SCSI_NSP32
 
 config SCSI_DEBUG
 	tristate "SCSI debugging host simulator"
-	depends on SCSI
+	depends on SCSI && SCSI_LOWLEVEL
 	help
 	  This is a host adapter simulator that can simulate multiple hosts
 	  each with multiple dummy SCSI devices (disks). It defaults to one
@@ -1563,7 +1571,7 @@ config SCSI_DEBUG
 
 config SCSI_MESH
 	tristate "MESH (Power Mac internal SCSI) support"
-	depends on ALL_PPC && SCSI
+	depends on ALL_PPC && SCSI && SCSI_LOWLEVEL
 	help
 	  Many Power Macintoshes and clones have a MESH (Macintosh Enhanced
 	  SCSI Hardware) SCSI bus adaptor (the 7200 doesn't, but all of the
@@ -1594,7 +1602,7 @@ config SCSI_MESH_RESET_DELAY_MS
 
 config SCSI_MAC53C94
 	tristate "53C94 (Power Mac external SCSI) support"
-	depends on ALL_PPC && SCSI
+	depends on ALL_PPC && SCSI && SCSI_LOWLEVEL
 	help
 	  On Power Macintoshes (and clones) with two SCSI buses, the external
 	  SCSI bus is usually controlled by a 53C94 SCSI bus adaptor. Older
@@ -1618,7 +1626,7 @@ config JAZZ_ESP
 
 config A3000_SCSI
 	tristate "A3000 WD33C93A support"
-	depends on AMIGA && SCSI
+	depends on AMIGA && SCSI && SCSI_LOWLEVEL
 	help
 	  If you have an Amiga 3000 and have SCSI devices connected to the
 	  built-in SCSI controller, say Y. Otherwise, say N. This driver is
@@ -1635,7 +1643,7 @@ config A4000T_SCSI
 
 config A2091_SCSI
 	tristate "A2091/A590 WD33C93A support"
-	depends on ZORRO && SCSI
+	depends on ZORRO && SCSI && SCSI_LOWLEVEL
 	help
 	  If you have a Commodore A2091 SCSI controller, say Y. Otherwise,
 	  say N. This driver is also available as a module ( = code which can
@@ -1645,7 +1653,7 @@ config A2091_SCSI
 
 config GVP11_SCSI
 	tristate "GVP Series II WD33C93A support"
-	depends on ZORRO && SCSI
+	depends on ZORRO && SCSI && SCSI_LOWLEVEL
 	---help---
 	  If you have a Great Valley Products Series II SCSI controller,
 	  answer Y. Also say Y if you have a later model of GVP SCSI
@@ -1660,7 +1668,7 @@ config GVP11_SCSI
 
 config CYBERSTORM_SCSI
 	tristate "CyberStorm SCSI support"
-	depends on ZORRO && SCSI
+	depends on ZORRO && SCSI && SCSI_LOWLEVEL
 	help
 	  If you have an Amiga with an original (MkI) Phase5 Cyberstorm
 	  accelerator board and the optional Cyberstorm SCSI controller,
@@ -1668,7 +1676,7 @@ config CYBERSTORM_SCSI
 
 config CYBERSTORMII_SCSI
 	tristate "CyberStorm Mk II SCSI support"
-	depends on ZORRO && SCSI
+	depends on ZORRO && SCSI && SCSI_LOWLEVEL
 	help
 	  If you have an Amiga with a Phase5 Cyberstorm MkII accelerator board
 	  and the optional Cyberstorm SCSI controller, say Y. Otherwise,
@@ -1676,7 +1684,7 @@ config CYBERSTORMII_SCSI
 
 config BLZ2060_SCSI
 	tristate "Blizzard 2060 SCSI support"
-	depends on ZORRO && SCSI
+	depends on ZORRO && SCSI && SCSI_LOWLEVEL
 	help
 	  If you have an Amiga with a Phase5 Blizzard 2060 accelerator board
 	  and want to use the onboard SCSI controller, say Y. Otherwise,
@@ -1684,7 +1692,7 @@ config BLZ2060_SCSI
 
 config BLZ1230_SCSI
 	tristate "Blizzard 1230IV/1260 SCSI support"
-	depends on ZORRO && SCSI
+	depends on ZORRO && SCSI && SCSI_LOWLEVEL
 	help
 	  If you have an Amiga 1200 with a Phase5 Blizzard 1230IV or Blizzard
 	  1260 accelerator, and the optional SCSI module, say Y. Otherwise,
@@ -1692,7 +1700,7 @@ config BLZ1230_SCSI
 
 config FASTLANE_SCSI
 	tristate "Fastlane SCSI support"
-	depends on ZORRO && SCSI
+	depends on ZORRO && SCSI && SCSI_LOWLEVEL
 	help
 	  If you have the Phase5 Fastlane Z3 SCSI controller, or plan to use
 	  one in the near future, say Y to this question. Otherwise, say N.
@@ -1722,7 +1730,7 @@ config BLZ603EPLUS_SCSI
 
 config OKTAGON_SCSI
 	tristate "BSC Oktagon SCSI support (EXPERIMENTAL)"
-	depends on ZORRO && EXPERIMENTAL && SCSI
+	depends on ZORRO && EXPERIMENTAL && SCSI && SCSI_LOWLEVEL
 	help
 	  If you have the BSC Oktagon SCSI disk controller for the Amiga, say
 	  Y to this question.  If you're in doubt about whether you have one,
diff -Naurp linux-2.5.62-vanilla/drivers/scsi/aic7xxx/Kconfig.aic79xx linux-2.5.62-mcp1/drivers/scsi/aic7xxx/Kconfig.aic79xx
--- linux-2.5.62-vanilla/drivers/scsi/aic7xxx/Kconfig.aic79xx	2003-02-10 19:38:29.000000000 +0100
+++ linux-2.5.62-mcp1/drivers/scsi/aic7xxx/Kconfig.aic79xx	2003-02-18 13:45:28.000000000 +0100
@@ -4,7 +4,7 @@
 #
 config SCSI_AIC79XX
 	tristate "Adaptec AIC79xx U320 support"
-	depends on PCI
+	depends on PCI && SCSI_LOWLEVEL
 	help
 	This driver supports all of Adaptec's Ultra 320 PCI-X
 	based SCSI controllers.
diff -Naurp linux-2.5.62-vanilla/drivers/scsi/aic7xxx/Kconfig.aic7xxx linux-2.5.62-mcp1/drivers/scsi/aic7xxx/Kconfig.aic7xxx
--- linux-2.5.62-vanilla/drivers/scsi/aic7xxx/Kconfig.aic7xxx	2003-02-10 19:38:18.000000000 +0100
+++ linux-2.5.62-mcp1/drivers/scsi/aic7xxx/Kconfig.aic7xxx	2003-02-18 13:45:28.000000000 +0100
@@ -4,6 +4,7 @@
 #
 config SCSI_AIC7XXX
 	tristate "Adaptec AIC7xxx Fast -> U160 support (New Driver)"
+	depends on SCSI_LOWLEVEL
 	---help---
 	This driver supports all of Adaptec's Fast through Ultra 160 PCI
 	based SCSI controllers as well as the aic7770 based EISA and VLB

--------------Boundary-00=_MJ9IE51A6B8IVTDUDL33--


