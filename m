Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265054AbSKETMu>; Tue, 5 Nov 2002 14:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265087AbSKETMu>; Tue, 5 Nov 2002 14:12:50 -0500
Received: from almesberger.net ([63.105.73.239]:41481 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265054AbSKETMt>; Tue, 5 Nov 2002 14:12:49 -0500
Date: Tue, 5 Nov 2002 16:19:02 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021105161902.I1408@almesberger.net>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com> <3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net> <20021105171230.A11443@in.ibm.com> <20021105150048.H1408@almesberger.net> <1036521360.5012.116.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036521360.5012.116.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 05, 2002 at 06:36:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Let me ask the same dumb question - what does kexec need that a dumper
> doesn't.

kexec needs:
 - a system call to set it up
 - a way to silence devices (difference to dumper: kexec normally
   operates under an intact system, so it's more similar to, say,
   swsusp. But I expect that cleaning up device power management
   would also clear the path for more reliable dumpers.)
 - a bit of glue, e.g. to switch to "real mode", etc. AFAIK, none
   of this touches other code, but there are of course some
   assumptions here on what other codes provides or does.
 - device drivers that can bring silent devices back to life
   (normally, device drivers do this already, but kexec may
   uncover dormant bugs in this area)

Since recent kernels already preserve memory areas with BIOS data,
kexec is actually quite a bit less intrusive than bootimg was.

> In other words given reboot/trap hooks can kexec happily live
> as a standalone module ?

"Module", as in "software package": yes, the main problem spot
would be the system call allocation, which is also inconvenient
for other developers. By the way, kexec does not tap into the
kernel's reboot process, so no such hooks are needed. If LKCD
wants to use kexec, it can do whatever it does to be invoked at
the time of a crash, and then call kexec directly.

"Module", as in "loadable kernel module": I think so, although
it's currently "bool", not "tristate". Also, you'd have the
system call issue again.

So not merging it is mainly inconvenient to use, adds the system
call allocation as a continuous annoyance, and makes it a little
harder to work on the related infrastructure. But then, despite
being somewhat obscure, bootimg and kexec have been in use for
years, the design is about as lean as it can get, and it's cool.
What more could you ask for ? :-)

What kexec needs now is more exposure, so that the BIOS
compatibility issues get noticed and fixed, it is ported to other
architectures, and that more people can start figuring out how to
use it, and how to build a boot environment. Then, maybe in a
year or two, we can send "Methuselah" LILO and "nice little OS"
GRUB off to their well-deserved retirement.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
