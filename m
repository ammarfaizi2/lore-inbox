Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756330AbWKVS0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330AbWKVS0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbWKVS0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:26:20 -0500
Received: from mgw-ext13.nokia.com ([131.228.20.172]:61344 "EHLO
	mgw-ext13.nokia.com") by vger.kernel.org with ESMTP
	id S1756329AbWKVS0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:26:19 -0500
Message-ID: <4564648B.2020005@indt.org.br>
Date: Wed, 22 Nov 2006 10:54:03 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Pierre Ossman <drzeus-list@drzeus.cx>, Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: [patch 5/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_omap_dma.diff
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2006 14:50:12.0379 (UTC) FILETIME=[836C3EB0:01C70E45]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OMAP platform specific patch.
- Adjust the frame size for DMA transfers.

Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-22 09:07:25.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-22 09:19:03.000000000 -0400
@@ -629,6 +629,14 @@ mmc_omap_prepare_dma(struct mmc_omap_hos

  	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
  	frame = data->blksz;
+
+#ifdef CONFIG_MMC_PASSWORDS
+	/* MMC LOCK/UNLOCK: Do frame size multiple of two. This is
+	 * needed for DMA transfers to work properly, once
+	 * the block size depends on MMC password length.
+	 */
+	frame += frame&0x1;
+#endif
  	count = sg_dma_len(sg);

  	if ((data->blocks == 1) && (count > (data->blksz)))

