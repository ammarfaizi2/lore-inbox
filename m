Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269808AbRHIQg4>; Thu, 9 Aug 2001 12:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269852AbRHIQgq>; Thu, 9 Aug 2001 12:36:46 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25410 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269808AbRHIQg0>; Thu, 9 Aug 2001 12:36:26 -0400
Date: Thu, 9 Aug 2001 18:36:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alloc_area_pte: page already exists
Message-ID: <20010809183634.K4895@athlon.random>
In-Reply-To: <20010809180344.J4895@athlon.random> <Pine.LNX.3.96.1010809170813.5473D-100000@medusa.sparta.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1010809170813.5473D-100000@medusa.sparta.lu.se>; from bjorn@sparta.lu.se on Thu, Aug 09, 2001 at 05:12:43PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 05:12:43PM +0200, Bjorn Wesen wrote:
> Yes, I found it. The irq which signals end-of-I/O also frees the kiovec,
> which is bad. But it seemed that what would happen then would be deadlocks
> (due to the spinlocks) and not races - but I'll try to make it free in a

In SMP the most obvious sympthom would be a deadlock right, but maybe
you're testing with a kernel compiled UP?

The locking there looks quite sane.

> task or something instead (there is no kernel context for the "calling"
> process because the driver is asynchronous so the context which did the
> alloc_kiovec etc. has exited when the irq comes later) and see if it works
> better.

Ok.

> > BTW, you should also avoid all the kiobuf allocation in all the fast
> > paths, try to pre-allocate it in a slow path to deliver higher
> > performance. (shortly we'll split the bh/blocks array out of the kiobuf
> 
> Ok, that's probably not a problem since the allocation is done in a normal
> system-call context.

Ok.

Andrea
