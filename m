Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVCWKr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVCWKr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVCWKr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:47:58 -0500
Received: from loopy.telegraphics.com.au ([202.45.126.152]:51083 "EHLO
	loopy.telegraphics.com.au") by vger.kernel.org with ESMTP
	id S261533AbVCWKrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:47:36 -0500
Date: Wed, 23 Mar 2005 21:47:33 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] Jazzsonic driver updates
In-Reply-To: <20050323100139.GB8813@linux-mips.org>
Message-ID: <Pine.LNX.4.61.0503232133250.15033@loopy.telegraphics.com.au>
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
> the Jazz machines.  Didn't realize m68k had cloned it :-)

m68k doesn't clone it. This is from macsonic.c,

#define vdma_alloc(foo, bar) ((u32)foo)

> If anything it seems this should be converted to the modern DMA API.

Sure, but until that happens, it would be nice if the upstream kernel had 
the MIPS repo versions of sonic.c, sonic.h and jazzsonic.c. That way it 
might be possible for me to put together a patch for macsonic that both 
archs are happy with.

It doesn't require a new DMA API to fix all the built-in ethernet ports on 
68k Macs.

-f

>   Ralf
