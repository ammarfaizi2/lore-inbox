Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291774AbSBHTpY>; Fri, 8 Feb 2002 14:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSBHTpP>; Fri, 8 Feb 2002 14:45:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44809 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291774AbSBHTo6>;
	Fri, 8 Feb 2002 14:44:58 -0500
Message-ID: <3C642A90.751BB750@zip.com.au>
Date: Fri, 08 Feb 2002 11:44:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Jens Axboe <axboe@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <200202081932.GAA05943@mangalore.zipworld.com.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> On Fri, Feb 08 2002, Andrew Morton wrote:
> > Here's a patch which addresses the get_request starvation problem.
> 
> [snip]
> 
> > Also, you noted the other day that a LILO run *never* terminated when
> > there was a dbench running.  This is in fact not due to request
> > starvation.  It's due to livelock in invalidate_bdev(), which is called
> > via ioctl(BLKFLSBUF) by LILO.  invalidate_bdev() will never terminate
> > as long as another task is generating locked buffers against the
> > device.
> [snip]
> 
> Could this below related?
> I get system looks through lilo (bzlilo) from time to time with all latest
> kernels + O(1) + -aa + preempt
> 

Depends what you mean by "system locks".  The invalidate_bdev() problem
won't lock the machine.  Its symptoms are merely that the ioctl will
not terminate until the process which is writing to disk stops.

In other words: if you run dbench, then lilo, lilo will not complete
until after dbench terminates.

If you're seeing actual have-to-hit-reset lockups then that'll
be due to something quite different.

-
