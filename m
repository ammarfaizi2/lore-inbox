Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUIWWWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUIWWWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUIWVJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:09:19 -0400
Received: from baikonur.stro.at ([213.239.196.228]:25565 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267356AbUIWVI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:26 -0400
Subject: [patch 03/20]  dvb/dvb_frontend: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:25 +0200
Message-ID: <E1CAapF-0003MD-Pl@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Replace dvb_delay() with msleep() to guarantee the
task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/dvb-core/dvb_frontend.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/media/dvb/dvb-core/dvb_frontend.c~msleep-drivers_media_dvb_dvb-core_dvb_frontend drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/dvb-core/dvb_frontend.c~msleep-drivers_media_dvb_dvb-core_dvb_frontend	2004-09-21 20:50:09.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-09-21 20:50:09.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/poll.h>
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/delay.h>
 #include <asm/processor.h>
 #include <asm/semaphore.h>
 
@@ -233,7 +234,7 @@ static void dvb_call_frontend_notifiers 
 	dprintk ("%s\n", __FUNCTION__);
 
 	if (((s ^ fe->status) & FE_HAS_LOCK) && (s & FE_HAS_LOCK))
-		dvb_delay (fe->info->notifier_delay);
+		msleep (fe->info->notifier_delay);
 
 	fe->status = s;
 
_
