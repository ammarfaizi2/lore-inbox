Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbUKTCqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbUKTCqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUKTCov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:44:51 -0500
Received: from baikonur.stro.at ([213.239.196.228]:9119 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S263046AbUKTCe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:34:26 -0500
Subject: [patch 01/10]  ide-tape: replace schedule_timeout() with 	msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:34:24 +0100
Message-ID: <E1CVL4z-00019f-B1@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. This is one (of
many) cases where I made a decision about replacing

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout(some_time);

with

msleep(jiffies_to_msecs(some_time));

msleep() is not exactly the same as the previous code, but I only did
this replacement where I thought long delays were *desired*. If this is
not the case here, then just disregard this patch.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/ide/ide-tape.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/ide/ide-tape.c~msleep-drivers_ide_ide-tape drivers/ide/ide-tape.c
--- linux-2.6.10-rc2-bk4/drivers/ide/ide-tape.c~msleep-drivers_ide_ide-tape	2004-11-19 17:15:12.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/ide/ide-tape.c	2004-11-19 17:15:12.000000000 +0100
@@ -2854,8 +2854,7 @@ static int idetape_wait_ready(ide_drive_
 		} else if (!(tape->sense_key == 2 && tape->asc == 4 &&
 			     (tape->ascq == 1 || tape->ascq == 8)))
 			return -EIO;
-		current->state = TASK_INTERRUPTIBLE;
-  		schedule_timeout(HZ / 10);
+		msleep(100);
 	}
 	return -EIO;
 }
_
