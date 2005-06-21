Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVFURvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVFURvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVFURvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:51:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64267 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262211AbVFURul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:50:41 -0400
Date: Tue, 21 Jun 2005 19:50:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alex Woods <linux-dvb@giblets.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/dvb/ttusb-dec/ttusbdecfe.c: remove dead code
Message-ID: <20050621175036.GU3666@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker discovered that these two kfree's can never be
executed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/ttusb-dec/ttusbdecfe.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

--- linux-2.6.12-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.c.old	2005-06-21 16:51:29.000000000 +0200
+++ linux-2.6.12-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.c	2005-06-21 16:52:13.000000000 +0200
@@ -154,52 +154,46 @@
 struct dvb_frontend* ttusbdecfe_dvbt_attach(const struct ttusbdecfe_config* config)
 {
 	struct ttusbdecfe_state* state = NULL;
 
 	/* allocate memory for the internal state */
 	state = (struct ttusbdecfe_state*) kmalloc(sizeof(struct ttusbdecfe_state), GFP_KERNEL);
-	if (state == NULL) goto error;
+	if (state == NULL)
+		return NULL;
 
 	/* setup the state */
 	state->config = config;
 	memcpy(&state->ops, &ttusbdecfe_dvbt_ops, sizeof(struct dvb_frontend_ops));
 
 	/* create dvb_frontend */
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
 	return &state->frontend;
-
-error:
-	kfree(state);
-	return NULL;
 }
 
 static struct dvb_frontend_ops ttusbdecfe_dvbs_ops;
 
 struct dvb_frontend* ttusbdecfe_dvbs_attach(const struct ttusbdecfe_config* config)
 {
 	struct ttusbdecfe_state* state = NULL;
 
 	/* allocate memory for the internal state */
 	state = (struct ttusbdecfe_state*) kmalloc(sizeof(struct ttusbdecfe_state), GFP_KERNEL);
-	if (state == NULL) goto error;
+	if (state == NULL)
+		return NULL;
 
 	/* setup the state */
 	state->config = config;
 	state->voltage = 0;
 	state->hi_band = 0;
 	memcpy(&state->ops, &ttusbdecfe_dvbs_ops, sizeof(struct dvb_frontend_ops));
 
 	/* create dvb_frontend */
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
 	return &state->frontend;
-
-error:
-	kfree(state);
-	return NULL;
 }
 
 static struct dvb_frontend_ops ttusbdecfe_dvbt_ops = {
 
 	.info = {
 		.name			= "TechnoTrend/Hauppauge DEC2000-t Frontend",

