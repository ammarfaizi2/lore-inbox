Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317388AbSGOPdI>; Mon, 15 Jul 2002 11:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317384AbSGOPdH>; Mon, 15 Jul 2002 11:33:07 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:23817 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317388AbSGOPdF>; Mon, 15 Jul 2002 11:33:05 -0400
Date: Mon, 15 Jul 2002 17:35:53 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Message-ID: <20020715153553.GC22828@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020715075221.GC21470@uncarved.com> <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com> <20020715133507.GF32155@merlin.emma.line.org> <20020715112059.A2316@ti20>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020715112059.A2316@ti20>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Bill Rugolsky Jr. wrote:

> Put dirsync in 2.4? Sure, good idea.  Dangerous without it? To whom?
> 
> Explain how it is dangerous?  The journalling filesystems perform
> directory updates as transactions.  It's dangerous to your MTA
> perhaps.  Andrew Morton has bent over backwards to find and fix bugs in
> the synchronous write logic and to provide what you wanted, i.e.,
> dirsync.  He and Chris Mason fixed performance problems in ext3 and
> Reiserfs.  Reread the thread -- you insisted repeatedly that you just
> wanted dirsync.  Or was that just the opening gambit?

The code is there, for ext3, but not for reiserfs. A year has passed,
but still, dirsync is not the default. This is directed towards the
maintainers of the kernel, not towards Andrew Morton.

> With all due respect to Wieste, that's nonsense: synchronous write
> in syslog or other logging facilities is a *userspace* policy issue.
> Default synchronous directory updates is a *kernel* policy issue.

I'm well aware of this, and that _by_default_ user-space is more
cautious than kernel-space is beyond my horizon, I'm afraid. Of course,
these things are not really related, as syslog and Linux kernel are
separate projects, but still, it looks strange from the outside.

> I don't have dirsync handy at the moment, so I can't test, but
> I have to ask: have you tried the simple (and IMHO devastating) benchmark
> that I posted back on 2001-08-02 comparing Linux to Solaris file creation,
> 
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=99678208121947&w=2
> 
> i.e., copy a file tree (XFree86-4.1, 33027 files) with hard links.

Nope, I prefer not to play disk hogging games on my Solaris boxen, both
of which are in production :-)

> Recall:
> 
> Solaris: 363.46s real    0.84s user   10.13s system
> Ext2:    real    0m3.823s user    0m0.240s sys     0m3.570s
> Ext3:    real    0m5.106s user    0m0.200s sys     0m3.700s
> 
> "dirsync" gives you what you want; please mount /var (or wherever)
> -o dirsync and leave the kernel defaults as they are.

/var and /home, indeed.

So you prefer speed over safety. That's fine. But that's not sane for a
kernel to do. Cheating benchmarks is what others may call it. I just
call it sad.

-- 
Matthias Andree
