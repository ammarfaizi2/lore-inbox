Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbUDBP1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbUDBP1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:27:20 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:4371 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264074AbUDBP1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:27:15 -0500
Date: Fri, 2 Apr 2004 16:27:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402162709.A4312@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040401180802.219ece99.akpm@osdl.org> <20040402022233.GQ18585@dualathlon.random> <20040402070525.A31581@infradead.org> <20040402152240.GA21341@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040402152240.GA21341@dualathlon.random>; from andrea@suse.de on Fri, Apr 02, 2004 at 05:22:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 05:22:40PM +0200, Andrea Arcangeli wrote:
> I already explained the reason of the changes, and they've nothing to do
> with hugetlbfs. The whole thing has nothing to do with hugetlbfs. I also
> proposed a way to optimize _always_ regardless of hugetlbfs=y or =n, by
> just turning my __GFP_NO_COPM into a __GFP_COMP, again regardless of
> hugetlbfs. The current mainline code returning different things from
> alloc_pages depending on a hugetlbfs compile option is totally broken
> and I simply fixed it. this has absolutely nothing to do with the
> hugetlbfs users.

Umm, the usersn't aren't supposed to dig into the VM internals that deep.
Everyone who does has a bug.

> The only ones that may not turn it on are probably the embedded people
> using a custom kernel, but as I said I strongly doubt they want to risk
> to trigger driver bugs with a different alloc_pages API since nobody
> tested that API since everybody is going to turn hugetlbfs on.

We can make a little poll on lkml, but I bet most kernel developers will
have it disabled :)

> I'll now look into the bug that you triggered with xfs. Did you ever
> test with hugetlbfs=y before btw

I for myself haven't run with hugetlfs=y ever and don't really plan to.

> (maybe you were one of the users
> keeping it off always and now noticing the API changes under you, and
> now benefiting from my standardization of the API)? 

Huh?  The callchain comes from generic slab code..

