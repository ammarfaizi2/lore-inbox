Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTBKGhG>; Tue, 11 Feb 2003 01:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbTBKGhG>; Tue, 11 Feb 2003 01:37:06 -0500
Received: from smtp.dslextreme.com ([66.51.205.17]:40627 "EHLO
	co1.dslextreme.com") by vger.kernel.org with ESMTP
	id <S267104AbTBKGhD>; Tue, 11 Feb 2003 01:37:03 -0500
Date: Mon, 10 Feb 2003 22:46:55 -0800
From: Paul Laufer <paul@laufernet.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Paul Laufer <paul@laufernet.com>, Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OSS Sound Blaster sb_card.c rewrite (PnP, module options, etc) - Failed
Message-ID: <20030211064655.GA11710@hal9000.laufernet.com>
Mail-Followup-To: Paul Laufer <paul@laufernet.com>,
	Shawn Starr <spstarr@sh0n.net>, Adam Belay <ambx1@neo.rr.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200302072217.24380.spstarr@sh0n.net> <20030208075339.GA13115@hal9000.laufernet.com> <200302100036.56796.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302100036.56796.spstarr@sh0n.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn, Adam,

Yes. Failing here is certainly not the right thing to do. The
soundblaster only needs 4 bytes at 0x388, which brings it from 0x388
to 0x38b, not in conflict with the ttyS0 that starts at 0x3f8.

Furthermore the soundblaster has other configurations at "priority
acceptable" with and without the OPL (0x388-0x3f8, 4 bytes).

Here are examples for the two cards I have in my system now:

# CTL0045, AWE64
Hal9000:/dev/sysfs/bus/pnp/devices/01:01.00# cat possible 
Dependent: 01 - Priority preferred
   port 0x220-0x220, align 0x0, size 0x10, 16-bit address decoding
   port 0x330-0x330, align 0x0, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5 High-Edge
   dma 1 8-bit byte-count compatible
   dma 5 16-bit word-count compatible
Dependent: 02 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5,7,2/9,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 03 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   irq 5,7,2/9,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 04 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   irq 5,7,2/9,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 05 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5,7,2/9,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
Dependent: 06 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   irq 5,7,2/9,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
Dependent: 07 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   irq 5,7,2/9,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
Dependent: 08 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
   port 0x388-0x394, align 0x3, size 0x4, 16-bit address decoding
   irq 5,7,2/9,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible

Hal9000:/dev/sysfs/bus/pnp/devices/01:01.00# cat resources
io 0x220-0x22f 
io 0x330-0x331 
io 0x388-0x38b 
irq 5 
dma 1 
dma 5 

# CTL0031, AWE32
Hal9000:/dev/sysfs/bus/pnp/devices/01:02.00# cat possible 
Dependent: 01 - Priority preferred
   port 0x220-0x220, align 0x0, size 0x10, 16-bit address decoding
   port 0x330-0x330, align 0x0, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5 High-Edge
   dma 1 8-bit byte-count compatible
   dma 5 16-bit word-count compatible
Dependent: 02 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 03 - Priority acceptable
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 04 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
   dma 5,6,7 16-bit word-count compatible
Dependent: 05 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
Dependent: 06 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
   irq 5,7,10 High-Edge
   dma 0,1,3 8-bit byte-count compatible
Dependent: 07 - Priority functional
   port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
   irq 5,7,10,11 High-Edge
   dma 0,1,3 8-bit byte-count compatible

Hal9000:/dev/sysfs/bus/pnp/devices/01:02.00# cat resources 
io 0x240-0x24f 
io 0x300-0x301 
io 0x38c-0x38f 
irq 10 
dma 3 
dma 6 


So you can see that the second card is configured correctly with OPL
IO address at 0x38c-0x38f, because the first card took 0x388-0x38b.

Adam, any insight as to what is causing Shawn's resource conflict or
why PNP isn't dropping to some priority where the OPL is not enabled?

Shawn, do you have "PNP Bios" enabled? If you turn it off does the
resource conflict go away (this happened to me before and then stopped
for reasons unknown to me).

Thanks,
Paul


On Mon, Feb 10, 2003 at 12:36:56AM -0500 or thereabouts, Shawn Starr wrote:
> pnp: Calling quirk for 01:01.00
> pnp: SB audio device quirk - increasing port range
> pnp: Calling quirk for 01:01.02
> pnp: AWE32 quirk - adding two ports
> isapnp: Card 'Creative SB32 PnP'
> isapnp: Card 'U.S. Robotics Sportster 33600 FAX/Voice Int'
> isapnp: 2 Plug & Play cards detected total
> 
> sb: Init: Starting Probe...
> pnp: the card driver 'OSS SndBlstr' has been registered
> pnp: pnp: match found with the PnP card '01:01' and the driver 'OSS SndBlstr'
> pnp: Automatic configuration failed for device '01:01.00' due to resource 
> conflicts
> sb: Init: Done
> 
> 01:01.00 = Creative SB32 PnP
> id = CTL0031
> 
> Conflicted by: 03f8-03ff : serial 
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 
> from 01:01.00/possible:
> 
> Dependent: 01 - Priority preferred
>    port 0x220-0x220, align 0x0, size 0x10, 16-bit address decoding
>    port 0x330-0x330, align 0x0, size 0x2, 16-bit address decoding
>    port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding <----------
>    irq 5 High-Edge
>    dma 1 8-bit byte-count compatible
>    dma 5 16-bit word-count compatible
> 
> Adam is working on resource conflict fixes to PnP to let us see and possibly 
> fix conflicts like this.
> 
> Shawn.
> 
> On Saturday 08 February 2003 2:53 am, Paul Laufer wrote:
> > Sorry, I sent a version of sb_card.c that was what I last minute
> > tested minus one change. The #include for sb_card.h should be under
> > the #include of pnp.h. Here is the patch. It should work after you
> > apply this.
> >
> > Thanks for testing.
> >
> > Paul
> >
> 
