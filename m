Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276571AbRI2SVk>; Sat, 29 Sep 2001 14:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276572AbRI2SVa>; Sat, 29 Sep 2001 14:21:30 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:28172 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S276571AbRI2SVX>;
	Sat, 29 Sep 2001 14:21:23 -0400
Date: Sat, 29 Sep 2001 20:21:48 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Makefile gcc -o /dev/null: the dissapearing of /dev/null
Message-ID: <20010929202148.D26521@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010929114304.A21440@lug-owl.de> <Pine.LNX.4.33.0109290535390.25966-100000@cerberus.stardot-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109290535390.25966-100000@cerberus.stardot-tech.com>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-29 06:10:52 -0700, Jim Treadway <jim@stardot-tech.com>
wrote in message <Pine.LNX.4.33.0109290535390.25966-100000@cerberus.stardot-tech.com>:
> On Sat, 29 Sep 2001, Jan-Benedict Glaw wrote:
> 
> > On Sat, 2001-09-29 09:55:35 +0200, proton <proton@energymech.net>
> > wrote in message <3BB57E77.4CDFF5D0@energymech.net>:
> >
> > > Ofcourse, you cant unlink /dev/null unless you are root.
> >
> > That's right and fine so far.
> >
> > > In any case, the `gcc -o /dev/null' test cases probably
> > > need to go away.
> >
> > No. Why? Well, the Linux kernel compiles just fine while
> > being an ordianary user. You don't have to be root to
> > compile it. As it's just bad to do usual *work* as root,
> > you're the bug.
> 
> So then you can no longer 'make modules && make modules_install', or you
> have to cp or chown /usr/src/linux on a fresh install to compile your
> kernel?   Doesn't sound pleasant to me.

You may do it this way:

make dep clean bzImage modules && su -c "make modules_install"

This is so far the minimal version for building as non-root user.

> I think the "trick" is to redirect stdout and stderr to /dev/null as well,
> so that /dev/null doesn't get removed from the file system since it is
> held open by the shell.
> 
> Something like:
> 
> 	gcc -o /dev/null -xc /dev/null /dev/null 2>&1

No-go. It's perfectly okay to remove an opened file. Test it yourself.
You may even replace a running (!) executable...

> Perhaps someone just forgot the I/O redirection in one of the tests?

No. It would be of no effect:-)

> However, I just compiled (but did not install) 2.4.10, as root, and my
> /dev/null still exists...

Fine:-) That's the way to go!

MfG, JBG

-- 
Jan-Benedict Glaw . jbglaw@lug-owl.de . +49-172-7608481
