Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVFUQ3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVFUQ3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVFUQ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:27:23 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:16311 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262172AbVFUQZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:25:19 -0400
Date: Tue, 21 Jun 2005 18:25:11 +0200
From: Tobias Klauser <tklauser@nuerscht.ch>
To: Jens Axboe <axboe@suse.de>
Cc: domen@coderock.org, linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: [patch 11/12] drivers/block/umem.c: Use the DMA_{64, 32}BIT_MASK constants
Message-ID: <20050621162511.GA778@mail.nuerscht.ch>
References: <20050620215139.825371000@nd47.coderock.org> <20050621071938.GC9020@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621071938.GC9020@suse.de>
X-GPG-Key: 0x3A445520
X-OS: GNU/Linux
User-Agent: Mutt/1.5.9i
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 32701; Body=4
	Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-06-21 at 09:19:39 +0200, Jens Axboe <axboe@suse.de> wrote:
> On Mon, Jun 20 2005, domen@coderock.org wrote:
> > From: Tobias Klauser <tklauser@nuerscht.ch>
> > 
> > 
> > 
> > Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when calling
> > pci_set_dma_mask() or pci_set_consistent_dma_mask()
> > These patches include dma-mapping.h explicitly because it caused errors
> > on some architectures otherwise.
> > See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details
> > 
> > Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
> > Signed-off-by: Domen Puncer <domen@coderock.org>
> > ---
> >  umem.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > Index: quilt/drivers/block/umem.c
> > ===================================================================
> > --- quilt.orig/drivers/block/umem.c
> > +++ quilt/drivers/block/umem.c
> > @@ -50,6 +50,7 @@
> >  #include <linux/timer.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> > +#include <linux/dma-mapping.h>
> >  
> >  #include <linux/fcntl.h>        /* O_ACCMODE */
> >  #include <linux/hdreg.h>  /* HDIO_GETGEO */
> > @@ -892,8 +893,8 @@ static int __devinit mm_pci_probe(struct
> >  	printk(KERN_INFO "Micro Memory(tm) controller #%d found at %02x:%02x (PCI Mem Module (Battery Backup))\n",
> >  	       card->card_number, dev->bus->number, dev->devfn);
> >  
> > -	if (pci_set_dma_mask(dev, 0xffffffffffffffffLL) &&
> > -	    !pci_set_dma_mask(dev, 0xffffffffLL)) {
> > +	if (pci_set_dma_mask(dev, DMA_64BIT_MASK) &&
> > +	    !pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
> >  		printk(KERN_WARNING "MM%d: NO suitable DMA found\n",num_cards);
> >  		return  -ENOMEM;
> >  	}
> 
> Not from your patch, but that code looks a little strange. We error if
> setting a 64-bit mask fails _but_ the 32-bit one succeeds? That can't be
> right.

Oh yes. I remember Alexey Dobriyan bringing this up some time ago on the
kernel-janitor list:
http://lists.osdl.org/mailman/htdig/kernel-janitors/2005-May/004063.html

Thanks, Tobias
