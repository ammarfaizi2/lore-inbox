Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbWBEFHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWBEFHx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 00:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWBEFHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 00:07:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932620AbWBEFHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 00:07:52 -0500
Date: Sat, 4 Feb 2006 21:06:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: pj@sgi.com, steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
Message-Id: <20060204210653.7bb355a2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154953.35a0f63f.akpm@osdl.org>
	<20060204174252.9390ddc6.pj@sgi.com>
	<20060204175411.19ff4ffb.akpm@osdl.org>
	<Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> Hmm... Make this
> 
> 
> static inline struct page *page_cache_alloc(struct address_space *x)
> {
> #ifdef CONFIG_NUMA
>  	if (cpuset_mem_spread_check()) {
>  		int n = cpuset_mem_spread_node();
>  		return alloc_pages_node(n, mapping_gfp_mask(x), 0);
>  	}
> #endif
>  	return alloc_pages(mapping_gfp_mask(x), 0);
> }

That's a no-op.

The problem remains that for CONFIG_NUMA=y, this function is too big to inline.

It's a minor thing.  But it's a thing.

