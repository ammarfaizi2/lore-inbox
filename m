Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVF0MRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVF0MRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVF0MRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:17:18 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:62692 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261246AbVF0MP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:15:56 -0400
Message-Id: <20050627121413.689826000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:21 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Content-Disposition: inline; filename=dvb-ttusb-dec-kfree-cleanup.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 21/51] ttusb-dec: kfree cleanup
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

The Coverity checker discovered that these two kfree's can never be
executed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttusb-dec/ttusbdecfe.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttusb-dec/ttusbdecfe.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttusb-dec/ttusbdecfe.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttusb-dec/ttusbdecfe.c	2005-06-27 13:24:14.000000000 +0200
@@ -157,7 +157,8 @@ struct dvb_frontend* ttusbdecfe_dvbt_att
 
 	/* allocate memory for the internal state */
 	state = (struct ttusbdecfe_state*) kmalloc(sizeof(struct ttusbdecfe_state), GFP_KERNEL);
-	if (state == NULL) goto error;
+	if (state == NULL)
+		return NULL;
 
 	/* setup the state */
 	state->config = config;
@@ -167,10 +168,6 @@ struct dvb_frontend* ttusbdecfe_dvbt_att
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
 	return &state->frontend;
-
-error:
-	kfree(state);
-	return NULL;
 }
 
 static struct dvb_frontend_ops ttusbdecfe_dvbs_ops;
@@ -181,7 +178,8 @@ struct dvb_frontend* ttusbdecfe_dvbs_att
 
 	/* allocate memory for the internal state */
 	state = (struct ttusbdecfe_state*) kmalloc(sizeof(struct ttusbdecfe_state), GFP_KERNEL);
-	if (state == NULL) goto error;
+	if (state == NULL)
+		return NULL;
 
 	/* setup the state */
 	state->config = config;
@@ -193,10 +191,6 @@ struct dvb_frontend* ttusbdecfe_dvbs_att
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
 	return &state->frontend;
-
-error:
-	kfree(state);
-	return NULL;
 }
 
 static struct dvb_frontend_ops ttusbdecfe_dvbt_ops = {

--

