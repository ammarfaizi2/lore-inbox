Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbREBH2C>; Wed, 2 May 2001 03:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbREBH1w>; Wed, 2 May 2001 03:27:52 -0400
Received: from hood.tvd.be ([195.162.196.21]:57729 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S130446AbREBH1m>;
	Wed, 2 May 2001 03:27:42 -0400
Date: Wed, 2 May 2001 09:26:20 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
In-Reply-To: <9cmrcv$20e$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.05.10105020922000.922-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 May 2001, Linus Torvalds wrote:
> In article <OF7A9C6B22.E1638E60-ON85256A3F.004EADC7@urscorp.com>,
>  <mike_phillips@urscorp.com> wrote:
> >>mike_phillips@urscorp.com wrote:
> >>> 
> >>> To get the pcmcia ibmtr driver (ibmtr/ibmtr_cs) working on ppc, all the
> >>> isa_read/write's have to be changed to regular read/write due to the 
> >lack
> >>> of the isa_read/write functions for ppc.
> >
> >> Treat it like a PCI device and use ioremap().  Then change isa_readl()
> >> to readl() etc.
> >
> >Bleurgh, the latest version of the driver (not in the kernel yet) searches 
> >for turbo based cards by checking the isa address space from 0xc0000 - 
> >0xe0000 in 8k chunks. So we'd have to ioremap each 8k section, check it, 
> >find out the adapter isn't there and then iounmap it. 
> >
> >Oh well, if that's what it takes =:0
> 
> I would suggest the opposite approach instead: make the PPC just support
> isa_readx/isa_writex instead.
> 
> Much simpler, and doesn't need changes to (correct) driver sources.

And while you're at it, please add isa_{request,release}_mem_region() as well.

Reasoning: while we can (and do) make ioremap(0xa0000, ...) work fine on PPC
(you must not use ioremap() for RAM, so it must be ISA memory space), we can't
distinguish between the first 16 MB of RAM and ISA memory space for
{request,release}_mem_region()...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

