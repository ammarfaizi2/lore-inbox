Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSKYG7H>; Mon, 25 Nov 2002 01:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSKYG7H>; Mon, 25 Nov 2002 01:59:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:51362 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262500AbSKYG7F>;
	Mon, 25 Nov 2002 01:59:05 -0500
Message-ID: <3DE1CBE5.C6576272@digeo.com>
Date: Sun, 24 Nov 2002 23:06:13 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: Andrea Arcangeli <andrea@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.4.20-rc2-aa1 with contest
References: <200211230929.31413.conman@kolivas.net> <20021124162845.GC12212@dualathlon.random> <200211251744.35509.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2002 07:06:13.0394 (UTC) FILETIME=[23D0BF20:01C29451]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> >On Sat, Nov 23, 2002 at 09:29:22AM +1100, Con Kolivas wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >> process_load:
> >> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >> 2.4.18 [3]              109.5   57      119     44      1.50
> >> 2.4.19 [3]              106.5   59      112     43      1.45
> >> 2.4.20-rc1 [3]          110.7   58      119     43      1.51
> >> 2.4.20-rc1aa1 [3]       110.5   58      117     43      1.51*
> >> 2420rc2aa1 [1]          212.5   31      412     69      2.90*
> >>
> >> This load just copies data between 4 processes repeatedly. Seems to take
> >> longer.
> >
> >you go into linux/include/blkdev.h and increase MAX_QUEUE_SECTORS to (2
> ><< (20 - 9)) and see if it makes any differences here? if it doesn't
> >make differences it could be the a bit increased readhaead but I doubt
> >it's the latter.
> 
> No significant difference:
> 2420rc2aa1              212.53  31%     412     69%
> 2420rc2aa1mqs2          227.72  29%     455     71%

process_load is a CPU scheduler thing, not a disk scheduler thing.  Something
must have changed in kernel/sched.c.

It's debatable whether 210 seconds is worse than 110 seconds in
this test, really.  You have four processes madly piping stuff around and
four to eight processes compiling stuff.  I don't see why it's "worse"
that the compile happens to get 31% of the CPU time in this kernel.  One
would need to decide how much CPU it _should_ get before making that decision.

> ...
> 
> The machine stops responding but sysrq works. It wont write anything to the
> logs. To get the error I have to run the mem_load portion of contest, not
> just mem_load by itself. The purpose of mem_load is to be just that - a
> memory load during the contest benchmark and contest will kill it when it
> finishes testing in that load. To reproduce it yourself, run mem_load then do
> a kernel compile make -j(4xnum_cpus).  If that doesnt do it I'm not sure how
> else you can see it. sys-rq-T shows too much stuff on screen for me to make
> any sense of it and scrolls away without me being able to scroll up.

Try sysrq-p.
