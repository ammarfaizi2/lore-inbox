Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268196AbUIAXVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268196AbUIAXVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268180AbUIAXTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:19:53 -0400
Received: from baikonur.stro.at ([213.239.196.228]:41951 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267971AbUIAXQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:01 -0400
Subject: [patch 04/14]  radio/radio-aimslab: replace 	while/schedule() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:00 +0200
Message-ID: <E1C2eKf-0002mH-2f@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Uses msleep() instead of a while-loop and schedule(). Thus
the CPU is given up for the time desired.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-aimslab.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)

diff -puN drivers/media/radio/radio-aimslab.c~msleep-drivers_media_radio-aimslab drivers/media/radio/radio-aimslab.c
--- linux-2.6.9-rc1-bk7/drivers/media/radio/radio-aimslab.c~msleep-drivers_media_radio-aimslab	2004-09-01 19:35:10.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-aimslab.c	2004-09-01 19:35:10.000000000 +0200
@@ -63,12 +63,7 @@ static void sleep_delay(long n)
 	if(!d)
 		udelay(n);
 	else
-	{
-		/* Yield CPU time */
-		unsigned long x=jiffies;
-		while((jiffies-x)<=d)
-			schedule();
-	}
+		msleep(jiffies_to_msecs(d));
 }
 
 static void rt_decvol(void)

_
