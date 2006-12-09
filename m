Return-Path: <linux-kernel-owner+w=401wt.eu-S936778AbWLIJvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936778AbWLIJvJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936751AbWLIJvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:51:09 -0500
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:59349 "EHLO
	hoboe1bl1.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936649AbWLIJvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:51:05 -0500
Date: Sat, 9 Dec 2006 10:51:03 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-net@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Amiga PCMCIA NE2000 Ethernet dev->irq init
Message-ID: <Pine.LNX.4.64.0612091050280.17743@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kars de Jong <jongk@linux-m68k.org>

Amiga PCMCIA NE2000 Ethernet: Add missing initialization of dev->irq

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 drivers/net/apne.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-m68k-2.6.19.orig/drivers/net/apne.c
+++ linux-m68k-2.6.19/drivers/net/apne.c
@@ -311,9 +311,10 @@ static int __init apne_probe1(struct net
 #endif
 
     dev->base_addr = ioaddr;
+    dev->irq = IRQ_AMIGA_PORTS;
 
     /* Install the Interrupt handler */
-    i = request_irq(IRQ_AMIGA_PORTS, apne_interrupt, IRQF_SHARED, DRV_NAME, dev);
+    i = request_irq(dev->irq, apne_interrupt, IRQF_SHARED, DRV_NAME, dev);
     if (i) return i;
 
     for(i = 0; i < ETHER_ADDR_LEN; i++) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
