Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUIWXx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUIWXx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUIWUpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:45:22 -0400
Received: from baikonur.stro.at ([213.239.196.228]:28111 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267199AbUIWUcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:12 -0400
Subject: [patch 09/21]  media/c-qcam: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:13 +0200
Message-ID: <E1CAaGD-0001Ck-MG@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/c-qcam.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/media/video/c-qcam.c~msleep_interruptible-drivers_media_video_c-qcam drivers/media/video/c-qcam.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/c-qcam.c~msleep_interruptible-drivers_media_video_c-qcam	2004-09-21 21:16:54.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/c-qcam.c	2004-09-21 21:16:54.000000000 +0200
@@ -103,8 +103,7 @@ static unsigned int qcam_await_ready1(st
 	{
 		if (qcam_ready1(qcam) == value)
 			return 0;
-		current->state=TASK_INTERRUPTIBLE;
-		schedule_timeout(HZ/10);
+		msleep_interruptible(100);
 	}
 
 	/* Probably somebody pulled the plug out.  Not much we can do. */
@@ -129,8 +128,7 @@ static unsigned int qcam_await_ready2(st
 	{
 		if (qcam_ready2(qcam) == value)
 			return 0;
-		current->state=TASK_INTERRUPTIBLE;
-		schedule_timeout(HZ/10);
+		msleep_interruptible(100);
 	}
 
 	/* Probably somebody pulled the plug out.  Not much we can do. */
_
