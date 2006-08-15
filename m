Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965288AbWHOIIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965288AbWHOIIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWHOIIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:08:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56754 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965288AbWHOIIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:08:34 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
References: <20060814110359.GA27704@2ka.mipt.ru>
	<20060815002724.a635d775.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 15 Aug 2006 10:08:23 +0200
In-Reply-To: <20060815002724.a635d775.akpm@osdl.org>
Message-ID: <p738xlqa0aw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> 
> There will be heaps of cacheline pingpong accessing these arrays.  I'd have
> though that
> 
> static struct whatever {
> 	avl_t avl_node_id;
> 	struct avl_node **avl_node_array;
> 	struct list_head *avl_container_array;
> 	struct avl_node *avl_root;
> 	struct avl_free_list *avl_free_list_head;
> 	spinlock_t avl_free_lock;
> } __cacheline_aligned_in_smp whatevers[NR_CPUS];
> 
> would be better.

Or even better per cpu data. New global/static NR_CPUS arrays should be really discouraged.

-Andi
