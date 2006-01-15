Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWAOV5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWAOV5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWAOV5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:57:39 -0500
Received: from xenotime.net ([66.160.160.81]:26004 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750912AbWAOV5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:57:39 -0500
Date: Sun, 15 Jan 2006 13:57:28 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>, jejb <james.bottomley@steeleye.com>
Subject: [PATCH/RFC] SATA in its own config menu
Message-Id: <20060115135728.7b13996d.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Put SATA into its own menu.  Reason:  using SCSI is an
implementation detail that users need not know about.

Enabling SATA selects SCSI since SATA uses SCSI as a function
library supplier.  It also enables BLK_DEV_SD since that is
what SATA drives look like in Linux.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/Kconfig           |    2 
 drivers/scsi/Kconfig      |  138 --------------------------------------------
 drivers/scsi/Kconfig.sata |  142 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 138 deletions(-)

--- linux-2615-g10.orig/drivers/scsi/Kconfig
+++ linux-2615-g10/drivers/scsi/Kconfig
@@ -461,144 +461,6 @@ config SCSI_IN2000
 
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
-config SCSI_SATA
-	tristate "Serial ATA (SATA) support"
-	depends on SCSI
-	help
-	  This driver family supports Serial ATA host controllers
-	  and devices.
-
-	  If unsure, say N.
-
-config SCSI_SATA_AHCI
-	tristate "AHCI SATA support"
-	depends on SCSI_SATA && PCI
-	help
-	  This option enables support for AHCI Serial ATA.
-
-	  If unsure, say N.
-
-config SCSI_SATA_SVW
-	tristate "ServerWorks Frodo / Apple K2 SATA support"
-	depends on SCSI_SATA && PCI
-	help
-	  This option enables support for Broadcom/Serverworks/Apple K2
-	  SATA support.
-
-	  If unsure, say N.
-
-config SCSI_ATA_PIIX
-	tristate "Intel PIIX/ICH SATA support"
-	depends on SCSI_SATA && PCI
-	help
-	  This option enables support for ICH5 Serial ATA.
-	  If PATA support was enabled previously, this enables
-	  support for select Intel PIIX/ICH PATA host controllers.
-
-	  If unsure, say N.
-
-config SCSI_SATA_MV
-	tristate "Marvell SATA support (HIGHLY EXPERIMENTAL)"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
-	help
-	  This option enables support for the Marvell Serial ATA family.
-	  Currently supports 88SX[56]0[48][01] chips.
-
-	  If unsure, say N.
-
-config SCSI_SATA_NV
-	tristate "NVIDIA SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
-	help
-	  This option enables support for NVIDIA Serial ATA.
-
-	  If unsure, say N.
-
-config SCSI_PDC_ADMA
-	tristate "Pacific Digital ADMA support"
-	depends on SCSI_SATA && PCI
-	help
-	  This option enables support for Pacific Digital ADMA controllers
-
-	  If unsure, say N.
-
-config SCSI_SATA_QSTOR
-	tristate "Pacific Digital SATA QStor support"
-	depends on SCSI_SATA && PCI
-	help
-	  This option enables support for Pacific Digital Serial ATA QStor.
-
-	  If unsure, say N.
-
-config SCSI_SATA_PROMISE
-	tristate "Promise SATA TX2/TX4 support"
-	depends on SCSI_SATA && PCI
-	help
-	  This option enables support for Promise Serial ATA TX2/TX4.
-
-	  If unsure, say N.
-
-config SCSI_SATA_SX4
-	tristate "Promise SATA SX4 support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
-	help
-	  This option enables support for Promise Serial ATA SX4.
-
-	  If unsure, say N.
-
-config SCSI_SATA_SIL
-	tristate "Silicon Image SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
-	help
-	  This option enables support for Silicon Image Serial ATA.
-
-	  If unsure, say N.
-
-config SCSI_SATA_SIL24
-	tristate "Silicon Image 3124/3132 SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
-	help
-	  This option enables support for Silicon Image 3124/3132 Serial ATA.
-
-	  If unsure, say N.
-
-config SCSI_SATA_SIS
-	tristate "SiS 964/180 SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
-	help
-	  This option enables support for SiS Serial ATA 964/180.
-
-	  If unsure, say N.
-
-config SCSI_SATA_ULI
-	tristate "ULi Electronics SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
-	help
-	  This option enables support for ULi Electronics SATA.
-
-	  If unsure, say N.
-
-config SCSI_SATA_VIA
-	tristate "VIA SATA support"
-	depends on SCSI_SATA && PCI
-	help
-	  This option enables support for VIA Serial ATA.
-
-	  If unsure, say N.
-
-config SCSI_SATA_VITESSE
-	tristate "VITESSE VSC-7174 SATA support"
-	depends on SCSI_SATA && PCI
-	help
-	  This option enables support for Vitesse VSC7174 Serial ATA.
-
-	  If unsure, say N.
-
-config SCSI_SATA_INTEL_COMBINED
-	bool
-	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
-	default y
-
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API
--- /dev/null
+++ linux-2615-g10/drivers/scsi/Kconfig.sata
@@ -0,0 +1,142 @@
+menu "Serial ATA (SATA) device support"
+
+config SCSI_SATA
+	tristate "Serial ATA (SATA) support"
+	select SCSI
+	select BLK_DEV_SD
+	help
+	  This driver family supports Serial ATA host controllers
+	  and devices.
+
+	  If unsure, say N.
+
+config SCSI_SATA_AHCI
+	tristate "AHCI SATA support"
+	depends on SCSI_SATA && PCI
+	help
+	  This option enables support for AHCI Serial ATA.
+
+	  If unsure, say N.
+
+config SCSI_SATA_SVW
+	tristate "ServerWorks Frodo / Apple K2 SATA support"
+	depends on SCSI_SATA && PCI
+	help
+	  This option enables support for Broadcom/Serverworks/Apple K2
+	  SATA support.
+
+	  If unsure, say N.
+
+config SCSI_ATA_PIIX
+	tristate "Intel PIIX/ICH SATA support"
+	depends on SCSI_SATA && PCI
+	help
+	  This option enables support for ICH5 Serial ATA.
+	  If PATA support was enabled previously, this enables
+	  support for select Intel PIIX/ICH PATA host controllers.
+
+	  If unsure, say N.
+
+config SCSI_SATA_MV
+	tristate "Marvell SATA support (HIGHLY EXPERIMENTAL)"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for the Marvell Serial ATA family.
+	  Currently supports 88SX[56]0[48][01] chips.
+
+	  If unsure, say N.
+
+config SCSI_SATA_NV
+	tristate "NVIDIA SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for NVIDIA Serial ATA.
+
+	  If unsure, say N.
+
+config SCSI_PDC_ADMA
+	tristate "Pacific Digital ADMA support"
+	depends on SCSI_SATA && PCI
+	help
+	  This option enables support for Pacific Digital ADMA controllers
+
+	  If unsure, say N.
+
+config SCSI_SATA_QSTOR
+	tristate "Pacific Digital SATA QStor support"
+	depends on SCSI_SATA && PCI
+	help
+	  This option enables support for Pacific Digital Serial ATA QStor.
+
+	  If unsure, say N.
+
+config SCSI_SATA_PROMISE
+	tristate "Promise SATA TX2/TX4 support"
+	depends on SCSI_SATA && PCI
+	help
+	  This option enables support for Promise Serial ATA TX2/TX4.
+
+	  If unsure, say N.
+
+config SCSI_SATA_SX4
+	tristate "Promise SATA SX4 support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for Promise Serial ATA SX4.
+
+	  If unsure, say N.
+
+config SCSI_SATA_SIL
+	tristate "Silicon Image SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for Silicon Image Serial ATA.
+
+	  If unsure, say N.
+
+config SCSI_SATA_SIL24
+	tristate "Silicon Image 3124/3132 SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for Silicon Image 3124/3132 Serial ATA.
+
+	  If unsure, say N.
+
+config SCSI_SATA_SIS
+	tristate "SiS 964/180 SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for SiS Serial ATA 964/180.
+
+	  If unsure, say N.
+
+config SCSI_SATA_ULI
+	tristate "ULi Electronics SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for ULi Electronics SATA.
+
+	  If unsure, say N.
+
+config SCSI_SATA_VIA
+	tristate "VIA SATA support"
+	depends on SCSI_SATA && PCI
+	help
+	  This option enables support for VIA Serial ATA.
+
+	  If unsure, say N.
+
+config SCSI_SATA_VITESSE
+	tristate "VITESSE VSC-7174 SATA support"
+	depends on SCSI_SATA && PCI
+	help
+	  This option enables support for Vitesse VSC7174 Serial ATA.
+
+	  If unsure, say N.
+
+config SCSI_SATA_INTEL_COMBINED
+	bool
+	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
+	default y
+
+endmenu
--- linux-2615-g10.orig/drivers/Kconfig
+++ linux-2615-g10/drivers/Kconfig
@@ -18,6 +18,8 @@ source "drivers/ide/Kconfig"
 
 source "drivers/scsi/Kconfig"
 
+source "drivers/scsi/Kconfig.sata"
+
 source "drivers/cdrom/Kconfig"
 
 source "drivers/md/Kconfig"


---
