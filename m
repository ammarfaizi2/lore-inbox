Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTBJHHh>; Mon, 10 Feb 2003 02:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbTBJHHh>; Mon, 10 Feb 2003 02:07:37 -0500
Received: from [195.223.140.107] ([195.223.140.107]:36737 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S263342AbTBJHHg>;
	Mon, 10 Feb 2003 02:07:36 -0500
Date: Mon, 10 Feb 2003 08:17:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Con Kolivas <ckolivas@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210071715.GD31401@dualathlon.random>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <Pine.LNX.4.50L.0302100127250.12742-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302100127250.12742-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 01:42:28AM -0200, Rik van Riel wrote:
> On Sun, 9 Feb 2003, Andrea Arcangeli wrote:
> 
> > The only way to get the minimal possible latency and maximal fariness is
> > my new stochastic fair queueing idea.
> 
> "The only way" ?   That sounds like a lack of fantasy ;))

you can do more but you'd need to build additional APIs, to allow the
highlevel (possibly userspace too) to give hints to the lowlevel.

This only requires the pid and checking current->mm which is trivial. So
without adding a complex API I think this is the best/only thing you can
do to get close to the minimal possible I/O latency from a process point
of view.

> On the contrary, once we have SFQ to fix the biggest elevator
> problems the difference made by the anticipatory scheduler should
> be much more visible.
> 
> Think of a disk with 6 track buffers for reading and a system with
> 10 active reader processes. Without the anticipatory scheduler you'd
> need to go to the platter for almost every OS read (because each
> process flushes out the track buffer for the others), while with the
> anticipatory scheduler you've got a bigger chance of having the data
> you want in one of the drive's track buffers, meaning that you don't
> need to go to the platter but can just do a silicon to silicon copy.
> 
> If you look at the academic papers of an anticipatory scheduler, you'll
> find that it gives as much as a 73% increase in throughput.
> On real-world tasks, not even on specially contrived benchmarks.
> 
> The only aspect of the anticipatory scheduler that is no longer needed
> with your SFQ idea is the distinction between reads and writes, since
> your idea already makes the (better, I guess) distinction between
> synchronous and asynchronous requests.

I'm not saying anticipatory scheduling is going to be obsoleted by SFQ,
especially because SFQ has to be an option to use only when absolutely
your only care to get the lowest possible I/O latency from a per-process
point of view (like while playing an mpeg or mp3).

But I still definitely think that if you run an anticipatory scheduling
benchmark w/ and w/o SFQ, the effect w/o SFQ (i.e. right now) is going
to be much more visible than w/ SFQ enabled. The reason is the size of
the queue that w/o SFQ can be as large as several seconds in time and
several dozen mbytes in bytes.

Andrea
