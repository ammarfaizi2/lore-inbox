Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUIBALF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUIBALF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 20:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268186AbUIAXVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:21:19 -0400
Received: from baikonur.stro.at ([213.239.196.228]:53972 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268179AbUIAXQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:53 -0400
Subject: [patch 13/14]  message/i2o_core: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:50 +0200
Message-ID: <E1C2eLS-0002tZ-Jd@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() so the task
is guaranteed to delay the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

Looks good to me, please forward to Linus to apply.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>



---

 linux-2.6.9-rc1-bk7-max/drivers/message/i2o/i2o_core.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/message/i2o/i2o_core.c~msleep-drivers_message_i2o_i2o_core drivers/message/i2o/i2o_core.c
--- linux-2.6.9-rc1-bk7/drivers/message/i2o/i2o_core.c~msleep-drivers_message_i2o_i2o_core	2004-09-01 19:35:24.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/message/i2o/i2o_core.c	2004-09-01 19:35:24.000000000 +0200
@@ -892,8 +892,7 @@ int i2o_release_device(struct i2o_device
 		if((err=i2o_issue_claim(I2O_CMD_UTIL_RELEASE, d->controller, d->lct_data.tid, I2O_CLAIM_PRIMARY)) )
 		{
 			err = -ENXIO;
-			current->state = TASK_UNINTERRUPTIBLE;
-			schedule_timeout(HZ);
+			msleep(1000);
 		}
 		else
 		{

_
