Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUIWUrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUIWUrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUIWUqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:46:45 -0400
Received: from baikonur.stro.at ([213.239.196.228]:9177 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267184AbUIWUcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:04 -0400
Subject: [patch 06/21]  media/zr36120: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:05 +0200
Message-ID: <E1CAaG5-00014r-D2@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/zr36120.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/media/video/zr36120.c~msleep-drivers_media_video_zr36120 drivers/media/video/zr36120.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/zr36120.c~msleep-drivers_media_video_zr36120	2004-09-21 21:07:44.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/zr36120.c	2004-09-21 21:07:44.000000000 +0200
@@ -819,8 +819,7 @@ void zoran_close(struct video_device* de
          *      be sure its safe to free the buffer. We wait 5-6 fields
          *      which is more than sufficient to be sure.
          */
-        current->state = TASK_UNINTERRUPTIBLE;
-        schedule_timeout(HZ/10);        /* Wait 1/10th of a second */
+        msleep(100);			/* Wait 1/10th of a second */
 
 	/* free the allocated framebuffer */
 	if (ztv->fbuffer)
@@ -1568,8 +1567,7 @@ void vbi_close(struct video_device *dev)
          *      be sure its safe to free the buffer. We wait 5-6 fields
          *      which is more than sufficient to be sure.
          */
-        current->state = TASK_UNINTERRUPTIBLE;
-        schedule_timeout(HZ/10);        /* Wait 1/10th of a second */
+        msleep(100);			/* Wait 1/10th of a second */
 
 	for (item=ztv->readinfo; item!=ztv->readinfo+ZORAN_VBI_BUFFERS; item++)
 	{
_
