Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUCaQqB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUCaQqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:46:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:23821 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262060AbUCaQpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:45:33 -0500
Date: Wed, 31 Mar 2004 17:45:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
    fix
In-Reply-To: <20040331150718.GC2143@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, Andrea Arcangeli wrote:
> 
> So I rewritten the fix this way:
> 
> +	ret = add_to_swap_cache(page, entry);

I think you'll find that gets into trouble on the header page,
entry 0, which pmdisk/swsusp does access through this interface,
but swapping does not: I'd expect its swap_duplicate to fail.

I've put off dealing with this, wasn't a priority for me to
decide what to do with it.  You might experiment with setting
p->swap_map[0] = 1 instead of SWAP_MAP_BAD in sys_swapon, but
offhand I'm unsure whether that's enough e.g. would the totals
come out right, would swapoff complete?

Just an idea, not something to finalize.

Hugh

