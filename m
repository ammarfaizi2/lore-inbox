Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280122AbRJaJ3V>; Wed, 31 Oct 2001 04:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280121AbRJaJ3L>; Wed, 31 Oct 2001 04:29:11 -0500
Received: from 87.ppp1-6.hob.worldonline.dk ([212.54.87.215]:46464 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280120AbRJaJ3E>; Wed, 31 Oct 2001 04:29:04 -0500
Date: Wed, 31 Oct 2001 10:29:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
Message-ID: <20011031102911.F5111@suse.de>
In-Reply-To: <Pine.LNX.4.33.0110302349550.31996-100000@penguin.transmeta.com> <3BDFBFF5.9F54B938@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BDFBFF5.9F54B938@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31 2001, Andrew Morton wrote:
> Linus Torvalds wrote:
> > 
> > If you have a pet peeve about the VM, now is the time to speak
> > up.
> >
> 
> I'm peeved by the request queue changes.

I was too. However it didn't seem to make too much of a difference in
real life, I guess your test cases shows a bit differently.

> Appended here is a program which creates 100,000 small files.
> Using ext2 on -pre5.  We see how long it takes to run
> 
> 	(make-many-files ; sync)
> 
> For several values of queue_nr_requests:
> 
> queue_nr_requests:	128	8192	32768
> execution time:		4:43	3:25	3:20
> 
> Almost all of the execution time is in the `sync'.
> 
> This is on a disk with a 2 meg cache which does pretty aggressive
> write-behind.  I expect the difference would be worse with a disk
> which doesn't help so much.
> 
> By restricting the number of requests in flight to 128 we're
> giving new requests only a very small chance of getting merged with
> an existing request.  More seeking.
> 
> OK, not an interesting workload.  But I suspect that there are real
> workloads which will be bitten by this.
> 
> Why is the queue length so tiny now?  Latency?  If so, couldn't this
> be addressed by giving reads higher priority versus writes?

Should be possible. Try for yourself. When you do your 100,000 small
file tes with 8k or more of requests, how is interactive feel of other
programs accessing the same spindle? Play around with the READ and WRITE
intial elevator sequence numbers, repeat :-)

-- 
Jens Axboe

