Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSGVGft>; Mon, 22 Jul 2002 02:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSGVGft>; Mon, 22 Jul 2002 02:35:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31756 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316503AbSGVGfs>;
	Mon, 22 Jul 2002 02:35:48 -0400
Message-ID: <3D3BAA5B.E3C100A6@zip.com.au>
Date: Sun, 21 Jul 2002 23:46:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH][1/2] return values shrink_dcache_memory etc
References: <3D3B9A6F.12B096E1@zip.com.au> <2725228.1027292816@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >> > If we can get something in place which works acceptably on Martin
> >> > Bligh's machines, and we can see that the gains of rmap (whatever
> >> > they are ;)) are worth the as-yet uncoded pains then let's move on.
> >> > But until then, adding new stuff to the VM just makes a `patch -R'
> >> > harder to do.
> >>
> >> I have the same kinds of machines and have already been testing with
> >> precisely the many tasks workloads he's concerned about for the sake of
> >> correctness, and efficiency is also a concern here. highpte_chain is
> >> already so high up on my priority queue that all other work is halted.
> >
> > OK.  But we're adding non-trivial amounts of new code simply
> > to get the reverse mapping working as robustly as the virtual
> > scan.  And we'll always have rmap's additional storage requirements.
> >
> > At some point we need to make a decision as to whether it's all
> > worth it.  Right now we do not even have the information on the
> > pluses side to do this.  That's worrisome.
> 
> These large NUMA machines should actually be rmap's glory day in the
> sun.

"should be".  Sigh.  Be nice to see an "is" one day ;)

> Per-node kswapd, being able to free mem pressure on one node
> easily (without cross-node bouncing), breakup of the lru list into
> smaller chunks, etc. These actually fix some of the biggest problems
> that we have right now and are hard to solve in other ways.
> 
> The large rmap overheads we still have to kill seem to me to be the
> memory usage and the fork overhead. There's also a certain amount of
> overhead to managing any more data structures, of course. I think we
> know how to kill most of it. I don't think adding highpte_chain is
> the correct thing to do ... seems like adding insult to injury. I'd
> rather see us drive a silver stake through the problem's heart and
> kill it properly ...

Well that would be nice.  And by extension, pte-highmem gets a stake
as well.

Do you think that large pages alone would be enough to allow us
to leave pte_chains (and page tables?) in ZONE_NORMAL, or would
shared pagetables also be needed?

Was it purely Oracle which drove pte-highmem, or do you think
that page table and pte_chain consumption could be a problem
on applications which can't/won't use large pages?

-
