Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVAKXQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVAKXQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbVAKXQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:16:32 -0500
Received: from coderock.org ([193.77.147.115]:7621 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262870AbVAKXQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:16:24 -0500
Subject: [patch 1/1] ide-tape: replace schedule_timeout() with msleep()
To: gadio@netvision.net.il
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:16:18 +0100
Message-Id: <20050111231619.558831F225@trashy.coderock.org>
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
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/ide-tape.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/ide/ide-tape.c~msleep-drivers_ide_ide-tape drivers/ide/ide-tape.c
--- kj/drivers/ide/ide-tape.c~msleep-drivers_ide_ide-tape	2005-01-10 17:59:47.000000000 +0100
+++ kj-domen/drivers/ide/ide-tape.c	2005-01-10 17:59:47.000000000 +0100
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
