Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280889AbRKLSKa>; Mon, 12 Nov 2001 13:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280894AbRKLSKT>; Mon, 12 Nov 2001 13:10:19 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:49025 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S280889AbRKLSKD>; Mon, 12 Nov 2001 13:10:03 -0500
Date: Mon, 12 Nov 2001 10:09:57 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: [PATCH] Configure.help CONFIG_PDC202XX_BURST
Message-ID: <Pine.LNX.4.33.0111121002500.28309-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Sorry, that last email escaped from me before I was done.  :-)

Anyway, I was fooling around with disabling the BIOS on my PDC20265
Promise Ultra100 PCI card, to speed up my booting.  When I did that, the
pdc202xx driver only configures the chipset for mdma2, not for udma5.  
Poking around a bit, I discovered that the CONFIG_PDC202XX_BURST option
does exactly what I need--it tells the pdc202xx driver to configure the
chipset for UDMA regardless of how it found it.

So here is an updated Configure.help entry that makes it clearer what
CONFIG_PDC202XX_BURST does.

Cheers,
Wayne

--- linux-2.4.15-pre3/Documentation/Configure.help	Sun Nov 11 22:11:25 2001
+++ linux-2.4.15-pre3-ide/Documentation/Configure.help	Mon Nov 12 09:56:59 2001
@@ -1112,11 +1112,13 @@
 
 Special UDMA Feature
 CONFIG_PDC202XX_BURST
-  For PDC20246, PDC20262, PDC20265 and PDC20267 Ultra DMA chipsets.
-  Designed originally for PDC20246/Ultra33 that has BIOS setup
-  failures when using 3 or more cards.
+  This option causes the pdc202xx driver to enable UDMA modes on the
+  PDC202xx even when the PDC202xx BIOS has not done so.
 
-  Unknown for PDC20265/PDC20267 Ultra DMA 100.
+  It was originally designed for the PDC20246/Ultra33, whose BIOS will
+  only setup UDMA on the first two PDC20246 cards.  It has also been
+  used succesfully on a PDC20265/Ultra100, allowing use of UDMA modes
+  when the PDC20265 BIOS has been disabled (for faster boot up).
 
   Please read the comments at the top of
   <file:drivers/ide/pdc202xx.c>.


