Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUIAXN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUIAXN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUIAU7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:59:53 -0400
Received: from baikonur.stro.at ([213.239.196.228]:18385 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267999AbUIAU5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:44 -0400
Subject: [patch 22/25]  isicom: replace schedule_timeout() with 	msleep()
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:39 +0200
Message-ID: <E1C2cAl-0007Uz-JC@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. This is one (of
many) cases where I made a decision about replacing

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout(some_time);

with

msleep(jiffies_to_msecs(some_time));

msleep() is not exactly the same as the previous code, but I only did
this replacement where I thought long delays were *desired*. If this is
not the case here, then just disregard this patch.

Note: I could not find any current Maintainer for this driver. If there
is one I should sent the patch too, please let me know.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/isicom.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/isicom.c~msleep-drivers_char_isicom drivers/char/isicom.c
--- linux-2.6.9-rc1-bk7/drivers/char/isicom.c~msleep-drivers_char_isicom	2004-09-01 21:08:16.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/isicom.c	2004-09-01 21:09:01.000000000 +0200
@@ -48,6 +48,7 @@
 #include <linux/miscdevice.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
+#include <linux/delay.h>
 #include <linux/ioport.h>
 
 #include <asm/uaccess.h>
@@ -1906,8 +1907,7 @@ int init_module(void)
 void cleanup_module(void)
 {
 	re_schedule = 0;
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ);
+	msleep(1000);
 
 #ifdef ISICOM_DEBUG	
 	printk("ISICOM: isicom_tx tx_count = %ld.\n", tx_count);

_
