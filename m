Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUIWUrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUIWUrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUIWUqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:46:35 -0400
Received: from baikonur.stro.at ([213.239.196.228]:13732 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267248AbUIWUck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:40 -0400
Subject: [patch 18/21]  media/saa7134-ts: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:38 +0200
Message-ID: <E1CAaGc-0001aP-Ez@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/saa7134/saa7134-ts.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/media/video/saa7134/saa7134-ts.c~msleep_interruptible-drivers_media_video_saa7134_saa7134-ts drivers/media/video/saa7134/saa7134-ts.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/saa7134/saa7134-ts.c~msleep_interruptible-drivers_media_video_saa7134_saa7134-ts	2004-09-21 21:17:05.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/saa7134/saa7134-ts.c	2004-09-21 21:17:05.000000000 +0200
@@ -176,8 +176,7 @@ static void ts_reset_encoder(struct saa7
 	saa_writeb(SAA7134_SPECIAL_MODE, 0x00);
 	mdelay(10);
    	saa_writeb(SAA7134_SPECIAL_MODE, 0x01);
-   	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+   	msleep_interruptible(100);
 }
 
 static int ts_init_encoder(struct saa7134_dev* dev, void* arg) 
_
