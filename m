Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313187AbSEPPfs>; Thu, 16 May 2002 11:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313199AbSEPPfr>; Thu, 16 May 2002 11:35:47 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:55826 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S313187AbSEPPfr>;
	Thu, 16 May 2002 11:35:47 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205161535.g4GFZfw23006@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver.
In-Reply-To: <Pine.LNX.4.44.0205160920220.14957-100000@waste.org> from Oliver
 Xymoron at "May 16, 2002 09:29:49 am"
To: Oliver Xymoron <oxymoron@waste.org>
Date: Thu, 16 May 2002 17:35:41 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
        "chen, xiangping" <chen_xiangping@emc.com>,
        "'Jes Sorensen'" <jes@wildopensource.com>,
        "'Steve Whitehouse'" <Steve@ChyGwyn.com>, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Oliver Xymoron wrote:"
> On Thu, 16 May 2002, Peter T. Breuer wrote:
> > "Oliver Xymoron wrote:"
> > > If the system runs out of memory, it may try to flush pages that are
> > > queued to your NBD device. That will try to allocate more memory for
> > > sending packets, which will fail, meaning the VM can never make progress
> > > freeing pages. Now your box is dead.
> > The system can avoid this by
> >
> >  a) not flushing sync  (i.e. giving up on pages that won't flush immediately)
> >  b) being nondeterministic about it .. not always retrying the same
> >     thing again and again.
> 
> Helpful but insufficient. What is to stop getting into a situation where
> _all_ memory that is pageable is only pageable via network? Even if you

OK, I agree. The socket (or the process using the socket) needs a
reserve of memory that it can call upon in order to complete each
individual network send, and that the rest of the system cannot touch.

> have a big box, if you do large streaming writes to about 20 NBD devices,
> you'll discover that each device queue can hold many megabytes of dirty
> data.. Try pulling out your ethernet cable for a moment and watch the
> thing strangle itself.

Any way of making sure that send_msg on the socket can always get the
(known a priori) buffers it needs?

> Harder to get into this situation with NFS, but still doable.

OTOH, if there is even a single other thread anywhere holding pages
that we can reclaim, then we can find them by using an async stochastic
algorithm inside the VM, instead of the current sync, deterministic one,
surely!

Peter
