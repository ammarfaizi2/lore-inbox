Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755650AbWKVQxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650AbWKVQxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755714AbWKVQxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:53:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11141 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755650AbWKVQxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:53:20 -0500
Date: Wed, 22 Nov 2006 16:57:36 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] PATA libata: suspend/resume simple cases
Message-ID: <20061122165736.78e57d16@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the suspend/resume callbacks for drivers which don't need
any additional help (beyond the pci resume quirk patch I posted earlier
anyway). Also bring version numbers back inline with master copies.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/ata_generic.c linux-2.6.19-rc5-mm2/drivers/ata/ata_generic.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/ata_generic.c	2006-11-15 13:26:59.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/ata_generic.c	2006-11-22 14:29:48.602945672 +0000
@@ -26,7 +26,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "ata_generic"
-#define DRV_VERSION "0.2.7"
+#define DRV_VERSION "0.2.10"
 
 /*
  *	A generic parallel ATA driver using libata
@@ -117,6 +117,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations generic_port_ops = {
@@ -225,7 +227,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= ata_generic,
 	.probe 		= ata_generic_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init ata_generic_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_atiixp.c linux-2.6.19-rc5-mm2/drivers/ata/pata_atiixp.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_atiixp.c	2006-11-15 13:25:59.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_atiixp.c	2006-11-22 14:49:37.740169336 +0000
@@ -22,7 +22,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_atiixp"
-#define DRV_VERSION "0.4.3"
+#define DRV_VERSION "0.4.4"
 
 enum {
 	ATIIXP_IDE_PIO_TIMING	= 0x40,
@@ -217,6 +217,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations atiixp_port_ops = {
@@ -280,7 +282,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= atiixp,
 	.probe 		= atiixp_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.resume		= ata_pci_device_resume,
+	.suspend	= ata_pci_device_suspend,
 };
 
 static int __init atiixp_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cs5535.c linux-2.6.19-rc5-mm2/drivers/ata/pata_cs5535.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cs5535.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_cs5535.c	2006-11-22 15:38:44.185241600 +0000
@@ -39,7 +39,7 @@
 #include <asm/msr.h>
 
 #define DRV_NAME	"cs5535"
-#define DRV_VERSION	"0.2.10"
+#define DRV_VERSION	"0.2.11"
 
 /*
  *	The Geode (Aka Athlon GX now) uses an internal MSR based
@@ -185,6 +185,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations cs5535_port_ops = {
@@ -268,6 +270,8 @@
 	.id_table	= cs5535,
 	.probe 		= cs5535_init_one,
 	.remove		= ata_pci_remove_one
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init cs5535_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cypress.c linux-2.6.19-rc5-mm2/drivers/ata/pata_cypress.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cypress.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_cypress.c	2006-11-22 15:39:36.266324072 +0000
@@ -18,7 +18,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_cypress"
-#define DRV_VERSION "0.1.2"
+#define DRV_VERSION "0.1.4"
 
 /* here are the offset definitions for the registers */
 
