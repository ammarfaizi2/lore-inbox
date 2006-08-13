Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWHMVDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWHMVDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWHMVD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:03:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6670 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751478AbWHMVBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:01:08 -0400
Date: Sun, 13 Aug 2006 23:01:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [-mm patch] cleanup drivers/ata/Kconfig
Message-ID: <20060813210106.GO3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
>  git-libata-all.patch
>...
>  git trees
>...

This patch contains the following cleanups:
- create a menu for ATA
- replace the dependencies on ATA with an "if ATA"
  as a side effect, this fixes a menu breakage due to SATA_INTEL_COMBINED
- fix a typo in the PATA_OPTIDMA prompt
- let ATA selet SCSI instead of depending on SCSI
  this should make it easier for users to enable ATA (similar to USB_STORAGE)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

One issue I noticed while creating this patch is that for the following 
options the dependency and the prompt don't agree whether the option
is EXPERIMENTAL:
- SATA_SX4
- PATA_AMD
- PATA_HPT3X3
- PATA_SC1200

 drivers/ata/Kconfig |  117 ++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 56 deletions(-)

--- linux-2.6.18-rc4-mm1/drivers/ata/Kconfig.old	2006-08-13 20:32:42.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/ata/Kconfig	2006-08-13 20:55:16.000000000 +0200
@@ -1,483 +1,488 @@
+menu "ATA device support"
 
 config ATA
 	tristate "ATA device support"
-	depends on SCSI
+	select SCSI
 	---help---
 	  If you want to use a ATA hard disk, ATA tape drive, ATA CD-ROM or
 	  any other ATA device under Linux, say Y and make sure that you know
 	  the name of your ATA host adapter (the card inside your computer
 	  that "speaks" the ATA protocol, also called ATA controller),
 	  because you will be asked for it.
 
+if ATA
+
 config SATA_AHCI
 	tristate "AHCI SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for AHCI Serial ATA.
 
 	  If unsure, say N.
 
 config SATA_SVW
 	tristate "ServerWorks Frodo / Apple K2 SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for Broadcom/Serverworks/Apple K2
 	  SATA support.
 
 	  If unsure, say N.
 
 config ATA_PIIX
 	tristate "Intel PIIX/ICH SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for ICH5/6/7/8 Serial ATA.
 	  If PATA support was enabled previously, this enables
 	  support for select Intel PIIX/ICH PATA host controllers.
 
 	  If unsure, say N.
 
 config SATA_MV
 	tristate "Marvell SATA support (HIGHLY EXPERIMENTAL)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] chips.
 
 	  If unsure, say N.
 
 config SATA_NV
 	tristate "NVIDIA SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for NVIDIA Serial ATA.
 
 	  If unsure, say N.
 
 config PDC_ADMA
 	tristate "Pacific Digital ADMA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for Pacific Digital ADMA controllers
 
 	  If unsure, say N.
 
 config SATA_QSTOR
 	tristate "Pacific Digital SATA QStor support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for Pacific Digital Serial ATA QStor.
 
 	  If unsure, say N.
 
 config SATA_PROMISE
 	tristate "Promise SATA TX2/TX4 support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for Promise Serial ATA TX2/TX4.
 
 	  If unsure, say N.
 
 config SATA_SX4
 	tristate "Promise SATA SX4 support"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for Promise Serial ATA SX4.
 
 	  If unsure, say N.
 
 config SATA_SIL
 	tristate "Silicon Image SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for Silicon Image Serial ATA.
 
 	  If unsure, say N.
 
 config SATA_SIL24
 	tristate "Silicon Image 3124/3132 SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for Silicon Image 3124/3132 Serial ATA.
 
 	  If unsure, say N.
 
 config SATA_SIS
 	tristate "SiS 964/180 SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for SiS Serial ATA 964/180.
 
 	  If unsure, say N.
 
 config SATA_ULI
 	tristate "ULi Electronics SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for ULi Electronics SATA.
 
 	  If unsure, say N.
 
 config SATA_VIA
 	tristate "VIA SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for VIA Serial ATA.
 
 	  If unsure, say N.
 
 config SATA_VITESSE
 	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for Vitesse VSC7174 and Intel 31244 Serial ATA.
 
 	  If unsure, say N.
 
 config SATA_INTEL_COMBINED
 	bool
 	depends on IDE=y && !BLK_DEV_IDE_SATA && (SATA_AHCI || ATA_PIIX)
 	default y
 
 config PATA_ALI
 	tristate "ALi PATA support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the ALi ATA interfaces
 	  found on the many ALi chipsets.
 
 	  If unsure, say N.
 
 config PATA_AMD
 	tristate "AMD/NVidia PATA support (Experimental)"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for the AMD and NVidia PATA
 	  interfaces found on the chipsets for Athlon/Athlon64.
 
 	  If unsure, say N.
 
 config PATA_ARTOP
 	tristate "ARTOP 6210/6260 PATA support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for ARTOP PATA controllers.
 
 	  If unsure, say N.
 
 config PATA_ATIIXP
 	tristate "ATI PATA support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the ATI ATA interfaces
 	  found on the many ATI chipsets.
 
 	  If unsure, say N.
 
 config PATA_CMD64X
 	tristate "CMD64x PATA support (Very Experimental)"
