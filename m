Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSHAWfE>; Thu, 1 Aug 2002 18:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSHAWfE>; Thu, 1 Aug 2002 18:35:04 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:14464 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S317283AbSHAWfD>;
	Thu, 1 Aug 2002 18:35:03 -0400
Date: Fri, 2 Aug 2002 00:38:27 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] es1371 synchronize_irq()
Message-ID: <20020801223827.GA11949@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
   nobody else is apparently using OSS's es1371...

Patch below converts synchronize_irq() calls in es1371 to the new
format.
					Petr Vandrovec
					vandrove@vc.cvut.cz

diff -urdN linux/sound/oss/es1371.c linux/sound/oss/es1371.c
--- linux/sound/oss/es1371.c	2002-07-31 10:48:09.000000000 +0000
+++ linux/sound/oss/es1371.c	2002-07-31 10:54:57.000000000 +0000
@@ -1597,12 +1597,12 @@
         case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac2(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_dac2.swptr = s->dma_dac2.hwptr = s->dma_dac2.count = s->dma_dac2.total_bytes = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
 		}
 		return 0;
@@ -2162,7 +2162,7 @@
 		
         case SNDCTL_DSP_RESET:
 		stop_dac1(s);
-		synchronize_irq();
+		synchronize_irq(s->irq);
 		s->dma_dac1.swptr = s->dma_dac1.hwptr = s->dma_dac1.count = s->dma_dac1.total_bytes = 0;
 		return 0;
 
@@ -3001,7 +3001,7 @@
 #endif /* ES1371_DEBUG */
 	outl(0, s->io+ES1371_REG_CONTROL); /* switch everything off */
 	outl(0, s->io+ES1371_REG_SERIAL_CONTROL); /* clear serial interrupts */
-	synchronize_irq();
+	synchronize_irq(s->irq);
 	free_irq(s->irq, s);
 	if (s->gameport.io) {
 		gameport_unregister_port(&s->gameport);
