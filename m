Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129780AbQKVWLY>; Wed, 22 Nov 2000 17:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129787AbQKVWLO>; Wed, 22 Nov 2000 17:11:14 -0500
Received: from hermes.mixx.net ([212.84.196.2]:57614 "HELO hermes.mixx.net")
        by vger.kernel.org with SMTP id <S129780AbQKVWLB>;
        Wed, 22 Nov 2000 17:11:01 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: user-mode port 0.34-2.4.0-test11
Date: Wed, 22 Nov 2000 22:40:23 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A1C3D47.89392E5F@innominate.de>
In-Reply-To: <200011200646.BAA17412@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 974929258 21260 10.0.0.90 (22 Nov 2000 21:40:58 GMT)
X-Complaints-To: news@innominate.de
To: Jeff Dike <jdike@karaya.com>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> 
> The user-mode port of 2.4.0-test11 is available.
> 
> UML is now able to run as a daemon, i.e. with no stdin/stdout/stderr.
> 
> The hostfs filesystem now works as a readonly filesystem.  It's now
> configurable.  I'm using it as a module.  It ought to work compiled into the
> kernel, but I haven't checked this.
> 
> I fixed a number of bugs.
> 
> NOTE:  If you compile from source, you must put 'ARCH=um' on the make command
> line or in the environment, like:
>         make linux ARCH=um
> or
>         ARCH=um make linux
> or
>         export ARCH=um
>         make linux
> 
> This is because I've changed the top-level Makefile to build either a native
> kernel or a usermode kernel, with the default being native.  This is in
> preparation for submitting this port to the main pool.  The ARCH calculation
> is now this:
> 
> # SUBARCH tells the usermode build what the underlying arch is.  That is set
> # first, and if a usermode build is happening, the "ARCH=um" on the command
> # line overrides the setting of ARCH below.  If a native build is happening,
> # then ARCH is assigned, getting whatever value it gets normally, and
> # SUBARCH is subsequently ignored.
> 
> SUBARCH:= $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e
> s/arm.*/arm/ -e s/sa110/arm/)
> ARCH:= $(SUBARCH)
> 
> If anyone has any objections to this going in the main pool, let me know, and
> also let me know what you would suggest as a fix.

As you know, I'm making heavy use of uml for mm, vfs and fs development,
and I can't say enough good things about it.  With uml I have a
development cycle that looks roughly like this:

  20 secs make+gcc+ln
  10 secs boot new user mode linux
  6 secs fsck (if crashed before) :-)
  *tests go here*
  10 secs shutdown

And there are still a lot of ways to tighten that up.  The stability has
been impressive - so far, no crashes at all that weren't supposed to be
crashes, at least in the work I'm doing.

I think this is ready...

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
