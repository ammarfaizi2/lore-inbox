Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVEHTWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVEHTWs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbVEHTWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:22:37 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:62102 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262888AbVEHTJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:51 -0400
Message-Id: <20050508184347.378752000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:46 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-dib3000-check.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 17/37] dib3000: add NULL pointer check
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

prevent NULL pointer related Oopses (Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/dib3000mb.c |    2 +-
 drivers/media/dvb/frontends/dib3000mc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/dib3000mb.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/dib3000mb.c	2005-05-08 16:21:47.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/dib3000mb.c	2005-05-08 16:22:51.000000000 +0200
@@ -61,7 +61,7 @@ static int dib3000mb_set_frontend(struct
 	fe_code_rate_t fe_cr = FEC_NONE;
 	int search_state, seq;
 
-	if (tuner) {
+	if (tuner && state->config.pll_addr && state->config.pll_set) {
 		dib3000mb_tuner_pass_ctrl(fe,1,state->config.pll_addr(fe));
 		state->config.pll_set(fe, fep, NULL);
 		dib3000mb_tuner_pass_ctrl(fe,0,state->config.pll_addr(fe));
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/dib3000mc.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/dib3000mc.c	2005-05-08 16:21:47.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/dib3000mc.c	2005-05-08 16:22:51.000000000 +0200
@@ -463,7 +463,7 @@ static int dib3000mc_set_frontend(struct
 	int search_state,auto_val;
 	u16 val;
 
-	if (tuner) { /* initial call from dvb */
+	if (tuner && state->config.pll_addr && state->config.pll_set) { /* initial call from dvb */
 		dib3000mc_tuner_pass_ctrl(fe,1,state->config.pll_addr(fe));
 		state->config.pll_set(fe,fep,NULL);
 		dib3000mc_tuner_pass_ctrl(fe,0,state->config.pll_addr(fe));

--

