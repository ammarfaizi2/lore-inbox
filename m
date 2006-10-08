Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWJHOAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWJHOAR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWJHOAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:00:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12933 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751180AbWJHOAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:00:16 -0400
Date: Sun, 8 Oct 2006 15:00:12 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] misc arm pt_regs fixes
Message-ID: <20061008140012.GT29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/dm9000.c           |    2 +-
 drivers/usb/gadget/dummy_hcd.c |    2 +-
 include/asm-arm/hw_irq.h       |    2 +-
 sound/oss/vidc.c               |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dm9000.c b/drivers/net/dm9000.c
index 3641f3b..615d2b1 100644
--- a/drivers/net/dm9000.c
+++ b/drivers/net/dm9000.c
@@ -346,7 +346,7 @@ #ifdef CONFIG_NET_POLL_CONTROLLER
 static void dm9000_poll_controller(struct net_device *dev)
 {
 	disable_irq(dev->irq);
-	dm9000_interrupt(dev->irq,dev,NULL);
+	dm9000_interrupt(dev->irq,dev);
 	enable_irq(dev->irq);
 }
 #endif
diff --git a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
index 4d2946e..f1f32d7 100644
--- a/drivers/usb/gadget/dummy_hcd.c
+++ b/drivers/usb/gadget/dummy_hcd.c
@@ -1551,7 +1551,7 @@ return_urb:
 			ep->already_seen = ep->setup_stage = 0;
 
 		spin_unlock (&dum->lock);
-		usb_hcd_giveback_urb (dummy_to_hcd(dum), urb, NULL);
+		usb_hcd_giveback_urb (dummy_to_hcd(dum), urb);
 		spin_lock (&dum->lock);
 
 		goto restart;
diff --git a/include/asm-arm/hw_irq.h b/include/asm-arm/hw_irq.h
index ea85697..98d594a 100644
--- a/include/asm-arm/hw_irq.h
+++ b/include/asm-arm/hw_irq.h
@@ -12,7 +12,7 @@ # define handle_dynamic_tick(action)				
 	if (!(action->flags & IRQF_TIMER) && system_timer->dyn_tick) {	\
 		write_seqlock(&xtime_lock);				\
 		if (system_timer->dyn_tick->state & DYN_TICK_ENABLED)	\
-			system_timer->dyn_tick->handler(irq, 0, regs);	\
+			system_timer->dyn_tick->handler(irq, NULL);	\
 		write_sequnlock(&xtime_lock);				\
 	}
 #endif
diff --git a/sound/oss/vidc.c b/sound/oss/vidc.c
index 8932d89..bb4a096 100644
--- a/sound/oss/vidc.c
+++ b/sound/oss/vidc.c
@@ -372,7 +372,7 @@ static void vidc_audio_trigger(int dev, 
 			adev->flags |= DMA_ACTIVE;
 
 			dma_interrupt = vidc_audio_dma_interrupt;
-			vidc_sound_dma_irq(0, NULL, NULL);
+			vidc_sound_dma_irq(0, NULL);
 			iomd_writeb(DMA_CR_E | 0x10, IOMD_SD0CR);
 
 			local_irq_restore(flags);
-- 
1.4.2.GIT

