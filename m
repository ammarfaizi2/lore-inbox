Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbTAQAwA>; Thu, 16 Jan 2003 19:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTAQAv7>; Thu, 16 Jan 2003 19:51:59 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:962 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267344AbTAQAv6>;
	Thu, 16 Jan 2003 19:51:58 -0500
Date: Fri, 17 Jan 2003 01:00:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Jim Houston <jim.houston@attbi.com>
Cc: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net, jim.houston@ccur.com
Subject: Re: [PATCH] improved boot time TSC synchronization
Message-ID: <20030117010045.GA14664@bjl1.asuk.net>
References: <200301161644.h0GGitX02052@linux.local> <20030116213332.GA14040@bjl1.asuk.net> <3E274FB1.EF85F6E0@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E274FB1.EF85F6E0@attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> The patch currently prints the round-trip time and the max_delta.
> On a Quad P4 Xeon, I got round-trip times in the 0.7 microsecond
> range which is disappointing. The max_delta was almost always
> zero cycles meaning that the feedback loop thinks that the TSC values
> are perfectly synchronized.

Is it reasonable to repeat the test over a duration of 10^6 cycles (or
more) such that you could detect any drift after synchronisation, as
well as variation _during_ that time interval?

I'm thinking of those spread spectrum clocks, which I gather are done
by frequency modulating the clock.  It may be possible to detect:

	(a) whether multiple CPUs with spread spectrum clocks are
	    actually locked to each other, or if the modulation
	    of each is independent

	(b) whether multiple CPUs are drifting w.r.t. each other
	    because of independent clock sources

Although drift tends to be small, it should be possible to determine
"these clocks drifted by <1ppm during the test interval", which is a
pretty good indication of whether it is safe to use the TSC for
gettimeofday() or not.

-- Jamie

