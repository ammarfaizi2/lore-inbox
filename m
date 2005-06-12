Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFLGbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFLGbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 02:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVFLGaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 02:30:14 -0400
Received: from loopy.telegraphics.com.au ([202.45.126.152]:57774 "EHLO
	loopy.telegraphics.com.au") by vger.kernel.org with ESMTP
	id S261165AbVFLGFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 02:05:34 -0400
Date: Sun, 12 Jun 2005 16:05:30 +1000 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux MIPS <linux-mips@vger.kernel.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] Jazzsonic driver updates
In-Reply-To: <20050323100139.GB8813@linux-mips.org>
Message-ID: <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au>
References: <200503070210.j272ARii023023@hera.kernel.org>
 <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Mar 2005, Ralf Baechle wrote:

> On Tue, Mar 22, 2005 at 06:13:17PM +0100, Geert Uytterhoeven wrote:
> 
> > On Fri, 28 Jan 2005, Linux Kernel Mailing List wrote:
> > > ChangeSet 1.1986, 2005/01/28 00:12:28-05:00, ralf@linux-mips.org
> > > 
> > > 	[PATCH] Jazzsonic driver updates
> > > 	
> > > 	 o Resurrect the Jazz SONIC driver after years of it not having been tested
> > > 	 o Convert from Space.c initialization to module_init / platform device.
> > > 	
> > > 	Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
> > 
> > > --- a/drivers/net/sonic.c	2005-03-06 18:10:39 -08:00
> > > +++ b/drivers/net/sonic.c	2005-03-06 18:10:39 -08:00
> > > @@ -116,7 +116,7 @@
> > >  	/*
> > >  	 * Map the packet data into the logical DMA address space
> > >  	 */
> > > -	if ((laddr = vdma_alloc(PHYSADDR(skb->data), skb->len)) == ~0UL) {
> > > +	if ((laddr = vdma_alloc(CPHYSADDR(skb->data), skb->len)) == ~0UL) {
> >                                 ^^^^^^^^^
> > This part broke compilation for Mac/m68k.
> > 
> > >  		printk("%s: no VDMA entry for transmit available.\n",
> > >  		       dev->name);
> > >  		dev_kfree_skb(skb);
> 
> Oh funny.  vdma_alloc() was created 10 years ago as an internal API for
> the Jazz machines.  Didn't realize m68k had cloned it :-)  If anything
> it seems this should be converted to the modern DMA API.

I've just started merging my Mac sonic work into 2.6.12-rc6. m68k doesn't 
yet implement the modern DMA API, but it is easy to fake it for a while 
for macsonic.c. So I don't mind converting macsonic, jazzsonic and the 
shared sonic driver core to the new API.

But, I knowing nothing about the Jazz DMA controller. I need some help 
from the MIPS people:

Would I be right to say that vdma_{alloc,free}() can be changed to 
dma_{,un}map_single? The other Jazz specific routine that sonic uses is 
vdma_log2phys, and I don't know if that has a better alternative.

-f

>   Ralf
> -
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
