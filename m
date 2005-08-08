Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVHHWbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVHHWbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVHHWbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:10 -0400
Received: from coderock.org ([193.77.147.115]:32643 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932303AbVHHWak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:30:40 -0400
Message-Id: <20050808223028.714862000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:42 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org
Subject: [patch 06/16] ide-tape: replace schedule_timeout() with msleep()
Content-Disposition: inline; filename=msleep-drivers_ide_ide-tape.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ide-tape.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: quilt/drivers/ide/ide-tape.c
===================================================================
--- quilt.orig/drivers/ide/ide-tape.c
+++ quilt/drivers/ide/ide-tape.c
@@ -2903,8 +2903,7 @@ static int idetape_wait_ready(ide_drive_
 		} else if (!(tape->sense_key == 2 && tape->asc == 4 &&
 			     (tape->ascq == 1 || tape->ascq == 8)))
 			return -EIO;
-		current->state = TASK_INTERRUPTIBLE;
-  		schedule_timeout(HZ / 10);
+		msleep(100);
 	}
 	return -EIO;
 }

--
