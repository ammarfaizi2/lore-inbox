Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUIWUrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUIWUrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUIWUqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:46:06 -0400
Received: from baikonur.stro.at ([213.239.196.228]:4294 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267291AbUIWUcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:48 -0400
Subject: [patch 21/21]  media/zoran_driver: 	replace schedule_timeout() with ssleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:46 +0200
Message-ID: <E1CAaGk-0001iI-PO@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use ssleep() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/zoran_driver.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/media/video/zoran_driver.c~ssleep-drivers_media_video_zoran_driver drivers/media/video/zoran_driver.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/zoran_driver.c~ssleep-drivers_media_video_zoran_driver	2004-09-21 21:17:34.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/zoran_driver.c	2004-09-21 21:17:34.000000000 +0200
@@ -1917,8 +1917,7 @@ zoran_set_norm (struct zoran *zr,
 		decoder_command(zr, DECODER_SET_NORM, &norm);
 
 		/* let changes come into effect */
-		current->state = TASK_UNINTERRUPTIBLE;
-		schedule_timeout(2 * HZ);
+		ssleep(2);
 
 		decoder_command(zr, DECODER_GET_STATUS, &status);
 		if (!(status & DECODER_STATUS_GOOD)) {
@@ -2639,8 +2638,7 @@ zoran_do_ioctl (struct inode *inode,
 		decoder_command(zr, DECODER_SET_NORM, &norm);
 
 		/* sleep 1 second */
-		current->state = TASK_UNINTERRUPTIBLE;
-		schedule_timeout(1 * HZ);
+		ssleep(1);
 
 		/* Get status of video decoder */
 		decoder_command(zr, DECODER_GET_STATUS, &status);
_
