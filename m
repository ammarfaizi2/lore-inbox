Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUIXDjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUIXDjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUIWUdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:33:17 -0400
Received: from baikonur.stro.at ([213.239.196.228]:63673 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266878AbUIWU0D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:26:03 -0400
Subject: [patch 25/26]  char/tpqic02: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:26:03 +0200
Message-ID: <E1CAaAG-0000Rj-7g@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/tpqic02.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/tpqic02.c~msleep_interruptible-drivers_char_tpqic02 drivers/char/tpqic02.c
--- linux-2.6.9-rc2-bk7/drivers/char/tpqic02.c~msleep_interruptible-drivers_char_tpqic02	2004-09-21 21:08:26.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/tpqic02.c	2004-09-21 21:08:26.000000000 +0200
@@ -554,10 +554,9 @@ static int wait_for_ready(time_t timeout
 	    /* not ready and no exception && timeout not expired yet */
 	while (((stat = inb_p(QIC02_STAT_PORT) & QIC02_STAT_MASK) == QIC02_STAT_MASK) && time_before(jiffies, spin_t)) {
 		/* be `nice` to other processes on long operations... */
-		current->state = TASK_INTERRUPTIBLE;
 		/* nap 0.30 sec between checks, */
 		/* but could be woken up earlier by signals... */
-		schedule_timeout(3 * HZ / 10);
+		msleep_interruptible(300);
 	}
 
 	/* don't use jiffies for this test because it may have changed by now */
_
