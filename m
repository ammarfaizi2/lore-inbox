Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261648AbTCGQMo>; Fri, 7 Mar 2003 11:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbTCGQMo>; Fri, 7 Mar 2003 11:12:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53898 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261648AbTCGQMm>; Fri, 7 Mar 2003 11:12:42 -0500
Date: Fri, 7 Mar 2003 11:23:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Chris Dukes <pakrat@www.uk.linux.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
In-Reply-To: <20030307142920.F17492@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1030307094333.15013A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Russell King wrote:

> On Fri, Mar 07, 2003 at 01:38:13PM +0000, Chris Dukes wrote:
> > You are asserting aesthetics instead of benefits.  I asked about benefits.
> > Specifically, what is the benefit of compact?
> 
> Think _embedded_.  Think "cost of flash chips".  Think "not everything
> has a floppy disk".
> 
> > I'm sure you have a very good technical or business benefit to compact, 
> 
> I'm sorry, believe it or not, but I'm not swayed by "business benefits"
> here.  Although I have my own business in the UK, we as a business are
> currently involved in hardware design which has nothing to do with the
> points I'm raising here.
> 
> > but those of us in the world of workstations and servers have zero clue 
> > what it may be.
> 
> Indeed and understandable.
> 
> > User space solution is not the same as a solution implemented with
> > multiple user space apps.
> 
> I've been working on klibc to work towards providing such a solution.
> I know what it involves, and I know that this solution isn't there yet.
> Also, the fundamentals of klibc have not been accepted by Linus, so we
> don't even know if this is going to be a solution yet.
> 
> > > Note: I *do* agree that ipconfig.c needs to die before 2.6 but I do not
> > > agree that today is the right day.
> > 
> > Perhaps you could explain why today is not the day.
> > (ie, soon to be shipping product that requires it.  desire to see a viable
> > userspace solution working before it is removed).
> 
> Just about every ARM kernel development downloads kernels via XMODEM
> and the ability to bring networking up and mount a NFS-root filesystem
> is by fair the easiest way to develop on *any* embedded device with
> Ethernet.
> 
> I suppose you could say I have a _community_ interest here - an interest
> in ensuring that the ARM community has the resources to be able to continue
> using Linux.
> 
> So, while the big server people run around removing functionality they
> don't need, they make other parts of the community suffer.  Is that
> really what Open Source is about?  Suffering? 8)
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> -

As the kernel changes there are some things that really need to remain.
You need to be able to boot from a "floppy" disk. Yes, now-days it's
probably not a real floppy, but a BIOS module that emulates a floppy.
A lot of people don't realilize that this is how a CD/ROM is booted!
The BIOS configures it to "look" like a floppy for the purpose of
booting. A "bootable" CD/ROM has as its first partition, the image
of a floppy disk.

Also, many embeded systems boot from a "RAM" disk that emulates
a floppy disk for the purpose of booting. In fact, there is
a good argument to make virtually all embeded systems that
use the same CPU as the development environment, boot this way.
You can design, code, and test the whole damn thing while the
hardware engineers are still laying out components. One such
RAM disk on our equipment, pages in "sectors" through a tiny
(0x1000) window which disappears after booting, therefore no
address-space is given up to some NVRAM. Linux is unmodified,
thinking it was booted from a 1.44 MB floppy.

If the kernel grows to where this can't be done anymore, then
embeded systems will not use modern kernels. It's that simple.
So, increased functionality really needs to be put into modules
so that the basic kernel doesn't continue to increase in size.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


