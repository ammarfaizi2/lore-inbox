Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbRHRT1e>; Sat, 18 Aug 2001 15:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266808AbRHRT1Y>; Sat, 18 Aug 2001 15:27:24 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:5380 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S266806AbRHRT1P>;
	Sat, 18 Aug 2001 15:27:15 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108181927.VAA03583@nbd.it.uc3m.es>
Subject: Re: scheduling with io_lock held in 2.4.6
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <3B7C607A.58B9E36@zip.com.au> "from Andrew Morton at Aug 16, 2001
 05:08:26 pm"
To: Andrew Morton <akpm@zip.com.au>
Date: Sat, 18 Aug 2001 21:27:09 +0200 (CEST)
CC: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Andrew Morton wrote:"
> "Peter T. Breuer" wrote:
> > I've been plagued for a month by smp lockups in my block driver
> > that I eventually deduced were due to somebody else scheduling while
> > holding the io_request_lock spinlock.

> >   Aug 17 01:41:00 xilofon kernel: Scheduling with io lock held in process 0
> >   Aug 17 01:41:01 xilofon last message repeated 87 times
> >   Aug 17 01:41:01 xilofon kernel: Scheduling with io lock held in process 1141

> Replace the printk with a BUG(), feed the result into ksymooops.
> Or use show_trace(0).
> 
> But if you're running SMP, scheduling with a lock held
> is quite legal - it'll be held by another CPU.  In that case

Err, yes, I had initially made that mistake, but was fortunately running
on a single cpu machine. I fixed the test to check that the spinlock
was taken on the same cpu as we are now scheduling on and the test still
triggers.

> you'll need to record which CPU holds the lock.

My initial conclusion, based on recording file and line numbers every
time the spinlock is taken, is that end_that_request_last from ll_rw_blk.c
sometimes schedules under the io_request_lock.

I am still investigating, in the hope of pinning it down more exactly. If
anyone recognizes what goes on, please tell me.

Peter
