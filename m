Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUIWVU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUIWVU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUIWVNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:13:51 -0400
Received: from baikonur.stro.at ([213.239.196.228]:46516 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267375AbUIWVIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:38 -0400
Subject: [patch 07/20]  dvb/cx24110: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:36 +0200
Message-ID: <E1CAapR-0003Yi-0u@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/cx24110.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/media/dvb/frontends/cx24110.c~msleep-drivers_media_dvb_frontends_cs24110 drivers/media/dvb/frontends/cx24110.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/cx24110.c~msleep-drivers_media_dvb_frontends_cs24110	2004-09-21 20:50:14.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/cx24110.c	2004-09-21 20:50:14.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
@@ -247,7 +248,7 @@ static int cx24108_set_tv_freq (struct d
         cx24108_write(i2c,pll);
         cx24110_writereg(i2c,0x56,0x7f);
 
-	dvb_delay(10); /* wait a moment for the tuner pll to lock */
+	msleep(10); /* wait a moment for the tuner pll to lock */
 
 	/* tuner pll lock can be monitored on GPIO pin 4 of cx24110 */
         while (!(cx24110_readreg(i2c,0x66)&0x20)&&i<1000)
_
