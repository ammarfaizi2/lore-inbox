Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWAaNhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWAaNhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWAaNhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:37:15 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:16051 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1750818AbWAaNhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:37:13 -0500
Message-ID: <43DF6807.9020907@indt.org.br>
Date: Tue, 31 Jan 2006 09:37:11 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: [patch 3/5] MMC OMAP driver
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2006 13:35:28.0547 (UTC) FILETIME=[32FD8730:01C6266B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are some misc fixes we've had in the OMAP tree. Might be worth
testing them on other platforms too.

Index: linux-2.6.15-mmc_omap/drivers/mmc/mmc.c
===================================================================
--- linux-2.6.15-mmc_omap.orig/drivers/mmc/mmc.c	2006-01-30 10:24:50.000000000 -0400
+++ linux-2.6.15-mmc_omap/drivers/mmc/mmc.c	2006-01-30 10:25:19.000000000 -0400
@@ -704,6 +704,7 @@ static void mmc_power_up(struct mmc_host
 	int bit = fls(host->ocr_avail) - 1;

 	host->ios.vdd = bit;
+	host->ios.clock = host->f_min;
 	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 	host->ios.chip_select = MMC_CS_DONTCARE;
 	host->ios.power_mode = MMC_POWER_UP;
@@ -712,7 +713,6 @@ static void mmc_power_up(struct mmc_host

 	mmc_delay(1);

-	host->ios.clock = host->f_min;
 	host->ios.power_mode = MMC_POWER_ON;
 	host->ops->set_ios(host, &host->ios);

@@ -747,6 +747,7 @@ static int mmc_send_op_cond(struct mmc_h
 		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
 			break;

+		mmc_delay(1);
 		err = MMC_ERR_TIMEOUT;

 		mmc_delay(10);
