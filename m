Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUIWUht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUIWUht (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUIWUgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:36:39 -0400
Received: from baikonur.stro.at ([213.239.196.228]:4035 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S266845AbUIWUZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:49 -0400
Subject: [patch 20/26]  char/specialix: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:49 +0200
Message-ID: <E1CAaA2-0000B5-26@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of schedule_timeout() to guarantee
the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/specialix.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/char/specialix.c~msleep_interruptible-drivers_char_specialix drivers/char/specialix.c
--- linux-2.6.9-rc2-bk7/drivers/char/specialix.c~msleep_interruptible-drivers_char_specialix	2004-09-21 21:08:20.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/specialix.c	2004-09-21 21:08:20.000000000 +0200
@@ -1452,8 +1452,7 @@ static void sx_close(struct tty_struct *
 		 */
 		timeout = jiffies+HZ;
 		while(port->IER & IER_TXEMPTY) {
-			current->state = TASK_INTERRUPTIBLE;
- 			schedule_timeout(port->timeout);
+			msleep_interruptible(jiffies_to_msecs(port->timeout));
 			if (time_after(jiffies, timeout)) {
 				printk (KERN_INFO "Timeout waiting for close\n");
 				break;
@@ -1471,8 +1470,7 @@ static void sx_close(struct tty_struct *
 	port->tty = NULL;
 	if (port->blocked_open) {
 		if (port->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->close_delay);
+			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
 		wake_up_interruptible(&port->open_wait);
 	}
_
