Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbUKTD6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbUKTD6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbUKTCmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:42:55 -0500
Received: from baikonur.stro.at ([213.239.196.228]:2770 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S263072AbUKTCe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:34:57 -0500
Subject: [patch 10/10]  mtd/cfi_cmdset_0020: 	replace schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:34:56 +0100
Message-ID: <E1CVL5V-0001de-9e@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/mtd/chips/cfi_cmdset_0020.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/mtd/chips/cfi_cmdset_0020.c~msleep-drivers_mtd_chips_cfi_cmdset_0020 drivers/mtd/chips/cfi_cmdset_0020.c
--- linux-2.6.10-rc2-bk4/drivers/mtd/chips/cfi_cmdset_0020.c~msleep-drivers_mtd_chips_cfi_cmdset_0020	2004-11-19 17:15:37.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/mtd/chips/cfi_cmdset_0020.c	2004-11-19 17:15:37.000000000 +0100
@@ -788,7 +788,7 @@ retry:
 	chip->state = FL_ERASING;
 	
 	spin_unlock_bh(chip->mutex);
-	schedule_timeout(HZ);
+	msleep(1000);
 	spin_lock_bh(chip->mutex);
 
 	/* FIXME. Use a timer to check this, and return immediately. */
@@ -1087,7 +1087,7 @@ retry:
 	chip->state = FL_LOCKING;
 	
 	spin_unlock_bh(chip->mutex);
-	schedule_timeout(HZ);
+	msleep(1000);
 	spin_lock_bh(chip->mutex);
 
 	/* FIXME. Use a timer to check this, and return immediately. */
@@ -1236,7 +1236,7 @@ retry:
 	chip->state = FL_UNLOCKING;
 	
 	spin_unlock_bh(chip->mutex);
-	schedule_timeout(HZ);
+	msleep(1000);
 	spin_lock_bh(chip->mutex);
 
 	/* FIXME. Use a timer to check this, and return immediately. */
_
