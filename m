Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVA1TzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVA1TzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVA1Ty1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:54:27 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:18305 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262815AbVA1TmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:42:00 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Date: Fri, 28 Jan 2005 11:41:16 -0800
User-Agent: KMail/1.7.2
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <200501281041.42016.jbarnes@sgi.com> <20050128193320.GB32135@colo.lackof.org>
In-Reply-To: <20050128193320.GB32135@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501281141.16450.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 28, 2005 11:33 am, Grant Grundler wrote:
> > But
> > if you mean being able to access legacy ports at all, then no.  On SGI
> > machines, there's a per-bus base address that can be used as the base for
> > port I/O, which is what I was getting at.
>
> Ok - my point was "0x3fc" will get routed to exactly one of those
> IO port address spaces.

Agreed, or it will cause a machine check if legacy I/O remapping isn't 
supported (like on SGI).

> > There is no resource for some of the I/O port space that cards respond
> > to.
>
> Yes - I've heard several graphics cards are horrible broken WRT address
> decoding.  Are PCI quirks supposed to handle that sort of thing?

I'm not sure if broken is the right work.  All this stuff predates PCI by 
quite a bit, so certain device classes claimed certain port ranges way before 
cards were required to have programmable address decoders.  VGA cards are 
probably the most tenacious example of this, they respond to certain well 
known ports after reset, regardless of BAR values.

> > I can set the I/O BAR of my VGA card to 0x400 and it'll still respond to
> > accesses at 0x3bc for example.  That's what I mean by legacy space--space
> > that cards respond to but don't report in their PCI resources.
>
> Can't PCI quirks fix up the resources to reflect this?

Not sure, the I/O BAR may correspond to real registers too--and they may not 
overlap with the ones in the well known space.

> I think one needs to fix up PCI IO Port resources to adjust
> for "The One" legacy IO port space getting routed to a different
> PCI segment - assuming no one submits a patch to change current
> behavior of using hard coded addresses.

I think we might just need a new resource for these well known ports, if my 
last statement is true.

> Am I making more sense now?

Yeah, I think I understand.  We could probably do the same thing on sn2 as you 
do on parisc--add a 'segment 0' offset to the port so that it's routed 
correctly.  I think that's a little less flexible than adding a new resource 
though, since it makes it harder for drivers to support more than one device 
or devices on non-segment 0 busses.

Jesse
