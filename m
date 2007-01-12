Return-Path: <linux-kernel-owner+w=401wt.eu-S1030505AbXALEYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbXALEYQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030519AbXALEYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:24:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030494AbXALEXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:34 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=VOy1iogarvJ4ZtDU7YxT0vf9tU/2JAeC5Ku/TOHBWXmEhlseozQF8owK9oYQsPRoJltNm/DdVFeKcOZ2fvxI04D9intECrvpxM6i/c7jp9/WLvGLdX8dnILOwC7dkrzFf6PA83V0OpGYL615CKlRDHxeiZxz16woqGl6YMIrNqg=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:27:10 +0100
Message-Id: <20070112042710.28794.40403.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 10/19] trm290: remove redundant CONFIG_BLK_DEV_IDEDMA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] trm290: remove redundant CONFIG_BLK_DEV_IDEDMA #ifdef-s

In drivers/ide/Kconfig BLK_DEV_TRM290 depends on
BLK_DEV_IDEDMA_PCI (on which is BLK_DEV_IDEDMA dependant on).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/trm290.c |    4 ----
 1 file changed, 4 deletions(-)

Index: a/drivers/ide/pci/trm290.c
===================================================================
--- a.orig/drivers/ide/pci/trm290.c
+++ a/drivers/ide/pci/trm290.c
@@ -177,7 +177,6 @@ static void trm290_selectproc (ide_drive
 	trm290_prepare_drive(drive, drive->using_dma);
 }
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
 static void trm290_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -242,7 +241,6 @@ static int trm290_ide_dma_test_irq (ide_
 	status = hwif->INW(hwif->dma_status);
 	return (status == 0x00ff);
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 /*
  * Invoked from ide-dma.c at boot time.
@@ -289,13 +287,11 @@ static void __devinit init_hwif_trm290(i
 
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080 : 0x0000), 3);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
 	hwif->dma_setup = &trm290_ide_dma_setup;
 	hwif->dma_exec_cmd = &trm290_ide_dma_exec_cmd;
 	hwif->dma_start = &trm290_ide_dma_start;
 	hwif->ide_dma_end = &trm290_ide_dma_end;
 	hwif->ide_dma_test_irq = &trm290_ide_dma_test_irq;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
 	hwif->selectproc = &trm290_selectproc;
 	hwif->autodma = 0;		/* play it safe for now */
