Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWJRNET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWJRNET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWJRNET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:04:19 -0400
Received: from brick.kernel.dk ([62.242.22.158]:10025 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030265AbWJRNES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:04:18 -0400
Date: Wed, 18 Oct 2006 15:04:57 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018130456.GJ24452@kernel.dk>
References: <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk> <20061018122323.GW23492@unthought.net> <1161175344.9363.30.camel@localhost.localdomain> <20061018124420.GI24452@kernel.dk> <4536245B.8070906@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4536245B.8070906@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2006, Nick Piggin wrote:
> Jens Axboe wrote:
> >On Wed, Oct 18 2006, Alan Cox wrote:
> >
> >>Bandwidth is completely silly in this context, iops/sec is merely
> >>hopeless 8)
> >
> >
> >Both need the disk to play nicely, if you get into error handling or
> >correction, you get screwed. Bandwidth by itself is meaningless, you
> >need latency as well to make sense of it.
> 
> When writing an IO scheduler, I decided `time' was a pretty good
> metric. That's roughly what we use for CPU scheduling as well (but
> use nice levels and adjusted by dynamic priorities instead of a
> straight % share).

Precisely, hence CFQ is now based on the time metric. Given larger
slices, you can mostly eliminate the impact of other applications in the
system.

> So you could say you want your database to consume no more than 50%
> of disk and have your mp3 player get a minimum of 10%. Of course,
> that doesn't say anything about what the time slices are, or what
> latencies you can expect (1s out of every 10, or 100ms out of every
> 1000?).

As I wrote previously, both a percentage and bandwidth  along with
desired latency make sense. For the mp3 player, you probably don't care
how much of the system it uses. You want 256kbit/sec or whatever you
media is, and if you don't get that then things don't work. The other
scenario is limiting eg the database.

> It is still far from perfect, but at least it accounts for seeks vs
> throughput reasonably well, and in a device independent manner.

We can't aim for perfection, as that is simple not doable generically.
So we have to settle for something that makes sense and is enforcible to
some extent. We can limit something to foo percentage of the disk, and
we can try the hardest possible to satisfy the mp3 player as long as we
know what it requires. Right now we don't, so we treat everybody the
same wrt slices and latency.

-- 
Jens Axboe

