Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSGVGGT>; Mon, 22 Jul 2002 02:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSGVGGT>; Mon, 22 Jul 2002 02:06:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37019 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316397AbSGVGGS>;
	Mon, 22 Jul 2002 02:06:18 -0400
Date: Sun, 21 Jul 2002 23:06:58 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH][1/2] return values shrink_dcache_memory etc
Message-ID: <2725228.1027292816@[10.10.2.3]>
In-Reply-To: <3D3B9A6F.12B096E1@zip.com.au>
References: <3D3B9A6F.12B096E1@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > If we can get something in place which works acceptably on Martin
>> > Bligh's machines, and we can see that the gains of rmap (whatever
>> > they are ;)) are worth the as-yet uncoded pains then let's move on.
>> > But until then, adding new stuff to the VM just makes a `patch -R'
>> > harder to do.
>> 
>> I have the same kinds of machines and have already been testing with
>> precisely the many tasks workloads he's concerned about for the sake of
>> correctness, and efficiency is also a concern here. highpte_chain is
>> already so high up on my priority queue that all other work is halted.
> 
> OK.  But we're adding non-trivial amounts of new code simply
> to get the reverse mapping working as robustly as the virtual
> scan.  And we'll always have rmap's additional storage requirements.
> 
> At some point we need to make a decision as to whether it's all
> worth it.  Right now we do not even have the information on the
> pluses side to do this.  That's worrisome.

These large NUMA machines should actually be rmap's glory day in the
sun. Per-node kswapd, being able to free mem pressure on one node
easily (without cross-node bouncing), breakup of the lru list into 
smaller chunks, etc. These actually fix some of the biggest problems
that we have right now and are hard to solve in other ways.

The large rmap overheads we still have to kill seem to me to be the
memory usage and the fork overhead. There's also a certain amount of
overhead to managing any more data structures, of course. I think we
know how to kill most of it. I don't think adding highpte_chain is
the correct thing to do ... seems like adding insult to injury. I'd
rather see us drive a silver stake through the problem's heart and
kill it properly ...

M.

