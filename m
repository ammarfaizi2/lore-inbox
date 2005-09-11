Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVIKFPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVIKFPE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 01:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVIKFPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 01:15:04 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:28346 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932419AbVIKFPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 01:15:02 -0400
Date: Sun, 11 Sep 2005 02:14:57 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH] V4L: Fixup on cx88_dvb for Dvico HDTV5 Gold
Message-ID: <4323bd51.u1gt4fmaZUkbvfDP%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Bug fix for DViCO FusionHDTV5 Gold to avoid noise after board init.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/cx88/cx88-dvb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -u /tmp/dst.25413 linux/drivers/media/video/cx88/cx88-dvb.c
--- /tmp/dst.25413	2005-09-11 01:44:00.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-09-11 01:44:00.000000000 -0300
@@ -221,9 +221,7 @@ static int lgdt330x_pll_set(struct dvb_f
 	int err;
 
 	/* Put the analog decoder in standby to keep it quiet */
-	if (core->tda9887_conf) {
-		cx88_call_i2c_clients (dev->core, TUNER_SET_STANDBY, NULL);
-	}
+	cx88_call_i2c_clients (dev->core, TUNER_SET_STANDBY, NULL);
 
 	dvb_pll_configure(core->pll_desc, buf, params->frequency, 0);
 	dprintk(1, "%s: tuner at 0x%02x bytes: 0x%02x 0x%02x 0x%02x 0x%02x\n",
@@ -402,6 +400,9 @@ static int dvb_register(struct cx8802_de
 		dev->dvb.frontend->ops->info.frequency_max = dev->core->pll_desc->max;
 	}
 
+	/* Put the analog decoder in standby to keep it quiet */
+	cx88_call_i2c_clients (dev->core, TUNER_SET_STANDBY, NULL);
+
 	/* register everything */
 	return videobuf_dvb_register(&dev->dvb, THIS_MODULE, dev);
 }
>From mchehab Sun Sep 11 02:02:19 2005
Date: Sun, 11 Sep 2005 02:02:19 -0300
To: cat, video4linux-list@redhat.com, akpm@osdl.org, -c,
 mchehab@brturbo.com.br, -r, -a s
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

- Bug fix for DViCO FusionHDTV5 Gold to avoid noise after board init.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/cx88/cx88-dvb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -u /tmp/dst.25413 linux/drivers/media/video/cx88/cx88-dvb.c
--- /tmp/dst.25413	2005-09-11 01:44:00.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-09-11 01:44:00.000000000 -0300
@@ -221,9 +221,7 @@ static int lgdt330x_pll_set(struct dvb_f
 	int err;
 
 	/* Put the analog decoder in standby to keep it quiet */
-	if (core->tda9887_conf) {
-		cx88_call_i2c_clients (dev->core, TUNER_SET_STANDBY, NULL);
-	}
+	cx88_call_i2c_clients (dev->core, TUNER_SET_STANDBY, NULL);
 
 	dvb_pll_configure(core->pll_desc, buf, params->frequency, 0);
 	dprintk(1, "%s: tuner at 0x%02x bytes: 0x%02x 0x%02x 0x%02x 0x%02x\n",
@@ -402,6 +400,9 @@ static int dvb_register(struct cx8802_de
 		dev->dvb.frontend->ops->info.frequency_max = dev->core->pll_desc->max;
 	}
 
+	/* Put the analog decoder in standby to keep it quiet */
+	cx88_call_i2c_clients (dev->core, TUNER_SET_STANDBY, NULL);
+
 	/* register everything */
 	return videobuf_dvb_register(&dev->dvb, THIS_MODULE, dev);
 }

