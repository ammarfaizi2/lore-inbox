Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUIWXx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUIWXx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUIWUpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:45:09 -0400
Received: from baikonur.stro.at ([213.239.196.228]:6331 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267259AbUIWUch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:37 -0400
Subject: [patch 17/21]  media/saa7134-core: 	replace schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:35 +0200
Message-ID: <E1CAaGZ-0001Xm-MD@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/saa7134/saa7134-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/media/video/saa7134/saa7134-core.c~msleep_interruptible-drivers_media_video_saa7134_saa7134-core drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/saa7134/saa7134-core.c~msleep_interruptible-drivers_media_video_saa7134_saa7134-core	2004-09-21 21:17:04.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/saa7134/saa7134-core.c	2004-09-21 21:17:04.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/kmod.h>
 #include <linux/sound.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
 
 #include "saa7134-reg.h"
 #include "saa7134.h"
@@ -910,8 +911,7 @@ static int __devinit saa7134_initdev(str
 	}
 
 	/* wait a bit, register i2c bus */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+	msleep_interruptible(100);
 	saa7134_i2c_register(dev);
 
 	/* initialize hardware #2 */
_
