Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVF0NHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVF0NHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVF0NFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:05:13 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:10981 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262051AbVF0MQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:27 -0400
Message-Id: <20050627121417.656494000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:40 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-alps-tded4-pll.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 40/51] frontend: add ALPS TDED4 PLL
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Add dvb_pll_desc for ALPS TDED4 used in Nebula USB boxes.
Changed the name-field of the FMD1216.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/dvb-pll.c |   26 +++++++++++++++++++++++++-
 drivers/media/dvb/frontends/dvb-pll.h |    1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/dvb-pll.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/dvb-pll.c	2005-06-27 13:26:08.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/dvb-pll.c	2005-06-27 13:26:12.000000000 +0200
@@ -208,7 +208,7 @@ static void fmd1216me_bw(u8 *buf, u32 fr
 }
 
 struct dvb_pll_desc dvb_pll_fmd1216me = {
-	.name = "placeholder",
+	.name = "Philips FMD1216ME",
 	.min = 50870000,
 	.max = 858000000,
 	.setbw = fmd1216me_bw,
@@ -225,6 +225,30 @@ struct dvb_pll_desc dvb_pll_fmd1216me = 
 };
 EXPORT_SYMBOL(dvb_pll_fmd1216me);
 
+/* ALPS TDED4
+ * used in Nebula-Cards and USB boxes
+ */
+static void tded4_bw(u8 *buf, u32 freq, int bandwidth)
+{
+	if (bandwidth == BANDWIDTH_8_MHZ)
+		buf[3] |= 0x04;
+}
+
+struct dvb_pll_desc dvb_pll_tded4 = {
+	.name = "ALPS TDED4",
+	.min = 47000000,
+	.max = 863000000,
+	.setbw = tded4_bw,
+	.count = 4,
+	.entries = {
+		{ 153000000, 36166667, 166667, 0x85, 0x01 },
+		{ 470000000, 36166667, 166667, 0x85, 0x02 },
+		{ 823000000, 36166667, 166667, 0x85, 0x08 },
+		{ 999999999, 36166667, 166667, 0x85, 0x88 },
+	}
+};
+EXPORT_SYMBOL(dvb_pll_tded4);
+
 /* ----------------------------------------------------------- */
 /* code                                                        */
 
Index: linux-2.6.12-git8/drivers/media/dvb/frontends/dvb-pll.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/dvb-pll.h	2005-06-27 13:26:08.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/dvb-pll.h	2005-06-27 13:26:12.000000000 +0200
@@ -31,6 +31,7 @@ extern struct dvb_pll_desc dvb_pll_env57
 extern struct dvb_pll_desc dvb_pll_tua6034;
 extern struct dvb_pll_desc dvb_pll_tda665x;
 extern struct dvb_pll_desc dvb_pll_fmd1216me;
+extern struct dvb_pll_desc dvb_pll_tded4;
 
 int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,
 		      u32 freq, int bandwidth);

--

