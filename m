Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVKCOwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVKCOwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVKCOwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:52:05 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:1482 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030236AbVKCOwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:52:01 -0500
Date: Thu, 3 Nov 2005 07:52:00 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103145200.GY23749@parisc-linux.org>
References: <20051103144926.GV23749@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103144926.GV23749@parisc-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use pci_valid_irq() instead of a custom NO_IRQ definition.
It probably didn't work on half a dozen architectures.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

---

 drivers/pcmcia/pd6729.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

applies-to: 1081da18698662c172c682d7e8b882e38ee57eee
220fd6c4becfe49c606b7bcbb7df6262691459b4
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
