Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUIWUz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUIWUz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUIWUwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:52:02 -0400
Received: from baikonur.stro.at ([213.239.196.228]:42961 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267354AbUIWUtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:49:09 -0400
Subject: [patch 4/4]  mmc: replace schedule_timeout() 	with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:49:10 +0200
Message-ID: <E1CAaWc-0002s3-Fd@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/mmc/mmc.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/mmc/mmc.c~msleep_interruptible-drivers_mmc_mmc drivers/mmc/mmc.c
--- linux-2.6.9-rc2-bk7/drivers/mmc/mmc.c~msleep_interruptible-drivers_mmc_mmc	2004-09-21 21:17:16.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/mmc/mmc.c	2004-09-21 21:17:16.000000000 +0200
@@ -270,8 +270,7 @@ static inline void mmc_delay(unsigned in
 		yield();
 		mdelay(ms);
 	} else {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(ms * HZ / 1000);
+		msleep_interruptible (ms);
 	}
 }
 
_
