Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUIWUYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUIWUYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUIWUUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:20:54 -0400
Received: from baikonur.stro.at ([213.239.196.228]:1483 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S266073AbUIWUTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:19:49 -0400
Subject: [patch 4/5]  pcmcia/i82365: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:19:50 +0200
Message-ID: <E1CAa4F-0007GS-2o@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. 



Description: Use msleep() instead of schedule_timeout() to 
guarantee the task delays for the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/pcmcia/i82365.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/pcmcia/i82365.c~msleep-drivers_pcmcia_i82365 drivers/pcmcia/i82365.c
--- linux-2.6.9-rc2-bk7/drivers/pcmcia/i82365.c~msleep-drivers_pcmcia_i82365	2004-09-21 20:51:17.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/pcmcia/i82365.c	2004-09-21 20:51:17.000000000 +0200
@@ -513,8 +513,7 @@ static u_int __init test_irq(u_short soc
     if (request_irq(irq, i365_count_irq, 0, "scan", i365_count_irq) != 0)
 	return 1;
     irq_hits = 0; irq_sock = sock;
-    __set_current_state(TASK_UNINTERRUPTIBLE);
-    schedule_timeout(HZ/100);
+    msleep(10);
     if (irq_hits) {
 	free_irq(irq, i365_count_irq);
 	debug(2, "    spurious hit!\n");
_
