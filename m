Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUIWUUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUIWUUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUIWUU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:20:29 -0400
Received: from baikonur.stro.at ([213.239.196.228]:47490 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266048AbUIWUTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:19:46 -0400
Subject: [patch 3/5]  pcmcia/ds: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:19:47 +0200
Message-ID: <E1CAa4B-0007DO-Ta@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. This is one (of
many) cases where I made a decision about replacing

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout(some_time);

with

msleep(jiffies_to_msecs(some_time));

msleep() is not exactly the same as the previous code, but I only did
this replacement where I thought long delays were *desired*. If this is
not the case here, then just disregard this patch. 

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/pcmcia/ds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/pcmcia/ds.c~msleep-drivers_pcmcia_ds drivers/pcmcia/ds.c
--- linux-2.6.9-rc2-bk7/drivers/pcmcia/ds.c~msleep-drivers_pcmcia_ds	2004-09-21 20:51:16.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/pcmcia/ds.c	2004-09-21 20:51:16.000000000 +0200
@@ -50,6 +50,7 @@
 #include <linux/poll.h>
 #include <linux/pci.h>
 #include <linux/list.h>
+#include <linux/delay.h>
 #include <linux/workqueue.h>
 
 #include <asm/atomic.h>
@@ -1080,8 +1081,7 @@ static int __devinit pcmcia_bus_add_sock
 	 * Ugly. But we want to wait for the socket threads to have started up.
 	 * We really should let the drivers themselves drive some of this..
 	 */
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ/4);
+	msleep(250);
 
 	init_waitqueue_head(&s->queue);
 	init_waitqueue_head(&s->request);
_
