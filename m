Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318201AbSHDUQp>; Sun, 4 Aug 2002 16:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSHDUQp>; Sun, 4 Aug 2002 16:16:45 -0400
Received: from ns.suse.de ([213.95.15.193]:21256 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318201AbSHDUQo>;
	Sun, 4 Aug 2002 16:16:44 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
       wli@holomorpy.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: large page patch (fwd) (fwd)
References: <200208041331.24895.frankeh@watson.ibm.com.suse.lists.linux.kernel> <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com.suse.lists.linux.kernel> <3D4D7F24.10AC4BDB@zip.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Aug 2002 22:20:16 +0200
In-Reply-To: Andrew Morton's message of "4 Aug 2002 21:17:50 +0200"
Message-ID: <p73d6syjrzz.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> If we instead clear out 4 or 8 pages, we trash a ton of cache and
> the chances of userspace _using_ pages 1-7 in the short-term are
> lower.   We could clear the pages with 7,6,5,4,3,2,1,0 ordering,
> but the cache implications of faultahead are still there.

What you could do on modern x86 and probably most other architectures as 
well is to clear the faulted page in cache and clear the other pages
with a non temporal write. The non temporal write will go straight
to main memory and not pollute any caches. 

When the process accesses it later it has to fetch the zeroes from
main memory. This is probably still faster than a page fault at least
for the first few accesses. It could be more costly when walking the full
page (then the added up cache miss costs could exceed the page fault cost), 
but then hopefully the CPU will help by doing hardware prefetch.

It could help or not help, may be worth a try at least :-)

-Andi

