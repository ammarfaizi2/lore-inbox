Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUIXDsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUIXDsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUIXDqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:46:38 -0400
Received: from baikonur.stro.at ([213.239.196.228]:5343 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267176AbUIWUcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:01 -0400
Subject: [patch 05/21]  media/ovcamchip_core: 	replace schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:02 +0200
Message-ID: <E1CAaG2-00012E-Ju@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/ovcamchip/ovcamchip_core.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/media/video/ovcamchip/ovcamchip_core.c~msleep-drivers_media_video_ovcamchip_ovcamchip_core drivers/media/video/ovcamchip/ovcamchip_core.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/ovcamchip/ovcamchip_core.c~msleep-drivers_media_video_ovcamchip_ovcamchip_core	2004-09-21 21:07:43.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/ovcamchip/ovcamchip_core.c	2004-09-21 21:07:43.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include "ovcamchip_priv.h"
 
 #define DRIVER_VERSION "v2.27 for Linux 2.6"
@@ -128,8 +129,7 @@ static int init_camchip(struct i2c_clien
 	ov_write(c, 0x12, 0x80);
 
 	/* Wait for it to initialize */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(1 + 150 * HZ / 1000);
+	msleep(150);
 
 	for (i = 0, success = 0; i < I2C_DETECT_RETRIES && !success; i++) {
 		if (ov_read(c, GENERIC_REG_ID_HIGH, &high) >= 0) {
@@ -145,8 +145,7 @@ static int init_camchip(struct i2c_clien
 		ov_write(c, 0x12, 0x80);
 
 		/* Wait for it to initialize */
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1 + 150 * HZ / 1000);
+		msleep(150);
 
 		/* Dummy read to sync I2C */
 		ov_read(c, 0x00, &low);
_
