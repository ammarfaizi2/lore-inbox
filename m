Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbSITHka>; Fri, 20 Sep 2002 03:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSITHka>; Fri, 20 Sep 2002 03:40:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31122 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261289AbSITHk3>;
	Fri, 20 Sep 2002 03:40:29 -0400
Date: Fri, 20 Sep 2002 09:52:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 100,000 threads? [was: [ANNOUNCE] Native POSIX Thread Library
 0.1]
In-Reply-To: <Pine.LNX.4.44L.0209192258010.1857-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0209200942030.27825-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Sep 2002, Rik van Riel wrote:

> So, where did you put those 800 MB of kernel stacks needed for 100,000
> threads ?

With the default split and kernel stack we can start up 94,000 threads on
x86. With Ben's/Dave's patch we can have up to 188,000 threads. With a 2:2
GB VM split configured we can start 376,000 threads. If someone's that
desperate then with a 1:3 split we can start up 564,000 threads.

Anton tested 1 million concurrent threads on one of his bigger PowerPC
boxes, which started up in around 30 seconds. I think he saw a load
average of around 200 thousand. [ie. the runqueue was probably a few
hundred thousand entries long at times.]

> If you used the standard 3:1 user/kernel split you'd be using all of
> ZONE_NORMAL for kernel stacks, but if you use a 2:2 split you'll end up
> with a lot less user space (bad if you want to have many threads in the
> same address space).

the extreme high-end of threading typically uses very controlled
applications and very small user level stacks.

as to the question of why so many threads, the answer is because we can :)
This, besides demonstrating some of the recent scalability advances, gives
us the warm fuzzy feeling that things are right in this area. I mean,
there are architectures where Linux could map a petabyte of RAM just fine,
even though that might not be something we desperately need today.

	Ingo

