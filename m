Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031026AbWKOXE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031026AbWKOXE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031027AbWKOXE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:04:29 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:48135 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1031026AbWKOXE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:04:28 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] sbp2: make 1bit bitfield unsigned
Date: Thu, 16 Nov 2006 00:04:24 +0100
User-Agent: KMail/1.9.5
Cc: Luca Tettamanti <kronos.it@gmail.com>, Ben Collins <bcollins@debian.org>,
       Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20061115181415.GA26751@dreamland.darkstar.lan> <455B6823.2080007@s5r6.in-berlin.de>
In-Reply-To: <455B6823.2080007@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611160004.24800.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Luca Tettamanti wrote:
> > A signed single-bit bitfield doesn't make much sense. Make it unsigned.
> ...
> Committed to linux1394-2.6.git.

There is a few more. Hopefuly 'grep + my eyes' caught them all.
The patch is against 2.6.19-rc5-mm2.

Signed-of-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

diff -upr linux-2.6.19-rc5-mm2-a/drivers/isdn/hisax/isdnhdlc.h linux-2.6.19-rc5-mm2-b/drivers/isdn/hisax/isdnhdlc.h
--- linux-2.6.19-rc5-mm2-a/drivers/isdn/hisax/isdnhdlc.h	2006-11-15 11:24:19.000000000 +0100
+++ linux-2.6.19-rc5-mm2-b/drivers/isdn/hisax/isdnhdlc.h	2006-11-15 23:54:15.000000000 +0100
@@ -41,10 +41,10 @@ struct isdnhdlc_vars {
 	unsigned char shift_reg;
 	unsigned char ffvalue;

-	int data_received:1; 	// set if transferring data
-	int dchannel:1; 	// set if D channel (send idle instead of flags)
-	int do_adapt56:1; 	// set if 56K adaptation
-        int do_closing:1; 	// set if in closing phase (need to send CRC + flag
+	unsigned int data_received:1; 	// set if transferring data
+	unsigned int dchannel:1; 	// set if D channel (send idle instead of flags)
+	unsigned int do_adapt56:1; 	// set if 56K adaptation
+	unsigned int do_closing:1; 	// set if in closing phase (need to send CRC + flag
 };


diff -upr linux-2.6.19-rc5-mm2-a/drivers/media/dvb/frontends/l64781.c linux-2.6.19-rc5-mm2-b/drivers/media/dvb/frontends/l64781.c
--- linux-2.6.19-rc5-mm2-a/drivers/media/dvb/frontends/l64781.c	2006-11-08 03:24:20.000000000 +0100
+++ linux-2.6.19-rc5-mm2-b/drivers/media/dvb/frontends/l64781.c	2006-11-15 21:35:33.000000000 +0100
@@ -36,7 +36,7 @@ struct l64781_state {
 	struct dvb_frontend frontend;

 	/* private demodulator data */
-	int first:1;
+	unsigned int first:1;
 };

 #define dprintk(args...) \
diff -upr linux-2.6.19-rc5-mm2-a/sound/arm/sa11xx-uda1341.c linux-2.6.19-rc5-mm2-b/sound/arm/sa11xx-uda1341.c
--- linux-2.6.19-rc5-mm2-a/sound/arm/sa11xx-uda1341.c	2006-11-08 03:24:20.000000000 +0100
+++ linux-2.6.19-rc5-mm2-b/sound/arm/sa11xx-uda1341.c	2006-11-15 21:40:16.000000000 +0100
@@ -125,7 +125,7 @@ struct audio_stream {
 #else
 	dma_regs_t *dma_regs;	/* points to our DMA registers */
 #endif
-	int active:1;		/* we are using this stream for transfer now */
+	unsigned int active:1;	/* we are using this stream for transfer now */
 	int period;		/* current transfer period */
 	int periods;		/* current count of periods registerd in the DMA engine */
 	int tx_spin;		/* are we recoding - flag used to do DMA trans. for sync */


-- 
Regards,

	Mariusz Kozlowski
