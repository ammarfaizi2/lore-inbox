Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVBWTfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVBWTfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 14:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVBWTfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 14:35:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49606 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261545AbVBWTfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 14:35:00 -0500
Date: Wed, 23 Feb 2005 04:23:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Charles-Edouard Ruault <ce@idtect.com>
Cc: torvalds@osdl.org, akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Reserve only needed regions for PC timers on i386 and x86_64
Message-ID: <20050223072358.GA6237@dmt.cnet>
References: <420734DC.4020900@idtect.com> <1108487045.4618.12.camel@localhost.localdomain> <4219DCCA.1090509@idtect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4219DCCA.1090509@idtect.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Feb 21, 2005 at 02:06:18PM +0100, Charles-Edouard Ruault wrote:
> Alan Cox wrote:
> >On Llu, 2005-02-07 at 09:29, Charles-Edouard Ruault wrote:
> >>- Why is the generic timer using this address ? isn't it reserving a too 
> >>wide portion of IO ports ? Should it be modified for this board ?
> >
> >It just reserved the entire chip space since way back when.
> >>-  If there's a good reason for the timer to request this address, is  
> >>there a clean way to share it with the timer ?
> >
> >Submit a small patch to Linus/Andrew to make the generic code only
> >reserve the ports it should. It's just a historical oversight
> >
> > 
> >
> Linus, Andrew,
> As suggested by Alan, here's a small patch against kernel 2.4.29 to 
> split the IO addresses reserved for the  PC timer into two regions 
> instead of a large one.
> It mimics what has been done in kernel 2.6.
> Instead of reserving 0x40 through 0x5f it reserves only what the two 
> timers need, i.e 0x40-0x43 and 0x50-0x53.
> It patches both i386 and x86_64 architecture.

Applied, 

Thanks Charles.

> --- linux/arch/i386/kernel/setup.c.orig	Fri Feb 18 18:46:55 2005
> +++ linux/arch/i386/kernel/setup.c	Mon Feb 21 11:19:45 2005
> @@ -354,7 +354,8 @@
>  struct resource standard_io_resources[] = {
>  	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
>  	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
> -	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
> +	{ "timer0", 0x40, 0x43, IORESOURCE_BUSY },
> +	{ "timer1", 0x50, 0x53, IORESOURCE_BUSY },
>  	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
>  	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
>  	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
> --- linux/arch/x86_64/kernel/setup.c.orig	Mon Feb 21 11:56:11 2005
> +++ linux/arch/x86_64/kernel/setup.c	Mon Feb 21 11:54:41 2005
> @@ -93,7 +93,8 @@
>  struct resource standard_io_resources[] = {
>  	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
>  	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
> -	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
> +	{ "timer0", 0x40, 0x43, IORESOURCE_BUSY },
> +	{ "timer1", 0x50, 0x53, IORESOURCE_BUSY },
>  	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
>  	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
>  	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },

