Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267835AbUIAXVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267835AbUIAXVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267846AbUIAXUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:20:50 -0400
Received: from baikonur.stro.at ([213.239.196.228]:22188 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267835AbUIAXPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:15:45 -0400
Subject: [patch 01/14]  cdu31a: replace schedule_timeout() with 	msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:15:44 +0200
Message-ID: <E1C2eKO-0002k9-O2@sputnik>
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

 linux-2.6.9-rc1-bk7-max/drivers/cdrom/cdu31a.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/cdrom/cdu31a.c~msleep-drivers_cdrom_cdu31a drivers/cdrom/cdu31a.c
--- linux-2.6.9-rc1-bk7/drivers/cdrom/cdu31a.c~msleep-drivers_cdrom_cdu31a	2004-09-01 19:34:41.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/cdrom/cdu31a.c	2004-09-01 19:34:41.000000000 +0200
@@ -729,8 +729,7 @@ static void restart_on_error(void)
 		       res_reg[1]);
 	}
 
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(2 * HZ);
+	msleep(2000);
 
 	sony_get_toc();
 }
@@ -960,8 +959,7 @@ retry_cd_operation:
 	if (((result_buffer[0] & 0xf0) == 0x20)
 	    && (num_retries < MAX_CDU31A_RETRIES)) {
 		num_retries++;
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(HZ / 10);	/* Wait .1 seconds on retries */
+		msleep(100):
 		goto retry_cd_operation;
 	}
 

_
