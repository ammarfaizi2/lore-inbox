Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUIXCJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUIXCJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUIWUkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:40:17 -0400
Received: from baikonur.stro.at ([213.239.196.228]:25224 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266741AbUIWUZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:18 -0400
Subject: [patch 09/26]  char/hvc_console: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com,
       R.E.Wolff@BitWizard.nl
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:18 +0200
Message-ID: <E1CAa9X-000864-1y@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Looks good.
Signed-off-by: Rogier Wolff <R.E.Wolff@BitWizard.nl>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/hvc_console.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/char/hvc_console.c~msleep_interruptible-drivers_char_hvc_console drivers/char/hvc_console.c
--- linux-2.6.9-rc2-bk7/drivers/char/hvc_console.c~msleep_interruptible-drivers_char_hvc_console	2004-09-21 21:08:07.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/hvc_console.c	2004-09-21 21:08:07.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/tty_flip.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/hvconsole.h>
 #include <asm/vio.h>
@@ -44,7 +45,7 @@
 #define HVC_MAJOR	229
 #define HVC_MINOR	0
 
-#define TIMEOUT		((HZ + 99) / 100)
+#define TIMEOUT		(10)
 
 /*
  * Wait this long per iteration while trying to push buffered data to the
@@ -610,7 +611,7 @@ int khvcd(void *unused)
 			if (poll_mask == 0)
 				schedule();
 			else
-				schedule_timeout(TIMEOUT);
+				msleep_interruptible(TIMEOUT);
 		}
 		__set_current_state(TASK_RUNNING);
 	} while (!kthread_should_stop());
_
