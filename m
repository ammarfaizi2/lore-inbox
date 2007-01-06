Return-Path: <linux-kernel-owner+w=401wt.eu-S932167AbXAFUcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbXAFUcN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbXAFUcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:32:13 -0500
Received: from aun.it.uu.se ([130.238.12.36]:40898 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167AbXAFUcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:32:12 -0500
Date: Sat, 6 Jan 2007 21:32:03 +0100 (MET)
Message-Id: <200701062032.l06KW3Qt022251@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH libata #promise-sata-pata] sata_promise: 2037x PATAPI support
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ATAPI support for the PATA port on Promise 2037x chips.
It depends on the common sata_promise ATAPI support patch.

First-generation chips don't support ATAPI on their SATA ports, so
the patch removes ATA_FLAG_NO_ATAPI from the 2037x common host flags,
and adds it back via the _port_flags[] entries for the SATA ports.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.20-rc3/drivers/ata/sata_promise.c.~1~	2007-01-06 17:10:56.000000000 +0100
+++ linux-2.6.20-rc3/drivers/ata/sata_promise.c	2007-01-06 17:14:23.000000000 +0100
@@ -187,7 +187,7 @@ static const struct ata_port_info pdc_po
 	/* board_2037x */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_NO_ATAPI /* | ATA_FLAG_SATA */,
+		.flags		= PDC_COMMON_FLAGS /* | ATA_FLAG_NO_ATAPI | ATA_FLAG_SATA */,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -996,6 +996,10 @@ static int pdc_ata_init_one (struct pci_
        			probe_ent->n_ports = 2;
 		probe_ent->_port_flags[0] = ATA_FLAG_SATA;
 		probe_ent->_port_flags[1] = ATA_FLAG_SATA;
+		if (board_idx == board_2037x) {
+			probe_ent->_port_flags[0] |= ATA_FLAG_NO_ATAPI;
+			probe_ent->_port_flags[1] |= ATA_FLAG_NO_ATAPI;
+		}
 		break;
 	case board_20619:
 		probe_ent->n_ports = 4;
