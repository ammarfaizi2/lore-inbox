Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUIWXy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUIWXy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbUIWUod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:44:33 -0400
Received: from baikonur.stro.at ([213.239.196.228]:20642 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267209AbUIWUcV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:21 -0400
Subject: [patch 11/21]  media/cx88-tvaudio: 	replace schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:18 +0200
Message-ID: <E1CAaGJ-0001I0-70@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/cx88/cx88-tvaudio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/media/video/cx88/cx88-tvaudio.c~msleep_interruptible-drivers_media_video_cx88_cx88-tvaudio drivers/media/video/cx88/cx88-tvaudio.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/cx88/cx88-tvaudio.c~msleep_interruptible-drivers_media_video_cx88_cx88-tvaudio	2004-09-21 21:16:57.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/cx88/cx88-tvaudio.c	2004-09-21 21:16:57.000000000 +0200
@@ -49,6 +49,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/delay.h>
 
 #include "cx88.h"
 
@@ -785,8 +786,7 @@ int cx88_audio_thread(void *data)
 	dprintk("cx88: tvaudio thread started\n");
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ*3);
+		msleep_interruptible(3000);
 		if (signal_pending(current))
 			break;
 		if (dev->shutdown)
_
