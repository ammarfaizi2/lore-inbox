Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSKJKAp>; Sun, 10 Nov 2002 05:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264791AbSKJKAo>; Sun, 10 Nov 2002 05:00:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21699 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264790AbSKJKAn>;
	Sun, 10 Nov 2002 05:00:43 -0500
Date: Sun, 10 Nov 2002 11:06:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: Andrea Arcangeli <andrea@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021110100656.GF31134@suse.de>
References: <200211091300.32127.conman@kolivas.net> <20021110024451.GE2544@x30.random> <200211102058.46883.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211102058.46883.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10 2002, Con Kolivas wrote:
> >> Well this is interesting. 2.4.20-rc1 seems to have improved it's ability
> >> to do IO work. Unfortunately it is now busy starving the scheduler in the
> >> mean time, much like the 2.5 kernels did before the deadline scheduler was
> >> put in.
> >>
> >> read_load:
> >> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >> 2.4.18 [3]              102.3   70      6       3       1.43
> >> 2.4.19 [2]              134.1   54      14      5       1.88
> >> 2.4.19-ck9 [2]          77.4    85      11      9       1.08
> >> 2.4.20-rc1 [3]          173.2   43      20      5       2.43
> >> 2.4.20-rc1aa1 [3]       150.6   51      16      5       2.11
> >
> >What is busy starving the scheduler? This sounds like it's again just an
> >evelator benchmark. I don't buy your scheduler claims, give more
> >explanations or it'll take it as vapourware wording, I very much doubt
> >you can find any single problem in the scheduler rc1aa2 or that the
> >scheduler in rc1aa1 has a chance to run slower than the one of 2.4.19 in
> >a I/O benchmark, ok it still misses the numa algorithm, but that's not a
> >bug, just a missing feature and it'll soon be fixed too and it doesn't
> >matter for normal smp non-numa machines out there.
> 
> Ok I fully retract the statement. I should not pass judgement on what part of 
> the kernel has changed the benchmark results, I'll just describe what the 
> results say. Note however this comment was centred on the results of io_load 
> above. Put simply : if I am writing a large file and then try to compile the 
> kernel (make -j4 bzImage) it is 16 times slower.

In Con's defence, I think he meant io scheduler starvation and not
process scheduler starvation. Otherwise the following wouldn't make a
lot of sense:

"Unfortunately it is now busy starving the scheduler in the mean time,
much like the 2.5 kernels did before the deadline scheduler was put in."

In indeed, 2.5 kernels had the exact same io scheduler algorithm in 2.5
as 2.4.20-rc has, so this makes perfect sense from the io scheduler
starvation POV.

There are inherent problems in the 2.4 io scheduler for these types of
work loads, the ugly and nausea-inducing read-latency hack that akpm did
attempts to work-around that.

Andrea is obviously talking about process scheduler, note the numa
reference among other things.

-- 
Jens Axboe

