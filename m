Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbTCICPJ>; Sat, 8 Mar 2003 21:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262363AbTCICPJ>; Sat, 8 Mar 2003 21:15:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43559 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262358AbTCICPH>; Sat, 8 Mar 2003 21:15:07 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
	<Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
	<20030307233916.Q17492@flint.arm.linux.org.uk>
	<m1d6l2lih9.fsf@frodo.biederman.org>
	<20030308100359.A27153@flint.arm.linux.org.uk>
	<m18yvpluw7.fsf@frodo.biederman.org>
	<20030308161309.B1896@flint.arm.linux.org.uk>
	<m1vfytkbsk.fsf@frodo.biederman.org> <3E6A5BC2.6040808@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Mar 2003 19:25:13 -0700
In-Reply-To: <3E6A5BC2.6040808@zytor.com>
Message-ID: <m1isutjmye.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> > I don't recall anything about the contents of initramfs being specified.
> > What I was expecting to see was a good set of general purpose policies
> > being included in the default kernel binary.  And just replacing
> > /sbin/kinit if I wanted something dramatically different.  And that is
> > what I remember Al Viro working on.
> > So I don't think building a very specific /sbin/kinit that
> > only does what the kernel currently does right now is a problem.
> >
> 
> It does matter how the initramfs is built.  /bin/sh may or may not be necessary
> (but klibc /bin/sh is just over 50K on i386 -- 55K static, whereas glibcx
> /bin/bash is 600K plus the glibc binary), but one of the goals with initramfs is
> 
> to at least make it feasible to give someone who comes and asks "I have a
> weird-ass site with 20000 hosts and we need X" a better answer then "well, go
> hack the kernel."

I agree the size of glibc 1.1M and /bin/bash 600K are substantial.
And in most cases if I had to drop one it would be /bin/bash.  But 2M
is not that bad if you already need 14M for your modules.   

There are still cases where you need to fit through a very narrow pipe
like a floppy, and for those any extra size is a show stopper.  But I
also don't see needing a lot of flexibility after coming through a
very narrow pipe.

> /sbin/kinit is a feasible way to do it, but it's important to keep the
> flexibility option open.

I agree, flexibility is important.  

My basic point was it sounds like the development process is backwards.
It feels like we are starting big and then going small, instead of the
other way around.  

And if starting big keeps the code from being incorporated into
the kernel, I'm not in favor of it.  I am in favor of any code that
works.

How I have always expected to use this code is to either use
what is provided in the kernel or replace it entirely.

> > So I think we should have a very small very specific /sbin/kinit
> > that does in user space what the kernel does in kernel space right
> > now.  Regardless of klibc the default /sbin/kinit should be gpl'd
> > because we are moving code from code from the kernel into it, and we
> > shouldn't need to double check the licenses to move code from the
> > kernel into it.
> 
> Agreed (although it's harder than you think to move code from the kernel into it
> 
> -- frequently it has been easier to just write code from scratch; it's cleaner
> that way, too.)

I am not surprised.  In kernel and out of the kernel the APIs are noticeably
different.  

There are some things like table parsers that I expect would remain unchanged
moving from kernel to user space.  Using the information would be quite
different but the same data structures could be used to represent it.

The important thing is when people have an itch to move code they can glance
at it and not have to worry about the license.  If something looks hard
at first glance it might not happen.  If it looks easy it more likely to happen
even if it is hard :)
 
> The reason I wanted to use BSD/MIT license only really applies to the library.

Quite reasonable, and I have no problem with BSD/MIT for just the
library as long as it has a  GPL compatible license.

Eric

