Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263115AbUKTE1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbUKTE1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUKTEZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:25:40 -0500
Received: from holomorphy.com ([207.189.100.168]:63617 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263093AbUKTEYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 23:24:33 -0500
Date: Fri, 19 Nov 2004 20:24:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robin Holt <holt@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120042427.GK2714@holomorphy.com>
References: <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <20041120020401.GC2714@holomorphy.com> <419EA96E.9030206@yahoo.com.au> <20041120023443.GD2714@holomorphy.com> <419EAEA8.2060204@yahoo.com.au> <20041120030425.GF2714@holomorphy.com> <20041120033312.GB1434@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120033312.GB1434@lnx-holt.americas.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 09:33:12PM -0600, Robin Holt wrote:
> Agree, we are currently using atomic ops on a global rss on our 2.4
> kernel with 512cpu systems and not seeing much cacheline contention.
> I don't remember how little it ended up being, but it was very little.
> We had gone to dropping the page_table_lock and only reaquiring it if
> the pte was non-null when we went to insert our new one.  I think that
> was how we had it working.  I would have to wake up and actually look
> at that code as it was many months ago that Ray Bryant did that work.
> We did make rss atomic.  Most of the contention is sorted out by the
> mmap_sem.  Processes acquiring themselves off of mmap_sem were found
> to have spaced themselves out enough that they were all approximately
> equal time from doing their atomic_add and therefore had very little
> contention for the cacheline.  At least it was not enough that we could
> measure it as significant.

Also, the densely-packed split counter can only get 4-16 cpus to a
cacheline with cachelines <= 128B, so there are definite limitations to
the amount of cacheline contention in such schemes.


-- wli
