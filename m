Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130921AbRCMHCC>; Tue, 13 Mar 2001 02:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130952AbRCMHBx>; Tue, 13 Mar 2001 02:01:53 -0500
Received: from PO7.ANDREW.CMU.EDU ([128.2.10.107]:18329 "EHLO
	po7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S130921AbRCMHBm>; Tue, 13 Mar 2001 02:01:42 -0500
Message-ID: <UufQJdRz0001R5nYw7@andrew.cmu.edu>
Date: Tue, 13 Mar 2001 01:59:53 -0500 (EST)
From: James R Bruce <bruce+@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
Cc: Helge Hafting <helgehaf@idb.hist.no>, Manoj Sontakke <manojs@sasken.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <y7r7l1xl9tx.fsf@sytry.doc.ic.ac.uk>
In-Reply-To: <200103091152.MAA31645@cave.bitwizard.nl>
	<y7r7l1xl9tx.fsf@sytry.doc.ic.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again.  The latter half of my email seems to have been forgotten in
the ensuing discussion, so I'll repost.  For a linked list of any
non-floating point data, radix sort is almost impossible to beat; it's
iterative, fast (linear time for fixed size integers, worst case), can
be stopped early for partial sorting, and has a pretty simple
implementation.

I've been using essentially the same radix sort implementation I
posted before to sort 1000 item lists 60 times a second in a numerical
application, and it barely shows up in the total time used when
profiling.  The other sorts I tried did not fare so well.  I would
much rather see this in a kernel modification than any
merge/quick/heap sort implementations I've seen so far for linked
lists.  OTOH, this conversation seems to have wandered out of
kernel-space anyway...

 - Jim Bruce

(Examples at: http://www.cs.cmu.edu/~jbruce/sort.cc)

10-Mar-2001 Re: quicksort for linked list by David Wragg@doc.ic.ac.uk 
> For modern machines, I'm not sure that quicksort on a linked list is
> typically much cheaper than mergesort on a linked list.  The
> majority of the potential cost is likely to be in the pointer
> chasing involved in bringing the lists into cache, and that will be
> the same for both.  Once the list is in cache, how much pointer
> fiddling you do isn't so important.  For lists that don't fit into
> cache, the advantages of mergesort should become even greater if the
> literature on tape and disk sorts applies (though multiway merges
> rather than simple binary merges would be needed to minimize the
> impact of memory latency).
>
> Given this, mergesort might be generally preferable to quicksort for
> linked lists.  But I haven't investigated this idea thoroughly.
> (The trick described above for avoiding an explicit stack also works
> for mergesort.)

