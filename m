Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269731AbRHDBBw>; Fri, 3 Aug 2001 21:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269735AbRHDBBm>; Fri, 3 Aug 2001 21:01:42 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:50192 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269733AbRHDBB1>; Fri, 3 Aug 2001 21:01:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Mike Black <mblack@csihq.com>
Subject: Re: Ongoing 2.4 VM suckage
Date: Sat, 4 Aug 2001 03:06:46 +0200
X-Mailer: KMail [version 1.2]
Cc: David Ford <david@blue-labs.org>, "Jeffrey W. Baker" <jwbaker@acm.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108031907220.11893-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108031907220.11893-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <0108040306470L.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 August 2001 00:08, Rik van Riel wrote:
> On Fri, 3 Aug 2001, Mike Black wrote:
> > Couldn't kswapd just gracefully back-off when it doesn't make any
> > progress? In my case (with ext3/raid5 and a tiobench test) kswapd
> > NEVER actually swaps anything out. It just chews CPU time.
> >
> > So...if kswapd just said "didn't make any progress...*2 last sleep" so
> > it would degrade itself.
>
> It wouldn't just degrade itself.
>
> It would also prevent other programs in the system
> from allocating memory, effectively halting anybody
> wanting to allocate memory.

It actually doesn't, Andrew Morton noticed this and I verified it for
myself.  Shutting down kswapd just degrades throughput, it doesn't stop
the system.  The reason for this is that alloc_pages calls
try_to_free_pages when the free lists run out and follows up by 
reclaiming directly from inactive_clean.

Performance drops without kswapd because the system isn't anticipating
demand any more, but always procrastinating until memory actually runs
out then waiting on writeouts.

--
Daniel
