Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTKLAGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTKLAGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:06:10 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5374 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263823AbTKLAFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:05:47 -0500
Date: Wed, 12 Nov 2003 01:05:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] give SATA its' own menu
Message-ID: <20031112000537.GD13643@fs.tum.de>
References: <20031026001554.GC23291@fs.tum.de> <20031026011145.GB23690@vana.vc.cvut.cz> <20031110175842.GO22185@fs.tum.de> <3FAFD81D.5080605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFD81D.5080605@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 01:25:33PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >I don't know the internals of the SATA driver, but this is unchanged 
> >from the current dependencies.
> >
> >If this is required, I can send a patch that adds disk an cdrom options 
> >to SATA and select's the appropriate SCSI options.
> 
> 
> If you didn't mind, such a patch would be nice...

Below is a patch that gives SATA its' own menu, and additionally adds 
options that select SCSI disc or cdrom support if enabled.

> 	Jeff

cu
Adrian

--- linux-2.6.0-test9/drivers/scsi/Kconfig.old	2003-11-12 00:45:34.000000000 +0100
+++ linux-2.6.0-test9/drivers/scsi/Kconfig	2003-11-12 01:02:11.000000000 +0100
@@ -1,3 +1,76 @@
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
+config SCSI_SATA_DISC
+	tristate "SATA disk support"
+	depends on SCSI_SATA
+	select BLK_DEV_SD
+	help
+	  This option enables support for SATA hard disks.
+
+config SCSI_SATA_CDROM
+	tristate "SATA CD-ROM support"
+	depends on SCSI_SATA
+	select BLK_DEV_SR
+	help
+	  This option enables support for SATA CD-ROMs.
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
+
+
 menu "SCSI device support"
 
 config SCSI
@@ -403,58 +476,6 @@
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
