Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUIXCBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUIXCBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUIWUnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:43:23 -0400
Received: from baikonur.stro.at ([213.239.196.228]:29929 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S265805AbUIWUcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:31 -0400
Subject: [patch 15/21]  media/saa5249: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:29 +0200
Message-ID: <E1CAaGU-0001SW-5s@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/saa5249.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/media/video/saa5249.c~msleep_interruptible-drivers_media_video_saa5249 drivers/media/video/saa5249.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/saa5249.c~msleep_interruptible-drivers_media_video_saa5249	2004-09-21 21:17:01.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/saa5249.c	2004-09-21 21:17:01.000000000 +0200
@@ -273,8 +273,7 @@ static void jdelay(unsigned long delay) 
 	sigfillset(&current->blocked);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(delay);
+	msleep_interruptible(jiffies_to_msecs(delay));
 
 	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = oldblocked;
_
