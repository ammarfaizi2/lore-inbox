Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSGVHT5>; Mon, 22 Jul 2002 03:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSGVHT5>; Mon, 22 Jul 2002 03:19:57 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14768 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316548AbSGVHT4>;
	Mon, 22 Jul 2002 03:19:56 -0400
Date: Mon, 22 Jul 2002 00:20:38 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Ed Tomlinson <tomlins@cam.org>, bcrl@redhat.com
Subject: Re: [PATCH][1/2] return values shrink_dcache_memory etc
Message-ID: <7146496.1027297237@[10.10.2.3]>
In-Reply-To: <3D3BAA5B.E3C100A6@zip.com.au>
References: <3D3BAA5B.E3C100A6@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well that would be nice.  And by extension, pte-highmem gets a stake
> as well.
> 
> Do you think that large pages alone would be enough to allow us
> to leave pte_chains (and page tables?) in ZONE_NORMAL, or would
> shared pagetables also be needed?
> 
> Was it purely Oracle which drove pte-highmem, or do you think

I don't see you can get into pathalogical crap without heavy
sharing of large amounts of data .... without sharing, you're at
a fixed percentage of phys mem - with sharing, I can have more
PTEs needed that I have phys mem. So anything that shares heavily
is the worst problem, and databases seemt to be the worst for this ...

If phys ram is significantly greater than virtual address space, 
you can, of course, still kill yourself quite happily, particularly
as ZONE_NORMAL is full of struct page's etc at this point. But I am
under the impression we can make pte_highmem much nicer by putting
everything into UKVA, and thus just mapping our own processes mappings
rather than everyone in the universe ... giving some sort of solution
to the problem. pte_chains don't do that nicely.

> that page table and pte_chain consumption could be a problem
> on applications which can't/won't use large pages?

Bill and Ben (desperately tempting to bring up English children's
programs at this point ...) were describing some sort of 32Kb
windowing Oracle uses which would render large pages useless
without some funky windowing we apparently used to do for PTX.
Ben ... could you describe this 32Kb stuff?

M.
