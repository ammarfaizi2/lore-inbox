Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWBDXvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWBDXvL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWBDXvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:51:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964885AbWBDXuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:50:51 -0500
Date: Sat, 4 Feb 2006 15:49:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, pj@sgi.com, clameter@sgi.com
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
Message-Id: <20060204154953.35a0f63f.akpm@osdl.org>
In-Reply-To: <20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>   static inline struct page *page_cache_alloc(struct address_space *x)
>   {
>  +	if (cpuset_mem_spread_check()) {
>  +		int n = cpuset_mem_spread_node();
>  +		return alloc_pages_node(n, mapping_gfp_mask(x), 0);
>  +	}
>   	return alloc_pages(mapping_gfp_mask(x), 0);
>   }
>   
>   static inline struct page *page_cache_alloc_cold(struct address_space *x)
>   {
>  +	if (cpuset_mem_spread_check()) {
>  +		int n = cpuset_mem_spread_node();
>  +		return alloc_pages_node(n, mapping_gfp_mask(x)|__GFP_COLD, 0);
>  +	}
>   	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
>   }

This is starting to get a bit bloaty.  Might be worth thinking about
uninlining these for certain Kconfig combinations.

