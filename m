Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUIXBqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUIXBqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUIXBiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:38:13 -0400
Received: from baikonur.stro.at ([213.239.196.228]:43186 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267334AbUIWUoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:44:25 -0400
Subject: [patch 6/9]  block/pg: replace pg_sleep() with 	msleep_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:44:26 +0200
Message-ID: <E1CAaS3-0002Wk-3U@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. This is a re-push of a patch I
submitted 20 July which hasn't been merged as of
2.6.9-rc1-mm5/2.6.9-rc2. 

Description: msleep_interruptible() is used instead of pg_sleep()
to guarantee the task delays as expected. The defintion of pg_sleep()
is also modified to use set_current_state() instead of direct
assignment.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/block/paride/pg.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/block/paride/pg.c~msleep_interruptible-drivers_block_pg drivers/block/paride/pg.c
--- linux-2.6.9-rc2-bk7/drivers/block/paride/pg.c~msleep_interruptible-drivers_block_pg	2004-09-21 21:07:54.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/block/paride/pg.c	2004-09-21 21:07:54.000000000 +0200
@@ -295,7 +295,7 @@ static inline u8 DRIVE(struct pg *dev)
 
 static void pg_sleep(int cs)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(cs);
 }
 
@@ -409,7 +409,7 @@ static int pg_reset(struct pg *dev)
 	write_reg(dev, 6, DRIVE(dev));
 	write_reg(dev, 7, 8);
 
-	pg_sleep(20 * HZ / 1000);
+	msleep_interruptible(20);
 
 	k = 0;
 	while ((k++ < PG_RESET_TMO) && (status_reg(dev) & STAT_BUSY))
_
