Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSGOQLo>; Mon, 15 Jul 2002 12:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317518AbSGOQLo>; Mon, 15 Jul 2002 12:11:44 -0400
Received: from 209-166-240-202.cust.walrus.com.240.166.209.in-addr.arpa ([209.166.240.202]:16027
	"EHLO ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id <S317517AbSGOQLl>; Mon, 15 Jul 2002 12:11:41 -0400
Date: Mon, 15 Jul 2002 12:14:24 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: linux-kernel@vger.kernel.org
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Message-ID: <20020715121424.B2316@ti20>
References: <20020715075221.GC21470@uncarved.com> <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com> <20020715133507.GF32155@merlin.emma.line.org> <20020715112059.A2316@ti20> <20020715153553.GC22828@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020715153553.GC22828@merlin.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Mon, Jul 15, 2002 at 05:35:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 05:35:53PM +0200, Matthias Andree wrote:
> The code is there, for ext3, but not for reiserfs. A year has passed,
> but still, dirsync is not the default. This is directed towards the
> maintainers of the kernel, not towards Andrew Morton.
 
I'm in violent agreement that it should go into 2.4 *now that it is merged
in 2.5*.  You may have noticed that Marcelo has been occupied with a few
other issues (VM, IDE).

> > I don't have dirsync handy at the moment, so I can't test, but
> > I have to ask: have you tried the simple (and IMHO devastating) benchmark
> > that I posted back on 2001-08-02 comparing Linux to Solaris file creation,
> > 
> >    http://marc.theaimsgroup.com/?l=linux-kernel&m=99678208121947&w=2
> > 
> > i.e., copy a file tree (XFree86-4.1, 33027 files) with hard links.
> 
> Nope, I prefer not to play disk hogging games on my Solaris boxen, both
> of which are in production :-)
 
I'm not asking you to do it on your Solaris boxen -- I couldn't give a
damn about slow, buggy Solaris I'm asking whether you have tested this
on ext2/ext3 with/without dirsync.  The gentlemanly thing to do when asking
for a change to the kernel is to (honestly) assess its impact.

> So you prefer speed over safety. That's fine. But that's not sane for a
> kernel to do. Cheating benchmarks is what others may call it. I just
> call it sad.

Cheating benchmarks -- bah!  Safety for *one* (naive) application class!

dirsync buys me no useful safety on my build host, all it will do is
slow down things like rpmbuild --rebuild.

This is all rather silly.  An MTA requires configuration, so what is
the difficulty in using -o dirsync, or alternatively, and quite a bit
more simply, executing chattr +D on the spool directory.  It's quite
simple: put dirsync in the kernel and tools, then add chattr +D to the
post-install scripts for your favorite package manager.

    - Bill Rugolsky
