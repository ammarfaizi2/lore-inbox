Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266188AbRGES0k>; Thu, 5 Jul 2001 14:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266189AbRGES0b>; Thu, 5 Jul 2001 14:26:31 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:13987 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S266188AbRGES0T>;
	Thu, 5 Jul 2001 14:26:19 -0400
Date: Thu, 5 Jul 2001 20:26:05 +0200
From: David Weinehall <tao@acc.umu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: grant@aerodeck.prestel.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RE: 2.4.5-ac14 through to 2.4.6-ac1 fdomain.c initialisation for shared IRQ
Message-ID: <20010705202605.B27854@khan.acc.umu.se>
In-Reply-To: <000201c1057b$f8ff4600$0101a8c0@heron1> <E15IDfu-00034t-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E15IDfu-00034t-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 05, 2001 at 07:16:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 07:16:26PM +0100, Alan Cox wrote:
> > I have recently had a problem with the fdomain driver initialisation and
> > have found the problem to be the way in which it requests the irq. Here is
> > my patch that has so far work ok.
> 
> I've seen this patch before. It needs at least one change
> 
> > -			     do_fdomain_16x0_intr, 0, "fdomain", NULL);
> > +      retcode = request_irq( shpnt->irq,
> > +			     do_fdomain_16x0_intr, SA_SHIRQ, "fdomain", shpnt);
> 
> Only set SA_SHIRQ if PCI - say -
> 
> 		pdev?SA_SHIRQ:0
> 
> The other problem is that the code doesnt have support for handling IRQ
> source checking, so if the line it shares with generates interrupts we might
> sometimes do the right thing
> 
> I have a long outstanding request with adaptec (who bought future domain)
> for the info needed to fix this, but obviously its a dead product, from a
> bought company and hardly on their priorities.
> 
> I suspect the IRQ handler needs to either
> 
> A.	Check bit 0 of the status port and return 
> 
> B.	Check bit 4 or bit 9 of the interrupt control register
> 
> Without docs someone would need to play with the various combinations and
> see what happened

Uhmmm, an idea would be to look in fd_mcs.c as that driver already has
working support for irq-sharing.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
