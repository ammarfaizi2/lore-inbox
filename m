Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbSKGUDf>; Thu, 7 Nov 2002 15:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbSKGUDf>; Thu, 7 Nov 2002 15:03:35 -0500
Received: from 3512-780200-242.dialup.surnet.ru ([212.57.170.242]:9488 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S261567AbSKGUDf>;
	Thu, 7 Nov 2002 15:03:35 -0500
Date: Fri, 8 Nov 2002 01:01:21 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] hda: DMA disabled
Message-ID: <20021108010121.A674@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have such a pessimistic messages at the startup, and nothing
relaxing is following, keeping such a feeling that DMA is really
disabled.  The tiny patch below brings the patiency, even though I'm
not sure that this is the exact way.  So, please apply, if it's
appropriate.


--- drivers/ide/ide-iops.c.orig	Thu Nov  7 23:14:03 2002
+++ drivers/ide/ide-iops.c	Thu Nov  7 23:15:01 2002
@@ -891,7 +891,7 @@ int ide_config_drive_speed (ide_drive_t 
 	if (speed >= XFER_SW_DMA_0)
 		hwif->ide_dma_host_on(drive);
 	else
-		hwif->ide_dma_off(drive);
+		hwif->ide_dma_off_quietly(drive);
 #endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 
 	switch(speed) {
