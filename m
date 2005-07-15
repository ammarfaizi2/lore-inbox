Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263244AbVGOJNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbVGOJNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 05:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbVGOJNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 05:13:30 -0400
Received: from smarthost4.mail.uk.easynet.net ([212.135.6.14]:29961 "EHLO
	smarthost4.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S263244AbVGOJN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 05:13:29 -0400
Message-ID: <42D77E37.5010908@ukonline.co.uk>
Date: Fri, 15 Jul 2005 10:13:27 +0100
From: Andrew Benton <b3nt@ukonline.co.uk>
User-Agent: Mail/News Client 1.0+ (X11/20050624)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cx22702.c, 2.6.13-rc3 and a pci Hauppauge Nova-T DVB-T TV card
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
My pci TV card (a Hauppauge Nova-T DVB-T) works fine with a 2.6.13-rc2 kernel but won't work with a 2.6.13-rc3 by a process of elimination I've found that if I reverse this part of the 2.6.13-rc3 patch the card works fine. Please do not include this in the 2.6.13 kernel.

diff --git a/drivers/media/dvb/frontends/cx22702.c b/drivers/media/dvb/frontends/cx22702.c
--- a/drivers/media/dvb/frontends/cx22702.c
+++ b/drivers/media/dvb/frontends/cx22702.c
@@ -76,7 +76,6 @@ static u8 init_tab [] = {
 	0x49, 0x56,
 	0x6b, 0x1e,
 	0xc8, 0x02,
-	0xf8, 0x02,
 	0xf9, 0x00,
 	0xfa, 0x00,
 	0xfb, 0x00,
@@ -347,10 +346,11 @@ static int cx22702_init (struct dvb_fron
 	for (i=0; i<sizeof(init_tab); i+=2)
 		cx22702_writereg (state, init_tab[i], init_tab[i+1]);
 
+	cx22702_writereg (state, 0xf8, (state->config->output_mode << 1) & 0x02);
 
 	/* init PLL */
 	if (state->config->pll_init) {
-	        cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) &0xfe);
+		cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) & 0xfe);
 		state->config->pll_init(fe);
 		cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) | 1);
 	}
