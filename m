Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUIXCJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUIXCJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUIWUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:39:23 -0400
Received: from baikonur.stro.at ([213.239.196.228]:42434 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266807AbUIWUZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:29 -0400
Subject: [patch 13/26]  char/lcd: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:30 +0200
Message-ID: <E1CAa9i-0008Jv-Ne@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/lcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/lcd.c~msleep_interruptible-drivers_char_lcd drivers/char/lcd.c
--- linux-2.6.9-rc2-bk7/drivers/char/lcd.c~msleep_interruptible-drivers_char_lcd	2004-09-21 21:08:12.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/lcd.c	2004-09-21 21:08:12.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/netdevice.h>
 #include <linux/sched.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -583,8 +584,7 @@ static long lcd_read(struct inode *inode
 	lcd_waiters++;
 	while (((buttons_now = (long) button_pressed()) == 0) &&
 	       !(signal_pending(current))) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(2 * HZ);
+		msleep_interruptible(2000);
 	}
 	lcd_waiters--;
 
_
