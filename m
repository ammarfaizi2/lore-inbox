Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUIWUhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUIWUhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUIWUgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:36:48 -0400
Received: from baikonur.stro.at ([213.239.196.228]:1194 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S266854AbUIWUZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:46 -0400
Subject: [patch 19/26]  char/serial167: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:47 +0200
Message-ID: <E1CAa9z-00008S-A2@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/serial167.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/serial167.c~msleep_interruptible-drivers_char_serial167 drivers/char/serial167.c
--- linux-2.6.9-rc2-bk7/drivers/char/serial167.c~msleep_interruptible-drivers_char_serial167	2004-09-21 21:08:19.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/serial167.c	2004-09-21 21:08:19.000000000 +0200
@@ -1856,8 +1856,7 @@ cy_close(struct tty_struct * tty, struct
     }
     if (info->blocked_open) {
 	if (info->close_delay) {
-	    current->state = TASK_INTERRUPTIBLE;
-	    schedule_timeout(info->close_delay);
+	    msleep_interruptible(jiffies_to_msecs(info->close_delay));
 	}
 	wake_up_interruptible(&info->open_wait);
     }
_
