Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbUDBPXC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbUDBPXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:23:02 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4236
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264075AbUDBPWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:22:43 -0500
Date: Fri, 2 Apr 2004 17:22:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402152240.GA21341@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040401180802.219ece99.akpm@osdl.org> <20040402022233.GQ18585@dualathlon.random> <20040402070525.A31581@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402070525.A31581@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 07:05:25AM +0100, Christoph Hellwig wrote:
> On Fri, Apr 02, 2004 at 04:22:33AM +0200, Andrea Arcangeli wrote:
> > Well, I doubt anybody could take advantage of this optimization, since
> > nobody can ship with hugetlbfs disabled anyways (peraphs with the
> > exception of the embedded people but then I doubt they want to risk
> 
> Common. stop smoking that bad stuff.  Almost non-one except the known
> oracle whores SuSE and RH need it.  Remeber Linux is used much more widely
> except the known "Enterprise" vendors.  None of the NAS/networking/media
> applicances or pdas I've seen has the slightest need for hugetlbfs.

I already explained the reason of the changes, and they've nothing to do
with hugetlbfs. The whole thing has nothing to do with hugetlbfs. I also
proposed a way to optimize _always_ regardless of hugetlbfs=y or =n, by
just turning my __GFP_NO_COPM into a __GFP_COMP, again regardless of
hugetlbfs. The current mainline code returning different things from
alloc_pages depending on a hugetlbfs compile option is totally broken
and I simply fixed it. this has absolutely nothing to do with the
hugetlbfs users.

About your comment about SUSE and RH being the only ones shipping with
hugetlbfs turned on, I very strongly doubt that any other distribution
can ship with hugetlbfs turned off, just go ask them, I bet you will
have a surprised that they turn it on too.

The only ones that may not turn it on are probably the embedded people
using a custom kernel, but as I said I strongly doubt they want to risk
to trigger driver bugs with a different alloc_pages API since nobody
tested that API since everybody is going to turn hugetlbfs on.

As far as I can tell the number of people that runs with hugetlbfs off
is a niche compared to the ones that will turn it on and you're totally
wrong about claiming the opposite. You're confusing the number of active
hugetlbfs users with the number of users that have a kernel compiled
with hugetlbfs=y. That's a completely different thing. And regardless I
proposed a way to optimize it. Plus I fixed a very bad bug that triggers
with hugetlbfs=n and that obviously nobody tested, expce the
CONFIG_MMU=n people, that infact had it fixed only for CONFIG_MM=n, that
as well was totally broken since the alloc_pages API must be indipendent
from CONFIG_MMU, that's a physical-memory thing. So stop making
aggressive claims on l-k, especially when you're wrong.

I'll now look into the bug that you triggered with xfs. Did you ever
test with hugetlbfs=y before btw (maybe you were one of the users
keeping it off always and now noticing the API changes under you, and
now benefiting from my standardization of the API)? Could be a bug in my
changes too (though it works fine for me), we'll see.

