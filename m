Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUIXBhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUIXBhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUIWUoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:44:19 -0400
Received: from baikonur.stro.at ([213.239.196.228]:51600 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267212AbUIWUcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:24 -0400
Subject: [patch 12/21]  media/cx88-video: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:21 +0200
Message-ID: <E1CAaGL-0001Kd-VK@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/cx88/cx88-video.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/media/video/cx88/cx88-video.c~msleep_interruptible-drivers_media_video_cx88_cx88-video drivers/media/video/cx88/cx88-video.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/cx88/cx88-video.c~msleep_interruptible-drivers_media_video_cx88_cx88-video	2004-09-21 21:16:58.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/cx88/cx88-video.c	2004-09-21 21:16:58.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <asm/div64.h>
 
 #include "cx88.h"
@@ -476,8 +477,7 @@ static int set_pll(struct cx8800_dev *de
 			return 0;
 		}
 		dprintk(1,"pll not locked yet, waiting ...\n");
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/10);
+		msleep_interruptible(100);
 	}
 	dprintk(1,"pll NOT locked [pre=%d,ofreq=%d]\n",prescale,ofreq);
 	return -1;
@@ -2237,8 +2237,7 @@ static int cx8800_reset(struct cx8800_de
 	cx_write(MO_INT1_STAT,   0xFFFFFFFF); // Clear RISC int
 
 	/* wait a bit */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+	msleep_interruptible(100);
 	
 	/* init sram */
 	cx88_sram_channel_setup(dev, &cx88_sram_channels[SRAM_CH21], 720*4, 0);
_
