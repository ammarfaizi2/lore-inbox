Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUIWXx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUIWXx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUIWUpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:45:39 -0400
Received: from baikonur.stro.at ([213.239.196.228]:20633 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267195AbUIWUcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:09 -0400
Subject: [patch 08/21]  media/bw-qcam: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:10 +0200
Message-ID: <E1CAaGA-0001A7-Tz@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/bw-qcam.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff -puN drivers/media/video/bw-qcam.c~msleep_interruptible-drivers_media_video_bw-qcam drivers/media/video/bw-qcam.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/bw-qcam.c~msleep_interruptible-drivers_media_video_bw-qcam	2004-09-21 21:16:53.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/bw-qcam.c	2004-09-21 21:16:53.000000000 +0200
@@ -249,8 +249,7 @@ static int qc_waithand(struct qcam_devic
 			   
 			if(runs++>maxpoll)
 			{
-				current->state=TASK_INTERRUPTIBLE;
-				schedule_timeout(HZ/200);
+				msleep_interruptible(5);
 			}
 			if(runs>(maxpoll+1000)) /* 5 seconds */
 				return -1;
@@ -269,8 +268,7 @@ static int qc_waithand(struct qcam_devic
 			   
 			if(runs++>maxpoll)
 			{
-				current->state=TASK_INTERRUPTIBLE;
-				schedule_timeout(HZ/200);
+				msleep_interruptible(5);
 			}
 			if(runs++>(maxpoll+1000)) /* 5 seconds */
 				return -1;
@@ -302,8 +300,7 @@ static unsigned int qc_waithand2(struct 
 		   
 		if(runs++>maxpoll)
 		{
-			current->state=TASK_INTERRUPTIBLE;
-			schedule_timeout(HZ/200);
+			msleep_interruptible(5);
 		}
 		if(runs++>(maxpoll+1000)) /* 5 seconds */
 			return 0;
@@ -669,8 +666,7 @@ long qc_capture(struct qcam_device * q, 
 		   time will be 240 / 200 = 1.2 seconds. The compile-time
 		   default is to yield every 4 lines. */
 		if (i >= yield) {
-			current->state=TASK_INTERRUPTIBLE;
-			schedule_timeout(HZ/200);
+			msleep_interruptible(5);
 			yield = i + yieldlines;
 		}
 	}
_
