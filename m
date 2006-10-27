Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWJ0XFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWJ0XFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWJ0XFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:05:05 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:52153 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750975AbWJ0XFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:05:02 -0400
Date: Fri, 27 Oct 2006 16:04:58 -0700
From: thockin@hockin.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061027230458.GA27976@hockin.org>
References: <1161969308.27225.120.camel@mindpipe> <20061027201820.GA8394@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027201820.GA8394@dreamland.darkstar.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 10:18:20PM +0200, Luca Tettamanti wrote:
> Lee Revell <rlrevell@joe-job.com> ha scritto:
> > Someone recently pointed out to me that a Windows "CPU driver update"
> > supplied by AMD fixes the unsynced TSC problem on dual core AMD64
> > systems.
> [...]
> > other incorrect timing effects that these applications may experience on
> > dual-core processor systems, by periodically adjusting the core
> > time-stamp-counters, so that they are synchronized."
> > 
> > What are the chances of Linux getting a similar fix?
> 
> Zero? ;)

Wrong.  We have a fix that has been under serious testing for a long time.

> There's always a window where the TSCs are not in sync (and userspace may
> see a non-monotonic counter); furthermore when C'n'Q is active TSCs
> aren't updated at a fixed frequency, userspace cannot use TSC for timing
> anyway.

Wrong, too.  We have a patch that will be coming SOON (trust me, I am
pushing hard for the author to publish it).  With this patch applied you
should never see the TSC go backwards.  Period.  It should be monotonic
(to userspace, kernel rdtsc calls can still be wrong).  CPUs should stay
very nearly in sync (again, to userspace).  The overhead of this patch is
pretty minimal and costs nothing unless you actually read the TSC.

The catch is that, while it is monotonic, it is not guaranteed to be
perfectly linear.  For many applications, this will be good enough.  Time
will always move forward, and you won't be subject to the weird HZ
granularity gettimeofday that unsynced TSCs can show.

I'm BCCing the author to poke him more publicly.

Tim
