Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUIWVMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUIWVMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUIWVKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:10:02 -0400
Received: from baikonur.stro.at ([213.239.196.228]:65175 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267382AbUIWVIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:47 -0400
Subject: [patch 11/20]  dvb/stv0299.c: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:48 +0200
Message-ID: <E1CAapc-0003l6-JH@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/stv0299.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/media/dvb/frontends/stv0299.c~msleep-drivers_media_dvb_frontends_stv0299 drivers/media/dvb/frontends/stv0299.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/stv0299.c~msleep-drivers_media_dvb_frontends_stv0299	2004-09-21 20:50:18.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/stv0299.c	2004-09-21 20:50:18.000000000 +0200
@@ -50,6 +50,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <asm/div64.h>
 
 #include "dvb_frontend.h"
@@ -710,7 +711,7 @@ static int stv0299_wait_diseqc_fifo (str
 			dprintk ("%s: timeout!!\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
-		dvb_delay(10);
+		msleep(10);
 	};
 
 	return 0;
@@ -728,7 +729,7 @@ static int stv0299_wait_diseqc_idle (str
 			dprintk ("%s: timeout!!\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
-		dvb_delay(10);
+		msleep(10);
 	};
 
 	return 0;
@@ -1338,7 +1339,7 @@ static int uni0299_attach (struct dvb_i2
 	u8 id;
  
 	stv0299_writereg (i2c, 0x02, 0x34); /* standby off */
-	dvb_delay(200);
+	msleep(200);
 	id = stv0299_readreg (i2c, 0x00);
 
 	dprintk ("%s: id == 0x%02x\n", __FUNCTION__, id);
_
