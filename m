Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVF0M1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVF0M1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVF0MYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:24:25 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:229 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262006AbVF0MQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:03 -0400
Message-Id: <20050627121413.507910000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:20 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Allan Stirling <Dibblahdvb0042@pendor.org>,
       Manu Abraham <manu@kromtek.com>
Content-Disposition: inline; filename=dvb-bt8xx-dst-lnb-polarity-fix.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 20/51] Twinhan DST: frontend polarization fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allan Stirling <Dibblahdvb0042@pendor.org>

Fix a bug that caused the polarization (V/H) to be interchanged.

Signed-off-by: Allan Stirling <Dibblahdvb0042@pendor.org>
Signed-off-by: Manu Abraham <manu@kromtek.com>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/bt8xx/dst.c	2005-06-27 13:24:12.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/bt8xx/dst.c	2005-06-27 13:24:13.000000000 +0200
@@ -325,12 +325,12 @@ static int dst_set_polarization(struct d
 	switch (state->voltage) {
 		case SEC_VOLTAGE_13:	// vertical
 			printk("%s: Polarization=[Vertical]\n", __FUNCTION__);
-			state->tx_tuna[8] |= 0x40;  //1
+			state->tx_tuna[8] &= ~0x40;  //1
 			break;
 
 		case SEC_VOLTAGE_18:	// horizontal
 			printk("%s: Polarization=[Horizontal]\n", __FUNCTION__);
-			state->tx_tuna[8] =~ 0x40;  // 0
+			state->tx_tuna[8] |= 0x40;  // 0
 			break;
 
 		case SEC_VOLTAGE_OFF:

--

