Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVIDXrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVIDXrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVIDXrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:47:04 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:45185 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932132AbVIDXam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:42 -0400
Message-Id: <20050904232326.054549000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:25 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ye Jianjun (Joey) <joeyye@trident.com.cn>,
       Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-dtt200u-frontend-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 26/54] usb: dtt200u: copy frontend_ops before modifying
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Jianjun (Joey) <joeyye@trident.com.cn>

Fix: copy frontend_ops before modifying

Signed-off-by: Ye Jianjun (Joey) <joeyye@trident.com.cn>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dtt200u-fe.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dtt200u-fe.c	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dtt200u-fe.c	2005-09-04 22:28:19.000000000 +0200
@@ -18,6 +18,7 @@ struct dtt200u_fe_state {
 
 	struct dvb_frontend_parameters fep;
 	struct dvb_frontend frontend;
+	struct dvb_frontend_ops ops;
 };
 
 static int dtt200u_fe_read_status(struct dvb_frontend* fe, fe_status_t *stat)
@@ -163,8 +164,9 @@ struct dvb_frontend* dtt200u_fe_attach(s
 	deb_info("attaching frontend dtt200u\n");
 
 	state->d = d;
+	memcpy(&state->ops,&dtt200u_fe_ops,sizeof(struct dvb_frontend_ops));
 
-	state->frontend.ops = &dtt200u_fe_ops;
+	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
 
 	goto success;

--

