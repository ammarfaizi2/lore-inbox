Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUIXB5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUIXB5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUIWUno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:43:44 -0400
Received: from baikonur.stro.at ([213.239.196.228]:60393 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267234AbUIWUc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:28 -0400
Subject: [patch 14/21]  media/planb: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:27 +0200
Message-ID: <E1CAaGR-0001Pt-EW@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/planb.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/media/video/planb.c~msleep_interruptible-drivers_media_video_planb drivers/media/video/planb.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/planb.c~msleep_interruptible-drivers_media_video_planb	2004-09-21 21:17:00.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/planb.c	2004-09-21 21:17:00.000000000 +0200
@@ -178,8 +178,7 @@ static unsigned char saa_status(int byte
 	saa_write_reg (SAA7196_STDC, saa_regs[pb->win.norm][SAA7196_STDC]);
 
 	/* Let's wait 30msec for this one */
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(30 * HZ / 1000);
+	msleep_interruptible(30);
 
 	return (unsigned char)in_8 (&planb_regs->saa_status);
 }
_
