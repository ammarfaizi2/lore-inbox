Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276876AbSIVJGq>; Sun, 22 Sep 2002 05:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276877AbSIVJGp>; Sun, 22 Sep 2002 05:06:45 -0400
Received: from smtpout.mac.com ([204.179.120.89]:33240 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S276876AbSIVJGp>;
	Sun, 22 Sep 2002 05:06:45 -0400
Date: Sat, 21 Sep 2002 22:30:10 +0200
Subject: [PATCH] 1/11 sound/oss replace cli() 
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Linus Torvalds <torvalds@transmeta.com>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <ED015C41-CDA0-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resent with a correction of dmasound_q40.c - I don't touch the
IRQ handler anymore.

This one just needs a parameter to synchronize_irq(irq);

--- linux-2.5.36/sound/oss/cs4281/cs4281m.c	2002-09-21 
19:02:02.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/cs4281/cs4281m.c	2002-08-10 
17:13:46.000000000 +0200
@@ -3205,7 +3205,7 @@
  			 "cs4281: cs4281_ioctl(): DSP_RESET\n"));
  		if (file->f_mode & FMODE_WRITE) {
  			stop_dac(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
  			s->dma_dac.swptr = s->dma_dac.hwptr =
  			    s->dma_dac.count = s->dma_dac.total_bytes =
  			    s->dma_dac.blocks = s->dma_dac.wakeup = 0;
@@ -3213,7 +3213,7 @@
  		}
  		if (file->f_mode & FMODE_READ) {
  			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
  			s->dma_adc.swptr = s->dma_adc.hwptr =
  			    s->dma_adc.count = s->dma_adc.total_bytes =
  			    s->dma_adc.blocks = s->dma_dac.wakeup = 0;
@@ -4452,7 +4452,7 @@
  {
  	struct cs4281_state *s = pci_get_drvdata(pci_dev);
  	// stop DMA controller
-	synchronize_irq();
+	synchronize_irq(s->irq);
  	free_irq(s->irq, s);
  	unregister_sound_dsp(s->dev_audio);
  	unregister_sound_mixer(s->dev_mixer);

