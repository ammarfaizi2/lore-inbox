Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266631AbRGTGKc>; Fri, 20 Jul 2001 02:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266620AbRGTGKW>; Fri, 20 Jul 2001 02:10:22 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:43020 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S266399AbRGTGKJ>; Fri, 20 Jul 2001 02:10:09 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: [PATCH] 2.4.7-pre8 scc.c vector latch region allocation
Date: Fri, 20 Jul 2001 08:03:27 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9j8i04$6ga$1@ncc1701.cistron.net>
X-Trace: ncc1701.cistron.net 995609412 6666 213.46.44.164 (20 Jul 2001 06:10:12 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> This patch fixes a failure in the scc.c driver to properly allocate the
I/O
> region for the interrupt vector latch, which is present on some ham radio
> SCC cards, such as the PA0HZP card.
>
> Rob Turk - PE1KOX
>

After receiving a few hints that uu-encoded messages are 'not done', here's
the same patch in text format. Sorry for any confusion.

Rob


--- linux.org/drivers/net/hamradio/scc.c Thu Jul 19 22:48:06 2001
+++ linux/drivers/net/hamradio/scc.c Thu Jul 19 20:55:58 2001
@@ -1775,8 +1775,8 @@
      Ivec[hwcfg.irq].used = 1;
    }

-   if (hwcfg.vector_latch) {
-    if (!request_region(Vector_Latch, 1, "scc vector latch"))
+   if (hwcfg.vector_latch && !Vector_Latch) {
+    if (!request_region(hwcfg.vector_latch, 1, "scc vector latch"))
      printk(KERN_WARNING "z8530drv: warning, cannot reserve vector latch
port 0x%lx\n, disabled.", hwcfg.vector_latch);
     else
      Vector_Latch = hwcfg.vector_latch;




