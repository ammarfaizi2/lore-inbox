Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273897AbRIRUS7>; Tue, 18 Sep 2001 16:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273896AbRIRUSu>; Tue, 18 Sep 2001 16:18:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23328 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273895AbRIRUSg>; Tue, 18 Sep 2001 16:18:36 -0400
Date: Tue, 18 Sep 2001 22:18:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, jogi@planetzork.ping.de,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
Message-ID: <20010918221854.C720@athlon.random>
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172500.F19092@athlon.random> <20010918173515.B6698@planetzork.spacenet> <20010918174434.I19092@athlon.random> <20010918175104.D6698@planetzork.spacenet> <20010918212856.50cd5b87.skraw@ithnet.com>, <20010918212856.50cd5b87.skraw@ithnet.com>; <20010918214152.A720@athlon.random> <3BA7A853.4EC44195@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA7A853.4EC44195@zip.com.au>; from akpm@zip.com.au on Tue, Sep 18, 2001 at 01:02:27PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 01:02:27PM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > I now have an update ready for Linus to merge that should fix the few
> > leftovers I had in the very first release of the vm rewrite but of
> > course I will be interested to hear about any regression/progression
> > about those changes, I'll post them in a few minutes in CC to l-k.
> > 
> 
> Please include Andi's likely()/unlikely() change - it's nice.

I guess I'll postpone the likely/unlikely after resynching with Linus
since I'm basically ready to run rsync and I prefer to go sleep early
today and to think about new things tomorrow ;).

I also have a few arguments about the likely/unlikely to solve before
agreeing on it, in particular in all my usages the value will be either
0 or 1 so I don't see why should I tell gcc to do !!, probably it will
be optimized away but I also don't see why should the left term matter
for an "if", the "if" only cares about zero or non zero, so I should be
able to define the fast path with an 1 even if my result is 2, otherwise
it sounds like gcc is doing something strange.

> I can't measure any obviously new causes of latency in your
> VM.  It's nice that you've paid attention to this in various
> places.

thanks.

> The main culprits now are the file IO and dirty buffer writeout paths:
> up to fifty milliseconds in each.
> 
> I suggest you stick scheduling points in generic_file_read(),
> generic_file_write() and write_locked_buffers() and then dispose
> of the copy-user-latency patch from -aa kernels.

Yes, I pretty much agree on such change, I remeber you just pointed out
once. It's postponed to tomorrow too ;).

At the moment I just care to post the vm fixes against pre11 plain in
order to possibly get some feedback on it while I sleep :)

> With the above fixed, the main source of latency is
> /proc/meminfo->si_swapinfo(). It's about five milliseconds per gig
> of swap, which isn't too bad.  But it's directly invokable by
> userspace (ie: /usr/bin/top) and really should be made less dumb.

ok.

Andrea
