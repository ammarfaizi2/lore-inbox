Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUIWUhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUIWUhq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUIWUg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:36:57 -0400
Received: from baikonur.stro.at ([213.239.196.228]:12498 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266837AbUIWUZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:43 -0400
Subject: [patch 18/26]  char/rocket: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:44 +0200
Message-ID: <E1CAa9w-00005o-IG@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/rocket.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/char/rocket.c~msleep_interruptible-drivers_char_rocket drivers/char/rocket.c
--- linux-2.6.9-rc2-bk7/drivers/char/rocket.c~msleep_interruptible-drivers_char_rocket	2004-09-21 21:08:18.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/rocket.c	2004-09-21 21:08:18.000000000 +0200
@@ -1108,8 +1108,7 @@ static void rp_close(struct tty_struct *
 
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	} else {
@@ -1534,8 +1533,7 @@ static void rp_wait_until_sent(struct tt
 #ifdef ROCKET_DEBUG_WAIT_UNTIL_SENT
 		printk(KERN_INFO "txcnt = %d (jiff=%lu,check=%d)...", txcnt, jiffies, check_time);
 #endif
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(check_time);
+		msleep_interruptible(jiffies_to_msecs(check_time));
 		if (signal_pending(current))
 			break;
 	}
_
