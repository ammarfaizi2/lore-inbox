Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUIWVUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUIWVUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUIWVOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:14:32 -0400
Received: from baikonur.stro.at ([213.239.196.228]:65227 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267377AbUIWVIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:40 -0400
Subject: [patch 08/20]  dvb/dst: replace schedule_timeout() with 	msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:39 +0200
Message-ID: <E1CAapT-0003br-S2@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/dst.c |   20 +++++++-------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff -puN drivers/media/dvb/frontends/dst.c~msleep-drivers_media_dvb_frontends_dst drivers/media/dvb/frontends/dst.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/dst.c~msleep-drivers_media_dvb_frontends_dst	2004-09-21 20:50:15.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/dst.c	2004-09-21 20:50:15.000000000 +0200
@@ -197,7 +197,7 @@ int retval;
 	retval = dst_gpio_outb(dst, DST_8820, DST_8820, 0);
 	if (retval < 0)
 		return retval;
-	dvb_delay(10);
+	msleep(10);
 	retval = dst_gpio_outb(dst, DST_8820, DST_8820, DST_8820);
 	if (retval < 0)
 		return retval;
@@ -220,7 +220,7 @@ int retval;
 	if (retval < 0)
 		return retval;
 	// dprintk ("%s: i2c enable delay\n", __FUNCTION__);
-	dvb_delay(33);
+	msleep(33);
 	return 0;
 }
 
@@ -234,7 +234,7 @@ int retval;
 	if (retval < 0)
 		return retval;
 	// dprintk ("%s: i2c disable delay\n", __FUNCTION__);
-	dvb_delay(33);
+	msleep(33);
 	return 0;
 }
 
@@ -252,7 +252,7 @@ int i;
 			dprintk ("%s: dst wait ready after %d\n", __FUNCTION__, i);
 			return 1;
 		}
-		dvb_delay(5);
+		msleep(5);
 	}
 	dprintk ("%s: dst wait NOT ready after %d\n", __FUNCTION__, i);
 	return 0;
@@ -275,14 +275,14 @@ static int write_dst (struct dst_data *d
 		}
 		dprintk("\n");
 	}
-	dvb_delay(30);
+	msleep(30);
 	for (cnt = 0; cnt < 4; cnt++) {
 		if ((err = dst->i2c->xfer (dst->i2c, &msg, 1)) < 0) {
 			dprintk ("%s: write_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, data[0]);
 			dst_i2c_disable(dst);
-			dvb_delay(500);
+			msleep(500);
 			dst_i2c_enable(dst);
-			dvb_delay(500);
+			msleep(500);
 			continue;
 		} else
 			break;
@@ -564,7 +564,7 @@ static int dst_check_ci (struct dst_data
 		dprintk("%s: write not successful, maybe no card?\n", __FUNCTION__);
 		return retval;
 	}
-	dvb_delay(3);
+	msleep(3);
 	retval = read_dst (dst, rxbuf, 1);
 	dst_i2c_disable(dst);
 	if (retval < 0) {
@@ -648,7 +648,7 @@ static int dst_command (struct dst_data 
 		dprintk("%s: write not successful\n", __FUNCTION__);
 		return retval;
 	}
-	dvb_delay(33);
+	msleep(33);
 	retval = read_dst (dst, &reply, 1);
 	dst_i2c_disable(dst);
 	if (retval < 0) {
@@ -899,7 +899,7 @@ static int dst_write_tuna (struct dst_da
 		dprintk("%s: write not successful\n", __FUNCTION__);
 		return retval;
 	}
-	dvb_delay(3);
+	msleep(3);
 	retval = read_dst (dst, &reply, 1);
 	dst_i2c_disable(dst);
 	if (retval < 0) {
_
