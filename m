Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUIWUhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUIWUhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUIWUhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:37:05 -0400
Received: from baikonur.stro.at ([213.239.196.228]:22215 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266808AbUIWUZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:35 -0400
Subject: [patch 15/26]  char/mxser: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:35 +0200
Message-ID: <E1CAa9o-0008PB-9g@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/mxser.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/mxser.c~msleep_interruptible-drivers_char_mxser drivers/char/mxser.c
--- linux-2.6.9-rc2-bk7/drivers/char/mxser.c~msleep_interruptible-drivers_char_mxser	2004-09-21 21:08:14.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/mxser.c	2004-09-21 21:08:14.000000000 +0200
@@ -59,6 +59,7 @@
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -820,8 +821,7 @@ static void mxser_close(struct tty_struc
 	info->tty = NULL;
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
_
