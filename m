Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263162AbRE1VVL>; Mon, 28 May 2001 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbRE1VVC>; Mon, 28 May 2001 17:21:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51206 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263162AbRE1VUp>;
	Mon, 28 May 2001 17:20:45 -0400
Date: Mon, 28 May 2001 23:20:31 +0200
From: Jens Axboe <axboe@kernel.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, 2nd edition
Message-ID: <20010528232031.P9102@suse.de>
In-Reply-To: <20010528175940.M9102@suse.de> <Pine.LNX.4.21.0105281546010.1261-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105281546010.1261-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, May 28, 2001 at 03:48:28PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28 2001, Marcelo Tosatti wrote:
> > Hi,
> > 
> > One minor bug found that would possibly oops if the SCSI pool ran out of
> > memory for the sg table and had to revert to a single segment request.
> > This should never happen, as the pool is sized after number of devices
> > and queue depth -- but it needed fixing anyway.
> > 
> > Other changes:
> > 
> > - Support cpqarray and cciss (two separate patches)
> > 
> > - Cleanup IDE DMA on/off wrt highmem
> > 
> > - Move run_task_queue back again in __wait_on_buffer. Need to look at
> >   why this hurts performance.
> 
> It decrease performance of what in which way ?

Initial dbench testing on a 3.5gb box showed a decrease in performance.
Which did not make sense to me, since there would be no reason to run
tq_disk if the buffer is not locked as is. In fact, I would have
expected this small change to increase performance slightly (which is
why I did it of course), we would be able to build longer queues. I
didn't do any queue monitoring, but I noted that __make_request scan
times were _smaller_ with this change. Which really doesn't make sense
at all :-)

So I'm suspecting a weird mm interaction, I'll drop more info as I find
out. Unfortunately I've been disconnected from above box since this
afternoon, so haven't been able to test since...

-- 
Jens Axboe

