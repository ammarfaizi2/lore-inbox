Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUIWUzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUIWUzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUIWUxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:53:06 -0400
Received: from baikonur.stro.at ([213.239.196.228]:9447 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267352AbUIWUtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:49:01 -0400
Subject: [patch 1/4]  md/md: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:49:01 +0200
Message-ID: <E1CAaWU-0002kD-82@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/md/md.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/md/md.c~msleep_interruptible-drivers_md_md drivers/md/md.c
--- linux-2.6.9-rc2-bk7/drivers/md/md.c~msleep_interruptible-drivers_md_md	2004-09-21 21:16:48.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/md/md.c	2004-09-21 21:16:48.000000000 +0200
@@ -3468,8 +3468,7 @@ static void md_do_sync(mddev_t *mddev)
 		if (currspeed > sysctl_speed_limit_min) {
 			if ((currspeed > sysctl_speed_limit_max) ||
 					!is_mddev_idle(mddev)) {
-				current->state = TASK_INTERRUPTIBLE;
-				schedule_timeout(HZ/4);
+				msleep_interruptible(250);
 				goto repeat;
 			}
 		}
_
