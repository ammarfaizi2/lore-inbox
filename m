Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUIWUrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUIWUrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUIWUq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:46:27 -0400
Received: from baikonur.stro.at ([213.239.196.228]:35719 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267283AbUIWUcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:42 -0400
Subject: [patch 19/21]  media/saa7134-tvaudio: 	replace schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:40 +0200
Message-ID: <E1CAaGf-0001d2-7R@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/saa7134/saa7134-tvaudio.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/media/video/saa7134/saa7134-tvaudio.c~msleep_interruptible-drivers_media_video_saa7134_saa7134-tvaudio drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/saa7134/saa7134-tvaudio.c~msleep_interruptible-drivers_media_video_saa7134_saa7134-tvaudio	2004-09-21 21:17:06.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-09-21 21:17:06.000000000 +0200
@@ -324,11 +324,12 @@ static int tvaudio_sleep(struct saa7134_
 	
 	add_wait_queue(&dev->thread.wq, &wait);
 	if (dev->thread.scan1 == dev->thread.scan2 && !dev->thread.shutdown) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (timeout < 0)
+		if (timeout < 0) {
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
+		}
 		else
-			schedule_timeout(timeout);
+			msleep_interruptible(jiffies_to_msecs(timeout));
 	}
 	remove_wait_queue(&dev->thread.wq, &wait);
 	return dev->thread.scan1 != dev->thread.scan2;
_
