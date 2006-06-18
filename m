Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWFRRWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWFRRWB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWFRRWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:22:01 -0400
Received: from bay105-f37.bay105.hotmail.com ([65.54.224.47]:38936 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932263AbWFRRWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:22:00 -0400
Message-ID: <BAY105-F37E386C7671BF4F79ABE01A3810@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Cc: tobiasoed@hotmail.com
Subject: [patch] pdc202xx_old depends on CONFIG_BLK_DEV_IDEDMA
Date: Sun, 18 Jun 2006 13:21:58 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Jun 2006 17:22:00.0063 (UTC) FILETIME=[B52BC8F0:01C692FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver pdc202xx_old requires CONFIG_BLK_DEV_IDEDMA, so it's always 
defined

Signed-off-by: Tobias Oed <tobiasoed@hotmail.com>

--- linux-2.6.17-rc1-mm3-1/drivers/ide/pci/pdc202xx_old.c       2006-04-26 
11:59:42.000000000 +0200
+++ linux-2.6.17-rc1-mm3-2/drivers/ide/pci/pdc202xx_old.c       2006-04-26 
11:59:52.000000000 +0200
@@ -491,12 +491,8 @@

static void pdc202xx_reset_host (ide_hwif_t *hwif)
{
-#ifdef CONFIG_BLK_DEV_IDEDMA
//     unsigned long high_16   = hwif->dma_base - (8*(hwif->channel));
        unsigned long high_16   = hwif->dma_master;
-#else /* !CONFIG_BLK_DEV_IDEDMA */
-       unsigned long high_16   = pci_resource_start(hwif->pci_dev, 4);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
        u8 udma_speed_flag      = hwif->INB(high_16|0x001f);

        hwif->OUTB((udma_speed_flag | 0x10), (high_16|0x001f));

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

