Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263067AbUKTCni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbUKTCni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbUKTCnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:43:10 -0500
Received: from baikonur.stro.at ([213.239.196.228]:14725 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263070AbUKTCey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:34:54 -0500
Subject: [patch 09/10]  mtd/cfi_cmdset_0002: 	replace schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:34:53 +0100
Message-ID: <E1CVL5R-0001an-Vb@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/mtd/chips/cfi_cmdset_0002.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/mtd/chips/cfi_cmdset_0002.c~msleep-drivers_mtd_chips_cfi_cmdset_0002 drivers/mtd/chips/cfi_cmdset_0002.c
--- linux-2.6.10-rc2-bk4/drivers/mtd/chips/cfi_cmdset_0002.c~msleep-drivers_mtd_chips_cfi_cmdset_0002	2004-11-19 17:15:36.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/mtd/chips/cfi_cmdset_0002.c	2004-11-19 17:15:36.000000000 +0100
@@ -1173,8 +1173,7 @@ static inline int do_erase_chip(struct m
 	chip->in_progress_block_addr = adr;
 
 	cfi_spin_unlock(chip->mutex);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout((chip->erase_time*HZ)/(2*1000));
+	msleep(chip->erase_time/2);
 	cfi_spin_lock(chip->mutex);
 
 	timeo = jiffies + (HZ*20);
@@ -1259,8 +1258,7 @@ static inline int do_erase_oneblock(stru
 	chip->in_progress_block_addr = adr;
 	
 	cfi_spin_unlock(chip->mutex);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout((chip->erase_time*HZ)/(2*1000));
+	msleep(chip->erase_time/2);
 	cfi_spin_lock(chip->mutex);
 
 	timeo = jiffies + (HZ*20);
_
