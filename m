Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbUCMR4D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUCMR4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:56:03 -0500
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:41601 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S263146AbUCMRzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:55:16 -0500
Date: Sat, 13 Mar 2004 12:55:09 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@ruby.engin.umich.edu
To: riel@redhat.com
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, andrea@suse.de
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.GSO.4.58.0403121548530.2624@sapphire.engin.umich.edu>
Message-ID: <Pine.LNX.4.58.0403131246580.28574@ruby.engin.umich.edu>
References: <20040310080000.GA30940@dualathlon.random>
 <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com>
 <20040310135012.GM30940@dualathlon.random> <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu>
 <20040312172600.GC30940@dualathlon.random> <Pine.GSO.4.58.0403121548530.2624@sapphire.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The only problem is mremap() after a fork(), and hell, we know that's a
> special case anyway, and let's just add a few lines to copy_one_pte(),
> which basically does:
>
>	if (PageAnonymous(page) && page->count > 1) {
>		newpage = alloc_page();
>		copy_page(page, newpage);
>		page = newpage;
>	}
>	/* Move the page to the new address */
>	page->index = address >> PAGE_SHIFT;
>
> and now we have zero special cases.

This part makes the problem so simple. If this is acceptable, then we
have many choices. Since we won't have many mms in the anonmm list,
I don't think we will have any search complexity problems. If we really
worry again about search complexity, we can consider using prio_tree
(adds 16 bytes per vma - we cannot share vma.shared.prio_tree_node).
The prio_tree easily fits for anonmm after linus-mremap-simplification.

Rajesh


