Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424072AbWKQNix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424072AbWKQNix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424330AbWKQNix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:38:53 -0500
Received: from mgw-ext11.nokia.com ([131.228.20.170]:59623 "EHLO
	mgw-ext11.nokia.com") by vger.kernel.org with ESMTP
	id S1424072AbWKQNiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:38:52 -0500
Message-ID: <455DB577.1000103@indt.org.br>
Date: Fri, 17 Nov 2006 09:13:27 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       ext David Brownell <david-b@pacbell.net>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: [patch 6/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Content-Type: multipart/mixed;
 boundary="------------070208020100010900000209"
X-OriginalArrivalTime: 17 Nov 2006 13:09:39.0717 (UTC) FILETIME=[A39C5350:01C70A49]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070208020100010900000209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OMAP platform specific patch.
- Adjust the frame count for DMA transfers.

Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-17 09:05:47.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-17 09:08:30.000000000 -0400
@@ -628,6 +628,10 @@ mmc_omap_prepare_dma(struct mmc_omap_hos

  	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
  	frame = data->blksz;
+
+	/* MMC LOCK/UNLOCK: Do frame size multiple of 16bits (2bytes) */
+	frame += frame&0x1;
+
  	count = sg_dma_len(sg);

  	if ((data->blocks == 1) && (count > (data->blksz)))


--------------070208020100010900000209
Content-Type: text/x-patch;
 name="mmc_omap_dma.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_dma.diff"

OMAP platform specific patch.
- Adjust the frame count for DMA transfers.

Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-17 09:05:47.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-17 09:08:30.000000000 -0400
@@ -628,6 +628,10 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
 
 	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
 	frame = data->blksz;
+
+	/* MMC LOCK/UNLOCK: Do frame size multiple of 16bits (2bytes) */
+	frame += frame&0x1;
+
 	count = sg_dma_len(sg);
 
 	if ((data->blocks == 1) && (count > (data->blksz)))

--------------070208020100010900000209--
