Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265113AbSKER4S>; Tue, 5 Nov 2002 12:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265115AbSKER4L>; Tue, 5 Nov 2002 12:56:11 -0500
Received: from NEUROSIS.MIT.EDU ([18.243.0.82]:4331 "EHLO neurosis.mit.edu")
	by vger.kernel.org with ESMTP id <S265113AbSKERzx>;
	Tue, 5 Nov 2002 12:55:53 -0500
Date: Tue, 5 Nov 2002 13:02:22 -0500
From: Jim Paris <jim@jtan.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy Tarreau <willy@w.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021105130222.A6245@neurosis.mit.edu>
References: <20021102013704.A24684@neurosis.mit.edu> <20021103143216.A27147@neurosis.mit.edu> <1036355418.30679.28.camel@irongate.swansea.linux.org.uk> <20021105113020.A5210@neurosis.mit.edu> <20021105171035.GB879@alpha.home.local> <1036520191.5012.109.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1036520191.5012.109.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 05, 2002 at 06:16:31PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +		if (count > LATCH) {
> > 
> > may be (count >= LATCH) would be even better ?
> 
> Some PIT clones seem to hold the LATCH value momentarily judging by
> other things that were triggered wrongly by >=

If so, then that's a separate problem: the later code

	count = ((LATCH-1) - count) * TICK_SIZE;
	delay_at_last_interrupt = (count + LATCH/2) / LATCH;

will cause delay_at_last_interrupt to be negative, so you'll see
backwards jumps in time and occasional wraparound of usecs as I did.
Perhaps a 

	if (count == LATCH) 
	   count--;

after the reset code?

-jim
