Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbUKTDg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbUKTDg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbUKTDeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 22:34:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:21990 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263070AbUKTDd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:33:29 -0500
Date: Fri, 19 Nov 2004 21:33:12 -0600
From: Robin Holt <holt@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Robin Holt <holt@sgi.com>
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120033312.GB1434@lnx-holt.americas.sgi.com>
References: <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com> <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <20041120020401.GC2714@holomorphy.com> <419EA96E.9030206@yahoo.com.au> <20041120023443.GD2714@holomorphy.com> <419EAEA8.2060204@yahoo.com.au> <20041120030425.GF2714@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120030425.GF2714@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 07:04:25PM -0800, William Lee Irwin III wrote:
> Why the Hell would you bother giving each cpu a separate cacheline?
> The odds of bouncing significantly merely amongst the counters are not
> particularly high.

Agree, we are currently using atomic ops on a global rss on our 2.4
kernel with 512cpu systems and not seeing much cacheline contention.
I don't remember how little it ended up being, but it was very little.
We had gone to dropping the page_table_lock and only reaquiring it if
the pte was non-null when we went to insert our new one.  I think that
was how we had it working.  I would have to wake up and actually look
at that code as it was many months ago that Ray Bryant did that work.
We did make rss atomic.  Most of the contention is sorted out by the
mmap_sem.  Processes acquiring themselves off of mmap_sem were found
to have spaced themselves out enough that they were all approximately
equal time from doing their atomic_add and therefore had very little
contention for the cacheline.  At least it was not enough that we could
measure it as significant.
