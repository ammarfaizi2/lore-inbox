Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUIXDnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUIXDnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267766AbUIXDmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:42:09 -0400
Received: from baikonur.stro.at ([213.239.196.228]:29600 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267298AbUIWUd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:33:28 -0400
Subject: [patch 2/3]  message/exec-osm: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:33:24 +0200
Message-ID: <E1CAaHM-0001pg-RL@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/message/i2o/exec-osm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/message/i2o/exec-osm.c~msleep_interruptible-drivers_message_i2o_exec-osm drivers/message/i2o/exec-osm.c
--- linux-2.6.9-rc2-bk7/drivers/message/i2o/exec-osm.c~msleep_interruptible-drivers_message_i2o_exec-osm	2004-09-21 21:17:14.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/message/i2o/exec-osm.c	2004-09-21 21:17:14.000000000 +0200
@@ -29,6 +29,7 @@
 
 #include <linux/module.h>
 #include <linux/i2o.h>
+#include <linux/delay.h>
 
 struct i2o_driver i2o_exec_driver;
 
@@ -151,7 +152,7 @@ int i2o_msg_post_wait_mem(struct i2o_con
 		prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
 
 		if (!iwait->complete)
-			schedule_timeout(timeout * HZ);
+			msleep_interruptible(timeout * 1000);
 
 		finish_wait(&wq, &wait);
 
_
