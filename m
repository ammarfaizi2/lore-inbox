Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbTACJZc>; Fri, 3 Jan 2003 04:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbTACJZc>; Fri, 3 Jan 2003 04:25:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:30947 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267473AbTACJZb>;
	Fri, 3 Jan 2003 04:25:31 -0500
Message-ID: <3E155903.F8C22286@digeo.com>
Date: Fri, 03 Jan 2003 01:33:55 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
References: <94F20261551DC141B6B559DC4910867204491F@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2003 09:33:55.0568 (UTC) FILETIME=[3C316F00:01C2B30B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> 
> Here is a comparison of results of 2.5.54 with mm2 and 2.5.54.

I'm sorry, but all you are doing with these tests is discrediting
lmbench, AIM9, tiobench and unixbench.  There really is nothing in
these patches which can account for the changes which you are observing.

Possibly, it is all caused by cache colouring effects - the physical
addresses at which critical kernel and userspace text and data
happen to end up.

I'd suggest that you look for more complex tests.  There's a decent
list at http://lbs.sourceforge.net/, but even those are rather microscopic.

If you have time, things like the osdl dbt1 test, http://osdb.sourceforge.net/
and the commercial benchmarks would be more interesting.

Or cook up some of your own: it's not hard.  Just think of some time-consuming
operation which we perform on a daily basis and measure it.  Script
the startup and shutdown of X11 applications. rsync. sendmail.  cvs.

Mixed workloads are interesting and real world: run tiobench or dbench
or qsbench or whatever while trying to do something else, see how long
"something else" takes.

It is these sorts of things which will find areas of weakness which
can be addressed in this phase of kernel development.

The teeny little microbenchmarks are telling us that the rmap overhead
hurts, that the uninlining of copy_*_user may have been a bad idea, that
the addition of AIO has cost a little and that the complexity which
yielded large improvements in readv(), writev() and SMP throughput were
not free.  All of this is already known.
