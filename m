Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbRBFTBw>; Tue, 6 Feb 2001 14:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129754AbRBFTBm>; Tue, 6 Feb 2001 14:01:42 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58863
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129412AbRBFTBd>; Tue, 6 Feb 2001 14:01:33 -0500
Date: Tue, 6 Feb 2001 12:00:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre1
Message-ID: <20010206120010.H8469@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.10.10102032021380.1010-100000@penguin.transmeta.com> <20010206113615.G8469@opus.bloom.county> <3A8047F4.327CE6B2@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A8047F4.327CE6B2@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Feb 06, 2001 at 01:52:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 01:52:36PM -0500, Jeff Garzik wrote:
> Tom Rini wrote:
> > Er, what exactly is the CONFIG_PREP stuff in this driver supposed to be
> > for?  "CONFIG_PREP" doesn't exist anymore to start with, and secondly I'm
> > not sure if any PReP boxes ever shipped with a riva card to start with.  The
> > only real way to handle this in 2.4 is something like:
> > #ifdef CONFIG_ALL_PPC /* CHRP/PMAC/PREP */
> > #include <asm/processor.h>
> > #define isPReP (_machine == _MACH_prep)
> > #else
> > #define isPReP 0
> > #endif
> > 
> > That is, if there's really any need to test explicitly for a PReP box.
> > I asked Ani Joshi about this a while ago, and he wasn't quite sure why they
> > were in there either..
> 
> It looks like it might have come from drivers/video/clgenfb.c, perhaps
> for use with big endian framebuffers?

It is indeed from clgen, but even there it's only needed on the PReP boxes
with a cirrus logic card.  The MacPicasso cards (also clgen) need some other
magic (see linux-fbdev).

> If the driver works on PPC without CONFIG_PREP code, let's get rid of
> it.

Well, it's definatly not doing anything now.  It probably shouldn't be there
anyways, as in clgen it seems to be for PReP black magic.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
