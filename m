Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUIXADu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUIXADu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUIXACx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:02:53 -0400
Received: from baikonur.stro.at ([213.239.196.228]:20408 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267250AbUIWUob
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:44:31 -0400
Subject: [patch 8/9]  block/swim3: replace direct 	assignment with set_current_state()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:44:32 +0200
Message-ID: <E1CAaS8-0002d4-NV@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: set_current_state() is used instead of direct assignment of
current->state.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/block/swim3.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/block/swim3.c~set_current_state-drivers_block_swim3 drivers/block/swim3.c
--- linux-2.6.9-rc2-bk7/drivers/block/swim3.c~set_current_state-drivers_block_swim3	2004-09-21 21:17:25.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/block/swim3.c	2004-09-21 21:17:25.000000000 +0200
@@ -832,7 +832,7 @@ static int fd_eject(struct floppy_state 
 			break;
 		}
 		swim3_select(fs, RELAX);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 		if (swim3_readbit(fs, DISK_IN) == 0)
 			break;
@@ -900,7 +900,7 @@ static int floppy_open(struct inode *ino
 				break;
 			}
 			swim3_select(fs, RELAX);
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);
 		}
 		if (err == 0 && (swim3_readbit(fs, SEEK_COMPLETE) == 0
@@ -984,7 +984,7 @@ static int floppy_revalidate(struct gend
 		if (signal_pending(current))
 			break;
 		swim3_select(fs, RELAX);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	ret = swim3_readbit(fs, SEEK_COMPLETE) == 0
_
