Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTLPLYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 06:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTLPLYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 06:24:20 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:18917 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S261492AbTLPLYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 06:24:18 -0500
Date: Tue, 16 Dec 2003 12:23:07 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, wli@holomorphy.com, kernel@kolivas.org,
       chris@cvine.freeserve.co.uk, riel@redhat.com,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031216112307.GA5041@k3.hellgate.ch>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, wli@holomorphy.com,
	kernel@kolivas.org, chris@cvine.freeserve.co.uk, riel@redhat.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com
References: <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031210215235.GC11193@dualathlon.random> <20031210220525.GA28912@k3.hellgate.ch> <20031210224445.GE11193@dualathlon.random> <20031215153122.1d915475.akpm@osdl.org> <20031215233746.GO6730@dualathlon.random> <20031215155427.6faff1d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215155427.6faff1d8.akpm@osdl.org>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 15:54:27 -0800, Andrew Morton wrote:
>  One tends to adjust the test case so that it takes a reasonable amount of
> time.  So the process is:
> 
> Run 1: took five seconds.
> 
>        "hmm, it didn't swap at all.  I'll use some more threads"
> 
> Run 2: takes 4 hours.
> 
>        "man, that sucked.  I'll use a few less threads"
> 
> Run 3: takes ten minutes.
> 
>        "ah, that's nice.  I'll use that many threads from now on".
> 
> [...]
> 
> It could well be that something is simply misbehaving in there and that we
> can pull back significant benefits with some inspired tweaking rather than
> with radical changes.  Certainly some of Roger's measurements indicate that
> this is the case, although I worry that he may have tuned himself onto the
> knee of the curve.

No worries, mate :-). The efax benchmark I run is a replica of the
case that started this thread. "make main.o" for efax with 32 MB. The
kbuild benchmark is very different as far as compile benchmarks go:
"make -j 24" for the Linux kernel with 64 MB -- the time was adjusted
not by using fewer processes but by only building a small part of the
kernel, which does not change the character of the test. As benchmarks,
efax and kbuild seem different enough to warrant the conclusion that
compiling under tight memory conditions is slow on 2.6.

The qsbench benchmarks is clearly a different type from the other two.
Improvements in qsbench coincided several times with losses for efax/kbuild
and vice versa. Exceptions exist like 2.5.65 which brought no change for
efax but big improvements for kbuild and qsbench (which was back on par
with 2.5.0 for two releases). It is at least conceivable, though, that the
damage for one type of benchmark (qsbench) was mitigated at the expense of
others.

One potential problem with the benchmarks is that my test box has
just one bar with 256 MB RAM. The kbuild and efax tests were run with
mem=64M and mem=32M, respectively. If the difference between mem=32M
and a real 32 MB machine is significant for the benchmark, the results
will be less than perfect. I plan to do some testing on a machine with
more than one memory module to get an idea of the impact, provided I
can dig up some usable hardware.

Roger
