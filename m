Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSEIOZN>; Thu, 9 May 2002 10:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313165AbSEIOZM>; Thu, 9 May 2002 10:25:12 -0400
Received: from ftp.nfas.org.sz ([196.28.7.66]:7366 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313038AbSEIOZL>; Thu, 9 May 2002 10:25:11 -0400
Date: Thu, 9 May 2002 16:03:15 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: twaugh@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] parport irq sharing
In-Reply-To: <3CDA8341.6070706@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0205091601080.6271-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, Jeff Garzik wrote:

> > 	if (p->irq != PARPORT_IRQ_NONE) {
> > 		if (request_irq (p->irq, parport_pc_interrupt,
> >-				 0, p->name, p)) {
> >+				 SA_SHIRQ, p->name, p)) {
> > 			printk (KERN_WARNING "%s: irq %d in use, "
> > 				"resorting to polled operation\n",
> > 				p->name, p->irq);
> >
> 
> I don't think you want to do this unconditionally... probably breaks 
> older setups.

I'd think perhaps if a PCI device grabs a legacy parallel port IRQ, which 
shouldn't happen, or if someone misconfigured a non PNP device.

> >
> >--- linux-2.4.19-pre7-ac3/drivers/parport/parport_serial.c.orig	Sun May  5 14:24:36 2002
> >+++ linux-2.4.19-pre7-ac3/drivers/parport/parport_serial.c	Thu May  9 09:46:58 2002
> >@@ -249,7 +249,7 @@
> > 	int success = 0;
> > 
> > 	if (cards[i].preinit_hook &&
> >-	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
> >+	    cards[i].preinit_hook (dev, dev->irq, PARPORT_DMA_NONE))
> > 		return -ENODEV;
> > 
> > 	for (n = 0; n < cards[i].numports; n++) {
> >
> 
> If parport_serial is 100% PCI (I'm too lazy to check), this should be ok...

Yep.

Thanks,
	Zwane
-- 
http://function.linuxpower.ca
		

