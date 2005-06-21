Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFUL0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFUL0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVFULZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:25:57 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:37056 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261192AbVFULMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:12:08 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jens Axboe <axboe@suse.de>
Date: Tue, 21 Jun 2005 21:11:44 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17079.62960.729515.27128@cse.unsw.edu.au>
Cc: domen@coderock.org, "pnguyen" <pnguyen@umem.com>,
       linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>
Subject: Re: [patch 11/12] drivers/block/umem.c: Use the DMA_{64, 32}BIT_MASK constants
In-Reply-To: message from Jens Axboe on Tuesday June 21
References: <20050620215139.825371000@nd47.coderock.org>
	<20050621071938.GC9020@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 21, axboe@suse.de wrote:
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

No, it can't be, can it.... I remember looking at that code in late
2001 (I think) and thought I could make sense of it, but I'm not so
sure now.

Phap: (if you are still at umem.com) do you remember the rationale
behind this??  
If not, we should probably just remove that '!'...

Thanks Jens,

NeilBrown
