Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318173AbSHKKIQ>; Sun, 11 Aug 2002 06:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSHKKIQ>; Sun, 11 Aug 2002 06:08:16 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:26109 "EHLO
	pimout3-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S318173AbSHKKIP>; Sun, 11 Aug 2002 06:08:15 -0400
Message-Id: <200208111011.g7BABva75716@pimout3-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Oliver Xymoron <oxymoron@waste.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc development release
Date: Sun, 11 Aug 2002 01:11:52 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208091651230.836-100000@waste.org>
In-Reply-To: <Pine.LNX.4.44.0208091651230.836-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 06:03 pm, Oliver Xymoron wrote:
> On 8 Aug 2002, H. Peter Anvin wrote:
> > Okay, I'm starting to have enough guts about this to release for
> > testing...
> >
> > klibc is a tiny C library subset intended to be integrated into the
> > kernel source tree and being used for initramfs stuff.  Thus,
> > initramfs+rootfs can be used to move things that are currently in
> > kernel space, such as ip autoconfiguration or nfsroot (in fact,
> > mounting root in general) into user space.
>
> Remind me why we'd want this in the kernel source tree when we don't even
> have modutils there?

It's optional: CONFIG_MODULES=n

> Or a real bootloader?

Also optional: cat bzImage > /dev/fd0 (ugly but still works)

> There is no requirement that
> the kernel must be able to build a bootable image with ip autoconf and
> nfsroot, etc. without using external tools.

How about partition detection?  When initramfs goes in that's one of the 
things they're threatening to move to userspace.  Also lots of the hardware 
detection and setup (ACPI, hotplug style PCI probing...)

If that sort of stuff goes into userspace, you may not be able to boot ANY 
linux system without it.

> A minimal 'parse command line
> to mount root and call real init' might be nice, but mostly as an
> example, like the example watchdog code.

See "partition detection in userspace".  How minimal is "minimal"?

> I think a better way to go is to simply roll an initbootutils.tar.gz,
> point to it in the kernel CHANGES, etc., start pulling stuff into it, and
> people will catch on in no time.

Possibly it could be gotten to work before being split off?  And then there's 
the question of upgrading your kernel without upgrading the initbootutils: if 
this never happens, what exactly is the benefit of it being in another 
tarball?  (I.E. how tight is the binding gonna be?  I certainly don't know 
yet...)

Rob
