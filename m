Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143404AbRATKUd>; Sat, 20 Jan 2001 05:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143409AbRATKUX>; Sat, 20 Jan 2001 05:20:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42502 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S143404AbRATKUJ>;
	Sat, 20 Jan 2001 05:20:09 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101200828.f0K8SKF00961@flint.arm.linux.org.uk>
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Sat, 20 Jan 2001 08:28:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010120003812.G9156@sventech.com> from "Johannes Erdfelt" at Jan 20, 2001 12:38:12 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt writes:
> On Fri, Jan 19, 2001, Miles Lane <miles@megapathdsl.net> wrote:
> > Johannes Erdfelt wrote:
> > 
> > > TODO
> > > ----
> > > - The PCI DMA architecture is horribly inefficient on x86 and ia64. The
> > >   result is a page is allocated for each TD. This is evil. Perhaps a slab
> > >   cache internally? Or modify the generic slab cache to handle PCI DMA
> > >   pages instead?
> > 
> > This might be the kind of thing to run past Linus when the 2.5 tree 
> > opens up.  Are these inefficiencies necessary evils due to workarounds 
> > for whacky bugs in BIOSen or PCI chipsets or are they due to poor 
> > design/implementation?
> 
> Looks like poor design/implementation. Or perhaps it was designed for
> another reason than I want to use it for.

Why?  What are you trying to do?  Allocate one area per small structure?
Why not allocate one big area and allocate from that (like the tulip
drivers do for their TX and RX rings)?

I don't really know what you're trying to do/what the problem is because
there isn't enough context left in the original mail above, and I have
no idea whether the original mail appeared here or where I can read it.

> I should also check architectures other than x86 and ia64.

This is an absolute must.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
