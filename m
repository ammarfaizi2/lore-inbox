Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWBFHO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWBFHO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWBFHO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:14:27 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:1162 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750707AbWBFHO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:14:27 -0500
Date: Mon, 6 Feb 2006 09:14:20 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, clameter@engr.sgi.com, steiner@sgi.com,
       dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
In-Reply-To: <20060205215152.27800776.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0602060912100.20153@sbz-30.cs.Helsinki.FI>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
 <20060204154953.35a0f63f.akpm@osdl.org> <20060204174252.9390ddc6.pj@sgi.com>
 <20060204175411.19ff4ffb.akpm@osdl.org> <Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
 <20060204210653.7bb355a2.akpm@osdl.org> <20060204220800.049521df.pj@sgi.com>
 <20060204221524.1607401e.akpm@osdl.org> <20060205215152.27800776.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2006, Paul Jackson wrote:
> These two page_cache_alloc*(), and perhaps also __cache_alloc() when
> Pekka or I gets a handle on it, are candidates for this marking, as
> routines to inline on UMA, out of line on NUMA.

For slab, I found that the following two patches reduce text size most 
(for i386 NUMAQ config) while keeping UMA path the same. I don't have 
actual NUMA-capable hardware so I have no way to benchmark them. Both 
patches move code out-of-line and thus introduce new function calls which 
might affect performance negatively.

http://www.cs.helsinki.fi/u/penberg/linux/penberg-2.6/penberg-01-slab/slab-alloc-path-cleanup.patch
http://www.cs.helsinki.fi/u/penberg/linux/penberg-2.6/penberg-01-slab/slab-reduce-text-size.patch

			Pekka
