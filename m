Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbRFNOBh>; Thu, 14 Jun 2001 10:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbRFNOB1>; Thu, 14 Jun 2001 10:01:27 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:32745 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S262684AbRFNOBM>; Thu, 14 Jun 2001 10:01:12 -0400
Date: Thu, 14 Jun 2001 09:01:10 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106141401.JAA39228@tomcat.admin.navo.hpc.mil>
To: jaswinder.singh@3disystems.com, "Daniel" <ddickman@nyc.rr.com>,
        "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Cleanup is a nice idea , but Linux should support old hardware and should
> not affect them in any way.
> 
> Jaswinder.

I agree - and added my comments below.

> ----- Original Message -----
> From: "Daniel" <ddickman@nyc.rr.com>
> To: "Linux kernel" <linux-kernel@vger.kernel.org>
> Sent: Wednesday, June 13, 2001 5:44 PM
> Subject: obsolete code must die
> 
> 
> > Anyone concerned about the current size of the kernel source code? I am,
> and
> > I propose to start cleaning house on the x86 platform. I mean it's all
> very
> > well and good to keep adding features, but stuff needs to go if kernel
> > development is to move forward. Before listing the gunk I want to get rid
> > of, here's my justification for doing so:
> > -- Getting rid of old code can help simplify the kernel. This means less
> > chance of bugs.
> > -- Simplifying the kernel means that it will be easier for newbies to
> > understand and perhaps contribute.
> > -- a simpler, cleaner kernel will also be of more use in an academic
> > environment.
> > -- a smaller kernel is easier to maintain and is easier to re-architect
> > should the need arise.
> > -- If someone really needs support for this junk, they will always have
> the
> > option of using the 2.0.x, 2.2.x or 2.4.x series.
> >
> > So without further ado here're the features I want to get rid of:
> >
> > i386, i486
> > The Pentium processor has been around since 1995. Support for these older
> > processors should go so we can focus on optimizations for the pentium and
> > better processors.

I'm still using 486 systems.... Works fine for a DSL firewall. Why change it?
I'd have to buy a whole new system. The case won't hold anything newer - so
it costs $600-$800; I'd rather put that into fixing up the house... or getting
a newer workstation (1.4 GHz looks REALLY nice). I don't need high performance
for a firewall that only handles ~700Kbits/sec over a 10 base T network.

I also understand that 386 systems make excellent terminal servers...

> > math-emu
> > If support for i386 and i486 is going away, then so should math emulation.
> > Every intel processor since the 486DX has an FPU unit built in. In fact
> > shouldn't FPU support be a userspace responsibility anyway?

Not when the code must support register save/restore on context switches.
Now the meat of the emulator perhaps. But then you must also provide a
way for applications that don't know about the lack to suddenly have access
to a new library, accessed via a kernel trap (illegal instruction). This
imposes more context switches on an already slow system (though why anywone
would use floating point on one is beyond me ... maybe performance tracking
of firewall/terminal server use...).

> > ISA bus, MCA bus, EISA bus
> > PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
> > CONFIG_ISAPNP, etc
> >
> > ISA, MCA, EISA device drivers
> > If support for the buses is gone, there's no point in supporting devices
> for
> > these buses.

Not on the 386/486 systems (at least the ISA/EISA based ones).

> > all code marked as CONFIG_OBSOLETE
> > Since we're cleaning house we may as well get rid of this stuff.
> >
> > MFM/RLL/XT/ESDI hard drive support
> > Does anyone still *have* an RLL drive that works? At the very least get
> rid
> > of the old driver (eg CONFIG_BLK_DEV_HD_ONLY, CONFIG_BLK_DEV_HD_IDE,
> > CONFIG_BLK_DEV_XD, CONFIG_BLK_DEV_PS2)
> >
> > parallel/serial/game ports
> > More controversial to remove this, since they are *still* in pretty wide
> > use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.

really? I'm still running my printer this way (and just bought a parallel
printer/copier/scanner - the USB port isn't finished yet). And one of my
serial mice. Not to mention the plan to add the UPS to the serial lines....
It's still cheaper to use existing serial ports than to buy 4 serial ports
for USB. USB doesn't buy me any performance advantage (yet).

> > a.out
> > Who needs it anymore. I love ELF.
> >
> > I really think doing a clean up is worthwhile. Maybe while looking for
> stuff
> > to clean up we'll even be able to better comment the existing code. Any
> > other features people would like to get rid of? Any comments or
> suggestions?
> > I'd love to start a good discussion about this going so please send me
> your
> > 2 cents.
> >
> > Daniel


-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
