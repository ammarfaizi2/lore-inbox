Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319045AbSHMR5j>; Tue, 13 Aug 2002 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319043AbSHMR44>; Tue, 13 Aug 2002 13:56:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11023 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319028AbSHMRz5>;
	Tue, 13 Aug 2002 13:55:57 -0400
Message-ID: <3D594B75.F4AF41F4@zip.com.au>
Date: Tue, 13 Aug 2002 11:09:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [patch 2/21] reduced locking in buffer.c
References: <3D561473.40A53C0D@zip.com.au> <Pine.LNX.4.44.0208131032210.7411-100000@home.transmeta.com> <3D5947B7.EDE01C2E@zip.com.au> <20020813185213.A17449@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Tue, Aug 13, 2002 at 10:53:59AM -0700, Andrew Morton wrote:
> > I have discussed it with David - he said it's OK in 2.5, but
> > not in 2.4, and he has eyeballed the diff.
> >
> > However there's another thing to think about:
> >
> >       local_irq_disable();
> >       atomic_inc();
> >
> > If the architecture implements atomic_inc with spinlocks, this will
> > schedule with interrupts off with CONFIG_PREEMPT=y, I expect.
> >
> > I can fix that with a preempt_disable() in there, but ick.
> 
> Is there a reason you can't just use brlocks?

I didn't use brlocks in the initial code because I wanted the lock
in the same cacheline as the data it's locking.

And this code removes the locking altogether.

I suspect the lock traffic is in the noise compared with all the
get_bh, brelse, set_bit and clear_bit operations but it's a start.
We don't have a tool to measure those other things ;)
