Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270503AbRHHPPo>; Wed, 8 Aug 2001 11:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270506AbRHHPPf>; Wed, 8 Aug 2001 11:15:35 -0400
Received: from smtp1.ns.sympatico.ca ([142.177.1.91]:5092 "EHLO
	smtp2.ns.sympatico.ca") by vger.kernel.org with ESMTP
	id <S270503AbRHHPPP>; Wed, 8 Aug 2001 11:15:15 -0400
Message-ID: <3B715783.F3EDEC71@yahoo.co.uk>
Date: Wed, 08 Aug 2001 11:15:15 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] parport_pc.c PnP BIOS sanity check
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following would seem to be required to protect against
the case in which PnP BIOS reports an IRQ of 0 for a 
parport with disabled IRQ.      // Thomas  jdthood_AT_yahoo.co.uk

--- linux-2.4.7-ac2/drivers/parport/parport_pc.c        Mon Jul 30 01:18:34 2001
+++ linux-2.4.7-ac2-jdth1/drivers/parport/parport_pc.c  Mon Jul 30 12:32:16 2001
@@ -2797,7 +2797,8 @@
        irq=dev->irq_resource[0].start;
        dma=dev->dma_resource[0].start;

-       if(dma==0) dma=-1;
+       if (dma==0) dma=PARPORT_DMA_NONE;
+       if (irq==0) irq=PARPORT_IRQ_NONE;

        printk(KERN_INFO "PnPBIOS: Parport found %s %s at io=%04x,%04x irq=%d dma=%d\n",
                dev->name,dev->slot_name,io,iohi,irq,dma);
