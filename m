Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269799AbRHDEuQ>; Sat, 4 Aug 2001 00:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269798AbRHDEuG>; Sat, 4 Aug 2001 00:50:06 -0400
Received: from [63.209.4.196] ([63.209.4.196]:41745 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269796AbRHDEtu>; Sat, 4 Aug 2001 00:49:50 -0400
Date: Fri, 3 Aug 2001 21:47:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108040026490.14842-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33.0108032141370.894-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Aug 2001, Ben LaHaise wrote:
>
> Using the number of queued sectors in the io queues is, imo, the right way
> to throttle io.  The high/low water marks give us decent batching as well
> as the delays that we need for throttling writers.  If we remove that,
> we'll need another way to wait for io to complete.

Well, we actually _do_ have that other way already - that should be, after
all, the whole point in the request allocation.

It's when we allocate the request that we know whether we already have too
many requests pending.. And we have the batching there too. Maybe the
current maximum number of requests is just way too big?

[ Quick grep later ]

On my 1GB machine, we apparently allocate 1792 requests for _each_ queue.
Considering that a single request can have hundreds of buffers allocated
to it, that is just _ridiculous_.

How about capping the number of requests to something sane, like 128? Then
the natural request allocation (together with the batching that we already
have) should work just dandy.

Ben, willing to do some quick benchmarks?

			Linus

