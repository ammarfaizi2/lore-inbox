Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbUCNBIG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbUCNBIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:08:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59869 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263245AbUCNBIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:08:00 -0500
Date: Sat, 13 Mar 2004 20:07:52 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040314010108.GF655@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0403132005410.15971-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, William Lee Irwin III wrote:
> On Sat, Mar 13, 2004 at 04:52:00PM -0800, Linus Torvalds wrote:
> > Yes. However, I'd at least personally hope that we don't even need the 
> > find_vma() all the time.
>
> find_vma() is often necessary to determine whether the page is mlock()'d.

Alternatively, the mlock()d pages shouldn't appear on the LRU
at all, reusing one of the variables inside page->lru as a
counter to keep track of exactly how many times this page is
mlock()d.

> In schemes where mm's that may not map the page appear in searches,
> it may also be necessary to determine if there's even a vma covering the
> area at all or otherwise a normal vma, since pagetables outside normal
> vmas may very well not be understood by the core (e.g. hugetlb).

If the page is a normal page on the LRU, I suspect we don't
need to find the VMA, with the exception of mlock()d pages...

Good thing Christoph was already looking at the mlock()d page
counter idea.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

