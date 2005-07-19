Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVGSM1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVGSM1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 08:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVGSM1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 08:27:49 -0400
Received: from penfold.hotkey.net.au ([202.138.0.33]:21996 "EHLO
	penfold.hotkey.net.au") by vger.kernel.org with ESMTP
	id S261977AbVGSM1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 08:27:49 -0400
Message-ID: <1121776133.42dcf20511c67@webmail.hotkey.net.au>
Date: Tue, 19 Jul 2005 22:28:53 +1000
From: frosts1@hotkey.net.au
To: frosts1@hotkey.net.au
Cc: akpm@osdl.org, js@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [PATCH] DVICO Fusion DVB-T1 Tuner (LG-Z201)
References: <1121775780.42dcf0a453b1a@webmail.hotkey.net.au>
In-Reply-To: <1121775780.42dcf0a453b1a@webmail.hotkey.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 220.238.243.76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I apologise profusely for initially sending this message without a 
subject.

Johannes Stezenbach (of dvb-kernel) suggested that I send this patch 
directly to you since I am anxious to get it into the kernel and he
felt 2.6.13 may be released soon (but who knows).

It is a small modification to the table that defines the way that 
the LG-Z201 tuner is controlled for the DVICO Fusion DVB-T1 tuner 
card.

I believe that a mistake was made when the dvb tuner code was 
reorganised (to use a generic table for the tuner information 
instead of inline code) and as a result, the DVICO card doesn't tune 
properly.

The modification I have made to the table makes it behave like it 
did with the old inline tuner code that worked. The patch is on
top of the 2.6.12 kernel.

Please personally cc me with any response as I am not subscribed to lkml.

Patch Description: Fix the way the LG-Z201 tuner is controlled for the DVICO Fusion DVB-T1 card.

Signed-off-by: Gregory B Frost <frosts1@hotkey.net.au>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -ru linux-2.6.12-clean/drivers/media/dvb/frontends/dvb-pll.c linux-2.6.12/drivers/media/dvb/frontends/dvb-pll.c
--- linux-2.6.12-clean/drivers/media/dvb/frontends/dvb-pll.c	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/drivers/media/dvb/frontends/dvb-pll.c	2005-07-02 22:25:31.000000000 +0000
@@ -84,13 +84,14 @@
 	.name  = "LG z201",
 	.min   = 174000000,
 	.max   = 862000000,
-	.count = 5,
+	.count = 6,
 	.entries = {
 		{          0, 36166667, 166666, 0xbc, 0x03 },
-		{  443250000, 36166667, 166666, 0xbc, 0x01 },
-		{  542000000, 36166667, 166666, 0xbc, 0x02 },
-		{  830000000, 36166667, 166666, 0xf4, 0x02 },
-		{  999999999, 36166667, 166666, 0xfc, 0x02 },
+		{  157500000, 36166667, 166666, 0xbc, 0x01 },
+		{  443250000, 36166667, 166666, 0xbc, 0x02 },
+		{  542000000, 36166667, 166666, 0xbc, 0x04 },
+		{  830000000, 36166667, 166666, 0xf4, 0x04 },
+		{  999999999, 36166667, 166666, 0xfc, 0x04 },
 	},
 };
 EXPORT_SYMBOL(dvb_pll_lg_z201);

