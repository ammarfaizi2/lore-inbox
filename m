Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUIXDsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUIXDsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267176AbUIXDqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:46:48 -0400
Received: from baikonur.stro.at ([213.239.196.228]:18146 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266884AbUIWUbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:31:50 -0400
Subject: [patch 01/21]  video/bttv-driver: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:31:51 +0200
Message-ID: <E1CAaFr-0000rG-BQ@sputnik>
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



Description: Replace schedule_timeout() with msleep() to guarantee the
task delays for the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/bttv-driver.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/media/video/bttv-driver.c~msleep-drivers_media_video_bttv-driver drivers/media/video/bttv-driver.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/bttv-driver.c~msleep-drivers_media_video_bttv-driver	2004-09-21 20:50:29.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/bttv-driver.c	2004-09-21 20:50:29.000000000 +0200
@@ -743,8 +743,7 @@ static void set_pll(struct bttv *btv)
         for (i=0; i<10; i++) {
 		/*  Let other people run while the PLL stabilizes */
 		vprintk(".");
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/50);
+		msleep(20);
 		
                 if (btread(BT848_DSTATUS) & BT848_DSTATUS_PLOCK) {
 			btwrite(0,BT848_DSTATUS);
_
