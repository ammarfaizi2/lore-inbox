Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVKAMHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVKAMHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVKAMHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:07:38 -0500
Received: from [85.8.13.51] ([85.8.13.51]:21653 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750768AbVKAMHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:07:37 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Use controller id instead of driver name for printks
Date: Tue, 01 Nov 2005 13:07:32 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051101120731.8145.20792.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The printks that aren't for debugging should use the name of the controller,
not the driver name. Multiple MMC controllers aren't that common today, but
this is the right way to do things.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -201,7 +201,7 @@ static void wbsd_reset(struct wbsd_host*
 {
 	u8 setup;
 
-	printk(KERN_ERR DRIVER_NAME ": Resetting chip\n");
+	printk(KERN_ERR "%s: Resetting chip\n", mmc_hostname(host->mmc));
 
 	/*
 	 * Soft reset of chip (SD/MMC part).
@@ -880,8 +880,9 @@ static void wbsd_finish_data(struct wbsd
 		 */
 		if (count)
 		{
-			printk(KERN_ERR DRIVER_NAME ": Incomplete DMA "
-				"transfer. %d bytes left.\n", count);
+			printk(KERN_ERR "%s: Incomplete DMA transfer. "
+				"%d bytes left.\n",
+				mmc_hostname(host->mmc), count);
 
 			data->error = MMC_ERR_FAILED;
 		}
@@ -1169,8 +1170,8 @@ static void wbsd_tasklet_card(unsigned l
 
 		if (host->mrq)
 		{
-			printk(KERN_ERR DRIVER_NAME
-				": Card removed during transfer!\n");
+			printk(KERN_ERR "%s: Card removed during transfer!\n",
+				mmc_hostname(host->mmc));
 			wbsd_reset(host);
 
 			host->mrq->cmd->error = MMC_ERR_FAILED;

