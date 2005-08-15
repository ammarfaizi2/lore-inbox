Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVHOSSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVHOSSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVHOSSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:18:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40918 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964885AbVHOSSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:18:38 -0400
Date: Mon, 15 Aug 2005 11:18:30 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: axboe@suse.de, emoenke@gwdg.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [-mm PATCH 17/32] drivers/cdrom: fix-up schedule_timeout() usage
Message-ID: <20050815181830.GT2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Use schedule_timeout_{un,}interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 drivers/cdrom/sbpcd.c     |    3 +--
 drivers/cdrom/sonycd535.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff -urpN 2.6.13-rc5-mm1/drivers/cdrom/sbpcd.c 2.6.13-rc5-mm1-dev/drivers/cdrom/sbpcd.c
--- 2.6.13-rc5-mm1/drivers/cdrom/sbpcd.c	2005-08-07 10:05:20.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/cdrom/sbpcd.c	2005-08-08 14:18:39.000000000 -0700
@@ -827,8 +827,7 @@ static void mark_timeout_audio(u_long i)
 static void sbp_sleep(u_int time)
 {
 	sti();
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(time);
+	schedule_interruptible_timeout(time);
 	sti();
 }
 /*==========================================================================*/
diff -urpN 2.6.13-rc5-mm1/drivers/cdrom/sonycd535.c 2.6.13-rc5-mm1-dev/drivers/cdrom/sonycd535.c
--- 2.6.13-rc5-mm1/drivers/cdrom/sonycd535.c	2005-08-07 09:57:49.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/cdrom/sonycd535.c	2005-08-12 13:30:50.000000000 -0700
@@ -1478,8 +1477,7 @@ static int __init sony535_init(void)
 	/* look for the CD-ROM, follows the procedure in the DOS driver */
 	inb(select_unit_reg);
 	/* wait for 40 18 Hz ticks (reverse-engineered from DOS driver) */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout((HZ+17)*40/18);
+	schedule_timeout_interruptible((HZ+17)*40/18);
 	inb(result_reg);
 
 	outb(0, read_status_reg);	/* does a reset? */
