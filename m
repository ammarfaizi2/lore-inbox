Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTKFT5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTKFT5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:57:41 -0500
Received: from gaia.cela.pl ([213.134.162.11]:16650 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263702AbTKFT5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:57:34 -0500
Date: Thu, 6 Nov 2003 20:57:17 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
In-Reply-To: <20031106190703.GA2654@localhost>
Message-ID: <Pine.LNX.4.44.0311062051270.21501-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday, 06 November 2003, at 17:15:33 +0800,
> Wee Teck Neo wrote:
> 
> >   procs                      memory      swap          io     system      
> > cpu
> > r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
> > 1  0  0  92744   9640  20240 801644    0    0     3    10   17     0 25  2 10
> > 
> > The system is having 1GB ram and currently using 92MB as swap. Why does the 
> > system use the slower swap when there are still memory available (as 
> > cache). Anyway to "force" the system to use more ram instead of putting 
> > into swap memory?

Why would you want to?  The kernel has determined that 92MB of the stuff 
in memory is less important than the disk cache.  For example a program 
requires 100 MB data for boot and then spends the next week using the last 
5 MB.  Do you expect all 100 MB to stay resident in memory for ever 
(while the program is running)?  Of course not, it'll get swapped out once 
it is determined to be less used than the disk cache and only that last 5 
MB which is actually doing something will remain in RAM, with the rest 
quietly sitting in swap.  Swap is slower than RAM, sure, but using RAM for 
storing your dirty laundry from two weeks ago is pointless - and that's 
why it's swapped out - the disk cache will likely accelerate stuff more 
than keeping the odds and ends in memory.

Now, if you have lots of cache and the system is swapping like crazy - 
then something is wrong, but only then.

> The obvious solution is to disable swap memory completely if those 
> 90 MiB worth of idle and unused memory pages on disk bother you.
> 
> If this "vmstat" output shows your box usual load, with 80% of RAM used
> in caches, I think you will never really need swap at all.

I wouldn't agree with that - It'll still swap via R/O text executable 
pages, so you'll still have swap, just invisible.

Cheers,
MaZe.


