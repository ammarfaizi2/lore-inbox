Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUCTNgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbUCTNgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:36:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17113 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263407AbUCTNf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:35:58 -0500
Date: Sat, 20 Mar 2004 08:35:52 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc1-aa1
In-Reply-To: <20040318230628.GA2050@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403200833150.30298-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Andrea Arcangeli wrote:

> the problem is that they will still not be mergeable if we obey to the
> vm_pgoff. We could merge some more though. The other main issue is the
> search in this single object for all mm, that has again the downside of
> searching all mm. I keep track of exactly which mm to track instead,

If you read Hugh's latest code, you'll find that for all the
non-shared pages, his code only looks at 1 mm too ...

> But I certainly agree we could mix the two things and have 1 anon_vma
> object per-mm instad of per-vma by losing some granularity in the
> tracking and making the search more expensive, but then we'd need a
> prio_tree there too and that doesn't come for free either, so I'd rather
> spend the 12 bytes for the finegrined tracking, the prio_tree can't get
> right which mm to scan and which not for every page, the current
> anon_vma can.

Note that this disadvantage only holds true for pages that
are shared between multiple processes, but not all of the
processes in a fork group. The non-shared pages are found
immediately with Hugh's code, so I suspect this shouldn't
be a big disadvantage any more.

Also, we'll need the prio_tree anyway for file backed stuff.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

