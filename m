Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTBJHRP>; Mon, 10 Feb 2003 02:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbTBJHRP>; Mon, 10 Feb 2003 02:17:15 -0500
Received: from [195.223.140.107] ([195.223.140.107]:40577 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S263991AbTBJHRO>;
	Mon, 10 Feb 2003 02:17:14 -0500
Date: Mon, 10 Feb 2003 08:26:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <ckolivas@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210072650.GF31401@dualathlon.random>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <3E4718D9.4030805@cyberone.com.au> <Pine.LNX.4.50L.0302100143000.12742-100000@imladris.surriel.com> <3E472E33.9070604@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E472E33.9070604@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:44:35PM +1100, Nick Piggin wrote:
> Rik van Riel wrote:
> 
> >On Mon, 10 Feb 2003, Nick Piggin wrote:
> >
> >>Andrea Arcangeli wrote:
> >>
> >>
> >>>The only way to get the minimal possible latency and maximal fariness is
> >>>my new stochastic fair queueing idea.
> >>>
> >>Sounds nice. I would like to see per process disk distribution.
> >>
> >
> >Sounds like the easiest way to get that fair, indeed.  Manage
> >every disk as a separately scheduled resource...
> >
> I hope this option becomes available one day.
> 
> >
> >
> >>However dependant reads can not merge with each other obviously so
> >>you could end up say submitting 4K reads per process.
> >>
> >
> >Considering that one medium/far disk seek counts for about 400 kB
> >of data read/write, I suspect we'll just want to merge requests or
> >put adjacant requests next to each other into the elevator up to
> >a fairly large size. Probably about 1 MB for a hard disk or a cdrom,
> >but much less for floppies, opticals, etc...
> >
> Yes, but the point is _dependant reads_. This is why Andrea's approach
> alone can't solve dependant read vs write or nondependant read - while
> maintaining a good throughput.

note that for soem workloads the _dependant reads_ can have _dependant
writes_ in between. I know it's not the most common case though, but I
don't love too much to make reads that much special. But again, it makes
perfect sense to have it as a feature, but I wouldn't like it to be only
option, I mean there must always be a way to disable anticipatory
scheduling like there must be a way to disable SFQ (infact for SFQ it
makes sense to leave it disabled by default, it's only a few people that
definitely only cares to have the lowest possible latency for mplayer or
xmms, or for multiuser system doing lots of I/O, but those guys can't
live without it)

Andrea
