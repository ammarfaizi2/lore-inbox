Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUIWVMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUIWVMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267389AbUIWVLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:11:18 -0400
Received: from baikonur.stro.at ([213.239.196.228]:43714 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267391AbUIWVI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:59 -0400
Subject: [patch 15/20]  dvb/av7110: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:59 +0200
Message-ID: <E1CAapo-0003xQ-IM@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/av7110.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/media/dvb/ttpci/av7110.c~msleep-drivers_media_dvb_ttpci_av7110 drivers/media/dvb/ttpci/av7110.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/ttpci/av7110.c~msleep-drivers_media_dvb_ttpci_av7110	2004-09-21 20:50:23.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/av7110.c	2004-09-21 20:50:23.000000000 +0200
@@ -89,7 +89,7 @@ static void recover_arm(struct av7110 *a
 	DEB_EE(("av7110: %p\n",av7110));
 
 	av7110_bootarm(av7110);
-        dvb_delay(100); 
+        msleep(100);
         restart_feeds(av7110);
 	av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, av7110->ir_config);
 }
@@ -1510,7 +1510,7 @@ err3:
 	av7110->arm_rmmod = 1;
 	wake_up_interruptible(&av7110->arm_wait);
 	while (av7110->arm_thread)
-		dvb_delay(1);
+		msleep(1);
 err2:
 	av7110_ca_exit(av7110);
 	av7110_av_exit(av7110);
@@ -1546,7 +1546,7 @@ static int av7110_detach (struct saa7146
 	wake_up_interruptible(&av7110->arm_wait);
 
 	while (av7110->arm_thread)
-		dvb_delay(1);
+		msleep(1);
 
 	dvb_unregister(av7110);
 	
_
