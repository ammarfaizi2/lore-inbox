Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUIAVEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUIAVEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIAVDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:03:02 -0400
Received: from baikonur.stro.at ([213.239.196.228]:13461 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267989AbUIAU5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:18 -0400
Subject: [patch 18/25]  ds1620: replace schedule_timeout() with 	msleep()
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:17 +0200
Message-ID: <E1C2cAP-0007Rx-JK@sputnik>
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

Note: I looked for the appropriate maintainer of this driver, but I did
not find anyone. If someone could tell me who that would be, I would
appreciate it.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/ds1620.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/ds1620.c~msleep-drivers_char_ds1620 drivers/char/ds1620.c
--- linux-2.6.9-rc1-bk7/drivers/char/ds1620.c~msleep-drivers_char_ds1620	2004-09-01 19:34:43.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/ds1620.c	2004-09-01 19:34:43.000000000 +0200
@@ -373,8 +373,7 @@ static int __init ds1620_init(void)
 	th_start.hi = 1;
 	ds1620_write_state(&th_start);
 
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(2*HZ);
+	msleep(2000);
 
 	ds1620_write_state(&th);
 

_
