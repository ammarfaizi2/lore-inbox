Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274766AbRIUGBb>; Fri, 21 Sep 2001 02:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274767AbRIUGBW>; Fri, 21 Sep 2001 02:01:22 -0400
Received: from sushi.toad.net ([162.33.130.105]:14007 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274766AbRIUGBJ>;
	Fri, 21 Sep 2001 02:01:09 -0400
Message-ID: <3BAAD796.A766FBEC@yahoo.co.uk>
Date: Fri, 21 Sep 2001 02:00:54 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
Content-Type: multipart/mixed;
 boundary="------------D617D8139E9E5BF008AE30D1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D617D8139E9E5BF008AE30D1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I'm still wondering why this function in parport_pc.c rejects dma
values of zero.  Is DMA0 not usable by the parallel port for some
reason?  I should think that if the PnP BIOS returns a dma of zero
then it means that the parallel port is using DMA0.  Sorry if I'm
being obtuse.                      // Thomas Hood 

parport_pc.c line 2799:
int init_pnp040x(struct pci_dev *dev)
{       int io,iohi,irq,dma;

        io=dev->resource[0].start;
        iohi=dev->resource[1].start;
        irq=dev->irq_resource[0].start;
        dma=dev->dma_resource[0].start;

        if(dma==0) dma=-1;             <--- Why?

        printk(KERN_INFO "PnPBIOS: Parport found %s %s at io=%04x,%04x irq=%d dma=%d\n",
                dev->name,dev->slot_name,io,iohi,irq,dma);
        if (parport_pc_probe_port(io,iohi,irq,dma,NULL))
                return 1;
        return 0;
}
--------------D617D8139E9E5BF008AE30D1
Content-Type: text/plain; charset=us-ascii;
 name="patch-norejdma"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-norejdma"

--- linux-2.4.7-ac10/drivers/parport/parport_pc.c_ORIG	Fri Aug 10 18:19:07 2001
+++ linux-2.4.7-ac10/drivers/parport/parport_pc.c	Mon Aug 13 17:40:38 2001
@@ -2797,8 +2797,6 @@
 	irq=dev->irq_resource[0].start;
 	dma=dev->dma_resource[0].start;
 
-	if (dma==0) dma=-1;
-
 	printk(KERN_INFO "PnPBIOS: Parport found %s %s at io=%04x,%04x irq=%d dma=%d\n",
 		dev->name,dev->slot_name,io,iohi,irq,dma);
 	if (parport_pc_probe_port(io,iohi,irq,dma,NULL))


--------------D617D8139E9E5BF008AE30D1
Content-Type: text/plain; charset=us-ascii;
 name="patch-dmanone"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-dmanone"

--- linux-2.4.7-ac10/drivers/parport/parport_pc.c_ORIG	Fri Aug 10 18:19:07 2001
+++ linux-2.4.7-ac10/drivers/parport/parport_pc.c	Fri Aug 10 18:19:55 2001
@@ -2797,7 +2797,7 @@
 	irq=dev->irq_resource[0].start;
 	dma=dev->dma_resource[0].start;
 
-	if (dma==0) dma=-1;
+	if (dma==0) dma=PARPORT_DMA_NONE;
 
 	printk(KERN_INFO "PnPBIOS: Parport found %s %s at io=%04x,%04x irq=%d dma=%d\n",
 		dev->name,dev->slot_name,io,iohi,irq,dma);


--------------D617D8139E9E5BF008AE30D1--

