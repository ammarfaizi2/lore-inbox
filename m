Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVKUBON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVKUBON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVKUBOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:14:12 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:64743 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932159AbVKUBOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:14:11 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Jun Komuro <komurojun-mbn@nifty.com>
Subject: [PATCH 3/5] Fix pd6729.c on architectures which define NO_IRQ
Message-Id: <E1Ee0G0-0004CL-5E@localhost.localdomain>
Date: Sun, 20 Nov 2005 20:14:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use pci_valid_irq() instead of a custom NO_IRQ definition.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 drivers/pcmcia/pd6729.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

applies-to: 26750e45f268b109d418c91b01a55e124bd879e1
fd1b59b22f926ee7daa097166d9e7ac6005b1284
diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index 20642f0..72720f2 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -39,10 +39,6 @@ MODULE_AUTHOR("Jun Komuro <komurojun-mbn
  */
 #define to_cycles(ns)	((ns)/120)
 
-#ifndef NO_IRQ
-#define NO_IRQ	((unsigned int)(0))
-#endif
-
 /*
  * PARAMETERS
  *  irq_mode=n
@@ -733,7 +729,7 @@ static int __devinit pd6729_pci_probe(st
 		goto err_out_disable;
 	}
 
-	if (dev->irq == NO_IRQ)
+	if (!pci_valid_irq(dev->irq))
 		irq_mode = 0;	/* fall back to ISA interrupt mode */
 
 	mask = pd6729_isa_scan();
---
0.99.8.GIT
