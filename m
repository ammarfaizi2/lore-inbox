Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272369AbRI3DDj>; Sat, 29 Sep 2001 23:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272404AbRI3DDa>; Sat, 29 Sep 2001 23:03:30 -0400
Received: from wisdn-0.gus.net ([208.146.196.17]:20754 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S272369AbRI3DDO>; Sat, 29 Sep 2001 23:03:14 -0400
Date: Sat, 29 Sep 2001 20:03:34 -0700 (PDT)
From: Jim Treadway <jim@stardot-tech.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Makefile gcc -o /dev/null: the dissapearing of /dev/null
In-Reply-To: <20010929202148.D26521@lug-owl.de>
Message-ID: <Pine.LNX.4.33.0109291952080.19966-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001, Jan-Benedict Glaw wrote:

> On Sat, 2001-09-29 06:10:52 -0700, Jim Treadway <jim@stardot-tech.com>
> wrote in message <Pine.LNX.4.33.0109290535390.25966-100000@cerberus.stardot-tech.com>:
> >
> > So then you can no longer 'make modules && make modules_install', or you
> > have to cp or chown /usr/src/linux on a fresh install to compile your
> > kernel?   Doesn't sound pleasant to me.
>
> You may do it this way:
>
> make dep clean bzImage modules && su -c "make modules_install"
>
> This is so far the minimal version for building as non-root user.

Except...

a) It doesn't work (yeah, I'm sure there are many, many, many other
work-arounds, but I can't believe I'm the only one compiling as root):

$ cd /usr/src/linux
$ make dep clean bzImage modules && su -c "make modules_install"
make[1]: Entering directory `/usr/src/linux/arch/i386/boot'
make[1]: Nothing to be done for `dep'.
make[1]: Leaving directory `/usr/src/linux/arch/i386/boot'
scripts/mkdep init/*.c > .depend
/bin/sh: .depend: Permission denied
make: *** [dep-files] Error 1

b) You are still evaluting most, if not all, of the lines in the Makefiles
that do "gcc -o /dev/null", as root.

> > I think the "trick" is to redirect stdout and stderr to /dev/null as well,
> > so that /dev/null doesn't get removed from the file system since it is
> > held open by the shell.
> >
> > Something like:
> >
> > 	gcc -o /dev/null -xc /dev/null /dev/null 2>&1
>
> No-go. It's perfectly okay to remove an opened file. Test it yourself.
> You may even replace a running (!) executable...

Which is exactly why I suggested keeping it open via I/O redirection
(except see below).

> > Perhaps someone just forgot the I/O redirection in one of the tests?
>
> No. It would be of no effect:-)

You are right here though...the I/O redirection doesn't have anything to
do with it, assuming you pass the -S flag to gcc, which I neglected, and
insert the missing '>' in my example above (oops).

But... this seems to be moot since in my case however /dev/null stays
around even when compiling as root. ;)


