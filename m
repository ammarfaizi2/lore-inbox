Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVCEWs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVCEWs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCEWsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:48:13 -0500
Received: from coderock.org ([193.77.147.115]:46501 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261308AbVCEWnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:06 -0500
Subject: [patch 03/15] block/swim3: replace direct assignment with set_current_state()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:42:48 +0100
Message-Id: <20050305224249.ACC821F202@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

set_current_state() is used instead of direct assignment of
current->state.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/swim3.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/block/swim3.c~set_current_state-drivers_block_swim3 drivers/block/swim3.c
--- kj/drivers/block/swim3.c~set_current_state-drivers_block_swim3	2005-03-05 16:09:15.000000000 +0100
+++ kj-domen/drivers/block/swim3.c	2005-03-05 16:09:15.000000000 +0100
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
