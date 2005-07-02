Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVGBB5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVGBB5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 21:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGBB52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 21:57:28 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:13292 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261684AbVGBBzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 21:55:20 -0400
Message-Id: <20050702015619.204999000@abc>
References: <20050702015506.631451000@abc>
Date: Sat, 02 Jul 2005 03:55:12 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Steffen Motzer <motzersn@t-link.de>,
       Manu Abraham <manu@kromtek.com>
Content-Disposition: inline; filename=dvb-dst-tuning-fix.patch
X-SA-Exim-Connect-IP: 84.189.246.3
Subject: [DVB patch 6/8] dst: fix tuning problem
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Motzer <motzersn@t-link.de>

Fix tuning failure for 200103A, 200103A failed to tune to low band
due to wrong tone setting on the 200103A.

Signed-off-by: Steffen Motzer <motzersn@t-link.de>
Signed-off-by: Manu Abraham <manu@kromtek.com>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/bt8xx/dst.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/bt8xx/dst.c	2005-07-02 03:22:31.000000000 +0200
@@ -1147,7 +1147,11 @@ static int dst_set_tone(struct dvb_front
 
 	switch (tone) {
 		case SEC_TONE_OFF:
-			state->tx_tuna[2] = 0xff;
+			if (state->type_flags & DST_TYPE_HAS_OBS_REGS)
+			    state->tx_tuna[2] = 0x00;
+			else
+			    state->tx_tuna[2] = 0xff;
+
 			break;
 
 		case SEC_TONE_ON:

--

