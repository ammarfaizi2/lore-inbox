Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUIWUhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUIWUhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUIWUhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:37:12 -0400
Received: from baikonur.stro.at ([213.239.196.228]:61855 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266820AbUIWUZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:38 -0400
Subject: [patch 16/26]  char/pcxx: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com,
       christoph@lameter.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:38 +0200
Message-ID: <E1CAa9r-0008SE-3d@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Looks fine to me.
Signed-off-by: Christoph Lameter <christoph@lameter.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/pcxx.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/pcxx.c~msleep_interruptible-drivers_char_pcxx drivers/char/pcxx.c
--- linux-2.6.9-rc2-bk7/drivers/char/pcxx.c~msleep_interruptible-drivers_char_pcxx	2004-09-21 21:08:15.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/pcxx.c	2004-09-21 21:08:15.000000000 +0200
@@ -555,8 +555,7 @@ static void pcxe_close(struct tty_struct
 #endif
 		if(info->blocked_open) {
 			if(info->close_delay) {
-				current->state = TASK_INTERRUPTIBLE;
-				schedule_timeout(info->close_delay);
+				msleep_interruptible(jiffies_to_msecs(info->close_delay));
 			}
 			wake_up_interruptible(&info->open_wait);
 		}
_
