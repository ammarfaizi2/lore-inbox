Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUCMR2u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUCMR2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:28:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263134AbUCMR2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:28:41 -0500
Date: Sat, 13 Mar 2004 12:28:31 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.44.0403131653010.3585-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403131227210.15971-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, Hugh Dickins wrote:
> On Sat, 13 Mar 2004, Linus Torvalds wrote:

> > 	if (PageAnonymous(page) && page->count > 1) {
> > 		newpage = alloc_page();
> > 		copy_page(page, newpage);
> > 		page = newpage;
> > 	}
> > 	/* Move the page to the new address */
> > 	page->index = address >> PAGE_SHIFT;
> > 
> > and now we have zero special cases.
> 
> That's always been a fallback solution, I was just a little too ashamed
> to propose it originally - seems a little wrong to waste whole pages
> rather than wasting a few bytes of data structure trying to track them:
> though the pages are pageable unlike any data structure we come up with.

No, Linus is right.

If a child process uses mremap(), it stands to reason that
it's about to use those pages for something.

Think of it as taking the COW faults early, because chances
are you'd be taking them anyway, just a little bit later...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

