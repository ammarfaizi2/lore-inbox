Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbVJKGAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbVJKGAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 02:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVJKGAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 02:00:53 -0400
Received: from havoc.gtf.org ([69.61.125.42]:43223 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751383AbVJKGAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 02:00:52 -0400
Date: Tue, 11 Oct 2005 02:00:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] libata driver fix
Message-ID: <20051011060052.GA9375@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Don't presume that newer NV SATA chips follow the same register scheme
as older chips.

 drivers/scsi/sata_nv.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


commit 9621904012de3c8d0d4e2904dcc7170b3012119e
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Tue Oct 11 01:52:39 2005 -0400

    sata_nv: Fixed bug introduced by 0.08's MCP51 and MCP55 support.


diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -29,6 +29,8 @@
  *  NV-specific details such as register offsets, SATA phy location,
  *  hotplug info, etc.
  *
+ *  0.09
+ *     - Fixed bug introduced by 0.08's MCP51 and MCP55 support.
  *
  *  0.08
  *     - Added support for MCP51 and MCP55.
@@ -132,9 +134,7 @@ enum nv_host_type
 	GENERIC,
 	NFORCE2,
 	NFORCE3,
-	CK804,
-	MCP51,
-	MCP55
+	CK804
 };
 
 static struct pci_device_id nv_pci_tbl[] = {
@@ -153,13 +153,13 @@ static struct pci_device_id nv_pci_tbl[]
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
