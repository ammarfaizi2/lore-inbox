Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTJZAQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 20:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbTJZAQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 20:16:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52699 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262894AbTJZAP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 20:15:59 -0400
Date: Sun, 26 Oct 2003 02:15:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] give SATA its' own menu
Message-ID: <20031026001554.GC23291@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

for an average user it's non-obvious to search for SATA support under 
SCSI. The patch below moves SATA suport out of SCSI and gives it an own 
menu below SCSI.

diffstat output:

 drivers/scsi/Kconfig |  110 ++++++++++++++++++++++---------------------
 1 files changed, 58 insertions(+), 52 deletions(-)


Please apply
Adrian

--- linux-2.6.0-test9/drivers/scsi/Kconfig.old	2003-10-26 01:46:49.000000000 +0200
+++ linux-2.6.0-test9/drivers/scsi/Kconfig	2003-10-26 01:53:29.000000000 +0200
@@ -403,58 +403,6 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called megaraid.
 
-config SCSI_SATA
-	bool "Serial ATA (SATA) support"
-	depends on SCSI && EXPERIMENTAL
-	help
-	  This driver family supports Serial ATA host controllers
-	  and devices.
-
-	  If unsure, say N.
-
-config SCSI_SATA_SVW
-	tristate "ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL)"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
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
-config SCSI_SATA_PROMISE
-	tristate "Promise SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
-	help
-	  This option enables support for Promise Serial ATA.
-
-	  If unsure, say N.
-
-config SCSI_SATA_SIL
-	tristate "Silicon Image SATA support"
-	depends on SCSI_SATA && PCI && BROKEN
-	help
-	  This option enables support for Silicon Image Serial ATA.
-
-	  If unsure, say N.
-
-config SCSI_SATA_VIA
-	tristate "VIA SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
-	help
-	  This option enables support for VIA Serial ATA.
-
-	  If unsure, say N.
-
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA) && SCSI
@@ -1719,3 +1667,61 @@
 source "drivers/scsi/pcmcia/Kconfig"
 
 endmenu
+
+menu "Serial ATA (SATA) support"
+	depends on EXPERIMENTAL
+
+config SCSI_SATA
+	bool "Serial ATA (SATA) support"
+	depends on EXPERIMENTAL
+	select SCSI
+	help
+	  This driver family supports Serial ATA host controllers
+	  and devices.
+
+	  If unsure, say N.
+
+config SCSI_SATA_SVW
+	tristate "ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL)"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
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
+config SCSI_SATA_PROMISE
+	tristate "Promise SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for Promise Serial ATA.
+
+	  If unsure, say N.
+
+config SCSI_SATA_SIL
+	tristate "Silicon Image SATA support"
+	depends on SCSI_SATA && PCI && BROKEN
+	help
+	  This option enables support for Silicon Image Serial ATA.
+
+	  If unsure, say N.
+
+config SCSI_SATA_VIA
+	tristate "VIA SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for VIA Serial ATA.
+
+	  If unsure, say N.
+
+endmenu
