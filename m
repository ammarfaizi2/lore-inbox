Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293299AbSCECCB>; Mon, 4 Mar 2002 21:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293330AbSCECBp>; Mon, 4 Mar 2002 21:01:45 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19819 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293299AbSCECBh>; Mon, 4 Mar 2002 21:01:37 -0500
Date: Tue, 5 Mar 2002 03:02:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] breaking up the pagemap_lru_lock in rmap
Message-ID: <20020305030204.A20606@dualathlon.random>
In-Reply-To: <194860000.1015265091@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194860000.1015265091@flay>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 10:04:51AM -0800, Martin J. Bligh wrote:
> High contention on the pagemap_lru lock seems to be a major
> scalability problem for rmap at the moment. Based on wli's and
> Rik's suggestions, I've made a first cut at a patch to split up the
> lock into a per-page lock for each pte_chain.

some year ago when I put a spinlock in the page structure I was flamed :)
That was fair enough. Sometime the theorical maximum degree of
scalability doesn't worth the additional ram usage.

but anyways, can you show where do you see this high contenction on the
pagemap_lru lock? Maybe that's more a sympthom that the rmap is doing
something silly with the lock acquired, can you measure high contention
also on my tree on similar workloads? I think we should worry about the
pagecache_lock, before the pagemap_lru lock. During heavy paging
activity, the system should become I/O bound, and the spinlock there
shouldn't matter. while when the system time goes up, it usually doesn't
run inside the vm, but it usually runs cached and there the
pagecache_lock matters.

Andrea
