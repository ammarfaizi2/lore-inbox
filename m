Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUIAXV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUIAXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268165AbUIAXTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:19:44 -0400
Received: from baikonur.stro.at ([213.239.196.228]:49374 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267986AbUIAXQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:06 -0400
Subject: [patch 05/14]  radio/radio-cadet: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:06 +0200
Message-ID: <E1C2eKk-0002mz-Gv@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() so the task
is guaranteed to delay the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-cadet.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/media/radio/radio-cadet.c~msleep-drivers_media_radio-cadet drivers/media/radio/radio-cadet.c
--- linux-2.6.9-rc1-bk7/drivers/media/radio/radio-cadet.c~msleep-drivers_media_radio-cadet	2004-09-01 19:35:11.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-cadet.c	2004-09-01 19:35:11.000000000 +0200
@@ -69,8 +69,7 @@ static int cadet_getrds(void)
 	outb(inb(io+1)&0x7f,io+1);  /* Reset RDS detection */
 	spin_unlock(&cadet_io_lock);
 	
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+	msleep(100);
 
 	spin_lock(&cadet_io_lock);	
         outb(3,io);                 /* Select Decoder Control/Status */
@@ -243,8 +242,7 @@ static void cadet_setfreq(unsigned freq)
 		outb(curvol,io+1);
 		spin_unlock(&cadet_io_lock);
 		
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/10);
+		msleep(100);
 
 		cadet_gettune();
 		if((tunestat & 0x40) == 0) {   /* Tuned */

_
