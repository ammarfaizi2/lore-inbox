Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWEVV11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWEVV11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWEVV11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:27:27 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:64750 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751203AbWEVV10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:27:26 -0400
Date: Mon, 22 May 2006 23:27:24 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
Message-ID: <20060522212724.GC9454@bitwizard.nl>
References: <20060423192251.GD8896@iucha.net> <20060423150206.546b7483.akpm@osdl.org> <20060508145609.GA3983@rhlx01.fht-esslingen.de> <20060508084301.5025b25d.akpm@osdl.org> <20060508163453.GB19040@flint.arm.linux.org.uk> <1147730828.26686.165.camel@localhost.localdomain> <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org> <1147734026.26686.200.camel@localhost.localdomain> <20060522115046.GA23074@bitwizard.nl> <1148299804.17376.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148299804.17376.34.camel@localhost.localdomain>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 01:10:04PM +0100, Alan Cox wrote:
> On Llu, 2006-05-22 at 13:50 +0200, Rogier Wolff wrote:
> > I happen to know (ISA) hardware that CANNOT share an interrupt: It
> > drives the IRQ line either high or low, and has a driver that will
> 
> You happen to be wrong. Some ISA boards use the correct diodes and
> pulldowns and can share an IRQ line although being edge triggered you
> must take great care to get it right.

I feel like I'm repeating myself... I happen to know (ISA) hardware
that /cannot/ share an interrupt. It does /not/ use correct diodes and
pulldowns. I have equipped the driver with the knowledge that it
cannot share the interrupt.

Linus' sugesstion that as an intermediate measure request that
everybody explictly flag: shared is ok, or "NO WAY", sounds like a
plan. In the meanwhile the infrastructure may warn about that driver
so that some human thinks about it, and adds the right flag. Only after
a while, (when there is no longer anybody using the default) can we
change the default....

Alan and Linus know (ISA) hardware that /can/ share interrupts.
Fine. I know hardware that /cannot/ share interrupts. So, my driver
requesting an interrupt, and getting: "Can't allocate interrupt" is an
indication of a hardware configuration error. Or software (you've been
telling one of the drivers the wrong interrupt line). If you force
"shared mode", my driver will cope (it works just great on the PCI
version of the card, no problem). But will the hardware?

You guys maybe trying to fix very real problems in PCMCIA land, of
which I have very little knowledge. But changing what "not passing
SA_SHIRQ" means globlaly IMHO changes too much... 

	Rogier. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
