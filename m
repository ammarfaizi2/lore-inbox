Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUIWUnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUIWUnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUIWUm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:42:58 -0400
Received: from baikonur.stro.at ([213.239.196.228]:1163 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267251AbUIWUce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:34 -0400
Subject: [patch 16/21]  media/saa6752hs: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:32 +0200
Message-ID: <E1CAaGW-0001V9-VW@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/saa7134/saa6752hs.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/media/video/saa7134/saa6752hs.c~msleep_interruptible-drivers_media_video_saa6752hs drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/saa7134/saa6752hs.c~msleep_interruptible-drivers_media_video_saa6752hs	2004-09-21 21:17:02.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/saa7134/saa6752hs.c	2004-09-21 21:17:02.000000000 +0200
@@ -168,13 +168,11 @@ static int saa6752hs_chip_command(struct
 		}
 	
 		// wait a bit
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/100);
+		msleep_interruptible(10);
 	}
 
 	// delay a bit to let encoder settle
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ/20);
+	msleep_interruptible(50);
 	
 	// done
   	return status;
_
