Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSBCWey>; Sun, 3 Feb 2002 17:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287833AbSBCWeo>; Sun, 3 Feb 2002 17:34:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3718 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287838AbSBCWeg>;
	Sun, 3 Feb 2002 17:34:36 -0500
Date: Mon, 4 Feb 2002 01:32:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Steffen Persvold <sp@scali.com>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
In-Reply-To: <3C5DB965.643661F2@scali.com>
Message-ID: <Pine.LNX.4.33.0202040130200.19055-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Feb 2002, Steffen Persvold wrote:

> Ok, the reason I'm asking is that I receive a request from a remote
> machine on interrupt level (tasklet) and want to submit this to the
> local device. The reason I'm using a tasklet instead of a kernel
> thread is that somewhere between RedHat's 2.4.3-12 and 2.4.9-12
> kernels the latency of waking up a kernel thread increased (using a
> semaphore method similar to the one used in loop.c). I don't know why
> this happened, but I guess that if I still could use a kernel thread
> there wouldn't be any problems using generic_make_request().

you really want a kernel thread for this. The wakeup latency of a kernel
thread is on the order of 2-3 usecs (context switch overhead included),
nothing compared to usual block IO costs.

you say that the latency of waking up a kernel thread has increased - by
how much?

	Ingo

