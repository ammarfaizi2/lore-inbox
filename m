Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275841AbRJKCVE>; Wed, 10 Oct 2001 22:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277511AbRJKCUy>; Wed, 10 Oct 2001 22:20:54 -0400
Received: from sushi.toad.net ([162.33.130.105]:28315 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S275841AbRJKCUn>;
	Wed, 10 Oct 2001 22:20:43 -0400
Subject: [PATCH] 2.4.10-ac11 parport_pc.c bugfix
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 10 Oct 2001 22:20:23 -0400
Message-Id: <1002766826.7434.38.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fix makes the parport driver print the correct dma number
and makes explicit a couple of type casts.  Applies cleanly against
-ac11         // Thomas Hood

The patch:
--- linux-2.4.10-ac10/drivers/parport/parport_pc.c	Mon Oct  8 22:41:14 2001
+++ linux-2.4.10-ac10-fix/drivers/parport/parport_pc.c	Tue Oct  9 19:36:58 2001
@@ -2826,7 +2826,7 @@
 	if ( UNSET(dev->irq_resource[0]) ) {
 		irq = PARPORT_IRQ_NONE;
 	} else {
-		if ( dev->irq_resource[0].start == -1 ) {
+		if ( dev->irq_resource[0].start == (unsigned long)-1 ) {
 			irq = PARPORT_IRQ_NONE;
 			printk(", irq disabled");
 		} else {
@@ -2838,12 +2838,12 @@
 	if ( UNSET(dev->dma_resource[0]) ) {
 		dma = PARPORT_DMA_NONE;
 	} else {
-		if ( dev->dma_resource[0].start == -1 ) {
+		if ( dev->dma_resource[0].start == (unsigned long)-1 ) {
 			dma = PARPORT_DMA_NONE;
 			printk(", dma disabled");
 		} else {
 			dma = dev->dma_resource[0].start;
-			printk(", dma %d",irq);
+			printk(", dma %d",dma);
 		}
 	}
 

