Return-Path: <linux-kernel-owner+w=401wt.eu-S932831AbXASSWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbXASSWD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbXASSWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:22:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50105 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932831AbXASSWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:22:01 -0500
Date: Fri, 19 Jan 2007 10:21:33 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Aubrey Li <aubreylee@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
In-Reply-To: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701191014250.15317@schroedinger.engr.sgi.com>
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Aubrey Li wrote:

> +int sysctl_pagecache_ratio = 10;
> +

Pagecache ratio is the ratio of memory to be left over? Would it not be 
better to twist this around and to be able to specify how much of the
memory of a node may be used by the pagecache?

Why limit the size of the pagecache? Some kind of rationale would be 
useful. Maybe it was there in earlier incarnations of the patch that I did 
not see? It should be kept with it.

zone_reclaim already dynamically limits the size of the pagecache.

> +	if (alloc_flags & ALLOC_PAGECACHE)
> +		min = min + (sysctl_pagecache_ratio * z->present_pages) / 100;

The calculation of the multiplication / division is usually not done in 
the hot allocation path. See f.e. how min_unmapped_pages is handled in 
mm/page_alloc.c
