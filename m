Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUIWUzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUIWUzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUIWUwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:52:49 -0400
Received: from baikonur.stro.at ([213.239.196.228]:45952 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267350AbUIWUtD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:49:03 -0400
Subject: [patch 2/4]  md/raid1: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:49:04 +0200
Message-ID: <E1CAaWW-0002mq-V7@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/md/raid1.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/md/raid1.c~msleep_interruptible-drivers_md_raid1 drivers/md/raid1.c
--- linux-2.6.9-rc2-bk7/drivers/md/raid1.c~msleep_interruptible-drivers_md_raid1	2004-09-21 21:16:50.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/md/raid1.c	2004-09-21 21:16:50.000000000 +0200
@@ -1013,7 +1013,7 @@ static int sync_request(mddev_t *mddev, 
 	 * put in a delay to throttle resync.
 	 */
 	if (!go_faster && waitqueue_active(&conf->wait_resume))
-		schedule_timeout(HZ);
+		msleep_interruptible(1000);
 	device_barrier(conf, sector_nr + RESYNC_SECTORS);
 
 	/*
_
