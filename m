Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbRCMDVi>; Mon, 12 Mar 2001 22:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130824AbRCMDV2>; Mon, 12 Mar 2001 22:21:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11149 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130791AbRCMDVO>;
	Mon, 12 Mar 2001 22:21:14 -0500
Date: Mon, 12 Mar 2001 22:20:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Nathan Paul Simons <npsimons@fsmlabs.com>
cc: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <20010312195647.A32437@fsmlabs.com>
Message-ID: <Pine.GSO.4.21.0103122202270.28460-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Mar 2001, Nathan Paul Simons wrote:

> On Mon, Mar 12, 2001 at 09:21:37PM +0000, Guennadi Liakhovetski wrote:
> > CPU utilisation. Each new application has to calculate it (ps, top, qps,
> > kps, various sysmons, procmons, etc.). Wouldn't it be worth it having a
> > syscall for that? Wouldn't it be more optimal?

The first rule of optimization: don't. I.e. optimizing something that
is not a bottleneck is pointless.


> 	No, it wouldn't be worth it because you're talking about 
> sacrificing simplicity and kernel speed in favor of functionality.

Or, in that case, in favour of nothing. It doesn't add any functionality.

> This has been know to lead to "bloat-ware".  Every new syscall you
> add takes just a little bit more time and space in the kernel, and
> when only a small number of programs will be using it, it's really 
> not worth it.  This time and space may not be large, but once you
> get _your_ syscall added, why can't everyone else get theirs added 
> as well?  And so, after making about a thousand specialized syscalls
> standard in the kernel, you end up with IRIX (from what I've heard).

	In that case there is much simpler argument.

If your program checks the system load so often that converting results
from ASCII to integers takes noticable time - all you are measuring
is the load created by that program. In other words, any program that
would get any speedup from such syscall is absolutely worthless, since
the load created by measurement will drown the load you are trying
to measure.

	End of story. It's not only unnecessary and tasteless, it's
useless. 
								Cheers,
									Al

