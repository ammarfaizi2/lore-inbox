Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287461AbSANPq1>; Mon, 14 Jan 2002 10:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSANPqQ>; Mon, 14 Jan 2002 10:46:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12617 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287461AbSANPqH>; Mon, 14 Jan 2002 10:46:07 -0500
Date: Mon, 14 Jan 2002 16:45:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>, jogi@planetzork.ping.de,
        Ed Sweetman <ed.sweetman@wmich.edu>, yodaiken@fsmlabs.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114164510.C22791@athlon.random>
In-Reply-To: <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au> <20020113184249.A15955@planetzork.spacenet> <1010946178.11848.14.camel@phantasy> <3C41E415.9D3DA253@zip.com.au> <1010952276.12125.59.camel@phantasy> <20020114125619.E10227@athlon.random> <1011015540.4137.1.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1011015540.4137.1.camel@phantasy>; from rml@tech9.net on Mon, Jan 14, 2002 at 08:38:54AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 08:38:54AM -0500, Robert Love wrote:
> On Mon, 2002-01-14 at 06:56, Andrea Arcangeli wrote:
> > On Sun, Jan 13, 2002 at 03:04:35PM -0500, Robert Love wrote:
> > > user system.  But things like (ack!) dbench 16 show a marked
> > > improvement.
> > 
> > please try again on top of -aa, and I've to specify this : benchmarked
> > in a way that can be trusted and compared, so we can make some use of
> > this information.  This mean with -18pre2aa2 alone and only -preempt on
> > top of -18pre2aa2.
> 
> I realize the test isn't directly comparing what we want, so I asked him
> for ll+O(1) benchmark, which he gave.  Another set would be to do
      ^^ actually mini-ll

right (I was still in the middle of the backlog of my emails, so I
didn't know he just produced the mini-ll+O(1)). The mini-ll+O(1) shows
that -preempt is still a bit faster (as expected not much faster
anymore). The reason it is faster it is probably really the sum of few
usec latency of userspace cpu cycles that you save. However given the
small difference in numbers in this patological case (-j1 obviously
cannot take advantage of the few usec less of reduced latency) still
makes me to think it doesn't worth the pain and the complexity, or at
least somebody should also proof that it doesn't visibly drop
performance in a 100% cpu bound _system_ (not user) time load (ala
pagecache_lock collision testcase with sendfile etc..), in general with
a single thread in the system.

Andrea
