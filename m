Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289148AbSBSBTQ>; Mon, 18 Feb 2002 20:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289166AbSBSBTH>; Mon, 18 Feb 2002 20:19:07 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:63121 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289148AbSBSBS7>;
	Mon, 18 Feb 2002 20:18:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 02:23:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hugh Dickins <hugh@veritas.com>, <dmccr@us.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>,
        Rik van Riel <riel@conectiva.com.br>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181631120.24405-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202181631120.24405-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cz0J-0000yQ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 01:56 am, Linus Torvalds wrote:
> On Tue, 19 Feb 2002, Daniel Phillips wrote:
> >
> > Thanks, here it is again.  This time I left the gratuitous whitespace
> > cleanup in as the route of least resistance ;-)
> 
> Daniel, there's something wrong in the locking.
> 
> I can see _no_ reason to have "page_table_share_lock". What is the point
> of that one?

Before I put it in I was getting a weird error trying to run UML on a
native kernel with page table sharing.  After it was solid.  That's emprical, 
but...

> Whenever we end up touching the pmd counts, we already hold the local
> mm->page_table_lock. That means that we are always guaranteed to have a
> count of at least one when we start out on it.

Yes, good observation, I was looking at it inversely: when we have a
count of one then we must have exclusion from the mm->page_table_lock.

> [...]
>
> In short, I do not believe that that lock is needed. And if it isn't
> needed, it is _incorrect_. Locking that doesn't buy you anything is not
> just a performance overhead, it's bad thinking.

It would be very nice if the lock isn't needed.  OK, it's going to take some
time to ponder over your post properly.  In the mean time, there is exclusion 
that's clearly missing elsewhere and needs to go it, i.e., in the read fault 
path.
 
-- 
Daniel
