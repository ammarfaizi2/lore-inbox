Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282145AbRK1OGm>; Wed, 28 Nov 2001 09:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282150AbRK1OGb>; Wed, 28 Nov 2001 09:06:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59788 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S282145AbRK1OGU>; Wed, 28 Nov 2001 09:06:20 -0500
Date: Wed, 28 Nov 2001 09:06:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Meadors <clubneon@hereintown.net>
cc: Martin Eriksson <nitrax@giron.wox.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 'spurious 8259A interrupt: IRQ7'
In-Reply-To: <Pine.LNX.4.40.0111280855270.88-100000@rc.priv.hereintown.net>
Message-ID: <Pine.LNX.3.95.1011128084801.10732A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2001, Chris Meadors wrote:

> On Wed, 28 Nov 2001, Martin Eriksson wrote:
> 
> > I'm starting to believe it has something to do with the parallel port being
> > unconnected, thus sending random signals to the mobo causing an interrupt?
> > If this is the case it is very possible that it has to do with correct
> > grounding also...
> 
> Actually I believe way back there was a discussion about this same
> message, Alan Cox said he thought it was caused by bad parallel ports.
> 
> That said I see it on 2 Athlon boxes with VIA chipsets.  One I had never
> seen the message until I removed the parallel port QuickCam I had hooked
> up.
> 

IRQ7 is usually connected to the parallel port. If there is no driver
installed, that expects interrupts, you could end up with this
annoying message because the printer status bits are all ORed into
that IRQ line. You can disable this with software, though, and it
might be a good idea.

          outb(0, BASE+2);

... where BASE is 0x278, 0x378, 0x3bc, etc.. the printer ports.

Also, a catch-all for confused interrupt controllers is IRQ7. Even
without a parallel port, you can still get an occasional spurious
interrupt. I think the kernel should have an interrupt handler for
this interrupt that does nothing except ACK the interrupt and
keep its mouth shut.  The request_irq() procedure should ignore
the fact that it is "in use", and let any driver have it without
sharing it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


