Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVA1R75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVA1R75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVA1R4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:56:31 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:18384 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261491AbVA1Ryb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:54:31 -0500
To: jgarzik@pobox.com
CC: linux-kernel@vger.kernel.org, mkrikis@yahoo.com
Subject: [RFC PATCH 2.4] ata_piix on ich6r in RAID mode
From: Martins Krikis <mkrikis@yahoo.com>
Date: 28 Jan 2005 12:54:08 -0500
Message-ID: <87acqte8xr.fsf@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

You might have come across this hack before, but I figured I should
remind you that it is still very useful for ata_piix...

Without this patch, if the BIOS of an ICH6R box has IDE set to "RAID"
mode then ata_piix will not find any SATA disks because it incorrectly
tries the legacy mode. With the patch all 4 SATA drives become visible.
I don't think it would break any other vendor's SATA, but you can be
the judge of that. If so, perhaps we can restrict the test some more
by checking vendor/device IDs.

  Martins Krikis
  Storage Components Division
  Intel Massachusetts



--- linux-2.4.29/drivers/scsi/libata-core.c	2005-01-28 12:07:56.000000000 -0500
+++ linux-2.4.29-iswraid/drivers/scsi/libata-core.c	2005-01-28 12:14:43.000000000 -0500
@@ -3605,6 +3605,9 @@ int ata_pci_init_one (struct pci_dev *pd
 			legacy_mode = (1 << 3);
 	}
 
+	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_RAID)
+		legacy_mode = 0;
+
 	/* FIXME... */
 	if ((!legacy_mode) && (n_ports > 1)) {
 		printk(KERN_ERR "ata: BUG: native mode, n_ports > 1\n");



