Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUIWVMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUIWVMC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUIWVKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:10:41 -0400
Received: from baikonur.stro.at ([213.239.196.228]:38618 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267358AbUIWVIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:08:50 -0400
Subject: [patch 12/20]  dvb/tda1004x.c: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:08:51 +0200
Message-ID: <E1CAapf-0003oB-DR@sputnik>
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

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/tda1004x.c |   25 +++++-----
 1 files changed, 13 insertions(+), 12 deletions(-)

diff -puN drivers/media/dvb/frontends/tda1004x.c~msleep-drivers_media_dvb_frontends_tda1004x drivers/media/dvb/frontends/tda1004x.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/frontends/tda1004x.c~msleep-drivers_media_dvb_frontends_tda1004x	2004-09-21 20:50:19.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/frontends/tda1004x.c	2004-09-21 20:50:19.000000000 +0200
@@ -42,6 +42,7 @@
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 #include <linux/syscalls.h>
+#include <linux/delay.h>
 
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
@@ -276,7 +277,7 @@ static int tda1004x_enable_tuner_i2c(str
 	dprintk("%s\n", __FUNCTION__);
 
 	result = tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 2, 2);
-	dvb_delay(1);
+	msleep(1);
 	return result;
 }
 
@@ -449,7 +450,7 @@ static int tda1004x_fwupload(struct dvb_
 		tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 0x10, 0);
                 tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 8);
                 tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 0);
-                dvb_delay(10);
+                msleep(10);
 
                 // set parameters
                 tda10045h_set_bandwidth(i2c, tda_state, BANDWIDTH_8_MHZ);
@@ -459,7 +460,7 @@ static int tda1004x_fwupload(struct dvb_
                 // reset chip
 		tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 1, 0);
                 tda1004x_write_mask(i2c, tda_state, TDA10046H_CONF_TRISTATE1, 1, 0);
-                dvb_delay(10);
+                msleep(10);
 
                 // set parameters
                 tda1004x_write_byte(i2c, tda_state, TDA10046H_CONFPLL2, 10);
@@ -502,7 +503,7 @@ static int tda1004x_fwupload(struct dvb_
         switch(tda_state->fe_type) {
         case FE_TYPE_TDA10045H:
                 // DSPREADY doesn't seem to work on the TDA10045H
-                dvb_delay(100);
+                msleep(100);
                 break;
 
         case FE_TYPE_TDA10046H:
@@ -513,7 +514,7 @@ static int tda1004x_fwupload(struct dvb_
                                 return -EIO;
                         }
 
-                        dvb_delay(1);
+                        msleep(1);
                 }
                 break;
         }
@@ -803,7 +804,7 @@ static int tda1004x_set_frequency(struct
                 if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
 			return -EIO;
 		}
-		dvb_delay(1);
+		msleep(1);
 		tda1004x_disable_tuner_i2c(i2c, tda_state);
                 if (tda_state->fe_type == FE_TYPE_TDA10046H)
                         tda1004x_write_mask(i2c, tda_state, TDA10046H_AGC_CONF, 4, 4);
@@ -990,12 +991,12 @@ static int tda1004x_set_fe(struct dvb_i2
         case FE_TYPE_TDA10045H:
 	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 8);
 	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 0);
-	dvb_delay(10);
+	msleep(10);
                 break;
 
         case FE_TYPE_TDA10046H:
                 tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 0x40, 0x40);
-                dvb_delay(10);
+                msleep(10);
                 break;
         }
 
@@ -1431,7 +1432,7 @@ static int tda1004x_attach(struct dvb_i2
 	tuner_msg.buf = td1344_init;
 	tuner_msg.len = sizeof(td1344_init);
 	if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
-                dvb_delay(1);
+                msleep(1);
                         tuner_address = 0x61;
                         tuner_type = TUNER_TYPE_TD1344;
                         printk("tda1004x: Detected Philips TD1344 tuner.\n");
@@ -1444,7 +1445,7 @@ static int tda1004x_attach(struct dvb_i2
                 tuner_msg.buf = td1316_init;
                 tuner_msg.len = sizeof(td1316_init);
                 if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
-                        dvb_delay(1);
+                        msleep(1);
                         tuner_address = 0x63;
                         tuner_type = TUNER_TYPE_TD1316;
                         printk("tda1004x: Detected Philips TD1316 tuner.\n");
@@ -1457,8 +1458,8 @@ static int tda1004x_attach(struct dvb_i2
                 tuner_msg.buf = td1316_init_tda10046h;
                 tuner_msg.len = sizeof(td1316_init_tda10046h);
                 if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
-                        dvb_delay(1);
-                        tuner_address = 0x60;
+                        msleep(1);
+			tuner_address = 0x60;
                         tuner_type = TUNER_TYPE_TD1316;
                         printk("tda1004x: Detected Philips TD1316 tuner.\n");
 		}
_
