Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317405AbSGOJqj>; Mon, 15 Jul 2002 05:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317406AbSGOJqi>; Mon, 15 Jul 2002 05:46:38 -0400
Received: from [195.223.140.120] ([195.223.140.120]:28683 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317405AbSGOJqh>; Mon, 15 Jul 2002 05:46:37 -0400
Date: Mon, 15 Jul 2002 11:49:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lincoln Dale <ltd@cisco.com>
Cc: Andrew Morton <akpm@zip.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, Steve Lord <lord@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 performance in 2.5.25 versus 2.4.19pre8aa2
Message-ID: <20020715094915.GD34@dualathlon.random>
References: <3D2CFF48.9EFF9C59@zip.com.au> <5.1.0.14.2.20020714202539.022c4270@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020715160245.02ad0978@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020715160245.02ad0978@mira-sjcm-3.cisco.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 04:06:21PM +1000, Lincoln Dale wrote:
> At 10:30 PM 14/07/2002 -0700, Andrew Morton wrote:
> >Funny thing about your results is the presence of sched_yield(),
> >especially in the copy-from-pagecache-only load.  That test should
> >peg the CPU at 100% and definitely shouldn't be spending time in
> >default_idle.  So who is calling sched_yield()?  I think it has to be
> >your test app?
> >
> >Be aware that the sched_yield() behaviour in 2.5 has changed a lot
> >wrt 2.4.  It has made StarOffice 5.2 completely unusable on a non-idle
> >system, for a start.  (This is a SO problem and not a kernel problem,
> >but it's a lesson).
> 
> my test app uses pthreads (one thread per disk-worker) and 
> pthread_cond_wait in the master task to wait for all workers to finish.
> i'll switch the app to use clone() and sys_futex instead.

unless you call pthread routines during the workload, pthreads cannot be
the reason for a slowdown.

Also I would suggest Andrew to benchmark 2.4.19rc1aa2 against 2.5
instead of plain rc1 just to be sure to compare apples to apples.
(rc1aa2 should also be faster than pre8aa2)

BTW, Lincol, I still have a pending answer for you, about the mmap
slowdown, that's because of reduced readahead mostly, you can tune it
with page-cluster sysctl, it's not only because of the expensive page
faults that mmap I/O implies. I've some revolutionary idea about
replacing readahead, not that it matters for your workload that is
reading physically contigous though.

Andrea
