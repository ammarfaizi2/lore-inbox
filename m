Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVCVC0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVCVC0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVCVCYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:24:53 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:32138 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262269AbVCVBeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:19 -0500
Message-Id: <20050322013454.430855000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:34 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-fw-msg.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 01/48] clarify firmware upload messages
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clarify firmware upload messages

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 nxt2002.c  |    3 ++-
 tda1004x.c |    6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/nxt2002.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c	2005-03-22 00:14:18.000000000 +0100
@@ -520,7 +520,7 @@ static int nxt2002_init(struct dvb_front
 
 	if (!state->initialised) {
 		/* request the firmware, this will block until someone uploads it */
-		printk("nxt2002: Waiting for firmware upload...\n");
+		printk("nxt2002: Waiting for firmware upload (%s)...\n", NXT2002_DEFAULT_FIRMWARE);
 		ret = state->config->request_firmware(fe, &fw, NXT2002_DEFAULT_FIRMWARE);
 		printk("nxt2002: Waiting for firmware upload(2)...\n");
 		if (ret) {
@@ -534,6 +534,7 @@ static int nxt2002_init(struct dvb_front
 			release_firmware(fw);
 			return ret;
 		}
+		printk("nxt2002: firmware upload complete\n");
 
 		/* Put the micro into reset */
 		nxt2002_microcontroller_stop(state);
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda1004x.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/tda1004x.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda1004x.c	2005-03-22 00:14:18.000000000 +0100
@@ -353,7 +353,7 @@ static int tda10045_fwupload(struct dvb_
 	if (tda1004x_check_upload_ok(state, 0x2c) == 0) return 0;
 
 	/* request the firmware, this will block until someone uploads it */
-	printk("tda1004x: waiting for firmware upload...\n");
+	printk("tda1004x: waiting for firmware upload (%s)...\n", TDA10045_DEFAULT_FIRMWARE);
 	ret = state->config->request_firmware(fe, &fw, TDA10045_DEFAULT_FIRMWARE);
 	if (ret) {
 		printk("tda1004x: no firmware upload (timeout or file not found?)\n");
@@ -372,6 +372,7 @@ static int tda10045_fwupload(struct dvb_
 	ret = tda1004x_do_upload(state, fw->data, fw->size, TDA10045H_FWPAGE, TDA10045H_CODE_IN);
 	if (ret)
 		return ret;
+	printk("tda1004x: firmware upload complete\n");
 
 	/* wait for DSP to initialise */
 	/* DSPREADY doesn't seem to work on the TDA10045H */
@@ -396,7 +397,7 @@ static int tda10046_fwupload(struct dvb_
 	if (tda1004x_check_upload_ok(state, 0x20) == 0) return 0;
 
 	/* request the firmware, this will block until someone uploads it */
-	printk("tda1004x: waiting for firmware upload...\n");
+	printk("tda1004x: waiting for firmware upload (%s)...\n", TDA10046_DEFAULT_FIRMWARE);
 	ret = state->config->request_firmware(fe, &fw, TDA10046_DEFAULT_FIRMWARE);
 	if (ret) {
 		printk("tda1004x: no firmware upload (timeout or file not found?)\n");
@@ -414,6 +415,7 @@ static int tda10046_fwupload(struct dvb_
 	ret = tda1004x_do_upload(state, fw->data, fw->size, TDA10046H_CODE_CPT, TDA10046H_CODE_IN);
 	if (ret)
 		return ret;
+	printk("tda1004x: firmware upload complete\n");
 
 	/* wait for DSP to initialise */
 	timeout = jiffies + HZ;

--

