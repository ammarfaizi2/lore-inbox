Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266489AbSKZSi5>; Tue, 26 Nov 2002 13:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSKZSi5>; Tue, 26 Nov 2002 13:38:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:897 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266489AbSKZSiz>; Tue, 26 Nov 2002 13:38:55 -0500
Date: Tue, 26 Nov 2002 13:48:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dennis Grant <trog@wincom.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Kernel Configuration Tale of Woe
In-Reply-To: <3de395e1.2c79.0@wincom.net>
Message-ID: <Pine.LNX.3.95.1021126131917.13432A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Dennis Grant wrote:

> > I think he missed the solution rather than missing the 
> > problem 
> 
> I think I may agree with you, to a point, in that (after further reflection)
> I think there's an intermediate step between the current state and the magical
> world of "make partsconfig" or even "make autoconfig"
> 
> The real problem is the difficulty in mapping a given hardware configuration
> to a kernel version and a subsequent kernel configuration. There's no smooth
> road to get from one to the other. Paving that road solves the problem; the
> only question is of degree. The "make autoconfig" case is the ideal, but we
> don't necessarily need the ideal. Perfect is the enemy of good enough.
> 
> I started doing a little doodling, and I came up with a very rough sort of relationship
> map. I don't present this as the ideal data model - it's a start point at best.
> 
> 
> A "box" is composed of "devices" and "subcomponents"
> A "subcomponent" is composed of "chipsets"
> A "chipset" provides a set of "capabilities"
> A "device" requires a  set of "capabilities"
> A "chipset->capability::capablility<-device" pair defines an "interface"
> An "interface" has associated with it:
>    a) the kernel version where it first became availible
>    b) the kernel config switches that activate it
> 
> So what is needed is some way to start at the "box" level, and given the set
> of subcomponents and devices associated with it, spit out a list of a) and b)
> 
> 
> Here's the mini-eureka I've had - that need not actually be a part of the kernel
> config system, although the kernel config system might potentially make use
> of it.
> 
> What would suffice would be some sort of online database, published in a highly
> visible location, and crosslinked from hell and back to make it likely to be
> discovered in a Google-driven troubleshooting session. Provide motherboard make
> and model (a subcomponent) any expansion cards (also subcomponents) and the
> make and model numbers of drives et al (devices) and then query the database
> and present the report.
> 
> I'm envisioning something very much like the CDDB service. This is a little
> more complex, but the concept is similar. And like the CDDB service, it could
> be queried over the network by some future "make" option if somebody decided
> to implement that.
> 
> Also like the CDDB service, it makes use of network effects. No one person has
> to populate the _entire_ database. The association of "subcomponents" to "chipsets"
> (or "devices" to "capabilities") might be done by the manufacturer, or it might
> be done by the developer who actually debugged the original driver instance,
> or it might even be done by someone like myself (a sufficiently clued-in sysadmin
> who did it the hard way and wants to help those who will follow after him)
> 
> All that matters is that _somebody_ contribute one little portion of the mapping,
> and then, given enough somebodies, the entire map assembles itself.
> 
> And if Microsoft hasn't dared attempt such a thing... well, then that would
> make it an "innovation", wouldn't it? ;)
> 
> DG 

I thought Alan responded quite well, but now you have a "solution"
to a problem that doesn't exist. Really.

To make myself perfectly clear, Unix and Unix clones come to life
running one program called init. It reads some scripts that tells
it how to configure the machine the way an end-user wants it.
Look in /etc/rc.d. There are various scripts or links to scripts
for various 'run-levels'.

If you don't know this or understand this, then I can't help you.
To 'auto-configure', all you need is a kernel that is configured for
modules. As Alan pointed out, it's also helpful to have a kernel
that boots an initial RAM-Disk so that a driver to run your root-
file-system hard disk can be loaded.

All you need to do, to auto-configure, under these conditions is
to run shell-scripts or any kind of programs you want upon boot.
This scripts or programs can probe, query, cajole, or do anything
else you want, to find out what hardware you have, whether you want
to load a driver (module) and if you want to enable it. This can
all be done automatically upon boot. It doesn't require any special
kernel capabilities other than what already exists.

The auto-configure really, truly, doesn't have anything to do with
the kernel. If your distribution doesn't do what you want, you
can make it do what you want if you are capable, or you can contact
the distributor with your suggestions.

The 'auto-configuration' of the kernel proper, to load various
drivers is typically done to 'optimize' a particular system.
For this optimization, one would build-in the drivers so that
modules don't have to be loaded. One would also enable specific
code enhancements for specific processors. To do this, you really
need to tell some script or program what you are intending to do.
Currently, we have two ways of doing this. There is a graphical
kernel configuration and a text-mode kernel configuration. These
user configuration methods really have to believe what the user
tells it to do.

That said, you can write a program that looks at a properly functioning
system, and from what it sees, it could create a '.config' file that
could be used as input for `make old_config`. This could cut down
the amount of time necessary to optimize the kernel for a specific
system. But, then again, that program, although it makes a kernel-
configuration file, is not really a kernel issue.

Since I loaded my first distribution from, I think it was 57 floppy
disks, to the current ones, I have hoped that somebody would make
a kernel autoconfiguration utility but so far it hasn't been done,
probably because the kernel is usually configured to boot some
other machine. In that case, the existing manual configuration needs
to believe what the user says.

I'm going to bow out of this discussion before I get whacked
for not being on-topic myself. Contact me off the list for further
discussion. If somebody wants some help in setting up some boot-time
autoconfiguration that they don't already have, you can contact me
off-list, also.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


