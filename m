Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVAKXYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVAKXYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVAKXUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:20:32 -0500
Received: from coderock.org ([193.77.147.115]:21189 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262920AbVAKXS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:18:58 -0500
Subject: [patch 3/4] block/swim3: replace direct assignment with set_current_state()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:18:48 +0100
Message-Id: <20050111231848.743771F225@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: set_current_state() is used instead of direct assignment of
current->state.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/swim3.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/block/swim3.c~set_current_state-drivers_block_swim3 drivers/block/swim3.c
--- kj/drivers/block/swim3.c~set_current_state-drivers_block_swim3	2005-01-10 17:59:55.000000000 +0100
+++ kj-domen/drivers/block/swim3.c	2005-01-10 17:59:55.000000000 +0100
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
