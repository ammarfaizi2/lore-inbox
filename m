Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261985AbSIYOay>; Wed, 25 Sep 2002 10:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261986AbSIYOay>; Wed, 25 Sep 2002 10:30:54 -0400
Received: from [198.149.18.6] ([198.149.18.6]:4503 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261985AbSIYOax>;
	Wed, 25 Sep 2002 10:30:53 -0400
Date: Wed, 25 Sep 2002 09:35:59 -0500 (CDT)
From: Alan Mayer <ajm@sgi.com>
To: Milton Miller <miltonm@bga.com>
cc: Alan Mayer <ajm@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: irqs on large machines (patch)
In-Reply-To: <200209250911.g8P9B1734121@sullivan.realtime.net>
Message-ID: <Pine.SGI.3.96.1020925091808.102141B-100000@fergus.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Milton Miller wrote:

> PowerPC 64 (p690 in particular) had a similar but different
> problem with NR_IRQS.
> 
> The hardware gives direct vectors, but the number space is 9 bits
> to identify the pci host bridge in the drawers, and yet 4 more to
> identify the source on the pci bus.  All of the 9 bits are used at
> various levels of the hardware for routing, so the global number
> space is a bit sparse.
> 
> Each interrupt can be sent to the global queue or a specific
> processor's queue.

Ours can only be sent to a specific processor.

> 
> Rather than size NR_IRQS for the native index, the hardware numbers
> are mapped with a simple mapping table that directly maps dense
> linux irqs to hardware numbers.  Thus the linux NR_IRQs is set based on
> the total number of hardware sources.  (And yes, we found we needed
> /proc/interrupts to be seq_file based, but that is long merged).

And that's our problem.  The total number of hardware sources of interrupts
is N IO nodes * 6 buses per node * 2 slots per bus = 12N sources of
IO interrupts.  N can be anywhere between 1 and 256.  How big N is depends
entirely on how much money the customer wants to spend.  Some of our
customers have LOTS of money.  So, the IRQ space is sparse for small values
of N, with the density increasing with N.  It doesn't take long before
an interrupt vector is overloaded, so it only makes sense to try and
differentiate between interrupt vector x sent to processor y and 
interrupt vector x sent to processor z.

> 
> 
> Perhaps this will give you ideas for other alternatives?  This approach
> could also allow you to assign IO interrupts to a node if your hardware
> allows.

There are lots of alternatives.  However, most of them require deviating
significantly from what David has in the IA64 Linux patch.
However, we made the design decision that
we would try to co-exist peacefully with the IA64 Linux patch.  So far,
we have been able to do that.  We are THIS close (imagine finger and thumb
nearly touching) to living within the IA64 Linux code.  We just need
this small patch.  We want ALL of the code we develop for Linux and IA64
to live in some "official" (meaning, non-SGI) release.  Right now, I think
we're something under 100 lines of code different.  We want that to be
zero.
> 
> milton
> -- 
> [I'll look for any replys on the list]
> 

Still crazy, after all these years.
--
Alan J. Mayer
SGI
ajm@sgi.com
WORK: 651-683-3131
HOME: 651-407-0134
--

