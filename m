Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSGOPSc>; Mon, 15 Jul 2002 11:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSGOPSb>; Mon, 15 Jul 2002 11:18:31 -0400
Received: from 209-166-240-202.cust.walrus.com.240.166.209.in-addr.arpa ([209.166.240.202]:64151
	"EHLO ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id <S316608AbSGOPSa>; Mon, 15 Jul 2002 11:18:30 -0400
Date: Mon, 15 Jul 2002 11:20:59 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: linux-kernel@vger.kernel.org
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Message-ID: <20020715112059.A2316@ti20>
References: <20020715075221.GC21470@uncarved.com> <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com> <20020715133507.GF32155@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020715133507.GF32155@merlin.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Mon, Jul 15, 2002 at 03:35:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 03:35:07PM +0200, Matthias Andree wrote:
> For the data of users not acquainted with kernel intrinsics, the way
> things are now are most dangerous, and I'd really ask that Andrew
> Morton's dirsync() patches (where still necessary) and tool patches
> (chattr, mount) be deployed NOW and that -o dirsync (call it noasync for
> compatibility) be the default. A safety-speed tradeoff should only
> sacrifice safety at the explicit request and mke2fs should be told to
> generate ext3fs by default NOW.

Put dirsync in 2.4? Sure, good idea.  Dangerous without it? To whom?

Explain how it is dangerous?  The journalling filesystems perform
directory updates as transactions.  It's dangerous to your MTA
perhaps.  Andrew Morton has bent over backwards to find and fix bugs in
the synchronous write logic and to provide what you wanted, i.e.,
dirsync.  He and Chris Mason fixed performance problems in ext3 and
Reiserfs.  Reread the thread -- you insisted repeatedly that you just
wanted dirsync.  Or was that just the opening gambit?

> The argumentation that Linux leaves the choice of when to sync directory
> data to the application is nice, but not more, and having this as tuning
> option is fine, but to quote Wietse Venema "it's interesting to see that
> out of the box, Linux handles logging more securely (sync writes) than
> email (async directory updates)". And right he is.

With all due respect to Wieste, that's nonsense: synchronous write
in syslog or other logging facilities is a *userspace* policy issue.
Default synchronous directory updates is a *kernel* policy issue.

I don't have dirsync handy at the moment, so I can't test, but
I have to ask: have you tried the simple (and IMHO devastating) benchmark
that I posted back on 2001-08-02 comparing Linux to Solaris file creation,

   http://marc.theaimsgroup.com/?l=linux-kernel&m=99678208121947&w=2

i.e., copy a file tree (XFree86-4.1, 33027 files) with hard links.

Recall:

Solaris: 363.46s real    0.84s user   10.13s system
Ext2:    real    0m3.823s user    0m0.240s sys     0m3.570s
Ext3:    real    0m5.106s user    0m0.200s sys     0m3.700s

"dirsync" gives you what you want; please mount /var (or wherever)
-o dirsync and leave the kernel defaults as they are.

Regards,

  Bill Rugolsky
