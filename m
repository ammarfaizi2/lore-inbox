Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUIXBqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUIXBqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUIXBjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:39:24 -0400
Received: from baikonur.stro.at ([213.239.196.228]:37784 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267325AbUIWUoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:44:17 -0400
Subject: [patch 3/9]  block/cciss: replace 	schedule_timeout() with msleep_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:44:18 +0200
Message-ID: <E1CAaRu-0002Kt-C7@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. This is a re-push of a patch I
submitted 19 July which hasn't been merged as of
2.6.9-rc1-mm5/2.6.9-rc2. 

Description: msleep_interruptible() is used instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/block/cciss.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/block/cciss.c~msleep_interruptible-drivers_block_cciss drivers/block/cciss.c
--- linux-2.6.9-rc2-bk7/drivers/block/cciss.c~msleep_interruptible-drivers_block_cciss	2004-09-21 21:07:51.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/block/cciss.c	2004-09-21 21:07:51.000000000 +0200
@@ -2381,8 +2381,7 @@ static int cciss_pci_init(ctlr_info_t *c
 		scratchpad = readl(c->vaddr + SA5_SCRATCHPAD_OFFSET);
 		if (scratchpad == CCISS_FIRMWARE_READY)
 			break;
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ / 10); /* wait 100ms */
+		msleep_interruptible(100);
 	}
 	if (scratchpad != CCISS_FIRMWARE_READY) {
 		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
_
