Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUIWU70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUIWU70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUIWU4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:56:42 -0400
Received: from baikonur.stro.at ([213.239.196.228]:20176 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267352AbUIWUx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:53:28 -0400
Subject: [patch 2/2]  ieee1394/sbp2: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:53:29 +0200
Message-ID: <E1CAaao-0002yl-0g@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Uses msleep_interruptible() in place of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/ieee1394/sbp2.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/ieee1394/sbp2.c~msleep_interruptible-drivers_ieee1394_sbp2 drivers/ieee1394/sbp2.c
--- linux-2.6.9-rc2-bk7/drivers/ieee1394/sbp2.c~msleep_interruptible-drivers_ieee1394_sbp2	2004-09-21 21:16:32.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/ieee1394/sbp2.c	2004-09-21 21:16:32.000000000 +0200
@@ -357,8 +357,7 @@ static int sbp2util_down_timeout(atomic_
 	int i;
 
 	for (i = timeout; (i > 0 && atomic_read(done) == 0); i-= HZ/10) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (schedule_timeout(HZ/10))	/* 100ms */
+		if (msleep_interruptible(100))	/* 100ms */
 			return(1);
 	}
 	return ((i > 0) ? 0:1);
_
