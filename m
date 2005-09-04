Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVIDXjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVIDXjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVIDXjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:39:06 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:53121 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932141AbVIDXa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:59 -0400
Message-Id: <20050904232334.689526000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:46 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-ttpci-budget-ci-fixes.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 47/54] budget-av: fixes for CI interface
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Fixes for CI interface.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/budget-av.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/budget-av.c	2005-09-04 22:03:40.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/budget-av.c	2005-09-04 22:30:56.000000000 +0200
@@ -192,7 +192,7 @@ static int ciintf_slot_reset(struct dvb_
 {
 	struct budget_av *budget_av = (struct budget_av *) ca->data;
 	struct saa7146_dev *saa = budget_av->budget.dev;
-	int timeout = 50; // 5 seconds (4.4.6 Ready)
+	int timeout = 500; // 5 seconds (4.4.6 Ready)
 
 	if (slot != 0)
 		return -EINVAL;
@@ -217,7 +217,6 @@ static int ciintf_slot_reset(struct dvb_
 	{
 		printk(KERN_ERR "budget-av: cam reset failed (timeout).\n");
 		saa7146_setgpio(saa, 2, SAA7146_GPIO_OUTHI); /* disable card */
-		saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTHI); /* Vcc off */
 		return -ETIMEDOUT;
 	}
 
@@ -276,7 +275,6 @@ static int ciintf_poll_slot_status(struc
 		{
 			printk(KERN_INFO "budget-av: cam ejected\n");
 			saa7146_setgpio(saa, 2, SAA7146_GPIO_OUTHI); /* disable card */
-			saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTHI); /* Vcc off */
 			budget_av->slot_status = 0;
 		}
 	}

--

