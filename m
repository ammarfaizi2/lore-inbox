Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129138AbQJ0HNy>; Fri, 27 Oct 2000 03:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129308AbQJ0HNo>; Fri, 27 Oct 2000 03:13:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62682 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129138AbQJ0HNg>;
	Fri, 27 Oct 2000 03:13:36 -0400
Date: Fri, 27 Oct 2000 03:13:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: kumon@flab.fujitsu.co.jp, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Negative scalability by removal of lock_kernel()?(Was: Strange
  performance behavior of 2.4.0-test9)
In-Reply-To: <39F92187.A7621A09@timpanogas.org>
Message-ID: <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Oct 2000, Jeff V. Merkey wrote:

> 
> Linux has lots of n-sqared linear list searches all over the place, and
> there's a ton of spots I've seen it go linear by doing fine grained
> manipulation of lock_kernel() [like in BLOCK.C in NWFS for sending async
> IO to ll_rw_block()].   I could see where there would be many spots
> where playing with this would cause problems.  
> 
> 2.5 will be better.

fs/locks.c is one hell of a sick puppy. Nothing new about that. I'm kinda
curious about "n-squared" searches in other places, though - mind showing
them?

BTW, what spinlocks get contention in variant without BKL? And what about
comparison between the BKL and non-BKL versions? If it's something like
	BKL	no BKL
4-way	50	20
8-way	30	30
- something is certainly wrong, but restoring the BKL is _not_ a win.

I didn't look into recent changes in fs/locks.c, but I have quite problem
inventing a scenario when _adding_ BKL (without reverting other changes)
might give an absolute improvement. Well, I see a couple of really perverted
scenarios, but... Seriously, folks, could you compare the 4 variants above
and gather the contention data for the -test9 on your loads? That would help
a lot.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
