Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756834AbWK0QVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbWK0QVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758356AbWK0QVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:21:18 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52874 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757150AbWK0QVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:21:17 -0500
Date: Mon, 27 Nov 2006 16:27:20 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] pata : more drivers that need only standard suspend and
 resume
Message-ID: <20061127162720.3eb72478@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_pdc202xx_old.c linux-2.6.19-rc6-mm1/drivers/ata/pata_pdc202xx_old.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_pdc202xx_old.c	2006-11-24 13:58:28.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_pdc202xx_old.c	2006-11-24 14:24:38.000000000 +0000
@@ -21,7 +21,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_pdc202xx_old"
-#define DRV_VERSION "0.2.2"
+#define DRV_VERSION "0.2.3"
 
 /**
  *	pdc2024x_pre_reset		-	probe begin
@@ -270,6 +270,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations pdc2024x_port_ops = {
@@ -399,7 +401,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= pdc202xx,
 	.probe 		= pdc202xx_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init pdc202xx_init(void)
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_sis.c linux-2.6.19-rc6-mm1/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_sis.c	2006-11-24 13:58:05.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_sis.c	2006-11-24 14:25:15.000000000 +0000
@@ -34,7 +34,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_sis"
-#define DRV_VERSION	"0.4.4"
+#define DRV_VERSION	"0.4.5"
 
 struct sis_chipset {
 	u16 device;			/* PCI host ID */
@@ -546,6 +546,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations sis_133_ops = {
@@ -999,6 +1001,8 @@
 	.id_table		= sis_pci_tbl,
 	.probe			= sis_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static int __init sis_init(void)
