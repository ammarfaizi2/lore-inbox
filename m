Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbUCTABM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 19:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUCTABM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 19:01:12 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:24846 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263176AbUCTABF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 19:01:05 -0500
Date: Sat, 20 Mar 2004 00:01:03 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Ian Campbell <icampbell@arcom.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PXA255 LCD Driver
In-Reply-To: <1079607908.2175.67.camel@icampbell-debian>
Message-ID: <Pine.LNX.4.44.0403192352580.14905-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I understand what you are saying (I think...), but I'm not sure how it
> applies to my situation -- my embedded LCD controller has no analogue
> for much of the stuff in fb_monspecs and has some extra stuff which are
> not present there.

What is it you need exactly? 

> Essentially the LCD controller<->panel interface has 16 data pins, an
> output enable, a pixel clock and (HV)sync. 

Is this the case for your setup or is this something true in general.
I like to add data fields that could be used by everyone.
 
> The settings which are of interest on a PXA255 are that aren't present
> in fb_monspecs, they specify the physical interface between the
> processor and the panel:
> 
>         active(==TFT) or passive(==STN), 
>                 These are two fundamentally different types of panel. It
>                 impacts when the pixclock ticks (all the time or just
>                 when data is present), and some other timing stuff.
>
>         output enable polarity
>                 panel is enabled on low or high
>         pixel clock polarity
>                 should the panel shift in data on a rising or a falling
>                 edge
> 	dual or single panel
>                 some STN panels are physically two panels stacked on top
>                 of each other, this impacts the way pixel data is packed
>                 onto the data lines
>         4pix or 8pix STN mono
>                 Monochrome STN panels take either 4 or 8 pixels at a
>                 time.
> 
> All of these differ from panel to panel, pretty much at the whim of the
> manufacturer...

Are these the fields you need in general?

> The other settings I think are already accounted for in the mode db:
>         resolution, bit depth, color/mono/grayscale, pixel clock, h and
>         vsync length, Left-Right-Upper-Lower margins.
> However -- all these are fixed in hardware for any given panel (although
> you could emulate different resolutions in s/w I guess).

... snip ...

> I also don't know how applicable all this is to other embedded LCD
> controllers --- the StrongArm hardware is very close to the PXA
> hardware, and I think all controllers which are as low level as them
> will share the same settings (since they are down to the hardware
> interface). I don't know for sure though.
> 
> My thinking prior to this discussion was to go for a database which maps
> LCD part # to all the settings above, where each LCD is selectable from
> Kconfig and a default can be specified (sort of like NLS now). People
> with a static panel would only build in the one database entry, people
> like me could build in a selection and choose from the command line etc
> (with overrides for all the above). 

I have thought about it. That is why I toke so long to reply. I think the 
best approach is that we create a database of struct fb_monspecs for LCD
panels. In struct fb_monspecs we have the following fields.

manufacturer[4]
monitor[14]
serial_no[14]
ascii[14]	For expansion.

We can have it so that we can pass in a monitor string that can be used to 
select the proper LCD panel in the database. How does that sound?










