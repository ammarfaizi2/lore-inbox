Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVBBD3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVBBD3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVBBD3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:29:47 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:60822 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262253AbVBBD1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:27:13 -0500
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, mkrikis@yahoo.com
Subject: [PATCH 2.4.29] libata: fix ata_piix on ICH6R in RAID mode
From: Martins Krikis <mkrikis@yahoo.com>
Date: 01 Feb 2005 22:26:38 -0500
Message-ID: <87d5vjtzf5.fsf@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Here is the cleaned up patch (as you suggested)
that enables ata_piix to work in RAID mode on ICH6R. 
I tested it and it seems to behave correctly
in all the modes---sees all 4 disks in IDE and RAID modes,
doesn't see any in Compatibility mode (which is right, 
because only two are available and the regular IDE driver 
has picked them up already). 

Signed-off-by: Martins Krikis <mkrikis@yahoo.com>

--- linux-2.4.29/drivers/scsi/libata-core.c	2005-01-25 20:55:41.000000000 -0500
+++ linux-2.4.29-iswraid/drivers/scsi/libata-core.c	2005-02-01 20:23:51.000000000 -0500
@@ -3597,7 +3597,8 @@ int ata_pci_init_one (struct pci_dev *pd
 	else
 		port[1] = port[0];
 
-	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0) {
+	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0
+	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		/* TODO: support transitioning to native mode? */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
 		mask = (1 << 2) | (1 << 0);

