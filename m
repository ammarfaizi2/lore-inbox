Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276492AbRI2NKx>; Sat, 29 Sep 2001 09:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276493AbRI2NKo>; Sat, 29 Sep 2001 09:10:44 -0400
Received: from wisdn-0.gus.net ([208.146.196.17]:42512 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S276492AbRI2NKa>; Sat, 29 Sep 2001 09:10:30 -0400
Date: Sat, 29 Sep 2001 06:10:52 -0700 (PDT)
From: Jim Treadway <jim@stardot-tech.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Makefile gcc -o /dev/null: the dissapearing of /dev/null
In-Reply-To: <20010929114304.A21440@lug-owl.de>
Message-ID: <Pine.LNX.4.33.0109290535390.25966-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001, Jan-Benedict Glaw wrote:

> On Sat, 2001-09-29 09:55:35 +0200, proton <proton@energymech.net>
> wrote in message <3BB57E77.4CDFF5D0@energymech.net>:
>
> > Ofcourse, you cant unlink /dev/null unless you are root.
>
> That's right and fine so far.
>
> > In any case, the `gcc -o /dev/null' test cases probably
> > need to go away.
>
> No. Why? Well, the Linux kernel compiles just fine while
> being an ordianary user. You don't have to be root to
> compile it. As it's just bad to do usual *work* as root,
> you're the bug.

So then you can no longer 'make modules && make modules_install', or you
have to cp or chown /usr/src/linux on a fresh install to compile your
kernel?   Doesn't sound pleasant to me.

I think the "trick" is to redirect stdout and stderr to /dev/null as well,
so that /dev/null doesn't get removed from the file system since it is
held open by the shell.

Something like:

	gcc -o /dev/null -xc /dev/null /dev/null 2>&1

Perhaps someone just forgot the I/O redirection in one of the tests?

However, I just compiled (but did not install) 2.4.10, as root, and my
/dev/null still exists...

