Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRCMJwv>; Tue, 13 Mar 2001 04:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbRCMJwl>; Tue, 13 Mar 2001 04:52:41 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:21122 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S130531AbRCMJw1>; Tue, 13 Mar 2001 04:52:27 -0500
Date: Tue, 13 Mar 2001 09:55:33 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Nathan Paul Simons <npsimons@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <Pine.GSO.4.21.0103122202270.28460-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0103130945460.507-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander, Nathan and all!

Thanks for your great answers! First of all - I was not REALLY proposing
to include this system call in the kernel - I just wanted to hear some pro
and contra - so, thanks again for your explanations! I started yesterday
sketching the required functions, will have to retreat to reading top & ps
sources, btw, apart from these 2 obvious sources, what else would you
suggest to look through for a good implementation of CPU-utilization
calculator as well as other process (multithreaded, SMP,...) statistics?
Portable (POSIX), maybe some documentation, not just sources?

Thanks
Guennadi

On Mon, 12 Mar 2001, Alexander Viro wrote:

> On Mon, 12 Mar 2001, Nathan Paul Simons wrote:
> 
> > On Mon, Mar 12, 2001 at 09:21:37PM +0000, Guennadi Liakhovetski wrote:
> > > CPU utilisation. Each new application has to calculate it (ps, top, qps,
> > > kps, various sysmons, procmons, etc.). Wouldn't it be worth it having a
> > > syscall for that? Wouldn't it be more optimal?
> 
> The first rule of optimization: don't. I.e. optimizing something that
> is not a bottleneck is pointless.
> 
> > 	No, it wouldn't be worth it because you're talking about 
> > sacrificing simplicity and kernel speed in favor of functionality.
> 
> Or, in that case, in favour of nothing. It doesn't add any functionality.
> 
> > This has been know to lead to "bloat-ware".  Every new syscall you
> > add takes just a little bit more time and space in the kernel, and
> > when only a small number of programs will be using it, it's really 
> > not worth it.  This time and space may not be large, but once you
> > get _your_ syscall added, why can't everyone else get theirs added 
> > as well?  And so, after making about a thousand specialized syscalls
> > standard in the kernel, you end up with IRIX (from what I've heard).
> 
> 	In that case there is much simpler argument.
> 
> If your program checks the system load so often that converting results
> from ASCII to integers takes noticable time - all you are measuring
> is the load created by that program. In other words, any program that
> would get any speedup from such syscall is absolutely worthless, since
> the load created by measurement will drown the load you are trying
> to measure.
> 
> 	End of story. It's not only unnecessary and tasteless, it's
> useless. 
> 								Cheers,
> 									Al
> 
> 

___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


