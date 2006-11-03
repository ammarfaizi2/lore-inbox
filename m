Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752860AbWKCNOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbWKCNOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 08:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbWKCNOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 08:14:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50361 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752860AbWKCNOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 08:14:16 -0500
Subject: [PATCH] pdc202xx_old: Fix name clashes with PA-RISC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matthew Wilcox <matthew@wil.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Nov 2006 13:18:06 +0000
Message-Id: <1162559886.12810.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pdc_* functions are part of the global namespace for the PDC on PA-RISC
systems and this means our choice of pdc_ causes collisions between the
PDC globals and our static functions. Rename them to pdc202xx where they
are for both 2024x and 2026x.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/drivers/ata/pata_pdc202xx_old.c linux-2.6.19-rc4-mm1/drivers/ata/pata_pdc202xx_old.c
--- linux.vanilla-2.6.19-rc4-mm1/drivers/ata/pata_pdc202xx_old.c	2006-10-31 21:11:29.000000000 +0000
+++ linux-2.6.19-rc4-mm1/drivers/ata/pata_pdc202xx_old.c	2006-11-03 12:46:20.587840712 +0000
@@ -21,7 +21,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_pdc202xx_old"
-#define DRV_VERSION "0.2.1"
+#define DRV_VERSION "0.2.2"
 
 /**
  *	pdc2024x_pre_reset		-	probe begin
@@ -63,7 +63,7 @@
 }
 
 /**
- *	pdc_configure_piomode	-	set chip PIO timing
+ *	pdc202xx_configure_piomode	-	set chip PIO timing
  *	@ap: ATA interface
  *	@adev: ATA device
  *	@pio: PIO mode
@@ -73,7 +73,7 @@
  *	versa
  */
 
-static void pdc_configure_piomode(struct ata_port *ap, struct ata_device *adev, int pio)
+static void pdc202xx_configure_piomode(struct ata_port *ap, struct ata_device *adev, int pio)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int port = 0x60 + 4 * ap->port_no + 2 * adev->devno;
@@ -98,7 +98,7 @@
 }
 
 /**
- *	pdc_set_piomode	-	set initial PIO mode data
+ *	pdc202xx_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
  *	@adev: ATA device
  *
@@ -106,13 +106,13 @@
  *	but we want to set the PIO timing by default.
  */
 
-static void pdc_set_piomode(struct ata_port *ap, struct ata_device *adev)
+static void pdc202xx_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	pdc_configure_piomode(ap, adev, adev->pio_mode - XFER_PIO_0);
+	pdc202xx_configure_piomode(ap, adev, adev->pio_mode - XFER_PIO_0);
 }
 
 /**
- *	pdc_configure_dmamode	-	set DMA mode in chip
+ *	pdc202xx_configure_dmamode	-	set DMA mode in chip
  *	@ap: ATA interface
  *	@adev: ATA device
  *
@@ -120,7 +120,7 @@
  *	to occur.
  */
 
-static void pdc_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+static void pdc202xx_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int port = 0x60 + 4 * ap->port_no + 2 * adev->devno;
@@ -184,7 +184,7 @@
 
 	/* The DMA clocks may have been trashed by a reset. FIXME: make conditional
 	   and move to qc_issue ? */
-	pdc_set_dmamode(ap, qc->dev);
+	pdc202xx_set_dmamode(ap, qc->dev);
 
 	/* Cases the state machine will not complete correctly without help */
 	if ((tf->flags & ATA_TFLAG_LBA48) ||  tf->protocol == ATA_PROT_ATAPI_DMA)
@@ -254,7 +254,7 @@
 	adev->max_sectors = 256;
 }
 
-static struct scsi_host_template pdc_sht = {
+static struct scsi_host_template pdc202xx_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
@@ -274,8 +274,8 @@
 
 static struct ata_port_operations pdc2024x_port_ops = {
 	.port_disable	= ata_port_disable,
-	.set_piomode	= pdc_set_piomode,
-	.set_dmamode	= pdc_set_dmamode,
+	.set_piomode	= pdc202xx_set_piomode,
+	.set_dmamode	= pdc202xx_set_dmamode,
 	.mode_filter	= ata_pci_default_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
@@ -307,8 +307,8 @@
 
 static struct ata_port_operations pdc2026x_port_ops = {
 	.port_disable	= ata_port_disable,
-	.set_piomode	= pdc_set_piomode,
-	.set_dmamode	= pdc_set_dmamode,
+	.set_piomode	= pdc202xx_set_piomode,
+	.set_dmamode	= pdc202xx_set_dmamode,
 	.mode_filter	= ata_pci_default_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
@@ -339,11 +339,11 @@
 	.host_stop	= ata_host_stop
 };
 
-static int pdc_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static struct ata_port_info info[3] = {
 		{
-			.sht = &pdc_sht,
+			.sht = &pdc202xx_sht,
 			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -351,7 +351,7 @@
 			.port_ops = &pdc2024x_port_ops
 		},
 		{
-			.sht = &pdc_sht,
+			.sht = &pdc202xx_sht,
 			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -359,7 +359,7 @@
 			.port_ops = &pdc2026x_port_ops
 		},
 		{
-			.sht = &pdc_sht,
+			.sht = &pdc202xx_sht,
 			.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -385,7 +385,7 @@
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
-static const struct pci_device_id pdc[] = {
+static const struct pci_device_id pdc202xx[] = {
 	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20246), 0 },
 	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20262), 1 },
 	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20263), 1 },
@@ -395,28 +395,28 @@
 	{ },
 };
 
-static struct pci_driver pdc_pci_driver = {
+static struct pci_driver pdc202xx_pci_driver = {
 	.name 		= DRV_NAME,
-	.id_table	= pdc,
-	.probe 		= pdc_init_one,
+	.id_table	= pdc202xx,
+	.probe 		= pdc202xx_init_one,
 	.remove		= ata_pci_remove_one
 };
 
-static int __init pdc_init(void)
+static int __init pdc202xx_init(void)
 {
-	return pci_register_driver(&pdc_pci_driver);
+	return pci_register_driver(&pdc202xx_pci_driver);
 }
 
-static void __exit pdc_exit(void)
+static void __exit pdc202xx_exit(void)
 {
-	pci_unregister_driver(&pdc_pci_driver);
+	pci_unregister_driver(&pdc202xx_pci_driver);
 }
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for Promise 2024x and 20262-20267");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(pci, pdc);
+MODULE_DEVICE_TABLE(pci, pdc202xx);
 MODULE_VERSION(DRV_VERSION);
 
-module_init(pdc_init);
-module_exit(pdc_exit);
+module_init(pdc202xx_init);
+module_exit(pdc202xx_exit);

