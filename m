Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUIWUmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUIWUmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUIWUmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:42:12 -0400
Received: from baikonur.stro.at ([213.239.196.228]:30601 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266187AbUIWUY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:24:58 -0400
Subject: [patch 01/26]  char/amiserial: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:24:55 +0200
Message-ID: <E1CAa9A-0007ji-0J@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/amiserial.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -L /drivers/char/amiserial.c -puN /dev/null /dev/null
diff -puN drivers/char/amiserial.c~msleep_interruptible-drivers_char_amiserial drivers/char/amiserial.c
--- linux-2.6.9-rc2-bk7/drivers/char/amiserial.c~msleep_interruptible-drivers_char_amiserial	2004-09-21 21:07:57.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/amiserial.c	2004-09-21 21:07:57.000000000 +0200
@@ -32,6 +32,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/delay.h>
 
 #undef SERIAL_PARANOIA_CHECK
 #define SERIAL_DO_RESTART
@@ -1567,8 +1568,7 @@ static void rs_close(struct tty_struct *
 	info->tty = 0;
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -1626,8 +1626,7 @@ static void rs_wait_until_sent(struct tt
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("serdatr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(char_time);
+		msleep_interruptible(jiffies_to_msecs(char_time));
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
_
