Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311422AbSCMWmF>; Wed, 13 Mar 2002 17:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311423AbSCMWl4>; Wed, 13 Mar 2002 17:41:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:20437 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311422AbSCMWlq>; Wed, 13 Mar 2002 17:41:46 -0500
Date: Wed, 13 Mar 2002 14:40:02 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 23 second kernel compile / pagemap_lru_lock improvement
Message-ID: <5740000.1016059202@flay>
In-Reply-To: <Pine.LNX.4.21.0203132126480.1636-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0203132126480.1636-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >>>> Linus:
>> >>>> 
>> >>>> Anyway, some obvious LRU lock improvements are clearly available: 
>> >>>> activate_page_nolock() shouldn't even need to take the lru lock if the 
>> >>>> page is already active. 
>> 
>> Your suggestion seems to improve the pagemap_lru_lock contention a little:
>> (make bzImage , 16 way NUMA-Q, 5 runs each)
> 
> I'm surprised it made any difference at all, I think the patch mainly

There's quite a bit of variablility between runs, so it's a little hard to pin
down. The number of locks taken doesn't seem to be affected much, and
that's probably the best indicator of whether this is really working.

> adds more tests: activate_page is only called from mark_page_accessed
> (after testing !PageActive) and from fail_writepage (where usually
> !PageActive).  I don't think many !PageLRU pages can get there.
> Or is activate_page being called from other places in your tree?

No, I don't think I'm doing other stranger things to activate_page.

It does seem distinctly odd that we take the lock, *then* test whether
we actually need to do anything. Is the test just a sanity check that
should never fail?

M.

