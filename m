Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318964AbSH1QIB>; Wed, 28 Aug 2002 12:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318965AbSH1QIB>; Wed, 28 Aug 2002 12:08:01 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38141 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318964AbSH1QH7>; Wed, 28 Aug 2002 12:07:59 -0400
Date: Wed, 28 Aug 2002 12:12:18 -0400
From: Doug Ledford <dledford@redhat.com>
To: Andris Pavenis <pavenis@latnet.lv>
Cc: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
       "linux-kernel@vger" <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
Message-ID: <20020828121218.E30777@redhat.com>
Mail-Followup-To: Andris Pavenis <pavenis@latnet.lv>,
	Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
	"linux-kernel@vger" <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@redhat.com>
References: <200208271253.12192.pavenis@latnet.lv> <200208281622.30303.pavenis@latnet.lv> <20020828112133.C30777@redhat.com> <200208281859.38609.pavenis@latnet.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208281859.38609.pavenis@latnet.lv>; from pavenis@latnet.lv on Wed, Aug 28, 2002 at 06:59:38PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 06:59:38PM +0300, Andris Pavenis wrote:
> 
> Tried, it helps for i810_audio.c both from 2.4.20-pre1-ac2 and 
> 2.4.20-pre4-ac1. (Patch simply to be sure we're talking about the
> same thing). In both cases I put i810_audio.c in 2.4.20-pre4-ac1 source
> tree.

[ Alan, you should be perking your ears up about now I think... ]

OK, let's be more precise on this ;-)  If you put this patch into the 
2.4.20-pre4-ac1 kernel, does it actually solve the DMA overrun problem 
(as in they don't happen anymore) or does it only reduce the frequency 
of the problem but it does still exist?  Same question for the drain_dac() 
DMA timeout messages?

> 
> Andris
> 
> --- i810_audio.c-2.4.20-pre1-ac2	2002-08-28 09:50:44.000000000 +0300
> +++ i810_audio.c	2002-08-28 18:51:34.000000000 +0300
> @@ -732,8 +732,6 @@
>  	outb(0, card->iobase + PI_CR);
>  	// wait for the card to acknowledge shutdown
>  	while( inb(card->iobase + PI_CR) != 0 ) ;
> -	// reset the dma engine now
> -	outb(0x02, card->iobase + PI_CR);
>  	// now clear any latent interrupt bits (like the halt bit)
>  	if(card->pci_id == PCI_DEVICE_ID_SI_7012)
>  		outb( inb(card->iobase + PI_PICB), card->iobase + PI_PICB );
> @@ -784,8 +782,6 @@
>  	outb(0, card->iobase + PO_CR);
>  	// wait for the card to acknowledge shutdown
>  	while( inb(card->iobase + PO_CR) != 0 ) ;
> -	// reset the dma engine now
> -	outb(0x02, card->iobase + PO_CR);
>  	// now clear any latent interrupt bits (like the halt bit)
>  	if(card->pci_id == PCI_DEVICE_ID_SI_7012)
>  		outb( inb(card->iobase + PO_PICB), card->iobase + PO_PICB );

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
