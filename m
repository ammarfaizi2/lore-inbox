Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVF0MYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVF0MYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVF0MX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:23:57 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:741 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262007AbVF0MQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:03 -0400
Message-Id: <20050627121414.864270000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:27 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-budget-av-qam128-fix.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 27/51] ttpci: budget-av / tu1216 fix for QAM128
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for QAM128 in VHF band suggested by Timo Helkiö.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/budget-av.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/budget-av.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/budget-av.c	2005-06-27 13:23:02.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/budget-av.c	2005-06-27 13:24:20.000000000 +0200
@@ -570,9 +570,9 @@ static int philips_cu1216_pll_set(struct
 
 	buf[0] = (div >> 8) & 0x7f;
 	buf[1] = div & 0xff;
-	buf[2] = 0x8e;
-	buf[3] = (params->frequency < 174500000 ? 0xa1 :
-		  params->frequency < 454000000 ? 0x92 : 0x34);
+	buf[2] = 0x86;
+	buf[3] = (params->frequency < 150000000 ? 0x01 :
+		  params->frequency < 445000000 ? 0x02 : 0x04);
 
 	if (i2c_transfer(&budget->i2c_adap, &msg, 1) != 1)
 		return -EIO;

--

