Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUIWXxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUIWXxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUIWUpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:45:51 -0400
Received: from baikonur.stro.at ([213.239.196.228]:20161 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267186AbUIWUcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:06 -0400
Subject: [patch 07/21]  media/bttv-i2c: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:07 +0200
Message-ID: <E1CAaG8-00017U-5S@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/bttv-i2c.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN drivers/media/video/bttv-i2c.c~msleep_interruptible-drivers_media_video_bttv-i2c drivers/media/video/bttv-i2c.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/bttv-i2c.c~msleep_interruptible-drivers_media_video_bttv-i2c	2004-09-21 21:16:52.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/bttv-i2c.c	2004-09-21 21:16:52.000000000 +0200
@@ -139,10 +139,8 @@ bttv_i2c_wait_done(struct bttv *btv)
 	int rc = 0;
 	
 	add_wait_queue(&btv->i2c_queue, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
 	if (0 == btv->i2c_done)
-		schedule_timeout(HZ/50+1);
-	set_current_state(TASK_RUNNING);
+		msleep_interruptible(20);
 	remove_wait_queue(&btv->i2c_queue, &wait);
 
 	if (0 == btv->i2c_done)
_
