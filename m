Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263087AbUKTCzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbUKTCzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUKTCtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:49:06 -0500
Received: from baikonur.stro.at ([213.239.196.228]:51395 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263092AbUKTCrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:47:05 -0500
Subject: [patch 4/4]  char/snsc: reorder set_current_state() and 	add_wait_queue()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:47:03 +0100
Message-ID: <E1CVLHE-0002XB-AH@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be, as always, appreciated.

-Nish

Description: Reorder add_wait_queue() and set_current_state() as a
signal could be lost in between the two functions.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 linux-2.6.10-rc2-bk4-max/drivers/char/snsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/snsc.c~reorder-state-drivers_char_snsc drivers/char/snsc.c
--- linux-2.6.10-rc2-bk4/drivers/char/snsc.c~reorder-state-drivers_char_snsc	2004-11-20 00:29:55.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/char/snsc.c	2004-11-20 00:29:55.000000000 +0100
@@ -192,8 +192,8 @@ scdrv_read(struct file *file, char __use
 		}
 
 		len = CHUNKSIZE;
-		add_wait_queue(&sd->sd_rq, &wait);
 		set_current_state(TASK_INTERRUPTIBLE);
+		add_wait_queue(&sd->sd_rq, &wait);
 		spin_unlock_irqrestore(&sd->sd_rlock, flags);
 
 		schedule_timeout(SCDRV_TIMEOUT);
@@ -288,8 +288,8 @@ scdrv_write(struct file *file, const cha
 			return -EAGAIN;
 		}
 
-		add_wait_queue(&sd->sd_wq, &wait);
 		set_current_state(TASK_INTERRUPTIBLE);
+		add_wait_queue(&sd->sd_wq, &wait);
 		spin_unlock_irqrestore(&sd->sd_wlock, flags);
 
 		schedule_timeout(SCDRV_TIMEOUT);
_
