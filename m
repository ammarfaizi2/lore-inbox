Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278841AbRKIAKg>; Thu, 8 Nov 2001 19:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278886AbRKIAK0>; Thu, 8 Nov 2001 19:10:26 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:36874 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S278841AbRKIAKV>;
	Thu, 8 Nov 2001 19:10:21 -0500
Date: Fri, 9 Nov 2001 11:05:32 +1100
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011109110532.B6822@krispykreme>
In-Reply-To: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain.suse.lists.linux.kernel> <Pine.LNX.4.33.0111081836080.15975-100000@localhost.localdomain.suse.lists.linux.kernel> <p731yj8kgvw.fsf@amdsim2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p731yj8kgvw.fsf@amdsim2.suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > we should fix this by trying to allocate continuous physical memory if
> > possible, and fall back to vmalloc() only if this allocation fails.
> 
> Check -aa. A patch to do that has been in there for some time now.

We also need a way to satisfy very large allocations for the hashes (eg
the pagecache hash). On a 32G machine we get awful performance on the
pagecache hash because we can only get an order 9 allocation out of
get_free_pages:

http://samba.org/~anton/linux/pagecache/pagecache_before.png

When switching to vmalloc the hash is large enough to be useful:

http://samba.org/~anton/linux/pagecache/pagecache_after.png

As pointed out by Davem and Ingo we should try and avoid vmalloc here
due to tlb trashing.

Anton
