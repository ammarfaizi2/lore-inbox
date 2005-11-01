Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbVKAIQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVKAIQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVKAIQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:16:10 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:32878 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965068AbVKAIQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:16:03 -0500
Message-ID: <4367241A.1060300@m1k.net>
Date: Tue, 01 Nov 2005 03:15:22 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 26/37] dvb: add support for plls used by nxt200x
Content-Type: multipart/mixed;
 boundary="------------030400000004020006080904"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030400000004020006080904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------030400000004020006080904
Content-Type: text/x-patch;
 name="2400.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2400.patch"

From: Kirk Lapray <kirk.lapray@gmail.com>

- Added support for the following:
  Philips TUV1236D - ATI HDTV Wonder
  ALPS TDHU2 - AverTVHD MCE A180
  Samsung TBMV30111IN - Air2PC ATSC - 2nd generation

These will be used in a new NXT200X driver that incorporates the
NXT2002 driver and adds support for a couple NXT2004 based cards.

Signed-off-by: Kirk Lapray <kirk.lapray@gmail.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/frontends/dvb-pll.c |   52 ++++++++++++++++++++++++++++++++++
 drivers/media/dvb/frontends/dvb-pll.h |    4 ++
 2 files changed, 56 insertions(+)

--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/dvb-pll.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/dvb-pll.c
@@ -292,6 +292,58 @@
 };
 EXPORT_SYMBOL(dvb_pll_tded4);
 
+/* ALPS TDHU2
+ * used in AverTVHD MCE A180
+ */
+struct dvb_pll_desc dvb_pll_tdhu2 = {
+	.name = "ALPS TDHU2",
+	.min = 54000000,
+	.max = 864000000,
+	.count = 4,
+	.entries = {
+		{ 162000000, 44000000, 62500, 0x85, 0x01 },
+		{ 426000000, 44000000, 62500, 0x85, 0x02 },
+		{ 782000000, 44000000, 62500, 0x85, 0x08 },
+		{ 999999999, 44000000, 62500, 0x85, 0x88 },
+	}
+};
+EXPORT_SYMBOL(dvb_pll_tdhu2);
+
+/* Philips TUV1236D
+ * used in ATI HDTV Wonder
+ */
+struct dvb_pll_desc dvb_pll_tuv1236d = {
+	.name  = "Philips TUV1236D",
+	.min   =  57000000,
+	.max   = 864000000,
+	.count = 3,
+	.entries = {
+		{ 157250000, 44000000, 62500, 0xc6, 0x41 },
+		{ 454000000, 44000000, 62500, 0xc6, 0x42 },
+		{ 999999999, 44000000, 62500, 0xc6, 0x44 },
+	},
+};
+EXPORT_SYMBOL(dvb_pll_tuv1236d);
+
+/* Samsung TBMV30111IN
+ * used in Air2PC ATSC - 2nd generation (nxt2002)
+ */
+struct dvb_pll_desc dvb_pll_tbmv30111in = {
+	.name = "Samsung TBMV30111IN",
+	.min = 54000000,
+	.max = 860000000,
+	.count = 4,
+	.entries = {
+		{ 172000000, 44000000, 166666, 0xb4, 0x01 },
+		{ 214000000, 44000000, 166666, 0xb4, 0x02 },
+		{ 467000000, 44000000, 166666, 0xbc, 0x02 },
+		{ 721000000, 44000000, 166666, 0xbc, 0x08 },
+		{ 841000000, 44000000, 166666, 0xf4, 0x08 },
+		{ 999999999, 44000000, 166666, 0xfc, 0x02 },
+	}
+};
+EXPORT_SYMBOL(dvb_pll_tbmv30111in);
+
 /* ----------------------------------------------------------- */
 /* code                                                        */
 
--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/dvb-pll.h
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/dvb-pll.h
@@ -36,6 +36,10 @@
 extern struct dvb_pll_desc dvb_pll_fmd1216me;
 extern struct dvb_pll_desc dvb_pll_tded4;
 
+extern struct dvb_pll_desc dvb_pll_tuv1236d;
+extern struct dvb_pll_desc dvb_pll_tdhu2;
+extern struct dvb_pll_desc dvb_pll_tbmv30111in;
+
 int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,
 		      u32 freq, int bandwidth);
 


--------------030400000004020006080904--
