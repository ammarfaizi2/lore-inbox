Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbTBJLut>; Mon, 10 Feb 2003 06:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbTBJLut>; Mon, 10 Feb 2003 06:50:49 -0500
Received: from [195.223.140.107] ([195.223.140.107]:15234 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267270AbTBJLus>;
	Mon, 10 Feb 2003 06:50:48 -0500
Date: Mon, 10 Feb 2003 13:00:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210120006.GC31401@dualathlon.random>
References: <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <3E4790F7.2010208@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4790F7.2010208@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 10:45:59PM +1100, Nick Piggin wrote:
> perspective it does nullify the need for readahead (though
> it is obivously still needed for other reasons).

I'm guessing that physically it may be needed from a head prospective
too, I doubt it only has to do with the in-core overhead.  Seeing it all
before reaching the seek point might allow the disk to do smarter things
and to keep the head at the right place for longer, dunno.  Anyways,
whatever is the reason it doesn't make much difference from our point of
view ;), but I don't expect this hardware behaviour changing in future
high end storage.

NOTE: just to be sure, I'm not at all against anticpiatory scheduling,
it's clearly a very good feature to have (still I would like an option
to disable it especially in heavy async environments like databases,
where lots of writes are sync too) but it should be probably be enabled
by default, especially for the metadata reads that have to be
synchronous by design.

Infact I wonder that it may be interesting to also make it optionally
controlled from a fs hint (of course we don't pretend all fs to provide
the hint), so that you stall I/O writes only when you know for sure
you're going to submit another read in a few usec, just the time to
parse the last metadata you read. Still a timeout would be needed for
scheduling against RT etc..., but it could be a much more relaxed
timeout with this option enabled, so it would need less accurate
timings, and it would be less dependent on hardware, and it would
be less prone to generate false positive stalls. The downside is having
to add the hints.

Andrea
