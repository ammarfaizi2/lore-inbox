Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbQKENhZ>; Sun, 5 Nov 2000 08:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKENhP>; Sun, 5 Nov 2000 08:37:15 -0500
Received: from humbolt.geo.uu.nl ([131.211.28.48]:19216 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S129181AbQKENhE>; Sun, 5 Nov 2000 08:37:04 -0500
Date: Sun, 5 Nov 2000 14:36:43 +0100 (CET)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Jonathan George <Jonathan.George@trcinc.com>,
        "'matthew@mattshouse.com'" <matthew@mattshouse.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test10 Sluggish After Load
In-Reply-To: <m3bsvvh5c5.fsf@linux.local>
Message-ID: <Pine.LNX.4.05.10011051433540.9109-100000@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Nov 2000, Christoph Rohland wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
> > Indeed, shared memory performance still sucks rocks.
> 
> No, it's not a performance problem. It is a hard lockup problem on
> highmem machines.
> 
> I do see two problems here:
> 1) shm_swap_core does not handle the failure of prepare_higmem_swapout
>    right and basically cannot do so. It gets called zone independant
>    and should probably get called per zone. At least it has to react:

AFAIC try_to_swap_out can handle this situation fine, it
shouldn't be very difficult to get shm_swap to handle it
too...

Unfortunately I don't have a really big memory machine so
I cannot test this stuff :(

> You see: you only have 5+27+27=59 pages under your control...

Ughhhh. Maybe we need some rebalancing there as well.
That's a maximum of 5 pages of executable text mapped
into all processes...

regards,

Rik
--
The Internet is not a network of computers. It is a network
of people. That is its real strength.

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
