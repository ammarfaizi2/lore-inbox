Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVEHUhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVEHUhD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVEHUVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:21:24 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:151 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262929AbVEHTKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:05 -0400
Message-Id: <20050508184347.927106000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:50 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-tda1004x-n_i2c.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 21/37] tda1004x: allow N_I2C to be overridden by the card driver
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

allow N_I2C to be overridden by the card driver (Andreas Oberritter)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/tda1004x.c |    4 ++--
 drivers/media/dvb/frontends/tda1004x.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/tda1004x.c	2005-05-08 16:17:19.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.c	2005-05-08 16:29:28.000000000 +0200
@@ -406,7 +406,7 @@ static int tda10046_fwupload(struct dvb_
 
 	/* set parameters */
 	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 10);
-	tda1004x_write_byteI(state, TDA10046H_CONFPLL3, 0);
+	tda1004x_write_byteI(state, TDA10046H_CONFPLL3, state->config->n_i2c);
 	tda1004x_write_byteI(state, TDA10046H_FREQ_OFFSET, 99);
 	tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
 	tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x2c);
@@ -547,7 +547,7 @@ static int tda10046_init(struct dvb_fron
 	tda1004x_write_mask(state, TDA1004X_AUTO, 8, 0); // select HP stream
 	tda1004x_write_mask(state, TDA1004X_CONFC1, 0x80, 0); // disable pulse killer
 	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 10); // PLL M = 10
-	tda1004x_write_byteI(state, TDA10046H_CONFPLL3, 0); // PLL P = N = 0
+	tda1004x_write_byteI(state, TDA10046H_CONFPLL3, state->config->n_i2c); // PLL P = N = 0
 	tda1004x_write_byteI(state, TDA10046H_FREQ_OFFSET, 99); // FREQOFFS = 99
 	tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd4); // } PHY2 = -11221
 	tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x2c); // }
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/tda1004x.h	2005-05-08 16:28:52.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.h	2005-05-08 16:29:28.000000000 +0200
@@ -37,6 +37,9 @@ struct tda1004x_config
 	/* Does the OCLK signal need inverted? */
 	u8 invert_oclk;
 
+	/* value of N_I2C of the CONF_PLL3 register */
+	u8 n_i2c;
+
 	/* PLL maintenance */
 	int (*pll_init)(struct dvb_frontend* fe);
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);

--

