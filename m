Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVJQCpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVJQCpK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 22:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVJQCpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 22:45:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:7048 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932142AbVJQCpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 22:45:08 -0400
Message-ID: <43531030.9000901@pobox.com>
Date: Sun, 16 Oct 2005 22:45:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: [PATCH] Re: Intel SATA combined mode quirk broken for SCSI_SATA=m
References: <200510161913.59622.jbarnes@virtuousgeek.org>
In-Reply-To: <200510161913.59622.jbarnes@virtuousgeek.org>
Content-Type: multipart/mixed;
 boundary="------------010703060400040205050404"
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.2 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Actually... does the attached patch fix things for you?
	Jeff diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig ---
	a/drivers/scsi/Kconfig +++ b/drivers/scsi/Kconfig @@ -437,7 +437,7 @@
	config SCSI_IN2000 source "drivers/scsi/megaraid/Kconfig.megaraid"
	[...] 
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010703060400040205050404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Actually... does the attached patch fix things for you?

	Jeff




--------------010703060400040205050404
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -437,7 +437,7 @@ config SCSI_IN2000
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
-	tristate "Serial ATA (SATA) support"
+	bool "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers
@@ -445,9 +445,11 @@ config SCSI_SATA
 
 	  If unsure, say N.
 
+if SCSI_SATA
+
 config SCSI_SATA_AHCI
 	tristate "AHCI SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for AHCI Serial ATA.
 
@@ -455,7 +457,7 @@ config SCSI_SATA_AHCI
 
 config SCSI_SATA_SVW
 	tristate "ServerWorks Frodo / Apple K2 SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for Broadcom/Serverworks/Apple K2
 	  SATA support.
@@ -464,7 +466,7 @@ config SCSI_SATA_SVW
 
 config SCSI_ATA_PIIX
 	tristate "Intel PIIX/ICH SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for ICH5 Serial ATA.
 	  If PATA support was enabled previously, this enables
@@ -474,7 +476,7 @@ config SCSI_ATA_PIIX
 
 config SCSI_SATA_MV
 	tristate "Marvell SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] chips.
@@ -483,7 +485,7 @@ config SCSI_SATA_MV
 
 config SCSI_SATA_NV
 	tristate "NVIDIA SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for NVIDIA Serial ATA.
 
@@ -491,7 +493,7 @@ config SCSI_SATA_NV
 
 config SCSI_SATA_PROMISE
 	tristate "Promise SATA TX2/TX4 support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for Promise Serial ATA TX2/TX4.
 
@@ -499,7 +501,7 @@ config SCSI_SATA_PROMISE
 
 config SCSI_SATA_QSTOR
 	tristate "Pacific Digital SATA QStor support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for Pacific Digital Serial ATA QStor.
 
@@ -507,7 +509,7 @@ config SCSI_SATA_QSTOR
 
 config SCSI_SATA_SX4
 	tristate "Promise SATA SX4 support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for Promise Serial ATA SX4.
 
@@ -515,7 +517,7 @@ config SCSI_SATA_SX4
 
 config SCSI_SATA_SIL
 	tristate "Silicon Image SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for Silicon Image Serial ATA.
 
@@ -523,7 +525,7 @@ config SCSI_SATA_SIL
 
 config SCSI_SATA_SIS
 	tristate "SiS 964/180 SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for SiS Serial ATA 964/180.
 
@@ -531,7 +533,7 @@ config SCSI_SATA_SIS
 
 config SCSI_SATA_ULI
 	tristate "ULi Electronics SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for ULi Electronics SATA.
 
@@ -539,7 +541,7 @@ config SCSI_SATA_ULI
 
 config SCSI_SATA_VIA
 	tristate "VIA SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for VIA Serial ATA.
 
@@ -547,12 +549,14 @@ config SCSI_SATA_VIA
 
 config SCSI_SATA_VITESSE
 	tristate "VITESSE VSC-7174 SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for Vitesse VSC7174 Serial ATA.
 
 	  If unsure, say N.
 
+endif	# if SCSI_SATA
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API

--------------010703060400040205050404--
