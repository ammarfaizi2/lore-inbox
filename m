Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUA2TIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUA2TIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:08:10 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:50702 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266281AbUA2TID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:08:03 -0500
Message-ID: <40195AE0.2010006@techsource.com>
Date: Thu, 29 Jan 2004 14:11:28 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au> <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk> <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Bradford wrote:
>>>Well, the cost of fabricating depends on the device.  I was basically
>>>thinking of a 68000, an EPROM and a SIMM on a piece of stripboard,
>>>some ribbon cable and a DB-25 connector.
>>>
>>>Maybe our goals are somewhat different :-)
>>
>>Very different.  What you're describing is a dumb terminal.
> 
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

But wouldn't it be painfully slow?

> 
> 
>>What I'm describing is a PC console graphics card that will let someone 
>>play Quake III at a reasonable framerate.
>>
>>Isn't that what most people want?
> 
> 
> In the embedded and server markets, I don't see it being a major
> requirement, actually.
> 
> Just because a standard graphics card is going to do all they want and
> be cheaper to develop, doesn't make it a requirement.

Have you ever used a graphics card in VESA mode?  Dragging a window 
around the screen and watching it repaint can be a very unenjoyable 
thing to watch.  From what you've described, this is the sort of thing 
you'd get.

> 
> 
>>And the performance disparity between what you're describing and what 
>>I'm describing is enormous!
> 
> 
> Your arguments seem to be based on the fact that fabricating an ASIC
> is out of the budget of most individuals, and that no large company
> would want to develop open source graphics hardware when they can buy
> $15 graphics cards.  That argument is perfectly valid, but it's
> incomplete.
> 
> What _is_ within the budget of most interested individuals are things
> like general purpose CPUs, generic video sync generation ICs, SIMMs.
> The parallel port remains far easier to interface to than the PCI bus,
> and can easily provide enough bandwidth for experimenting with simple
> 640x480 framebuffer graphics type applications.

Interfacing with the PCI bus is easy enough in an FPGA.  If all you want 
is a dumb framebuffer, you can fit that logic into a very small, 
inexpensive Xilinx part.  All you need is a DAC and some memory chips, 
and you're set.

But even PCI can be very slow, particularly for image loads.

> 
> So, we can either do something interesting with the above, or sit
> around discussing how expensive it is to make a graphics card.
> 
> At least it provides a way for us to create the first generation of
> open graphics hardware cheaply, and experiment with various ideas.
> 
> Besides, this is just the first stage - once we have the graphics
> card, we can move on to other things like the 9-track tape drive
> discussed on LKML a while ago:


Ok, so, how about this idea:

- Small Xilinx FPGA, 16M of RAM, and a DAC on a board.
- AGP 2X
- Up to 2048x2048 resolution at 8, 16, and 32 bpp.
- Acceleration ONLY for solid fills and bitblts on-screen.

Given that so little is accelerated, there is no point in putting more 
than the viewable framebuffer on the card, hense the 16 megs.  It would 
probably actually HURT performance to cache pixmaps on the card.


Oh, there's one thing I forgot.  It would have to support VGA.  There is 
a VGA core on opencores.org that we could use, but its logic area would 
probably push up the FPGA cost so that the board was in the $100 range. 
  Probably more.

<sigh>


