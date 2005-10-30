Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVJ3Qzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVJ3Qzb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 11:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVJ3Qzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 11:55:31 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:52366 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S932178AbVJ3Qza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 11:55:30 -0500
Subject: patch to add a config option to enable SATA ATAPI by default
From: Mark Tomich <tomichm@bellsouth.net>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Content-Type: text/plain
Date: Sun, 30 Oct 2005 11:55:28 -0500
Message-Id: <1130691328.8303.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a very straight-forward patch to add a config option to
enabling SATA ATAPI by default.
Please CC me with any comments.

diff -u -r linux-2.6.14-rc5/drivers/scsi/Kconfig
linux-2.6.14-rc5-patched/drivers/scsi/Kconfig
--- linux-2.6.14-rc5/drivers/scsi/Kconfig	2005-10-30 11:09:15.533533419
-0500
+++ linux-2.6.14-rc5-patched/drivers/scsi/Kconfig	2005-10-30
11:21:39.735696058 -0500
@@ -445,6 +445,17 @@
 
 	  If unsure, say N.
 
+config SCSI_SATA_ENABLE_ATAPI
+	bool "Enable SATA ATAPI by default"
+	depends on SCSI_SATA
+	help
+	  SATA ATAPI is disabled by default.
+	  Use this option to enable it by default.
+	  
+	  You probably want this if you have a CDROM attached on the SATA bus.
+
+	  If unsure, say Y.
+
 config SCSI_SATA_AHCI
 	tristate "AHCI SATA support"
 	depends on SCSI_SATA && PCI
diff -u -r linux-2.6.14-rc5/drivers/scsi/libata-core.c
linux-2.6.14-rc5-patched/drivers/scsi/libata-core.c
--- linux-2.6.14-rc5/drivers/scsi/libata-core.c	2005-10-30
11:09:15.614522543 -0500
+++ linux-2.6.14-rc5-patched/drivers/scsi/libata-core.c	2005-10-30
11:44:45.776652352 -0500
@@ -75,7 +75,12 @@
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
+#ifdef CONFIG_SCSI_SATA_ENABLE_ATAPI
+int atapi_enabled = 1;
+#else
 int atapi_enabled = 0;
+#endif
+
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices
(0=off, 1=on)");
 


