Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUIWUmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUIWUmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUIWUlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:41:21 -0400
Received: from baikonur.stro.at ([213.239.196.228]:25787 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266674AbUIWUZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:06 -0400
Subject: [patch 04/26]  char/epca: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:04 +0200
Message-ID: <E1CAa9I-0007s1-Nt@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/epca.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/epca.c~msleep_interruptible-drivers_char_epca drivers/char/epca.c
--- linux-2.6.9-rc2-bk7/drivers/char/epca.c~msleep_interruptible-drivers_char_epca	2004-09-21 21:08:01.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/epca.c	2004-09-21 21:08:01.000000000 +0200
@@ -563,8 +563,7 @@ static void pc_close(struct tty_struct *
 
 			if (ch->close_delay) 
 			{
-				current->state = TASK_INTERRUPTIBLE;
-				schedule_timeout(ch->close_delay);
+				msleep_interruptible(jiffies_to_msecs(ch->close_delay));
 			}
 
 			wake_up_interruptible(&ch->open_wait);
_
