Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318731AbSHERTs>; Mon, 5 Aug 2002 13:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSHERTs>; Mon, 5 Aug 2002 13:19:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26040 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318731AbSHERTq>; Mon, 5 Aug 2002 13:19:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Mon, 5 Aug 2002 13:21:15 -0400
User-Agent: KMail/1.4.1
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
       <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>, <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com> <200208041530.24661.frankeh@watson.ibm.com> <15694.44775.232380.718847@napali.hpl.hp.com>
In-Reply-To: <15694.44775.232380.718847@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208051321.15368.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 12:59 pm, David Mosberger wrote:
> >>>>> On Sun, 4 Aug 2002 15:30:24 -0400, Hubertus Franke
> >>>>> <frankeh@watson.ibm.com> said:
>
>   Hubertus> Yes, if we (correctly) assume that page coloring only buys
>   Hubertus> you significant benefits for small associative caches
>   Hubertus> (e.g. <4 or <= 8).
>
> This seems to be a popular misconception.  Yes, page-coloring
> obviously plays no role as long as your cache no bigger than
> PAGE_SIZE*ASSOCIATIVITY.  IIRC, Xeon can have up to 1MB of cache and I
> bet that it doesn't have a 1MB/4KB=256-way associative cache.  Thus,
> I'm quite confident that it's possible to observe significant
> page-coloring effects even on a Xeon.
>
> 	--david

The wording was "significant" benefits.
The point is/was that as your associativity goes up, the likelihood of 
full cache occupancy increases, with cache thrashing in each class decreasing.
Would have to dig through the literature to figure out at what point 
the benefits are insignificant (<1 %) wrt page coloring.

I am probably missing something in your argument?
How is the Xeon cache indexed (bits), what's the cache line size ?
My assumptions are as follows. 

Take the bits of an address to be two different bit assignments.

< PG , PGOFS >  with PG=V,X  and PGOFS=<Y,Z>  =>   < <V, X>, Y, Z >
where Z is the cacheline size,   
<X,Y> is used to index the cache (that is not strictly required to be 
contiguous, but apparently many arch do it that way).
Page coloring should guarantee that X remains the same in the virtual and the 
physical address assigned to it.
As your associativity goes up, your number of rows (colors) in the cache comes 
down !!

We can take this offline as to not bother the rest, your call. Just interested 
in flushing out the arguments.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
