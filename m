Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264988AbSKESOJ>; Tue, 5 Nov 2002 13:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSKESOI>; Tue, 5 Nov 2002 13:14:08 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:51208 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S264988AbSKESNv>;
	Tue, 5 Nov 2002 13:13:51 -0500
Date: Tue, 5 Nov 2002 19:20:19 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jim Paris <jim@jtan.com>, Willy Tarreau <willy@w.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021105182019.GA25472@alpha.home.local>
References: <20021102013704.A24684@neurosis.mit.edu> <20021103143216.A27147@neurosis.mit.edu> <1036355418.30679.28.camel@irongate.swansea.linux.org.uk> <20021105113020.A5210@neurosis.mit.edu> <20021105171035.GB879@alpha.home.local> <1036520191.5012.109.camel@irongate.swansea.linux.org.uk> <20021105130222.A6245@neurosis.mit.edu> <1036521477.4827.118.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036521477.4827.118.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 06:37:57PM +0000, Alan Cox wrote:
> On Tue, 2002-11-05 at 18:02, Jim Paris wrote:
> > > > > +		if (count > LATCH) {
> > > > 
> > > > may be (count >= LATCH) would be even better ?
> > > 
> > > Some PIT clones seem to hold the LATCH value momentarily judging by
> > > other things that were triggered wrongly by >=
> > 
> > If so, then that's a separate problem: the later code
> > 
> > 	count = ((LATCH-1) - count) * TICK_SIZE;
> > 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
> > 
> 
> It might be interesting to catch that case with a printk too and put
> both in 2.5 and see what comes out in the wash yes

could that be the reason a few people have experienced occasionnal jumps
backwards in gettimeofday() a few months ago, which many others could never
reproduce ? Just because of buggy hardware ?

If so, I think the printk patch should be proposed to Marcelo before
2.4.20-final.

Regards,
Willy

