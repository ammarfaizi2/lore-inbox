Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVCFX3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVCFX3r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVCFWhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:37:37 -0500
Received: from coderock.org ([193.77.147.115]:47279 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261539AbVCFWgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:36:21 -0500
Subject: [patch 01/14] char/snsc: reorder set_current_state() and add_wait_queue()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:16 +0100
Message-Id: <20050306223616.C82751EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be, as always, appreciated.

-Nish

Reorder add_wait_queue() and set_current_state() as a
signal could be lost in between the two functions.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/snsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/snsc.c~reorder-state-drivers_char_snsc drivers/char/snsc.c
--- kj/drivers/char/snsc.c~reorder-state-drivers_char_snsc	2005-03-05 16:09:54.000000000 +0100
+++ kj-domen/drivers/char/snsc.c	2005-03-05 16:09:54.000000000 +0100
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
