Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbUDBPqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264092AbUDBPqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:46:01 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46476
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264091AbUDBPp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:45:59 -0500
Date: Fri, 2 Apr 2004 17:45:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402154559.GE21341@dualathlon.random>
References: <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040401180802.219ece99.akpm@osdl.org> <20040402022233.GQ18585@dualathlon.random> <20040402070525.A31581@infradead.org> <20040402152240.GA21341@dualathlon.random> <20040402162709.A4312@infradead.org> <20040402153801.GD21341@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402153801.GD21341@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 05:38:01PM +0200, Andrea Arcangeli wrote:
> 100 kernel developers, who cares about saving some cycles in 100
> machines? Get real.

just to avoid any misunderstanding, I want to optimize it _everywhere_,
I mean that optimizing it in only 100 machines and an embedded niche is
worthless.  I'm not saying it's worthless to optimize it everywhere
(though I doubt it's a measurable slowdown given the order > 0 is
unlikely in the first place). if you check my first emails about the
compound thing I wasn't very happy about it. The only single reason I
had to keep it on by default is that currently I feel unsafe about
optimizing it away turning it off by default, since the big testing (on
weird drivers too) has happened so far with compound on by default, and
disabling it everywhere would risk to trigger bugs, and this clearly
shows you how unreliable it is to return different things from
alloc_pages in function of an unrelated hugetlbfs option, and this is a
basic problem I'm fixing.
