Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269506AbTCDSk0>; Tue, 4 Mar 2003 13:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269507AbTCDSk0>; Tue, 4 Mar 2003 13:40:26 -0500
Received: from krynn.axis.se ([193.13.178.10]:63211 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S269506AbTCDSkZ>;
	Tue, 4 Mar 2003 13:40:25 -0500
Date: Tue, 4 Mar 2003 19:49:59 +0100 (CET)
From: Johan Adolfsson <johan.adolfsson@axis.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Johan Adolfsson <johan.adolfsson@axis.com>
Subject: [PATCH] Avoid PC(?) specific cascade dma reservation in kernel/dma.c
Message-ID: <Pine.LNX.4.21.0303041945590.7198-100000@hydra-11.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess the reservation of dma channel 4 for "cascade" is
PC or chipset specific and we don't have such a thing in the 
CRIS (ETRAX100LX) chip and channel 4 clashes with external dma0.
Perhaps a better fix is to #ifdef on something else or remove 
the cascade stuff entirely from this file, but I leave that
to those who know better.
Have no other arch been bitten by this?

Please apply to both 2.4 and 2.5.

/Johan


diff -u -p -r1.3 dma.c
--- linux/kernel/dma.c	23 Feb 2001 13:50:32 -0000	1.3
+++ linux/kernel/dma.c	4 Mar 2003 18:46:51 -0000
@@ -59,7 +59,11 @@ static struct dma_chan dma_chan_busy[MAX
 	{ 0, 0 },
 	{ 0, 0 },
 	{ 0, 0 },
+#ifndef __CRIS__
 	{ 1, "cascade" },
+#else
+	{ 0, 0 },
+#endif        
 	{ 0, 0 },
 	{ 0, 0 },
 	{ 0, 0 }

