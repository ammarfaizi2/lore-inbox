Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWCTPY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWCTPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWCTPYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:24:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15800 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965274AbWCTPYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:24:16 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Curt Meyers <cmeyers@boilerbots.com>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 097/141] V4L/DVB (3362): KWorld ATSC110: implement
	set_pll_input
Date: Mon, 20 Mar 2006 12:08:53 -0300
Message-id: <20060320150853.PS178748000097@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Curt Meyers <cmeyers@boilerbots.com>
Date: 1141009707 -0300

- When tuning VSB, use ANT input
- When tuning QAM, use CABLE input

Signed-off-by: Curt Meyers <cmeyers@boilerbots.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index 354bbf7..7577962 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -928,10 +928,20 @@ static struct nxt200x_config avertvhda18
 	.pll_desc         = &dvb_pll_tdhu2,
 };
 
+static int nxt200x_set_pll_input(u8 *buf, int input)
+{
+	if (input)
+		buf[3] |= 0x08;
+	else
+		buf[3] &= ~0x08;
+	return 0;
+}
+
 static struct nxt200x_config kworldatsc110 = {
 	.demod_address    = 0x0a,
 	.pll_address      = 0x61,
 	.pll_desc         = &dvb_pll_tuv1236d,
+	.set_pll_input    = nxt200x_set_pll_input,
 };
 #endif
 

