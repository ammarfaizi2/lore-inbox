Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbVINNNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbVINNNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVINNNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:13:47 -0400
Received: from havoc.gtf.org ([69.61.125.42]:15022 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965191AbVINNNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:13:46 -0400
Date: Wed, 14 Sep 2005 09:13:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20050914131343.GA1080@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the following fixes:


 drivers/scsi/sata_sis.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Arnaud Patard:
  sata_sis: Fix typo in sata port2 initialisation

Uwe Koziolek:
  sata_sis: uninitialized variable


diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -161,7 +161,7 @@ static u32 sis_scr_cfg_read (struct ata_
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev->device);
-	u32 val, val2;
+	u32 val, val2 = 0;
 	u8 pmr;
 
 	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
@@ -289,7 +289,7 @@ static int sis_init_one (struct pci_dev 
 	if (ent->device != 0x182) {
 		if ((pmr & SIS_PMR_COMBINED) == 0) {
 			printk(KERN_INFO "sata_sis: Detected SiS 180/181 chipset in SATA mode\n");
-			port2_start=0x64;
+			port2_start = 64;
 		}
 		else {
 			printk(KERN_INFO "sata_sis: Detected SiS 180/181 chipset in combined mode\n");
