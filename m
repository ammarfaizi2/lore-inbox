Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUIAXN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUIAXN6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267999AbUIAVAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:00:36 -0400
Received: from baikonur.stro.at ([213.239.196.228]:30082 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268000AbUIAU5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:53 -0400
Subject: [patch 24/25]  pcwd: replace schedule_timeout() with 	msleep()
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:50 +0200
Message-ID: <E1C2cAw-0007WP-J6@sputnik>
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
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/watchdog/pcwd.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/watchdog/pcwd.c~msleep-drivers_char_watchdog_pcwd drivers/char/watchdog/pcwd.c
--- linux-2.6.9-rc1-bk7/drivers/char/watchdog/pcwd.c~msleep-drivers_char_watchdog_pcwd	2004-09-01 19:34:47.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/watchdog/pcwd.c	2004-09-01 19:34:47.000000000 +0200
@@ -859,8 +859,7 @@ static int __init pcwd_checkcard(int bas
 		/* Not an 'ff' from a floating bus, so must be a card! */
 		for (i = 0; i < 4; ++i) {
 
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ / 2);
+			msleep(500);
 
 			last_port0 = port0;
 			last_port1 = port1;

_
