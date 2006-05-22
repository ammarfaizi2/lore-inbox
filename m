Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWEVLuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWEVLuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWEVLuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:50:50 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:30460 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750768AbWEVLut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:50:49 -0400
Date: Mon, 22 May 2006 13:50:46 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
Message-ID: <20060522115046.GA23074@bitwizard.nl>
References: <20060423192251.GD8896@iucha.net> <20060423150206.546b7483.akpm@osdl.org> <20060508145609.GA3983@rhlx01.fht-esslingen.de> <20060508084301.5025b25d.akpm@osdl.org> <20060508163453.GB19040@flint.arm.linux.org.uk> <1147730828.26686.165.camel@localhost.localdomain> <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org> <1147734026.26686.200.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147734026.26686.200.camel@localhost.localdomain>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 12:00:26AM +0100, Alan Cox wrote:
> > So I would strongly argue that any driver that depends on getting an 
> > exclusive IRQ is buggy, not the PCMCIA layer itself, and that it would be 
> > a lot more productive to try to fix those drivers.
> 
> It would certainly be a lot cleaner than this sort of code in the pcmcia
> core right now. Want me to send a patch which only allows for SA_SHIRQ
> and WARN_ON()'s for any driver not asking for shared IRQ ?

The question I'm stuck with is: When is it valid to ask for a non-shared
IRQ, and get back a shared one. 

Drivers that know that they don't work well if they are called by the
"other" interrupt?

I happen to know (ISA) hardware that CANNOT share an interrupt: It
drives the IRQ line either high or low, and has a driver that will
overpower anything else on that line. This sounds like a good place to
me to have the driver request no sharing (*), and to prevent the IRQ
line drivers getting in eachothers way, it would be nice if the kernel
refused "early on" (i.e. before the stronger driver asserts: No IRQ
pending, and the weaker one keeps trying to assert: "YES, I have an
IRQ", and the weaker one slowly burning out).

Or am I talking nonsense again?

	Roger. 

(*) The driver knows to allow sharing when it's talking to the PCI
version of the card.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
