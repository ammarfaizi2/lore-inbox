Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261881AbRF0OLF>; Wed, 27 Jun 2001 10:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRF0OKp>; Wed, 27 Jun 2001 10:10:45 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:16628 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S261881AbRF0OKl>;
	Wed, 27 Jun 2001 10:10:41 -0400
Date: Wed, 27 Jun 2001 16:09:23 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: John Stoffel <stoffel@casc.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <15160.65442.682067.38776@gargle.gargle.HOWL>
Message-ID: <Pine.GSO.4.30.0106271550360.29611-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Rik> ... but I fail to see this one. If we get a low cache hit rate,
> Rik> couldn't that just mean we allocated too little memory for the
> Rik> cache ?
> Or that we're doing big sequential reads of file(s) which are larger
> than memory, in which case expanding the cache size buys us nothing,
> and can actually hurt us alot.

I've got an idea about how to handle this situation generally (without
sending 'tips' to kernel via madvice() or anything similar).

Instead of sorting chached pages (i mean blocks of files) by last touch
time, and dropping the oldest page(s) if we're sort on memory, i would
propose this nicer algorithm: (i this is relevant only to the read cache)

Suppose that f1,f2,...fN files cached, their sizes are s1,s2,...sN and
that they were last touched t1,t2,...tN seconds ago. (t1<t2<...<tN)
Now we shouldn't automatically choose pages of fN to drop, instead a
probability (chance) could be assigned to each file, for example:
 fI*sI*tI/SUM where I is one of 1,2,...,N, and SUM is the SUM of fI*sI*tI.

With this, mostly newer files would stay in cache, but older files would
still have a chance.
This could also be tuned, for example to take into account 't' more, the
 fI*sI*tI*tI could be  used... and so on, we have infinite possibilities.


have a nice day,
Balazs Pozsar.

ps: If 'my' idea is the which is already used in the kernel, then tell me
:) and give me some points were to read more before telling stupid things.

> I personally don't feel that the cache should be allowed to grow over
> 50% of the system's memory at all, we've got so much in the cache at
> that point, that we're probably not hitting it all that much.
>
> This is why the discussion on the other cache scanning algorithm
> (2Q+?) was so interesting, since it looked to handle both the LRU
> vs. FIFO tradeoffs very nicely.

-- 


