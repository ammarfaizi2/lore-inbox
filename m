Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUIWUrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUIWUrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUIWUqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:46:17 -0400
Received: from baikonur.stro.at ([213.239.196.228]:21703 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267285AbUIWUcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:45 -0400
Subject: [patch 20/21]  media/tda9887: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:43 +0200
Message-ID: <E1CAaGi-0001ff-04@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/tda9887.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/media/video/tda9887.c~msleep_interruptible-drivers_media_video_tda9887 drivers/media/video/tda9887.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/tda9887.c~msleep_interruptible-drivers_media_video_tda9887	2004-09-21 21:17:10.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/tda9887.c	2004-09-21 21:17:10.000000000 +0200
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include <media/audiochip.h>
 #include <media/tuner.h>
@@ -543,8 +544,7 @@ static int tda9887_configure(struct tda9
                 printk(PREFIX "i2c i/o error: rc == %d (should be 4)\n",rc);
 
 	if (debug > 2) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ);
+		msleep_interruptible(1000);
 		tda9887_status(t);
 	}
 	return 0;
_
