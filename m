Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUIWUzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUIWUzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUIWUw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:52:27 -0400
Received: from baikonur.stro.at ([213.239.196.228]:2786 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267353AbUIWUtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:49:06 -0400
Subject: [patch 3/4]  md/raid10: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:49:07 +0200
Message-ID: <E1CAaWZ-0002pT-Nb@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/md/raid10.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/md/raid10.c~msleep_interruptible-drivers_md_raid10 drivers/md/raid10.c
--- linux-2.6.9-rc2-bk7/drivers/md/raid10.c~msleep_interruptible-drivers_md_raid10	2004-09-21 21:16:51.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/md/raid10.c	2004-09-21 21:16:51.000000000 +0200
@@ -1358,7 +1358,7 @@ static int sync_request(mddev_t *mddev, 
 	 * put in a delay to throttle resync.
 	 */
 	if (!go_faster && waitqueue_active(&conf->wait_resume))
-		schedule_timeout(HZ);
+		msleep_interruptible(1000);
 	device_barrier(conf, sector_nr + RESYNC_SECTORS);
 
 	/* Again, very different code for resync and recovery.
_
