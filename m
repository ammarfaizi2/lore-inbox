Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289313AbSBSCS0>; Mon, 18 Feb 2002 21:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289326AbSBSCSR>; Mon, 18 Feb 2002 21:18:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:35486 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289313AbSBSCSL>;
	Mon, 18 Feb 2002 21:18:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 03:22:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hugh Dickins <hugh@veritas.com>, <dmccr@us.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181758260.24597-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202181758260.24597-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16czvB-0000z2-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 03:05 am, Linus Torvalds wrote:
> On Mon, 18 Feb 2002, Rik van Riel wrote:
> >
> > The swapout code can remove a page from the page table
> > while another process is in the process of unsharing
> > the page table.
> 
> Ok, I'll buy that. However, looking at that, the locking is not the real
> issue at all:
> 
> When the swapper does a "ptep_get_and_clear()" on a shared pmd, it will
> end up having to not just synchronize with anybody doing unsharing, it
> will have to flush all the TLB's on all the mm's that might be implicated.
> 
> Which implies that the swapper needs to look up all mm's some way anyway,

Ick.  With rmap this is straightforward, but without, what?  flush_tlb_all?
Maybe page tables should be unshared on swapin/out after all, only on arches
that need special tlb treatment, or until we have rmap.

> so the locking gets solved that way.

-- 
Daniel
