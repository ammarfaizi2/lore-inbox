Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263051AbUKTCqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbUKTCqF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbUKTCok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:44:40 -0500
Received: from baikonur.stro.at ([213.239.196.228]:43752 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263048AbUKTCea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:34:30 -0500
Subject: [patch 02/10]  ieee/sbp2: replace schedule_timeout() with 	msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:34:29 +0100
Message-ID: <E1CVL53-0001F8-Sx@sputnik>
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



Description: Use msleep() instead of schedule_timeout() to guarantee
desired timeout.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/ieee1394/sbp2.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/ieee1394/sbp2.c~msleep-drivers_ieee1394_sbp2 drivers/ieee1394/sbp2.c
--- linux-2.6.10-rc2-bk4/drivers/ieee1394/sbp2.c~msleep-drivers_ieee1394_sbp2	2004-11-19 17:15:14.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/ieee1394/sbp2.c	2004-11-19 17:15:14.000000000 +0100
@@ -902,8 +902,7 @@ alloc_fail:
 	 * connected to the sbp2 device being removed. That host would
 	 * have a certain amount of time to relogin before the sbp2 device
 	 * allows someone else to login instead. One second makes sense. */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ);
+	msleep(1000);
 
 	/*
 	 * Login to the sbp-2 device
_
