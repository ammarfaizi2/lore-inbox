Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTLPBEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 20:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTLPBEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 20:04:06 -0500
Received: from intra.cyclades.com ([64.186.161.6]:54985 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264334AbTLPBEC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 20:04:02 -0500
Date: Mon, 15 Dec 2003 22:48:48 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Ernie Petrides <petrides@redhat.com>
Cc: yMarcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Peter Bergmann <bergmann.peter@gmx.net>, <nfedera@esesix.at>,
       <andrea@suse.de>, <riel@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Configurable OOM killer Re: old oom-vm for 2.4.32 (was oom killer
 in 2.4.23)
In-Reply-To: <200312152228.hBFMSCJf010565@pasta.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0312152211590.1533-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Ernie Petrides wrote:

> On Monday, 8-Dec-2003 at 15:15 -0200, Marcelo Tosatti wrote:
> 
> > The following patch makes OOM killer configurable (its the same as the 
> > other patches posted except its around CONFIG_OOM_KILLER).
> > 
> > I hope the Configure.help entry is clear enough.
> > 
> > Peter, can you please try this.
> > 
> > Comments are appreciated.
> [...]
> > --- linux-2.4.24.orig/mm/page_alloc.c	2003-12-08 14:18:51.000000000 +0000
> > +++ linux-2.4.24/mm/page_alloc.c	2003-12-08 15:49:35.000000000 +0000
> > @@ -378,7 +378,8 @@
> >  
> >  	/* here we're in the low on memory slow path */
> >  
> > -	if (current->flags & PF_MEMALLOC && !in_interrupt()) {
> > +	if (((current->flags & PF_MEMALLOC) && !in_interrupt()) || 
> > +			(current->flags & (PF_MEMALLOC | PF_MEMDIE))) {
> >  		zone = zonelist->zones;
> >  		for (;;) {
> >  			zone_t *z = *(zone++);
> [...]
> 
> 
> Hi, Marcelo.  I haven't studied this patch, but the change above looks
> suspicious.  The part added after the || makes the original condition
> irrelevant (because the 2nd part is true if either the PF_MEMALLOC or
> PF_MEMDIE flags are set).
>
> 
> Were you perhaps thinking of something like this?
>
> 	if ((current->flags & PF_MEMALLOC) &&
> 	    ((current->flags & PF_MEMDIE) || !in_interrupt())) {
> 
> Cheers.  -ernie

Correct.  

I'll change it. Thanks

