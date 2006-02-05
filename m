Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWBED3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWBED3O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 22:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWBED3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 22:29:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5511 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030205AbWBED3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 22:29:13 -0500
Date: Sat, 4 Feb 2006 19:28:59 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Paul Jackson <pj@sgi.com>, steiner@sgi.com, dgc@sgi.com,
       Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
In-Reply-To: <20060204175411.19ff4ffb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
 <20060204154953.35a0f63f.akpm@osdl.org> <20060204174252.9390ddc6.pj@sgi.com>
 <20060204175411.19ff4ffb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... Make this


static inline struct page *page_cache_alloc(struct address_space *x)
{
#ifdef CONFIG_NUMA
 	if (cpuset_mem_spread_check()) {
 		int n = cpuset_mem_spread_node();
 		return alloc_pages_node(n, mapping_gfp_mask(x), 0);
 	}
#endif
 	return alloc_pages(mapping_gfp_mask(x), 0);
}
