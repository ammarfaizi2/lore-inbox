Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSLBHxG>; Mon, 2 Dec 2002 02:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbSLBHxG>; Mon, 2 Dec 2002 02:53:06 -0500
Received: from p508B631F.dip.t-dialin.net ([80.139.99.31]:58601 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S261371AbSLBHxF>; Mon, 2 Dec 2002 02:53:05 -0500
Date: Mon, 2 Dec 2002 08:59:23 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021202085923.A11711@linux-mips.org>
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com> <1038804400.4411.4.camel@rth.ninka.net> <20021201233901.B32203@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021201233901.B32203@twiddle.net>; from rth@twiddle.net on Sun, Dec 01, 2002 at 11:39:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 11:39:01PM -0800, Richard Henderson wrote:

> On Sun, Dec 01, 2002 at 08:46:40PM -0800, David S. Miller wrote:
> > X86_64 on the other hand seems to run x86 binaries in a similar
> > fashion.  I don't know how people currently doing this port intend
> > to do the useland, but I bet it would benefit from a mostly 32-bit
> > userland just like sparc64/ppc64 does, both in space and performance.
> 
> Except that x86-64 binaries get to use 16 more registers, can use
> pc-relative addressing modes, and have a sane function calling
> convention.  So things tend to run a bit faster in 64-bit mode.

Cache locality tends to make a much bigger difference.  I've been reported
a performance difference of over 100% for certain applications running 32-bit
on MIPS.  64-bit stuff just tends to push apps out of caches so I don't
see us on MIPS switch to a pure 64-bit any time soon either.  Assuming the
availability of 64-bit compiler etc that is - at the moment we're entirely
dependant on the 32-bit environment.

What's the plan to attack 32-bit ioctls?  Compared to "normal" syscalls
that's the much bigger dragon.  The various ioctl32.c files in the tree
are ugly enough to cause a solar eclipse ;)  The only sane solution that
also can work for multiply used ioctl numbers is pushing that down into
the the actual ioctl handlers (as opposed to an implementation sitting on
top of sys_ioctl() which basically is what we're having now) - but I guess
that's going to cause objections?

  Ralf
