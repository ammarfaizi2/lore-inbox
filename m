Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132695AbRDKSM2>; Wed, 11 Apr 2001 14:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132697AbRDKSMS>; Wed, 11 Apr 2001 14:12:18 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:58889 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132695AbRDKSMM>;
	Wed, 11 Apr 2001 14:12:12 -0400
Date: Wed, 11 Apr 2001 20:11:31 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vuser.vu.union.edu
Subject: [PATCH] matroxfb and mga XF4 driver coexistence...
Message-ID: <20010411201131.A1781@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Alan, Linus, please apply this patch to matroxfb. It fixes complaints
from people that screen is black after they exit from X back to console.
Matrox driver does not know that it should return hardware state back to
initial state after switch, but matroxfb relies on that (XF3 did that...).
So now it reprograms hardware always from scratch...
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

diff -urdN linux/drivers/video/matrox/matroxfb_DAC1064.c linux/drivers/video/matrox/matroxfb_DAC1064.c
--- linux/drivers/video/matrox/matroxfb_DAC1064.c	Tue Apr 10 22:56:19 2001
+++ linux/drivers/video/matrox/matroxfb_DAC1064.c	Wed Apr 11 11:45:50 2001
@@ -418,7 +418,12 @@
 	outDAC1064(PMINFO DAC1064_XSYSPLLM, hw->DACclk[3]);
 	outDAC1064(PMINFO DAC1064_XSYSPLLN, hw->DACclk[4]);
 	outDAC1064(PMINFO DAC1064_XSYSPLLP, hw->DACclk[5]);
-	if (!oldhw || memcmp(hw->DACreg, oldhw->DACreg, sizeof(MGA1064_DAC_regs))) {
+	/*
+	 * We must ALWAYS reprogram hardware due to broken XF4 matrox drivers...
+	 *
+	 * if (!oldhw || memcmp(hw->DACreg, oldhw->DACreg, sizeof(MGA1064_DAC_regs))) 
+	 */
+	{
 		unsigned int i;
 
 		for (i = 0; i < sizeof(MGA1064_DAC_regs); i++) {
