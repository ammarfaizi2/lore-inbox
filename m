Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUIWU7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUIWU7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUIWU4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:56:14 -0400
Received: from baikonur.stro.at ([213.239.196.228]:62141 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267346AbUIWUx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:53:26 -0400
Subject: [patch 1/2]  ieee1394/nodemgr: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:53:26 +0200
Message-ID: <E1CAaal-0002w5-9G@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Uses msleep_interruptible() in place of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/ieee1394/nodemgr.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -puN drivers/ieee1394/nodemgr.c~msleep_interruptible-drivers_ieee1394_nodemgr drivers/ieee1394/nodemgr.c
--- linux-2.6.9-rc2-bk7/drivers/ieee1394/nodemgr.c~msleep_interruptible-drivers_ieee1394_nodemgr	2004-09-21 21:13:26.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/ieee1394/nodemgr.c	2004-09-21 21:13:26.000000000 +0200
@@ -70,8 +70,7 @@ static int nodemgr_bus_read(struct csr12
 		if (!ret)
 			break;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (schedule_timeout (HZ/3))
+		if (msleep_interruptible(334))
 			return -EINTR;
 	}
 
@@ -1496,7 +1495,7 @@ static int nodemgr_host_thread(void *__h
 		 * to make sure things settle down. */
 		for (i = 0; i < 4 ; i++) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (schedule_timeout(HZ/16)) {
+			if (msleep_interruptible(63)) {
 				up(&nodemgr_serialize);
 				goto caught_signal;
 			}
_
