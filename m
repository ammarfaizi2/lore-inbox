Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUCMR7C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbUCMR6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:58:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263147AbUCMR5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:57:13 -0500
Date: Sat, 13 Mar 2004 12:57:02 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040313173348.GI30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403131254480.15971-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, Andrea Arcangeli wrote:

> The remaining downside of all the global anonmm designs vs my finegrined
> anon_vma design, is that if you execute a malloc in a child (that will
> be direct memory with page->count == 1), you'll still have to try all
> the mm in the anongroup (that can be on the order of the thousands),

That's ok, you have a similar issue with very commonly
mmap()d files, where some pages haven't been faulted in
by most processes, or have been replaced by private pages
after a COW fault due to MAP_PRIVATE mapping.

You just increase the number of pages for which this
search is done, but I suspect that shouldn't be a big
worry...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

