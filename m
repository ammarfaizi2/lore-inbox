Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUIWWbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUIWWbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUIWW3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:29:13 -0400
Received: from baikonur.stro.at ([213.239.196.228]:53406 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267408AbUIWVJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:09:13 -0400
Subject: [patch 20/20]  dvb/ttpci/buget-ci.c: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:09:14 +0200
Message-ID: <E1CAaq2-0004D7-Ty@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Replace dvb_delay() with msleep() to guarantee the
task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/budget-ci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/media/dvb/ttpci/budget-ci.c~msleep-drivers_media_dvb_ttpci_budget-ci drivers/media/dvb/ttpci/budget-ci.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/ttpci/budget-ci.c~msleep-drivers_media_dvb_ttpci_budget-ci	2004-09-21 20:50:28.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/budget-ci.c	2004-09-21 20:50:28.000000000 +0200
@@ -326,7 +326,7 @@ static int ciintf_slot_reset(struct dvb_
 	saa7146_setgpio(saa, 0, SAA7146_GPIO_IRQHI);
 	budget_ci->slot_status = SLOTSTATUS_RESET;
 	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, 0);
-	dvb_delay(1);
+	msleep(1);
 	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, CICONTROL_RESET);
 
 	saa7146_setgpio(saa, 1, SAA7146_GPIO_OUTHI);
@@ -475,7 +475,7 @@ static void ciintf_deinit(struct budget_
 	saa7146_setgpio(saa, 0, SAA7146_GPIO_INPUT);
 	tasklet_kill(&budget_ci->ciintf_irq_tasklet);
 	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, 0);
-	dvb_delay(1);
+	msleep(1);
 	budget_debiwrite(budget_ci, DEBICICTL, DEBIADDR_CICONTROL, 1, CICONTROL_RESET);
 
 	// disable TS data stream to CI interface
_
