Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311378AbSCMVit>; Wed, 13 Mar 2002 16:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311362AbSCMVij>; Wed, 13 Mar 2002 16:38:39 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:59868 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S311378AbSCMVi0>; Wed, 13 Mar 2002 16:38:26 -0500
Date: Wed, 13 Mar 2002 21:40:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 23 second kernel compile / pagemap_lru_lock improvement
In-Reply-To: <192090000.1015968170@flay>
Message-ID: <Pine.LNX.4.21.0203132126480.1636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Martin J. Bligh wrote:
> >>>> Linus:
> >>>>
> >>>> Anyway, some obvious LRU lock improvements are clearly available: 
> >>>> activate_page_nolock() shouldn't even need to take the lru lock if the 
> >>>> page is already active. 
> 
> Your suggestion seems to improve the pagemap_lru_lock contention a little:
> (make bzImage , 16 way NUMA-Q, 5 runs each)

I'm surprised it made any difference at all, I think the patch mainly
adds more tests: activate_page is only called from mark_page_accessed
(after testing !PageActive) and from fail_writepage (where usually
!PageActive).  I don't think many !PageLRU pages can get there.
Or is activate_page being called from other places in your tree?

Hugh

