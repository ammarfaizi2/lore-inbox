Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTAQD0Z>; Thu, 16 Jan 2003 22:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbTAQD0Z>; Thu, 16 Jan 2003 22:26:25 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:49554 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S267135AbTAQD0Y>; Thu, 16 Jan 2003 22:26:24 -0500
Message-ID: <3E2779F9.2A6264A1@attbi.com>
Date: Thu, 16 Jan 2003 22:35:21 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net, jim.houston@ccur.com
Subject: Re: [PATCH] improved boot time TSC synchronization
References: <200301161644.h0GGitX02052@linux.local> <20030116213332.GA14040@bjl1.asuk.net> <3E274FB1.EF85F6E0@attbi.com> <20030117010045.GA14664@bjl1.asuk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Is it reasonable to repeat the test over a duration of 10^6 cycles (or
> more) such that you could detect any drift after synchronisation, as
> well as variation _during_ that time interval?
> 
> I'm thinking of those spread spectrum clocks, which I gather are done
> by frequency modulating the clock.  It may be possible to detect:
> 
>         (a) whether multiple CPUs with spread spectrum clocks are
>             actually locked to each other, or if the modulation
>             of each is independent
> 
>         (b) whether multiple CPUs are drifting w.r.t. each other
>             because of independent clock sources
> 
> Although drift tends to be small, it should be possible to determine
> "these clocks drifted by <1ppm during the test interval", which is a
> pretty good indication of whether it is safe to use the TSC for
> gettimeofday() or not.
> 
> -- Jamie

Hi Jamie,

These are problems I haven't run into yet. All of the systems
I have stay nicely locked once they are in sync. It might be fun
to try this experiment if someone who has a system with this 
problem volunteered to test.

For systems where the cpu frequency may vary I like the idea of
still using the TSC but doing a software phase locked loop to 
synchronize it to another timer.  I believe that Linus suggested 
this as well.  At least he suggested an NTP like approach.
The code necessary to do this could detect properly synchronized
TSCs and avoid most of the work.

Jim Houston - Concurrent Computer Corp.
