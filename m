Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267594AbUIAXkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267594AbUIAXkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUIAXjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:39:33 -0400
Received: from baikonur.stro.at ([213.239.196.228]:41678 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268182AbUIAXQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:59 -0400
Subject: [patch 14/14]  mtd/cfi_cmdset_0001: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:55 +0200
Message-ID: <E1C2eLY-0002uJ-Bk@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() so the task
is guaranteed to delay the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/mtd/chips/cfi_cmdset_0001.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/mtd/chips/cfi_cmdset_0001.c~msleep-drivers_mtd_chips_cfi_cmdset_0001 drivers/mtd/chips/cfi_cmdset_0001.c
--- linux-2.6.9-rc1-bk7/drivers/mtd/chips/cfi_cmdset_0001.c~msleep-drivers_mtd_chips_cfi_cmdset_0001	2004-09-01 19:35:25.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/mtd/chips/cfi_cmdset_0001.c	2004-09-01 19:35:25.000000000 +0200
@@ -1437,8 +1437,7 @@ static int do_erase_oneblock(struct map_
 
 	spin_unlock(chip->mutex);
 	INVALIDATE_CACHED_RANGE(map, adr, len);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout((chip->erase_time*HZ)/(2*1000));
+	msleep(chip->erase_time / 2);
 	spin_lock(chip->mutex);
 
 	/* FIXME. Use a timer to check this, and return immediately. */

_
