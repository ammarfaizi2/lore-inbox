Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVB1VJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVB1VJD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVB1VGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:06:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60935 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261749AbVB1VCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:02:06 -0500
Date: Mon, 28 Feb 2005 22:02:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/sata_*: make code static
Message-ID: <20050228210204.GN4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/sata_nv.c  |    6 ++++--
 drivers/scsi/sata_sil.c |    2 +-
 drivers/scsi/sata_svw.c |    4 ++--
 drivers/scsi/sata_vsc.c |    3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/sata_nv.c.old	2005-02-28 19:53:22.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/sata_nv.c	2005-02-28 19:54:00.000000000 +0100
@@ -99,7 +99,8 @@
 #define NV_MCP_SATA_CFG_20_SATA_SPACE_EN	0x04
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static irqreturn_t nv_interrupt (int irq, void *dev_instance,
+				 struct pt_regs *regs);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
@@ -258,7 +259,8 @@
 MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t nv_interrupt (int irq, void *dev_instance,
+				 struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	struct nv_host *host = host_set->private_data;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/sata_sil.c.old	2005-02-28 19:54:20.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/sata_sil.c	2005-02-28 19:54:34.000000000 +0100
@@ -78,7 +78,7 @@
 
 
 /* TODO firmware versions should be added - eric */
-struct sil_drivelist {
+static const struct sil_drivelist {
 	const char * product;
 	unsigned int quirk;
 } sil_blacklist [] = {
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/sata_svw.c.old	2005-02-28 19:54:47.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/sata_svw.c	2005-02-28 19:55:06.000000000 +0100
@@ -156,7 +156,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void k2_bmdma_setup_mmio (struct ata_queued_cmd *qc)
+static void k2_bmdma_setup_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -186,7 +186,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void k2_bmdma_start_mmio (struct ata_queued_cmd *qc)
+static void k2_bmdma_start_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	void *mmio = (void *) ap->ioaddr.bmdma_addr;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/sata_vsc.c.old	2005-02-28 19:55:18.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/sata_vsc.c	2005-02-28 19:55:40.000000000 +0100
@@ -155,7 +155,8 @@
  *
  * Read the interrupt register and process for the devices that have them pending.
  */
-irqreturn_t vsc_sata_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t vsc_sata_interrupt (int irq, void *dev_instance,
+				       struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	unsigned int i;

