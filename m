Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUIXCKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUIXCKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUIWUlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:41:13 -0400
Received: from baikonur.stro.at ([213.239.196.228]:63467 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266566AbUIWUZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:09 -0400
Subject: [patch 05/26]  char/esp: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:07 +0200
Message-ID: <E1CAa9L-0007ue-FU@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/esp.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/char/esp.c~msleep_interruptible-drivers_char_esp drivers/char/esp.c
--- linux-2.6.9-rc2-bk7/drivers/char/esp.c~msleep_interruptible-drivers_char_esp	2004-09-21 21:08:02.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/esp.c	2004-09-21 21:08:02.000000000 +0200
@@ -57,6 +57,7 @@
 #include <linux/ioport.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -2074,8 +2075,7 @@ static void rs_close(struct tty_struct *
 
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2106,8 +2106,7 @@ static void rs_wait_until_sent(struct tt
 
 	while ((serial_in(info, UART_ESI_STAT1) != 0x03) ||
 		(serial_in(info, UART_ESI_STAT2) != 0xff)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(char_time);
+		msleep_interruptible(jiffies_to_msecs(char_time));
 
 		if (signal_pending(current))
 			break;
_
