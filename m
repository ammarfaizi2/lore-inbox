Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSEIOLE>; Thu, 9 May 2002 10:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSEIOLD>; Thu, 9 May 2002 10:11:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29203 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313060AbSEIOLD>;
	Thu, 9 May 2002 10:11:03 -0400
Message-ID: <3CDA8341.6070706@mandrakesoft.com>
Date: Thu, 09 May 2002 10:10:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: twaugh@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] parport irq sharing
In-Reply-To: <Pine.LNX.4.44.0205091416280.6271-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>--- linux-2.4.19-pre-ac/drivers/parport/parport_pc.c	Mon Apr  8 21:36:20 2002
>+++ linux-2.4.19-pre7-ac3/drivers/parport/parport_pc.c	Thu May  9 08:19:32 2002
>@@ -2355,7 +2355,7 @@
> 
> 	if (p->irq != PARPORT_IRQ_NONE) {
> 		if (request_irq (p->irq, parport_pc_interrupt,
>-				 0, p->name, p)) {
>+				 SA_SHIRQ, p->name, p)) {
> 			printk (KERN_WARNING "%s: irq %d in use, "
> 				"resorting to polled operation\n",
> 				p->name, p->irq);
>

I don't think you want to do this unconditionally... probably breaks 
older setups.

>
>--- linux-2.4.19-pre7-ac3/drivers/parport/parport_serial.c.orig	Sun May  5 14:24:36 2002
>+++ linux-2.4.19-pre7-ac3/drivers/parport/parport_serial.c	Thu May  9 09:46:58 2002
>@@ -249,7 +249,7 @@
> 	int success = 0;
> 
> 	if (cards[i].preinit_hook &&
>-	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
>+	    cards[i].preinit_hook (dev, dev->irq, PARPORT_DMA_NONE))
> 		return -ENODEV;
> 
> 	for (n = 0; n < cards[i].numports; n++) {
>

If parport_serial is 100% PCI (I'm too lazy to check), this should be ok...

    Jeff



