Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVCGVn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVCGVn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVCGV1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:27:53 -0500
Received: from mail0.lsil.com ([147.145.40.20]:13735 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261232AbVCGVKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:10:08 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CC0D@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: [ANNOUNCE][PATCH 2.6.11 1/3] megaraid_sas: Announcing new module 
	for LSI Logic's SAS based MegaRAID controllers
Date: Mon, 7 Mar 2005 16:09:40 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

We are announcing a driver for LSI Logic's new SAS based MegaRAID 
controllers. I am submitting the inlined patch in three parts. Please
review the patches.


Thank you,
Sreenivas Bagalkote
LSI Logic Corporation

Patch 1 of 3:

Signed-off-by: Sreenivas Bagalkote <sreenivas.bagalkote@lsil.com>

diff -Naur linux-2.6.11-orig/Documentation/scsi/ChangeLog.megaraid_sas
linux-2.6.11/Documentation/scsi/ChangeLog.megaraid_sas
--- linux-2.6.11-orig/Documentation/scsi/ChangeLog.megaraid_sas	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.11/Documentation/scsi/ChangeLog.megaraid_sas	2005-03-05
21:18:08.745716776 -0500
@@ -0,0 +1,9 @@
+Release Date	: Fri Mar  4 21:06:57 EST 2005
+Released by	: Sreenivas Bagalkote (sreenivas.bagalkote@lsil.com)
+Current Version	: 00.00.01.00
+Older Version	: NA
+
+1.	Initial announcement to community - Module for LSI Logic's SAS based
+	RAID controllers.
+
+
diff -Naur linux-2.6.11-orig/drivers/scsi/Kconfig
linux-2.6.11/drivers/scsi/Kconfig
--- linux-2.6.11-orig/drivers/scsi/Kconfig	2005-03-02
02:38:25.000000000 -0500
+++ linux-2.6.11/drivers/scsi/Kconfig	2005-03-05 21:18:56.538451176 -0500
@@ -404,6 +404,7 @@
 	  module will be called in2000.
 
 source "drivers/scsi/megaraid/Kconfig.megaraid"
+source "drivers/scsi/megaraid/Kconfig.megaraid_sas"
 
 config SCSI_SATA
 	bool "Serial ATA (SATA) support"
diff -Naur linux-2.6.11-orig/drivers/scsi/Makefile
linux-2.6.11/drivers/scsi/Makefile
--- linux-2.6.11-orig/drivers/scsi/Makefile	2005-03-02
02:38:19.000000000 -0500
+++ linux-2.6.11/drivers/scsi/Makefile	2005-03-05 21:19:14.806673984 -0500
@@ -97,6 +97,7 @@
 obj-$(CONFIG_SCSI_DC390T)	+= tmscsim.o
 obj-$(CONFIG_MEGARAID_LEGACY)	+= megaraid.o
 obj-$(CONFIG_MEGARAID_NEWGEN)	+= megaraid/
+obj-$(CONFIG_MEGARAID_SAS)	+= megaraid/
 obj-$(CONFIG_SCSI_ACARD)	+= atp870u.o
 obj-$(CONFIG_SCSI_SUNESP)	+= esp.o
 obj-$(CONFIG_SCSI_GDTH)		+= gdth.o
diff -Naur linux-2.6.11-orig/drivers/scsi/megaraid/Kconfig.megaraid_sas
linux-2.6.11/drivers/scsi/megaraid/Kconfig.megaraid_sas
--- linux-2.6.11-orig/drivers/scsi/megaraid/Kconfig.megaraid_sas
1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.11/drivers/scsi/megaraid/Kconfig.megaraid_sas	2005-03-05
21:27:37.628233488 -0500
@@ -0,0 +1,9 @@
+config MEGARAID_SAS
+	tristate "LSI Logic MegaRAID SAS RAID module (New Driver)"
+	depends on PCI && SCSI
+	help
+	Module for LSI Logic's SAS based RAID controllers.
+	To compile this driver as a module, choose 'm' here.
+	Module will be called megaraid_sas
+
+
diff -Naur linux-2.6.11-orig/drivers/scsi/megaraid/Makefile
linux-2.6.11/drivers/scsi/megaraid/Makefile
--- linux-2.6.11-orig/drivers/scsi/megaraid/Makefile	2005-03-02
02:38:26.000000000 -0500
+++ linux-2.6.11/drivers/scsi/megaraid/Makefile	2005-03-05
21:27:40.000000000 -0500
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MEGARAID_MM)	+= megaraid_mm.o
 obj-$(CONFIG_MEGARAID_MAILBOX)	+= megaraid_mbox.o
+obj-$(CONFIG_MEGARAID_SAS)	+= megaraid_sas.o




