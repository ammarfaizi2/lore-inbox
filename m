Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUIXCJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUIXCJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUIWUjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:39:54 -0400
Received: from baikonur.stro.at ([213.239.196.228]:3242 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S266768AbUIWUZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:24 -0400
Subject: [patch 11/26]  char/isicom: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:24 +0200
Message-ID: <E1CAa9c-0008BK-RN@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/isicom.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/isicom.c~msleep_interruptible-drivers_char_isicom drivers/char/isicom.c
--- linux-2.6.9-rc2-bk7/drivers/char/isicom.c~msleep_interruptible-drivers_char_isicom	2004-09-21 21:08:09.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/isicom.c	2004-09-21 21:08:09.000000000 +0200
@@ -1126,11 +1126,10 @@ static void isicom_close(struct tty_stru
 	port->tty = NULL;
 	if (port->blocked_open) {
 		if (port->close_delay) {
-			set_current_state(TASK_INTERRUPTIBLE);
 #ifdef ISICOM_DEBUG			
 			printk(KERN_DEBUG "ISICOM: scheduling until time out.\n");
 #endif			
-			schedule_timeout(port->close_delay);
+			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
 		wake_up_interruptible(&port->open_wait);
 	}	
_
