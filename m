Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbVAKXm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVAKXm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVAKXmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:42:19 -0500
Received: from coderock.org ([193.77.147.115]:10182 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262951AbVAKXfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:35:23 -0500
Subject: [patch 08/11] char/snsc: reorder set_current_state() and add_wait_queue()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:35:14 +0100
Message-Id: <20050111233514.0320B1F228@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be, as always, appreciated.

-Nish

Description: Reorder add_wait_queue() and set_current_state() as a
signal could be lost in between the two functions.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/snsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/snsc.c~reorder-state-drivers_char_snsc drivers/char/snsc.c
--- kj/drivers/char/snsc.c~reorder-state-drivers_char_snsc	2005-01-10 18:00:24.000000000 +0100
+++ kj-domen/drivers/char/snsc.c	2005-01-10 18:00:24.000000000 +0100
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
