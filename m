Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUIWUho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUIWUho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUIWUhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:37:32 -0400
Received: from baikonur.stro.at ([213.239.196.228]:18152 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266839AbUIWUZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:40 -0400
Subject: [patch 17/26]  char/riscom8: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:41 +0200
Message-ID: <E1CAa9t-0008Ur-R8@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/riscom8.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/char/riscom8.c~msleep_interruptible-drivers_char_riscom8 drivers/char/riscom8.c
--- linux-2.6.9-rc2-bk7/drivers/char/riscom8.c~msleep_interruptible-drivers_char_riscom8	2004-09-21 21:08:17.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/riscom8.c	2004-09-21 21:08:17.000000000 +0200
@@ -45,6 +45,7 @@
 #include <linux/fcntl.h>
 #include <linux/major.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 
@@ -1114,8 +1115,7 @@ static void rc_close(struct tty_struct *
 		 */
 		timeout = jiffies+HZ;
 		while(port->IER & IER_TXEMPTY)  {
-			current->state = TASK_INTERRUPTIBLE;
- 			schedule_timeout(port->timeout);
+			msleep_interruptible(jiffies_to_msecs(port->timeout));
 			if (time_after(jiffies, timeout))
 				break;
 		}
@@ -1130,8 +1130,7 @@ static void rc_close(struct tty_struct *
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
