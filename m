Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263064AbUKTCnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUKTCnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbUKTCnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:43:20 -0500
Received: from baikonur.stro.at ([213.239.196.228]:33502 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263064AbUKTCeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:34:44 -0500
Subject: [patch 06/10]  ide/ide-cs: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:34:43 +0100
Message-ID: <E1CVL5I-0001SC-03@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Uses msleep() in place of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/ide/legacy/ide-cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs drivers/ide/legacy/ide-cs.c
--- linux-2.6.10-rc2-bk4/drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs	2004-11-19 17:15:29.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/ide/legacy/ide-cs.c	2004-11-19 17:15:29.000000000 +0100
@@ -43,6 +43,7 @@
 #include <linux/ide.h>
 #include <linux/hdreg.h>
 #include <linux/major.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -357,8 +358,7 @@ void ide_config(dev_link_t *link)
 		break;
 	    }
 	}
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+	msleep(100);
     }
 
     if (hd < 0) {
_
