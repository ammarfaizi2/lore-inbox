Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVEMWRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVEMWRR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVEMWPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:15:47 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:161 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262575AbVEMWKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:10:20 -0400
Message-Id: <20050513220226.345946000@abc>
References: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:30 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-diseqc-fix.patch
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 11/11] B2C2 / FlexCop driver rewrite
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed DiSeqC switching, which was wrongly taking over from skystar2.c.
Thanks to Joerg Riechardt for finding the bug and testing the Fix.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/b2c2/flexcop-fe-tuner.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2005-05-12 01:31:17.000000000 +0200
@@ -79,8 +79,8 @@ static int flexcop_set_tone(struct dvb_f
 
 	v.lnb_switch_freq_200.LNB_CTLPrescaler_sig = 1; /* divide by 2 */
 
-	v.lnb_switch_freq_200.LNB_CTLHighCount_sig =
-		v.lnb_switch_freq_200.LNB_CTLLowCount_sig  = ax;
+	v.lnb_switch_freq_200.LNB_CTLHighCount_sig = ax;
+	v.lnb_switch_freq_200.LNB_CTLLowCount_sig  = ax == 0 ? 0x1ff : ax;
 
 	return fc->write_ibi_reg(fc,lnb_switch_freq_200,v);
 }

--

