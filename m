Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUJTV4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUJTV4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUJTV4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:56:48 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:3091 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S269003AbUJTVvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:51:19 -0400
Message-ID: <4176E08B.2050706@techsource.com>
Date: Wed, 20 Oct 2004 18:02:51 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've brought this up the following subject before on LKML, but it wasn't 
really resolved, and also, management at my company (Tech Source) has 
only now started to warm up to my idea.

To begin with, I'm an ASIC/FPGA designer, as well as software developer. 
  My own projects here include X11 drivers (DDX modules) for OpenWindows 
and XFree86, as well as the bulk of a graphics ASIC which we use in our 
air traffic control systems.  The point:  we have a lot of experience 
with graphics hardware and system software.

In short, what I have been proposing to my superiors is the development 
of a graphics card specifically for open source systems.  This means 
full disclosure on all register interfaces so that no one has to deal 
with anything closed source (BIOS included).  The goal here is to 
produce a graphics card which is a Free Software geek's dream in terms 
of openness.  If Tech Source (me being its avatar) can develop a 
relationship with the Linux (and BSD) community, users and developers 
can get a product that they want without being locked out by hardware 
vendors that feel they have to protect every last little bit of IP 
relating to their products.  The EXPRESS PURPOSE of this product is to 
be free-software-friendly.

I can produce more detail later, but first, some characteristics and 
advantages of what I'm proposing:

- x86 BIOS/OpenBoot/OpenFirmware code under BSD and GPL license
- kernel drivers under BSD and GPL license
- X11 module under MIT license
- flashable PROM so that boot code can be added for more platforms
- usable as the console on any platform that can take a PCI, AGP, or 
PCI-Express card
- downloadable schematic for the circuit board
- FPGA-based graphics engine so it's reprogrammable
- instructions on how to reprogram the FPGA, so it's hackable
- if we discontinue a product, we may release the Verilog code for the FPGA
- Since this is designed to be open-source-friendly, we want to play by 
the rules of the open-source community.
- Tech Source would actively participate in the development and 
maintenance of our own drivers.
- We will actually pay attention to problems and concerns raised by 
users and developers.
- We won't be control-freaks.

The desired effects, for developers, of these characteristics would include:

- The card "just works" with Linux because, maybe, the drivers would go 
into main-line
- The drivers are not a debugging/tainting nightmare, since they are 
open source
- The drivers are easy to work on, since you don't ever have to guess 
about anything.
- The drivers are easy to debug because
     (a) we document everything, and
     (b) we'll talk to you.
- People will think it's cool and want to hack it.

The desired effect for end users:

- It just works.
- It's not a liability for system stability.


The reason this idea came up is because I, as a user of Linux, am often 
frustrated by the lack of open-source support for graphics cards which 
are not "pre-owned".  Sure, SOME companies release specs so that we can 
develop open source drivers, but those cards tend to be prohibitively 
expensive, slower than their cheaper counterparts from ATI or nVidia, 
and they STILL don't document the internals of the BIOS so that the card 
can be ported to a non-x86 system.  Furthermore, since all these vendors 
focus exclusively on Windows, they don't give much help to open source 
developers who may produce drivers which work but which are sub-optimal 
in performance or stability.  (Here, I have to make the obligatory CYA 
statement that there is nothing wrong with their business models -- it's 
just unfortunate for Linux users.)

By contrast, what _I_ want to produce would be supportable by both Tech 
Source (mostly me), and also by anyone else who wants to hack it.  I 
would be one of the primary designers of the chip, so I would know it 
inside and out.  I would also be the primary driver developer, with the 
help of others on LKML.  So, I would be here to help, but hopefully, the 
documentation would be clear enough (and the drivers I write, complete 
enough) so that no one gets stuck having to guess or reverse-engineer 
anything.

There are, however, some caveats.  Tech Source is not willing to foot a 
lot of development capital for this project.  That means we can't spend 
an excessive amount of time on developing a fully virtex shading 
programmable 3D engine, and my superiors are not willing, as yet, to 
give me sufficient funding to produce an ASIC.  What this means is that 
the design has to be small and simple and focus primarily on 2D 
performance so that it can fit into an FPGA.

A 2D rendering engine is easy to parallelize, so although we can't clock 
the FPGA design as fast as an ASIC design, we can easily saturate a 
128-bit DDR memory bus at, say, 200Mhz.  A 3D rendering engine, on the 
other hand, is a beast, and our performance will be less than stellar 
(although certainly better than doing it all with the host CPU).  (If 
there IS sufficient demand, we would LOVE to produce a 
performance-competitive 3D chip, but keep in mind that that would be a 
huge and expensive development effort, and would result in an expensive 
product.)

The advantage of having this in an FPGA is that we can add features and 
fix bugs as necessary, and provide a flash utility for everyone to use 
to upgrade.  You run the utility, cycle power, and you're set.  This 
way, if some kernel developer who is concerned about latency decides 
that having an interrupt signal occur on some event that we don't 
already cover, we can add the feature and supply a new bitfile in 
relatively short order.  You wouldn't have to buy a new card to upgrade.

All of this, however, is a pipe-dream if it's not cost effective for 
Tech Source.  I have to make a very strong case to the CEO.  I think 
everyone at this company is excited about the IDEA of developing this 
product.  But we have no clue what the market is like.  It's not worth 
it to us to develop this if only a handful of kernel hackers are going 
to buy it.  We're guessing that some workstation and server vendors who 
deal in Linux would like to resell this sort of product, because if our 
drivers are in the mainline Linux kernel, it'll "just work".  On the 
other hand, maybe they're all perfectly happy with the graphics 
controllers that come built into many Intel motherboards and have "good 
enough" support.

The very fact that no other company has openly considered going to the 
level of openness that I'm proposing might suggest that what I'm 
proposing is completely out of touch with reality, because it just can't 
be profitable.

So, here are some questions to answer:

(1) Would the sales volumes of this product be enough to make it worth 
producing (ie. profitable)?
(2) How much would you be willing to pay for it?
(3) How do you feel about the choice of neglecting 3D performance as a 
priority?  How important is 3D performance?  In what cases is it not?
(4) How much extra would you be willing to pay for excellent 3D performance?
(5) What's most important to you, performance, price, or stability?

Feel free to insert your own questions and answers here.  Remember, I'm 
an engineer.  My understanding of business is dilettantish at best.

I haven't worked out a complete design spec for this product.  The 
reason is that what we think people want and what people REALLY want may 
not be congruent.  If you have a good idea for a piece of graphics 
hardware which you think would be beneficial to the free software 
community (and worth it for a company to produce), then Tech Source, as 
a graphics company, might be willing to sell it.


Oh, and before you flame me, YES, I AM doing market research for Tech 
Source here, but NO, I am not doing it at THEIR request.  They told me 
that if I wanted to do this, I would have to make a case for it, and 
that's what I'm trying to do.  This is MY idea, and I would personally 
love to have a product like what I'm describing.  I would also 
personally very much enjoy WORKING on such a project, because then I 
wouldn't have to do more boring stuff.  There's a lot of selfishness 
here on my part.  But it's selfishess that I hope everyone else will 
benefit from.

