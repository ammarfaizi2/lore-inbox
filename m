Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbUC2WJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUC2WJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:09:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39810 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263153AbUC2WJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:09:51 -0500
Date: Mon, 29 Mar 2004 17:10:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Lev Lvovsky <lists1@sonous.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
In-Reply-To: <BB3FCEF5-81CB-11D8-A0A8-000A959DCC8C@sonous.com>
Message-ID: <Pine.LNX.4.53.0403291659400.3272@chaos>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
 <Pine.LNX.4.53.0403291602340.2893@chaos> <1CD69E8E-81C9-11D8-A0A8-000A959DCC8C@sonous.com>
 <Pine.LNX.4.53.0403291644200.3114@chaos> <BB3FCEF5-81CB-11D8-A0A8-000A959DCC8C@sonous.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Lev Lvovsky wrote:

>
> On Mar 29, 2004, at 1:50 PM, Richard B. Johnson wrote:
>
> > On Mon, 29 Mar 2004, Lev Lvovsky wrote:
> >> I might be a bit confused here, but the problem with that, is that I'm
> >> effectively working backwards.  I've reverted the kernel version, but
> >> all other applications have been kept of course - this means that
> >> though I can keep those sym-links pointing to the correct kernel
> >> headers (those which were present when glibc was compiled), the
> >> current
> >> kernel (the reverted one) will obviously have different include files.
> >>
> >> In order to compile the modules for the afformentioned hardware, those
> >> symlinks need to point to the 2.2.x kernel directories - will this
> >> break functionality of future compiled applications etc?
> >>
> >
> > No No. Never! The modules never, ever, use glibc headers. Never!
> >
> > The compilation should set the -I (include) parameter to point
> > to the kernel headers.
> >
> > Something like:
> >
> > VER	:= $(shell uname -r)
> > INC= -I. -I/usr/src/linux-$(VER)
> > DEF= -D__KERNEL__ -DMODULE
> >
> > gcc -c -Wall -O2 -fomit-frame-pointer $(INC) $(DEF) -m module.o
> > module.c
>
> sorry, that was my mistake in wording - the modules point to the kernel
> headers.  However, the system as it was first made, had those
> directories symlinked to the 2.4.7 (?) kernel - I had to remove that
> package, and symlink the "asm", and "linux" directories to the 2.2.26
> kernel directories of the same name - I'm assuming this is the correct
> thing to do? (it did work ;)
>

You didn't care to read what I said? I said to remove those sym-links.
They must be replaced by headers that were in-use around the time
the C library code was compiled, preferably the exact same headers.

There must not be any sym-link in the /usr/include/... directories
pointing to any kernel headers. That way, you can add new kernels
without ever screwing up your compiler.

When you compile modules, NO 'C' runtime library components are
used at except, possibly, stddef.h or stdarg.h. These are
automatically searched in the `gcc -print-file-name=include`
directory. You can see what's there by executing:

ls `gcc -print-file-name=include`. You can guarantee that
only the files you want are searched by using -nostdinc on
the gcc command line. Of course if you do this, stddef.h
won't be found, if needed so you would need to add the
that directory back to the search-list.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