@@ -136,6 +136,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations cy82c693_port_ops = {
@@ -203,7 +205,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= cy82c693,
 	.probe 		= cy82c693_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init cy82c693_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_efar.c linux-2.6.19-rc5-mm2/drivers/ata/pata_efar.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_efar.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_efar.c	2006-11-22 14:48:40.248909336 +0000
@@ -22,7 +22,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_efar"
-#define DRV_VERSION	"0.4.2"
+#define DRV_VERSION	"0.4.3"
 
 /**
  *	efar_pre_reset	-	check for 40/80 pin
@@ -234,6 +234,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations efar_ops = {
@@ -315,6 +317,8 @@
 	.id_table		= efar_pci_tbl,
 	.probe			= efar_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static int __init efar_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_marvell.c linux-2.6.19-rc5-mm2/drivers/ata/pata_marvell.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_marvell.c	2006-11-15 13:26:59.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_marvell.c	2006-11-22 15:38:44.842141736 +0000
@@ -20,7 +20,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_marvell"
-#define DRV_VERSION	"0.0.5u"
+#define DRV_VERSION	"0.1.1"
 
 /**
  *	marvell_pre_reset	-	check for 40/80 pin
@@ -103,6 +103,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations marvell_ops = {
@@ -197,6 +199,8 @@
 	.id_table		= marvell_pci_tbl,
 	.probe			= marvell_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static int __init marvell_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_mpiix.c linux-2.6.19-rc5-mm2/drivers/ata/pata_mpiix.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_mpiix.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_mpiix.c	2006-11-22 15:40:53.458589064 +0000
@@ -35,7 +35,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_mpiix"
-#define DRV_VERSION "0.7.2"
+#define DRV_VERSION "0.7.3"
 
 enum {
 	IDETIM = 0x6C,		/* IDE control register */
@@ -167,6 +167,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations mpiix_port_ops = {
@@ -284,7 +286,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= mpiix,
 	.probe 		= mpiix_init_one,
-	.remove		= mpiix_remove_one
+	.remove		= mpiix_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init mpiix_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_netcell.c linux-2.6.19-rc5-mm2/drivers/ata/pata_netcell.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_netcell.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_netcell.c	2006-11-22 14:47:23.298607560 +0000
@@ -16,7 +16,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_netcell"
-#define DRV_VERSION	"0.1.5"
+#define DRV_VERSION	"0.1.6"
 
 /**
  *	netcell_probe_init	-	check for 40/80 pin
@@ -64,6 +64,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations netcell_ops = {
@@ -152,6 +154,8 @@
 	.id_table		= netcell_pci_tbl,
 	.probe			= netcell_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static int __init netcell_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_ns87410.c linux-2.6.19-rc5-mm2/drivers/ata/pata_ns87410.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_ns87410.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_ns87410.c	2006-11-22 15:41:35.704166760 +0000
@@ -28,7 +28,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_ns87410"
-#define DRV_VERSION "0.4.2"
+#define DRV_VERSION "0.4.3"
 
 /**
  *	ns87410_pre_reset		-	probe begin
@@ -157,6 +157,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations ns87410_port_ops = {
@@ -209,7 +211,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= ns87410,
 	.probe 		= ns87410_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init ns87410_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_oldpiix.c linux-2.6.19-rc5-mm2/drivers/ata/pata_oldpiix.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_oldpiix.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_oldpiix.c	2006-11-22 14:43:46.906504160 +0000
@@ -232,6 +232,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations oldpiix_pata_ops = {
@@ -313,6 +315,8 @@
 	.id_table		= oldpiix_pci_tbl,
 	.probe			= oldpiix_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static int __init oldpiix_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_opti.c linux-2.6.19-rc5-mm2/drivers/ata/pata_opti.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_opti.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_opti.c	2006-11-22 15:47:50.858134688 +0000
@@ -34,7 +34,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_opti"
-#define DRV_VERSION "0.2.5"
+#define DRV_VERSION "0.2.7"
 
 enum {
 	READ_REG	= 0,	/* index of Read cycle timing register */
@@ -109,30 +109,6 @@
 	outb(0x83, regio + 2);
 }
 
-#if 0
-/**
- *	opti_read_reg		-	control register read
- *	@ap: ATA port
- *	@reg: control register number
- *
- *	The Opti uses magic 'trapdoor' register accesses to do configuration
- *	rather than using PCI space as other controllers do. The double inw
- *	on the error register activates configuration mode. We can then read
- *	the control register
- */
-
-static u8 opti_read_reg(struct ata_port *ap, int reg)
-{
-	unsigned long regio = ap->ioaddr.cmd_addr;
-	u8 ret;
-	inw(regio + 1);
-	inw(regio + 1);
-	outb(3, regio + 2);
-	ret = inb(regio + reg);
-	outb(0x83, regio + 2);
-}
-#endif
-
 /**
  *	opti_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -203,12 +179,13 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations opti_port_ops = {
 	.port_disable	= ata_port_disable,
 	.set_piomode	= opti_set_piomode,
-/*	.set_dmamode	= opti_set_dmamode, */
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
@@ -266,7 +243,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= opti,
 	.probe 		= opti_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init opti_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_optidma.c linux-2.6.19-rc5-mm2/drivers/ata/pata_optidma.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_optidma.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_optidma.c	2006-11-22 15:43:16.225885136 +0000
@@ -33,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_optidma"
-#define DRV_VERSION "0.2.2"
+#define DRV_VERSION "0.2.3"
 
 enum {
 	READ_REG	= 0,	/* index of Read cycle timing register */
@@ -360,6 +360,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations optidma_port_ops = {
@@ -521,7 +523,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= optidma,
 	.probe 		= optidma_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init optidma_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_radisys.c linux-2.6.19-rc5-mm2/drivers/ata/pata_radisys.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_radisys.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_radisys.c	2006-11-22 14:50:19.858766336 +0000
@@ -228,6 +228,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations radisys_pata_ops = {
@@ -310,6 +312,8 @@
 	.id_table		= radisys_pci_tbl,
 	.probe			= radisys_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static int __init radisys_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_sc1200.c linux-2.6.19-rc5-mm2/drivers/ata/pata_sc1200.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_sc1200.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_sc1200.c	2006-11-22 15:44:32.988215488 +0000
@@ -40,7 +40,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sc1200"
-#define DRV_VERSION	"0.2.3"
+#define DRV_VERSION	"0.2.4"
 
 #define SC1200_REV_A	0x00
 #define SC1200_REV_B1	0x01
@@ -194,6 +194,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations sc1200_port_ops = {
@@ -263,7 +265,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= sc1200,
 	.probe 		= sc1200_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init sc1200_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_triflex.c linux-2.6.19-rc5-mm2/drivers/ata/pata_triflex.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_triflex.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_triflex.c	2006-11-22 14:24:35.021617280 +0000
@@ -43,7 +43,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_triflex"
-#define DRV_VERSION "0.2.5"
+#define DRV_VERSION "0.2.7"
 
 /**
  *	triflex_prereset		-	probe begin
@@ -193,6 +193,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations triflex_port_ops = {
@@ -257,7 +259,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= triflex,
 	.probe 		= triflex_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
 };
 
 static int __init triflex_init(void)
