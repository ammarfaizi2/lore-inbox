Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVCVWMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVCVWMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVCVWLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:11:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:781 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262153AbVCVWE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:04:59 -0500
Date: Tue, 22 Mar 2005 23:04:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alex Woods <linux-dvb@giblets.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/dvb/ttusb-dec/ttusbdecfe.c: remove dead code
Message-ID: <20050322220457.GR1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker discovered that these two kfree's can never be 
executed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/ttusb-dec/ttusbdecfe.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

--- linux-2.6.12-rc1-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.c.old	2005-03-22 20:34:45.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.c	2005-03-22 20:37:41.000000000 +0100
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
-	if (state) kfree(state);
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
-	if (state) kfree(state);
-	return NULL;
 }
 
 static struct dvb_frontend_ops ttusbdecfe_dvbt_ops = {
 
 	.info = {
 		.name			= "TechnoTrend/Hauppauge DEC2000-t Frontend",

