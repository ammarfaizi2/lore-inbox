Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTLDFY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 00:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTLDFY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 00:24:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:44041 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263007AbTLDFY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 00:24:56 -0500
Date: Thu, 4 Dec 2003 06:21:36 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
Message-ID: <20031204052136.GA16903@alpha.home.local>
References: <20031202002347.GD621@frodo> <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet> <bqlbuj$j03$1@gatekeeper.tmr.com> <200312032117.QAA20238@gatekeeper.tmr.com> <3FCE5EF7.5010201@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCE5EF7.5010201@wmich.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 05:08:55PM -0500, Ed Sweetman wrote:
 
> The windows can freeze for many reasons. You could be running X in a 
> lower priority, painting X terms is heavy on X using that command and it 
> can steal cpu from the terminal who's process is working in retrieving 
> data from the fs. No dma on the hdds, Etc.

sorry I gave no info. disk is SCSI and is *not* sollicited at all because
everything fits in cache. If I was speaking about the scheduler, it's
because it's really a CU scheduling behaviour and not an I/O scheduling
behaviour. I never changed my X priority, and in 2.4, all windows are
fluid because timeslices are evenly distributed.

>  I ran this command using 
> test11 with akpm's test10-mm1 patch applied and 10 were going just fine. 
>  All going at the same time along with mplayer playing a divx movie. No 
> skips in video or audio and all the terminals were updating as rapidly 
> as they could with no pauses of noticable length.

bingo ! you're in the exact case where people try to detect skips in their
players. I suspect that your player and your xterms don't go too fast and
are detected as interactive task by the scheduler. So they don't go very
fast, but they are all fluid. Now if you can feed saturate a CPU by feeding
6000 lines/s to an xterm during 1 minute and can repeat this on 10 xterms,
they won't become interactive at all, and now you'll see that some of them
scroll smoothly while others are stopped. If you put your pointer into them
and strike a key, they often start again.

> The schedular is nothing short of incredibly better than 2.4.x and 
> prior.

I also think it's better for many workloads. I only say that we can easily
identify *some* workloads for which it simply fails to be fair, and although
these workload are not more representative than xmms while compiling a kernel,
they might match other applications' behaviour. For instance, I don't know
if a system which runs all the day at 100% CPU compressing logs asynchronously
won't suffer from this.

> Despite the xmms croud's loud cries of trying to get the kernel 
> to fix their player's performance which seems to always suffer more than 
> any other player i've tried.

I totally agree. I've used mpg123 from my old P166+ years ago, to my dual
xp1800 and on my notebooks, I've also tried madplay, and I've yet to hear
what a skip sounds like.

> having to manually adjust the schedular is seen by many as a fault in 
> the design of the schedular.  The perfect schedular would be able to 
> adjust itself automatically on it's own.

I don't agree here. No system knows better than the admin what he's doing.
If this was the case, the 'nice' command would never have been invented.

> if it's likely impossible to achieve it, it makes sense to strive to get 
> as close to it as possible rather than create a set of separate 
> schedulars which the root user (which really shouldn't be doing anything 
> on the system all the time anyway) has to select whenever their workload 
> changes from one goal to another.

The root you're talking about is also the same person who installs a server
for a dedicated task and sometimes the same person who discovered a profund
scheduling problem on the same system two racks away. As long as your systems
don't share their experiences, it's up to the humans to tell them.

Willy

