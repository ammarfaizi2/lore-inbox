Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290381AbSAPHrR>; Wed, 16 Jan 2002 02:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289889AbSAPHrI>; Wed, 16 Jan 2002 02:47:08 -0500
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:21674 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290381AbSAPHrB>; Wed, 16 Jan 2002 02:47:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Larry McVoy <lm@bitmover.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@thyrsus.com>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: Tue, 15 Jan 2002 18:44:56 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20020114105341.E27433@work.bitmover.com> <192999434.1011130714@[195.224.237.69]>
In-Reply-To: <192999434.1011130714@[195.224.237.69]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116074700.IUTL28557.femail14.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 January 2002 04:38 pm, Alex Bligh - linux-kernel wrote:

> However, Eric's approach (dmesg) is still flawed as normally
> the way these distros fail is either (a) hanging on boot, or
> (b) failing to detect the relevant hardware. Needless to say,
> neither failure mode is going to give much use to a configurator
> tool which looks at dmesg.

"make autoconfigure" looks at a bunch of things, one of which is dmesg.  (It 
also looks at the PCI bus, isapnp, enumerates filesystems in use out of the 
mounted partitions, checks /proc/cpuinfo to see what to optimize for...)

It's actually doing a fairly decent job, although it's not quite ready for 
prime time yet.  (Improving rapidly, of course, as we continue to thump on 
it. :)

> Eric: I think you'd be far better off trying to identify the
> machine (and hence get a working .config) rather than the
> hardware.
>
> Example: put in some wget based thingy, which goes to some (fixed) web
> site, searches for (some extracted or Tillie composed string) which
> describes the hardware (bound to have been bought as-is and never opened),
> pulls down a set of config files and heuristics to determine between them
> (look at BIOS, or 'that model will always show this or that in the PCI
> table') and guesses the correct (initial) config as tested by some other
> user.

Meaning you'll continue to be six months behind the curve, and fail every 
time Dell tweaks its laptop layout.  (Dell does things like switch sound 
chips without switching model numbers ALL THE TIME.)

Are you volunteering to maintain this database?

So no-name assembled white boxes from e-machines and stuff wouldn't be 
supported?

Have you TRIED the current auto-configurator?

> This is the automated equivalent of going to www.google.com/linux,
> typing your machine name followed by 'kernel .config'. If the site
> it contacted was configurable by the distro, you'd then have
> the distros praising you in that once they have solved the problem
> for one IBM T23, they've solved it for all of them, without doing
> a new release.

Assuming every IBM T23 has the same hardware in it, which oddly enough is a 
bit of a gamble.  (OK, IBM is better at this than Dell, largely due to 
inventory management reasons.)  And assuming the finite number of database 
maintainers has yet bought an IBM T23, and that the rest of the world can 
wait until then.

Requiring live network access for the autoconfigurator to work is one heck of 
an extra requirement, though.  Most of the world is still using dialup, you 
know...

> And Aunt Tillie (apart from the module changes whatever)
> can be using the kernel version etc. from their distro (recompiled),
> rather than the latest 2.[2468].xx with lots of new bugs^Wunwanted
> fixes in.

You want to write some other tool.

In order to compile a new kernel and use it on a new machine, you need to 
configure it, which is time consuming and tedious, and can require a bit of 
detective work.  This is a problem that Giacamo and Eric decided to address.

This is NOT the problem you're trying to address.

Aunt Tillie is a side issue.  She's going to continue to run Windows until 
Linux comes preinstalled on her new computer, or until somebody ELSE installs 
it for her and does an awful lot of hand holding.  And what she probably 
really WANTS is an iMac. :)

Autoprobing PCI is -EASY-.  Almost trivial.  USB and PCMCIA/Cardbus were 
DESIGNED to be autoprobed.  Finding out your CPU type and chipset aren't too 
hard either.

It's really the old nasty ISA devices that are a pain to auto-probe, and they 
are finally, mercifully, dying off.  The newer and more naieve the user, the 
less likely they are to have lashed together an old 486 with VESA local bus, 
three different SCSI adapters, a CD-ROM hanging off the sound blaster, and a 
ham radio interface plugged into the parallel port.  Autoprobe really should 
become EASIER as time goes on.

Giacamo and Eric started work on the autoprobe as a way to reduce the number 
of questions the configurator showed people by eliminating hardware that they 
provably do not have, and defaulting the stuff they DO have to on.  But it 
turns out that on any relatively recent machine, it's an easy enough problem 
that you can autoprobe EVERYTHING and build straight from that.  So the Linux 
kernel could finally do "configure; make; make install".

I consider that a neat hack.

Rob
