Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWCAPAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWCAPAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWCAO75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:59:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29860 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932372AbWCAO7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:59:54 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 07/13] Cxusb: fix lgdt3303 naming
Date: Wed, 01 Mar 2006 09:05:38 -0300
Message-id: <20060301120538.PS72141800007@infradead.org>
In-Reply-To: <20060301120529.PS80375900000@infradead.org>
References: <20060301120529.PS80375900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1141009697 \-0300

The following are specific to lgdt3303, and are being renamed to reflect this.
- cxusb_lgdt330x_config renamed to cxusb_lgdt3303_config.
- cxusb_lgdt330x_frontend_attach renamed to cxusb_lgdt3303_frontend_attach.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/cxusb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/cxusb.c
index f327fac..162f979 100644
--- a/drivers/media/dvb/dvb-usb/cxusb.c
+++ b/drivers/media/dvb/dvb-usb/cxusb.c
@@ -282,7 +282,7 @@ static struct cx22702_config cxusb_cx227
 	.pll_set  = dvb_usb_pll_set_i2c,
 };
 
-static struct lgdt330x_config cxusb_lgdt330x_config = {
+static struct lgdt330x_config cxusb_lgdt3303_config = {
 	.demod_address = 0x0e,
 	.demod_chip    = LGDT3303,
 	.pll_set       = dvb_usb_pll_set_i2c,
@@ -357,14 +357,14 @@ static int cxusb_cx22702_frontend_attach
 	return -EIO;
 }
 
-static int cxusb_lgdt330x_frontend_attach(struct dvb_usb_device *d)
+static int cxusb_lgdt3303_frontend_attach(struct dvb_usb_device *d)
 {
 	if (usb_set_interface(d->udev,0,7) < 0)
 		err("set interface failed");
 
 	cxusb_ctrl_msg(d,CMD_DIGITAL, NULL, 0, NULL, 0);
 
-	if ((d->fe = lgdt330x_attach(&cxusb_lgdt330x_config, &d->i2c_adap)) != NULL)
+	if ((d->fe = lgdt330x_attach(&cxusb_lgdt3303_config, &d->i2c_adap)) != NULL)
 		return 0;
 
 	return -EIO;
@@ -506,7 +506,7 @@ static struct dvb_usb_properties cxusb_b
 
 	.streaming_ctrl   = cxusb_streaming_ctrl,
 	.power_ctrl       = cxusb_power_ctrl,
-	.frontend_attach  = cxusb_lgdt330x_frontend_attach,
+	.frontend_attach  = cxusb_lgdt3303_frontend_attach,
 	.tuner_attach     = cxusb_lgh064f_tuner_attach,
 
 	.i2c_algo         = &cxusb_i2c_algo,

