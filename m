Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291377AbSBSMjm>; Tue, 19 Feb 2002 07:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291372AbSBSMjc>; Tue, 19 Feb 2002 07:39:32 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:29080 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291377AbSBSMjT>;
	Tue, 19 Feb 2002 07:39:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 13:43:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, mingo@redhat.co,
        Andrew Morton <akpm@zip.com.au>, manfred@colorfullife.com,
        wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.21.0202191209570.1016-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0202191209570.1016-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16d9cc-0001Ep-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 01:22 pm, Hugh Dickins wrote:
> On Tue, 19 Feb 2002, Daniel Phillips wrote:
> > On February 19, 2002 04:22 am, Linus Torvalds wrote:
> > > That still leaves the TLB invalidation issue, but we could handle that
> > > with an alternate approach: use the same "free_pte_ctx" kind of gathering
> > > that the zap_page_range() code uses for similar reasons (ie gather up the
> > > pte entries that you're going to free first, and then do a global
> > > invalidate later).
> > 
> > I think I'll fall back to unsharing the page table on swapout as Hugh 
> > suggested, until we sort this out.
> 
> My proposal was to unshare the page table on read fault, to avoid race.
> I suppose you could, just for your current testing, use that technique
> in swapout, to avoid the much more serious TLB issue that Linus has now
> raised.  But don't do so without realizing that it is a very deadlocky
> idea for swapout (making pages freeable) to need to allocate pages.

I didn't fail to notice that.  It's no worse than any other page reservation
issue, of which we have plenty.  One day we're going to have to solve them all.

> And it's not much use for swapout to skip them either, since the shared
> page tables become valuable on the very large address spaces which we'd
> want swapout to be hitting.

Unsharing is the route of least resistance at the moment.  If necessary I can
keep a page around for that purpose, then reestablish that reserve after using
it.

-- 
Daniel
