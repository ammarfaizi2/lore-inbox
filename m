Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUIXCJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUIXCJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUIWUjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:39:07 -0400
Received: from baikonur.stro.at ([213.239.196.228]:23759 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266825AbUIWUZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:33 -0400
Subject: [patch 14/26]  char/moxa: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:33 +0200
Message-ID: <E1CAa9l-0008MY-EB@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/moxa.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/moxa.c~msleep_interruptible-drivers_char_moxa drivers/char/moxa.c
--- linux-2.6.9-rc2-bk7/drivers/char/moxa.c~msleep_interruptible-drivers_char_moxa	2004-09-21 21:08:13.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/moxa.c	2004-09-21 21:08:13.000000000 +0200
@@ -625,8 +625,7 @@ static void moxa_close(struct tty_struct
 	ch->tty = NULL;
 	if (ch->blocked_open) {
 		if (ch->close_delay) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(ch->close_delay);
+			msleep_interruptible(jiffies_to_msecs(ch->close_delay));
 		}
 		wake_up_interruptible(&ch->open_wait);
 	}
_
