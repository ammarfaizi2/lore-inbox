Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVAYA4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVAYA4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVAYAbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:31:38 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:49131 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261752AbVAYAaT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:30:19 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <11066130981300@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 25 Jan 2005 01:31:41 +0100
Message-Id: <11066131012142@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.86.181.249
Subject: [PATCH 4/4] cleanup firmware loading printks
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] frontends: sp887x: improve confusing firmware loading messages

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -rupN linux-2.6.11-rc2-bk2/drivers/media/dvb/frontends/sp8870.c linux-2.6.11-rc2-bk2-dvb/drivers/media/dvb/frontends/sp8870.c
--- linux-2.6.11-rc2-bk2/drivers/media/dvb/frontends/sp8870.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.11-rc2-bk2-dvb/drivers/media/dvb/frontends/sp8870.c	2005-01-25 00:40:10.000000000 +0100
@@ -313,7 +313,7 @@ static int sp8870_init (struct dvb_front
 
 
 	/* request the firmware, this will block until someone uploads it */
-	printk("sp8870: waiting for firmware upload...\n");
+	printk("sp8870: waiting for firmware upload (%s)...\n", SP8870_DEFAULT_FIRMWARE);
 	if (state->config->request_firmware(fe, &fw, SP8870_DEFAULT_FIRMWARE)) {
 		printk("sp8870: no firmware upload (timeout or file not found?)\n");
 		release_firmware(fw);
@@ -325,6 +325,7 @@ static int sp8870_init (struct dvb_front
 		release_firmware(fw);
 		return -EIO;
 	}
+	printk("sp8870: firmware upload complete\n");
 
 	/* enable TS output and interface pins */
 	sp8870_writereg(state, 0xc18, 0x00d);
diff -rupN linux-2.6.11-rc2-bk2/drivers/media/dvb/frontends/sp887x.c linux-2.6.11-rc2-bk2-dvb/drivers/media/dvb/frontends/sp887x.c
--- linux-2.6.11-rc2-bk2/drivers/media/dvb/frontends/sp887x.c	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.11-rc2-bk2-dvb/drivers/media/dvb/frontends/sp887x.c	2005-01-25 00:41:31.000000000 +0100
@@ -518,7 +518,7 @@ static int sp887x_init(struct dvb_fronte
 
 	if (!state->initialised) {
 	/* request the firmware, this will block until someone uploads it */
-	printk("sp887x: waiting for firmware upload...\n");
+		printk("sp887x: waiting for firmware upload (%s)...\n", SP887X_DEFAULT_FIRMWARE);
 		ret = state->config->request_firmware(fe, &fw, SP887X_DEFAULT_FIRMWARE);
 	if (ret) {
 		printk("sp887x: no firmware upload (timeout or file not found?)\n");
@@ -531,6 +531,7 @@ static int sp887x_init(struct dvb_fronte
 			release_firmware(fw);
 			return ret;
 	}
+		printk("sp887x: firmware upload complete\n");
 		state->initialised = 1;
 	}
 