-	depends on ATA && PCI&& EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the CMD64x series chips
 	  except for the CMD640.
 
 	  If unsure, say N.
 
 config PATA_CS5520
 	tristate "CS5510/5520 PATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for the Cyrix 5510/5520
 	  companion chip used with the MediaGX/Geode processor family.
 
 	  If unsure, say N.
 
 config PATA_CS5530
 	tristate "CS5530 PATA support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Cyrix/NatSemi/AMD CS5530
 	  companion chip used with the MediaGX/Geode processor family.
 
 	  If unsure, say N.
 
 config PATA_CS5535
 	tristate "CS5535 PATA support (Experimental)"
-	depends on ATA && PCI && X86 && !X86_64 && EXPERIMENTAL
+	depends on PCI && X86 && !X86_64 && EXPERIMENTAL
 	help
 	  This option enables support for the NatSemi/AMD CS5535
 	  companion chip used with the Geode processor family.
 
 	  If unsure, say N.
 
 config PATA_CYPRESS
 	tristate "Cypress CY82C693 PATA support (Very Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Cypress/Contaq CY82C693
 	  chipset found in some Alpha systems
 
 	  If unsure, say N.
 
 config PATA_EFAR
 	tristate "EFAR SLC90E66 support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for the EFAR SLC90E66
 	  IDE controller found on some older machines.
 
 	  If unsure, say N.
 
 config ATA_GENERIC
 	tristate "Generic ATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for generic BIOS configured
 	  ATA controllers via the new ATA layer
 
 	  If unsure, say N.
 
 config PATA_HPT366
 	tristate "HPT 366/368 PATA support (Very Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the HPT 366 and 368
 	  PATA controllers via the new ATA layer.
 
 	  If unsure, say N.
 
 config PATA_HPT37X
 	tristate "HPT 370/370A/371/372/374/302 PATA support (Very Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the majority of the later HPT
 	  PATA controllers via the new ATA layer.
 
 	  If unsure, say N.
 
 config PATA_HPT3X2N
 	tristate "HPT 372N/302N PATA support (Very Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the N variant HPT PATA
 	  controllers via the new ATA layer
 
 	  If unsure, say N.
 
 config PATA_HPT3X3
 	tristate "HPT 343/363 PATA support (Experimental)"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for the HPT 343/363
 	  PATA controllers via the new ATA layer
 
 	  If unsure, say N.
 
 config PATA_ISAPNP
 	tristate "ISA Plug and Play PATA support (Very Experimental)"
