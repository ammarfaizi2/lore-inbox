Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbRE0Tvz>; Sun, 27 May 2001 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbRE0Tvp>; Sun, 27 May 2001 15:51:45 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:42049
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S262067AbRE0Tvg>; Sun, 27 May 2001 15:51:36 -0400
Date: Sun, 27 May 2001 21:51:28 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: sailer@ife.ee.ethz.ch
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add missing restore_flags to sm_wss.c (244-ac18)
Message-ID: <20010527215128.M857@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch adds a missing restore_flags as per the
stanford team's report way back. Applies against 244ac18.


--- linux-244-ac18-clean/drivers/net/hamradio/soundmodem/sm_wss.c	Wed Jul 19 01:55:19 2000
+++ linux-244-ac18/drivers/net/hamradio/soundmodem/sm_wss.c	Sun May 27 21:36:25 2001
@@ -172,8 +172,10 @@
 		/* MCE and interface config reg */
 		write_codec(dev, 0x49, fdx ? 0x8 : 0xc);
 	outb(0xb, WSS_CODEC_IA(dev->base_addr)); /* leave MCE */
-	if (SCSTATE->crystal && !fullcalib)
+	if (SCSTATE->crystal && !fullcalib) {
+		restore_flags(flags);
 		return 0;
+	}
 	/*
 	 * wait for ACI start
 	 */
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

I've overclocked my keyboard interface.  It's quite messy dipping my
hands into the mineral oil, but *MAN* is my keyboard ever fast now!
                                         - Anonymous Coward
