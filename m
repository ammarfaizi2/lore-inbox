Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269428AbRIDWEw>; Tue, 4 Sep 2001 18:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269421AbRIDWEm>; Tue, 4 Sep 2001 18:04:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31012 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269428AbRIDWEb>; Tue, 4 Sep 2001 18:04:31 -0400
Date: Wed, 5 Sep 2001 00:04:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010905000437.T699@athlon.random>
In-Reply-To: <20010904131349.B29711@cs.cmu.edu> <20010904135427.A30503@cs.cmu.edu> <20010904215449.S699@athlon.random> <20010904200348Z16581-32383+3477@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010904200348Z16581-32383+3477@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Tue, Sep 04, 2001 at 10:10:42PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 10:10:42PM +0200, Daniel Phillips wrote:
> Which reproducible deadlocks did you have in mind, and how do I reproduce
> them?

I meant the various known oom deadlocks. I've one showstopper report
with the blkdev in pagecache patch with in use also a small ramdisk
pagecache backed, the pagecache backed works like ramfs etc.. marks the
page dirty again in writepage, somebody must have broken page_launder or
something else in the memory managment because exactly the same code was
working fine in 2.4.7. Now it probably loops or breaks totally when
somebody marks the page dirty again, but the vm problems are much much
wider, starting from the kswapd loop on gfp dma or gfp normal, the
overkill swapping when there's tons of ram in freeable cache and you are
taking advantage of the cache, lack of defragmentation, lack of
knowledge of the classzone to balance in the memory balancing (this in
turn is why kswapd goes mad),  very imprecise estimation of the freeable
ram, overkill code in the allocator (the limit stuff is senseless), tons
magic numbers that doesn't make any sensible difference, tons of cpu
wasted, performance that decreases at every run of the benchmarks,
etc...

If you believe I'm dreaming just forget about this email, this is my
last email about this until I've finished.

Andrea
