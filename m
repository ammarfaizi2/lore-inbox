Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUC3XOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUC3XOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:14:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27013 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261573AbUC3XO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:14:28 -0500
Message-ID: <4069FF46.7090604@pobox.com>
Date: Tue, 30 Mar 2004 18:14:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Sebor <petr@scssoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com>
In-Reply-To: <4069FBC3.2080104@scssoft.com>
Content-Type: multipart/mixed;
 boundary="------------070703030608030604010605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070703030608030604010605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Petr Sebor wrote:
> Hi Jeff,
> 
> I have upgraded from 2.6.3 to 2.6.5-rc3 and can't see the secondary
> sata drive anymore...

Does this patch fix it?

	Jeff



--------------070703030608030604010605
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_via.c 1.10 vs edited =====
--- 1.10/drivers/scsi/sata_via.c	Thu Mar 25 07:30:08 2004
+++ edited/drivers/scsi/sata_via.c	Tue Mar 30 18:13:16 2004
@@ -56,6 +56,7 @@
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void svia_phy_reset(struct ata_port *ap);
 
 static struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, via_sata },
@@ -96,7 +97,7 @@
 	.check_status		= ata_check_status_pio,
 	.exec_command		= ata_exec_command_pio,
 
-	.phy_reset		= sata_phy_reset,
+	.phy_reset		= svia_phy_reset,
 
 	.bmdma_start            = ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
@@ -115,6 +116,13 @@
 MODULE_DESCRIPTION("SCSI low-level driver for VIA SATA controllers");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, svia_pci_tbl);
+
+static void svia_phy_reset(struct ata_port *ap)
+{
+	ap->cbl = ATA_CBL_SATA;
+	ata_port_probe(ap);
+	ata_bus_reset(ap);
+}
 
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {

--------------070703030608030604010605--

