Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUIXDkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUIXDkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUIXDgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:36:49 -0400
Received: from baikonur.stro.at ([213.239.196.228]:35803 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267301AbUIWUda
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:33:30 -0400
Subject: [patch 3/3]  message/device: replace 	schedule_timeout() with ssleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:33:27 +0200
Message-ID: <E1CAaHP-0001sJ-Jq@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use ssleep() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/message/i2o/device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/message/i2o/device.c~ssleep-drivers_message_i20_device drivers/message/i2o/device.c
--- linux-2.6.9-rc2-bk7/drivers/message/i2o/device.c~ssleep-drivers_message_i20_device	2004-09-21 21:17:35.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/message/i2o/device.c	2004-09-21 21:17:35.000000000 +0200
@@ -15,6 +15,7 @@
 
 #include <linux/module.h>
 #include <linux/i2o.h>
+#include <linux/delay.h>
 
 /* Exec OSM functions */
 extern struct bus_type i2o_bus_type;
@@ -106,8 +107,7 @@ int i2o_device_claim_release(struct i2o_
 		if (!rc)
 			break;
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ);
+		ssleep(1);
 	}
 
 	if (!rc)
_
