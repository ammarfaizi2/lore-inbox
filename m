Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWEEQqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWEEQqP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWEEQox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:44:53 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:33668 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751647AbWEEQov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:44:51 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <6.420169009@selenic.com>
Subject: [PATCH 5/14] random: Remove bogus SA_SAMPLE_RANDOM from at91 compact flash driver
Date: Fri, 05 May 2006 11:42:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bogus SA_SAMPLE_RANDOM from at91 compact flash driver

Flash doesn't possess the same unpredictable performance
characteristics as traditional media.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/pcmcia/at91_cf.c
===================================================================
--- 2.6.orig/drivers/pcmcia/at91_cf.c	2006-05-02 17:28:44.000000000 -0500
+++ 2.6/drivers/pcmcia/at91_cf.c	2006-05-03 11:28:06.000000000 -0500
@@ -267,8 +267,7 @@ static int __init at91_cf_probe(struct d
 	);
 
 	/* must be a GPIO; ergo must trigger on both edges */
-	status = request_irq(board->det_pin, at91_cf_irq,
-			SA_SAMPLE_RANDOM, driver_name, cf);
+	status = request_irq(board->det_pin, at91_cf_irq, 0, driver_name, cf);
 	if (status < 0)
 		goto fail0;
 
Index: 2.6/drivers/mmc/at91_mci.c
===================================================================
--- 2.6.orig/drivers/mmc/at91_mci.c	2006-05-02 17:28:43.000000000 -0500
+++ 2.6/drivers/mmc/at91_mci.c	2006-05-03 11:33:40.000000000 -0500
@@ -889,7 +889,7 @@ static int at91_mci_probe(struct platfor
 	 */
 	if (host->board->det_pin) {
 		ret = request_irq(host->board->det_pin, at91_mmc_det_irq,
-				SA_SAMPLE_RANDOM, DRIVER_NAME, host);
+				  0, DRIVER_NAME, host);
 		if (ret)
 			DBG("couldn't allocate MMC detect irq\n");
 	}
