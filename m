Return-Path: <linux-kernel-owner+w=401wt.eu-S1030479AbXALEXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbXALEXa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbXALEX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:23:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030479AbXALEXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:16 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=m0rpyREovM+lOZ+SZQ2yuSoIBb6SPix8PNaaCNpHQtetitnDFnkIFKwMkcBzSn44yaH15xRJko6KgCm2UIDPgiC2jmLvuJKeCRSDM8AycwCQitmqkIYfvDyn1GSYRPEztppWCV7X7HODP6C3OwUAo2z92Y4lch5T6OEH47mRUoU=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:26:52 +0100
Message-Id: <20070112042652.28794.54747.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 7/19] au1xxx-ide: remove dead code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] au1xxx-ide: remove dead code

'speed' is always equal to 'mode' when ide_config_drive_speed() is called

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/mips/au1xxx-ide.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

Index: a/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a.orig/drivers/ide/mips/au1xxx-ide.c
+++ a/drivers/ide/mips/au1xxx-ide.c
@@ -181,12 +181,6 @@ static int auide_tune_chipset (ide_drive
 {
 	int mem_sttime;
 	int mem_stcfg;
-	unsigned long mode;
-
-#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-	if (ide_use_dma(drive))
-		mode = ide_dma_speed(drive, 0);
-#endif
 
 	mem_sttime = 0;
 	mem_stcfg  = au_readl(MEM_STCFG2);
@@ -195,7 +189,7 @@ static int auide_tune_chipset (ide_drive
 		auide_tune_drive(drive, speed - XFER_PIO_0);
 		return 0;
 	}
-	      
+
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 	case XFER_MW_DMA_2:
@@ -207,7 +201,6 @@ static int auide_tune_chipset (ide_drive
 		mem_stcfg &= ~TOECS_MASK;
 		mem_stcfg |= SBC_IDE_MDMA2_TCSOE | SBC_IDE_MDMA2_TOECS;
 
-		mode = XFER_MW_DMA_2;
 		break;
 	case XFER_MW_DMA_1:
 		mem_sttime = SBC_IDE_TIMING(MDMA1);
@@ -218,7 +211,6 @@ static int auide_tune_chipset (ide_drive
 		mem_stcfg &= ~TOECS_MASK;
 		mem_stcfg |= SBC_IDE_MDMA1_TCSOE | SBC_IDE_MDMA1_TOECS;
 
-		mode = XFER_MW_DMA_1;
 		break;
 	case XFER_MW_DMA_0:
 		mem_sttime = SBC_IDE_TIMING(MDMA0);
@@ -229,14 +221,13 @@ static int auide_tune_chipset (ide_drive
 		mem_stcfg &= ~TOECS_MASK;
 		mem_stcfg |= SBC_IDE_MDMA0_TCSOE | SBC_IDE_MDMA0_TOECS;
 
-		mode = XFER_MW_DMA_0;
 		break;
 #endif
 	default:
 		return 1;
 	}
-	
-	if (ide_config_drive_speed(drive, mode))
+
+	if (ide_config_drive_speed(drive, speed))
 		return 1;
 
 	au_writel(mem_sttime,MEM_STTIME2);
