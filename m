Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVCWKDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVCWKDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVCWKDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:03:35 -0500
Received: from pD95622C1.dip.t-dialin.net ([217.86.34.193]:29421 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261484AbVCWKDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:03:33 -0500
Date: Wed, 23 Mar 2005 10:01:39 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] Jazzsonic driver updates
Message-ID: <20050323100139.GB8813@linux-mips.org>
References: <200503070210.j272ARii023023@hera.kernel.org> <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 06:13:17PM +0100, Geert Uytterhoeven wrote:

> On Fri, 28 Jan 2005, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1986, 2005/01/28 00:12:28-05:00, ralf@linux-mips.org
> > 
> > 	[PATCH] Jazzsonic driver updates
> > 	
> > 	 o Resurrect the Jazz SONIC driver after years of it not having been tested
> > 	 o Convert from Space.c initialization to module_init / platform device.
> > 	
> > 	Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
> 
> > --- a/drivers/net/sonic.c	2005-03-06 18:10:39 -08:00
> > +++ b/drivers/net/sonic.c	2005-03-06 18:10:39 -08:00
> > @@ -116,7 +116,7 @@
> >  	/*
> >  	 * Map the packet data into the logical DMA address space
> >  	 */
> > -	if ((laddr = vdma_alloc(PHYSADDR(skb->data), skb->len)) == ~0UL) {
> > +	if ((laddr = vdma_alloc(CPHYSADDR(skb->data), skb->len)) == ~0UL) {
>                                 ^^^^^^^^^
> This part broke compilation for Mac/m68k.
> 
> >  		printk("%s: no VDMA entry for transmit available.\n",
> >  		       dev->name);
> >  		dev_kfree_skb(skb);

Oh funny.  vdma_alloc() was created 10 years ago as an internal API for
the Jazz machines.  Didn't realize m68k had cloned it :-)  If anything
it seems this should be converted to the modern DMA API.

  Ralf