-	depends on ATA && EXPERIMENTAL && ISAPNP
+	depends on EXPERIMENTAL && ISAPNP
 	help
 	  This option enables support for ISA plug & play ATA
 	  controllers such as those found on old soundcards.
 
 	  If unsure, say N.
 
 config PATA_IT8172
 	tristate "IT8172 PATA support (Very Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the ITE 8172 PATA controller
 	  via the new ATA layer.
 
 	  If unsure, say N.
 
 config PATA_IT821X
 	tristate "IT821x PATA support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the ITE 8211 and 8212
 	  PATA controllers via the new ATA layer, including RAID
 	  mode.
 
 	  If unsure, say N.
 
 config ATA_JMICRON
 	tristate "JMicron non-AHCI support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for Jmicron ATA controllers
 	  ports running in non-AHCI mode. Where possible you should
 	  set the configuration for AHCI to get better performance
 
 config PATA_LEGACY
 	tristate "Legacy ISA PATA support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for ISA/VLB bus legacy PATA
 	  ports and allows them to be accessed via the new ATA layer.
 
 	  If unsure, say N.
 
 config PATA_TRIFLEX
 	tristate "Compaq Triflex PATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  Enable support for the Compaq 'Triflex' IDE controller as found
 	  on many Compaq Pentium-Pro systems, via the new ATA layer.
 
 	  If unsure, say N.
 
 config PATA_MPIIX
 	tristate "Intel PATA MPIIX support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for MPIIX PATA support.
 
 	  If unsure, say N.
 
 config PATA_OLDPIIX
 	tristate "Intel PATA old PIIX support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for old(?) PIIX PATA support.
 
 	  If unsure, say N.
 
 config PATA_NETCELL
 	tristate "NETCELL Revolution RAID support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for the Netcell Revolution RAID
 	  PATA controller.
 
 	  If unsure, say N.
 
 config PATA_NS87410
 	tristate "Nat Semi NS87410 PATA support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the National Semiconductor
 	  NS87410 PCI-IDE controller.
 
 	  If unsure, say N.
 
 config PATA_OPTI
 	tristate "OPTI621/6215 PATA support (Very Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables full PIO support for the early Opti ATA
 	  controllers found on some old motherboards.
 
 	  If unsure, say N.
 
 config PATA_OPTIDMA
-	tristate "OPTI FireStar PATA support (Veyr Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	tristate "OPTI FireStar PATA support (Very Experimental)"
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables DMA/PIO support for the later OPTi
 	  controllers found on some old motherboards and in some
 	  latops
 
 	  If unsure, say N.
 
 config PATA_PCMCIA
 	tristate "PCMCIA PATA support"
-	depends on ATA && PCMCIA
+	depends on PCMCIA
 	help
 	  This option enables support for PCMCIA ATA interfaces, including
 	  compact flash card adapters via the new ATA layer.
 
 	  If unsure, say N.
 
 config PATA_PDC_OLD
 	tristate "Older Promise PATA controller support (Very Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Promise 20246, 20262, 20263,
 	  20265 and 20267 adapters.
 
 	  If unsure, say N.
 
 config PATA_QDI
 	tristate "QDI VLB PATA support"
-	depends on ATA
 	help
 	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
 
 config PATA_RADISYS
 	tristate "RADISYS 82600 PATA support (Very experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the RADISYS 82600
 	  PATA controllers via the new ATA layer
 
 	  If unsure, say N.
 
 config PATA_RZ1000
 	tristate "PC Tech RZ1000 PATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables basic support for the PC Tech RZ1000/1
 	  PATA controllers via the new ATA layer
 
 	  If unsure, say N.
 
 config PATA_SC1200
 	tristate "SC1200 PATA support (Raving Lunatic)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the NatSemi/AMD SC1200 SoC
 	  companion chip used with the Geode processor family.
 
 	  If unsure, say N.
 
 config PATA_SERVERWORKS
 	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Serverworks OSB4/CSB5/CSB6 and
 	  HT1000 PATA controllers, via the new ATA layer.
 
 	  If unsure, say N.
 
 config PATA_PDC2027X
 	tristate "Promise PATA 2027x support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for Promise PATA pdc20268 to pdc20277 host adapters.
 
 	  If unsure, say N.
 
 config PATA_SIL680
 	tristate "CMD / Silicon Image 680 PATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for CMD / Silicon Image 680 PATA.
 
 	  If unsure, say N.
 
 config PATA_SIS
 	tristate "SiS PATA support (Experimental)"
-	depends on ATA && PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for SiS PATA controllers
 
 	  If unsure, say N.
 
 config PATA_VIA
 	tristate "VIA PATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for the VIA PATA interfaces
 	  found on the many VIA chipsets.
 
 	  If unsure, say N.
 
 config PATA_WINBOND
 	tristate "Winbond SL82C105 PATA support"
-	depends on ATA && PCI
+	depends on PCI
 	help
 	  This option enables support for SL82C105 PATA devices found in the
 	  Netwinder and some other systems
 
 	  If unsure, say N.
 
+endif  # ATA
+
+endmenu # "ATA device support"
