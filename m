Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130494AbRCILxc>; Fri, 9 Mar 2001 06:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRCILxM>; Fri, 9 Mar 2001 06:53:12 -0500
Received: from 13dyn199.delft.casema.net ([212.64.76.199]:4101 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130492AbRCILxG>; Fri, 9 Mar 2001 06:53:06 -0500
Message-Id: <200103091152.MAA31645@cave.bitwizard.nl>
Subject: Re: quicksort for linked list
In-Reply-To: <3AA89624.46DBADD7@idb.hist.no> from Helge Hafting at "Mar 9, 2001
 09:36:52 am"
To: Helge Hafting <helgehaf@idb.hist.no>
Date: Fri, 9 Mar 2001 12:52:22 +0100 (MET)
CC: Manoj Sontakke <manojs@sasken.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Manoj Sontakke wrote:
> > 
> > Hi
> >         Sorry, these questions do not belog here but i could not find any
> > better place.
> > 
> > 1. Is quicksort on doubly linked list is implemented anywhere? I need it
> > for sk_buff queues.
> 
> I cannot see how the quicksort algorithm could work on a doubly
> linked list, as it relies on being able to look
> up elements directly as in an array.

It took me a few moments to realize, but quicksort is one algorithm
that DOES NOT rely on directly accessing array elements.

  qsort (items) 
  {
    if (numberof (items) <= 1) return. 
    pivot = chose_pivot (items)
    for (all items)
	if (curitem < pivot) put on the left of pivot
        else                 put on the right of pivot
    qsort (items on the left of pivot);
    qsort (items on the right of pivot);
  }

All operations are easily done on lists, not only on arrays. Actually,
the array-implementation has a few thingies to avoid having to move
the half the array on the scan of one item. With a list that is not an
issue.

If you know how you chose your pivot, one of the "puts" can be
nil. (for example, chose the pivot as the leftmost item. All other
items are already on the right. So "put on the left of pivot" is
"unlink (curitem), relink_to_the_left (pivot, curitem)", but put on
the right is "/* nothing to be done */".

Quicksort however is an algorithm that is recursive. This means that
it can use unbounded amounts of stack -> This is not for the kernel.

Quicksort however is an algorithm that is good for large numbers of
elements to be sorted: the overhead of a small set of items to sort is
very large. Is the "normal" case indeed "large sets"?

Quicksort has a very bad "worst case": quadratic sort-time. Are you
sure this won't happen?

Isn't it easier to do "insertion sort": Keep the lists sorted, and
insert the item at the right place when you get the new item.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
