Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSJVE2r>; Tue, 22 Oct 2002 00:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbSJVE2r>; Tue, 22 Oct 2002 00:28:47 -0400
Received: from dp.samba.org ([66.70.73.150]:37327 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262129AbSJVE2n>;
	Tue, 22 Oct 2002 00:28:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@zip.com.au, davej@suse.de, davem@redhat.com,
       Guillaume Boissiere <boissiere@adiglobal.com>, mingo@redhat.com
Subject: Re: 2.6: Shortlist of Missing Features 
In-reply-to: Your message of "21 Oct 2002 13:38:17 +0100."
             <1035203897.27259.76.camel@irongate.swansea.linux.org.uk> 
Date: Tue, 22 Oct 2002 13:42:54 +1000
Message-Id: <20021022043451.4989A2C05B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1035203897.27259.76.camel@irongate.swansea.linux.org.uk> you write:
> On Mon, 2002-10-21 at 04:51, Rusty Russell wrote: 
> > - Device Mapper (lvm2)	(Alasdair Kergon, Patrick Caulfield, Joe Thornb
er)
> 
> This is in my tree
> 
> > - New config system (Roman Zippel)
> > - In-kernel module loader (Rusty Russell)
> > - Unified boot/parameter support (Rusty Russell)
> > - Hotplug CPU removal (Rusty Russell)
> 
> I guess much of this is now early 2.7.x stuff.

The new config system and in-kernel module loader are the kind of
wrenching changes which are never nice, now or in 2.7.  Both are about
as well tested as they're going to get (no external tree will merge
either, since the first means constant patch rejects and the second
means new userspace tools requirements).

In particular, the module code solves real races while making current
ones no worse.  It does printk() module refcount bugs in drivers: it
depends how long the shakeout process is going to be.

The unified boot & parameter support depends on the in-kernel module
loader (part of that "additional flexibility" I keep talking about for
the in-kernel loader).  Old-style parameters are still supported, so
it's low impact to drivers.

The Hotplug CPU removal is a noop on architectures which don't want
it: Linus took "add" some time back, but remove has been pending since
then.  I'm testing x86 "remove" now, which makes it more accessible
and useful to other people.

> The big one missing is 32bit dev_t. Thats the killer item we have left.
> The rest is mostly driver work, and some forward porting of major 2.4
> features not yet in 2.5.

Is there a patch for this in existence?

> I'd love the split console stuff if it was ready but its not vital, and
> I really want to get ucLinux merged or mostly merged

OK, here is my current list.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Key:
A: Author
M: lkml posting describing patch
W: Download
N: Random notes

In rough order of invasiveness (mostly guesses):

In-kernel Module Loader
A: Rusty Russell
W: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/
N: Requires new modutils

Kernel Config
A: Roman Zippel
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
W: http://www.xs4all.nl/~zippel/lc/

Linux Trace Toolkit (LTT)
A: Karim Yaghmour
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103491640202541&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103423004321305&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103247532007850&w=2
W: http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021019-2.2.bz2

ucLinux Patch (MMU-less support)
A: Greg Ungerer
M: http://lwn.net/Articles/11016/
W: http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc2.patch.gz

Fbdev Rewrite
A: James Simmons
W: http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

initramfs
A: Al Viro
M: http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html
W: ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C21

ext2/ext3 ACLs and Extended Attributes
A: Ted Ts'o
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
B: bk://extfs.bkbits.net/extfs-2.5-update
W: http://thunk.org/tytso/linux/extfs-2.5

High Resolution Timers
A: George Anzinger
W: http://high-res-timers.sourceforge.net/

Hotplug CPU Removal
A: Rusty Russell
W: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotplug/

Device Mapper (LVM2)
A: LWM2 Team
W: http://www.sistina.com/products_lvm.htm
N: In -ac kernels

Kernel Probes
A: Vamsi Krishna S
M: lists.insecure.org/linux-kernel/2002/Aug/1299.html
W: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Misc/kprobes.patch.gz

EVMS
A: EVMS Team
W: http://sourceforge.net/projects/evms

Crash Dumping (LKCD)
A: Matt Robinson, LKCD team
W: http://lkcd.sourceforge.net/

IPSec
A: David Miller and Alexey Kuznetsov

Crypto API
A: James Morris

Unified Boot/Module Parameter Support
A: Rusty Russell
W: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/
N: Depends on in-kernel module loader
