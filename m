Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUA3QzB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUA3QzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:55:00 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:1263 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261931AbUA3Qy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:54:56 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: John Bradford <john@grabjohn.com>, Timothy Miller <miller@techsource.com>
Subject: Re: [OT] Crazy idea: Design open-source graphics chip
Date: Fri, 30 Jan 2004 10:54:27 -0600
X-Mailer: KMail [version 1.2]
Cc: chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4017F2C0.4020001@techsource.com> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Message-Id: <04013010542700.32275@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 January 2004 12:55, John Bradford wrote:
> > > Well, the cost of fabricating depends on the device.  I was basically
> > > thinking of a 68000, an EPROM and a SIMM on a piece of stripboard,
> > > some ribbon cable and a DB-25 connector.
> > >
> > > Maybe our goals are somewhat different :-)
> >
> > Very different.  What you're describing is a dumb terminal.
>
> Hardly.  It's nothing like a dumb terminal whatsoever.
>
> It's a simple framebuffer, possibly with line drawing, and box filling
> capabilities.  Nevertheless, it could be used as a general purpose X
> display, for spreadsheets, simple to moderate wordprocessing,
> (I.E. probably not DTP-like applications), status displays for various
> systems, etc.
>
> So, it does have real world uses.

Yes - but you want it:

1. to use the AGP to gain access to multiple offscreen pages
2. a DMA controler to copy the data
3. A simple emulation (either 8bit cpu based or better) of VGA/SVGA
4. room in the design for future processors.

Really - future processors:
1. including multiple vector multiply processors
2. general purpose CPU for control
3. LOTS of memory.

What you REALLY need to do (long term) is to move the entire X server
into a graphics board (including Mesa/OpenGL/... but minus the network
code, authentication, and resource database...).

It is my understanding that a LOT of the effort at speed is lost by using
a single threaded process to handle the graphics. With a multiple cpu (not
necessarily SMP mind you) performing the graphics transformations, you have
a single rendering output step (another case for multiple cpus - 1 cpu: entire
pixel render, 2: each takes 1/2 display, 4 - 1/4 display...). And with 
multiple dual ported graphics memory (port to pixel rendering cpu, port to
frame buffer) you end up wit a very fast graphics display.

Limiting factor: it may be bigger than a single slot.

It would likely resemble the old SGI type of rendering engine, which used 
multiple boards, multiple staging memory, and multiported display.

BUT: it would be modular. Pay a little and you only get a frame buffer.

Add a general CPU - you get a basic X server (with slow 3D, but likely
faster than currently done by the host processor)-- and pay more.
Add a geometry engine (ie a processor/memory for Mesa) you get faster 3D 
operations...

Add multiple engines (each takes part of the display) you get speed...

It would likely require one AGP, but two PCI slots; and like the SGI
engines, an internal connection between the two boards.

This would also allow the project to have price levels - a $20 AGP frame
buffer wouldn't be bad at all (and not all that slow either...)

Add $40 for a general CPU... with the benifit of offloading the major X
functions... and still have the ability to use the AGP. (BTY - the AGP
is bi-directional... you should be able to copy images from the framebuffer)

Add $40 (might have to trade in the existing general CPU... so it could
actually be ~$80) and you should get options for multiple geometry 
processors... at $10/20 each?

Note - the costs shown for the last upgrade is very likely wrong.

> > What I'm describing is a PC console graphics card that will let someone
> > play Quake III at a reasonable framerate.
> >
> > Isn't that what most people want?

Something like the above should do.
>
[snip]
