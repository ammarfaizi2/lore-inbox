Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270002AbRHEUYg>; Sun, 5 Aug 2001 16:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270005AbRHEUYZ>; Sun, 5 Aug 2001 16:24:25 -0400
Received: from [63.209.4.196] ([63.209.4.196]:12299 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270002AbRHEUYO>; Sun, 5 Aug 2001 16:24:14 -0400
Date: Sun, 5 Aug 2001 13:20:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Mike Black <mblack@csihq.com>, Ben LaHaise <bcrl@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <996985193.982.7.camel@gromit>
Message-ID: <Pine.LNX.4.33.0108051315540.7988-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Aug 2001, Michael Rothwell wrote:
>
> Could there be both interactive and throughput optimizations, and a
> way to choose one or the other at run-time? Or even just at compile
> time?

Quite frankly, that's in my opinion the absolute worst approach.

Yes, it's an approach many systems take - put the tuning load on the user,
and blame the user if something doesn't work well. That way you don't have
to bother with trying to get the code right, or make it make sense.

In general, I think we can get latency to acceptable values, and latency
is the _hard_ thing. We seem to have become a lot better already, by just
removing the artificial ll_rw_blk code.

Getting throughput up to where it should be should "just" be a matter of
making sure we get nicely overlapping IO going. We probably just have some
silly bug tht makes us hickup every once in a while and not keep the
queues full enough. My current suspect is the read-ahead code itself being
a bit too inflexible, but..

			Linus

