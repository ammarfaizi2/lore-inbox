Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318313AbSHKPwg>; Sun, 11 Aug 2002 11:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318314AbSHKPwg>; Sun, 11 Aug 2002 11:52:36 -0400
Received: from waste.org ([209.173.204.2]:20875 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318313AbSHKPwf>;
	Sun, 11 Aug 2002 11:52:35 -0400
Date: Sun, 11 Aug 2002 10:56:06 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rob Landley <landley@trommello.org>
cc: "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: klibc development release
In-Reply-To: <200208111011.g7BABva75716@pimout3-int.prodigy.net>
Message-ID: <Pine.LNX.4.44.0208111032001.25011-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002, Rob Landley wrote:

> On Friday 09 August 2002 06:03 pm, Oliver Xymoron wrote:
> > On 8 Aug 2002, H. Peter Anvin wrote:
> > > Okay, I'm starting to have enough guts about this to release for
> > > testing...
> > >
> > > klibc is a tiny C library subset intended to be integrated into the
> > > kernel source tree and being used for initramfs stuff.  Thus,
> > > initramfs+rootfs can be used to move things that are currently in
> > > kernel space, such as ip autoconfiguration or nfsroot (in fact,
> > > mounting root in general) into user space.
> >
> > Remind me why we'd want this in the kernel source tree when we don't even
> > have modutils there?
>
> It's optional: CONFIG_MODULES=n

For some configurations. Part of this boot in userspace deal was more
reliance on modules and late initialization.

> > Or a real bootloader?
>
> Also optional: cat bzImage > /dev/fd0 (ugly but still works)

On some machines. I don't have any with floppies. Making a bootable CDROM
without a real userspace is kindof silly. And I can't do a whole heck of a
lot with that floppy unless I've got some other packages around anyway.

> > There is no requirement that
> > the kernel must be able to build a bootable image with ip autoconf and
> > nfsroot, etc. without using external tools.
>
> How about partition detection?  When initramfs goes in that's one of the
> things they're threatening to move to userspace.  Also lots of the hardware
> detection and setup (ACPI, hotplug style PCI probing...)

Yes, yes. The whole point of this exercise is to move such things out of
the kernel. The mechanics of booting can (and should) be made entirely
independent of the kernel tree. LILO, grub, etc., do this on one side,
bootutils.tgz should do this on the other. The kernel's job here is to get
some form of userspace running and say 'not my job'. Having an 'official'
bootutils tied to the kernel effectively keeps it kernel policy and will
discourage people from rolling their own alternatives.

> If that sort of stuff goes into userspace, you may not be able to boot ANY
> linux system without it.

Big deal. For most practical purposes, you already need a bunch of other
packages to do anything useful.

> > A minimal 'parse command line
> > to mount root and call real init' might be nice, but mostly as an
> > example, like the example watchdog code.
>
> See "partition detection in userspace".  How minimal is "minimal"?

Hello world, really. Given that kernels can't boot off IDE without a
bootloader, partition detection isn't going to get it closer to
self-booting.

> > I think a better way to go is to simply roll an initbootutils.tar.gz,
> > point to it in the kernel CHANGES, etc., start pulling stuff into it, and
> > people will catch on in no time.
>
> Possibly it could be gotten to work before being split off?  And then there's
> the question of upgrading your kernel without upgrading the initbootutils: if
> this never happens, what exactly is the benefit of it being in another
> tarball?  (I.E. how tight is the binding gonna be?  I certainly don't know
> yet...)

It ought not be any more tightly bound than regular libc. Isn't that the
point? If it still depends on non-generic services in the kernel, then we
haven't succeeded in pulling it all the way into userspace.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

