Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSKKPhM>; Mon, 11 Nov 2002 10:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265706AbSKKPhM>; Mon, 11 Nov 2002 10:37:12 -0500
Received: from [195.223.140.107] ([195.223.140.107]:41093 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265705AbSKKPhK>;
	Mon, 11 Nov 2002 10:37:10 -0500
Date: Mon, 11 Nov 2002 16:43:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@digeo.com>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021111154331.GE30193@dualathlon.random>
References: <20021111015445.GB5343@x30.random> <Pine.LNX.4.44L.0211111139450.30221-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211111139450.30221-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 11:45:06AM -0200, Rik van Riel wrote:
> On Mon, 11 Nov 2002, Andrea Arcangeli wrote:
> 
> > [snip bad example by somebody who hasn't read Andrew's patch]
> 
> > Anybody claiming there isn't the potential of a global I/O throughput
> > slowdown would be clueless.
> 
> IO throughput isn't the point.  Due to the fundamental asymmetry

IO throughput is the whole point of the elevator and if you change it
that way, you can decrease it, even if you put at the seventh request
instead of the first, you're making assumption that the reads cannot
keep the I/O pipeline full, this is a realistic assumption for some
workloads, but not all. My example still very much apply, just not at
the head but as the seventh request. I definitely known what is the
design idea behind read-latency unlike what you think, I just didn't
remeber the lowlevel implementation details which are not important in
terms of a pontential slowdown in math theorical terms.

> On the contrary, the decrease of latency will probably bring a
> global throughput increase.  Just program throughput, not raw

I perfectly know this, but you're making assumptions about certain
workloads, I can agree they are realistic workloads on a desktop
machine though, but not all the workloads are like that.

> That must be why it was backed out ;)

it was backed out because the request size must be big and it couldn't
be big with such ""feature"" enabled, as I just said in my previous
email. I just given you the reason it was backed out, not sure what are
you wondering about.

The fact is that read-latency is an hack for getting a special case
faster and that definitely in theory can hurt some workload, there is a
reason read-latency isn't the default, read-latency definitely *can*
increase the seeks, not admitting this and claiming it can only improve
performance is clueless from your part. the implementation detail that
it is adding as the seventh request instead of as the first request
decreases the probability of a slowdown, but it still has the potential
of slowing down something, this is all about math local to the elevator.

And IMHO read-latency kinds of hide the real problem that is we should
limit the queue in bytes or we could delay after I/O completion as
mentioned by Andrew since certain workloads will be still very much
slower than writes even with read-latency. I'll fix soon the real
problem in my tree, I just need to make a number of benchmarks on SCSI
and IDE to kind of measure a good size in bytes for peak contigous I/O
performance before I can implement that.

Andrea
