Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVDMBaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVDMBaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVDLTyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:54:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:46536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262161AbVDLKbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:49 -0400
Message-Id: <200504121031.j3CAVd57005368@shell0.pdx.osdl.net>
Subject: [patch 061/198] ata_piix: IDE mode SATA patch for Intel ESB2
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jason.d.gaston@intel.com,
       Jason.d.gaston@intel.com, jgarzik@pobox.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jason Gaston <jason.d.gaston@intel.com>

This patch adds the Intel ESB2 DID's to the ata_piix.c and quirks.c file for
IDE mode SATA support.

Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/pci/quirks.c    |    1 +
 25-akpm/drivers/scsi/ata_piix.c |   14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff -puN drivers/pci/quirks.c~ata_piix-ide-mode-sata-patch-for-intel-esb2 drivers/pci/quirks.c
--- 25/drivers/pci/quirks.c~ata_piix-ide-mode-sata-patch-for-intel-esb2	2005-04-12 03:21:17.908414408 -0700
+++ 25-akpm/drivers/pci/quirks.c	2005-04-12 03:21:17.913413648 -0700
@@ -1189,6 +1189,7 @@ static void __devinit quirk_intel_ide_co
 	case 0x2651:
 	case 0x2652:
 	case 0x2653:
+	case 0x2680:	/* ESB2 */
 		ich = 6;
 		break;
 	case 0x27c0:
diff -puN drivers/scsi/ata_piix.c~ata_piix-ide-mode-sata-patch-for-intel-esb2 drivers/scsi/ata_piix.c
--- 25/drivers/scsi/ata_piix.c~ata_piix-ide-mode-sata-patch-for-intel-esb2	2005-04-12 03:21:17.909414256 -0700
+++ 25-akpm/drivers/scsi/ata_piix.c	2005-04-12 03:21:17.914413496 -0700
@@ -61,6 +61,7 @@ enum {
 	ich6_sata		= 3,
 	ich6_sata_rm		= 4,
 	ich7_sata		= 5,
+	esb2_sata		= 6,
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -93,6 +94,7 @@ static struct pci_device_id piix_pci_tbl
 	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb2_sata },
 
 	{ }	/* terminate list */
 };
@@ -256,6 +258,18 @@ static struct ata_port_info piix_port_in
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
+
+	/* esb2_sata */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
+				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
+				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
 };
 
 static struct pci_bits piix_enable_bits[] = {
_
