Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268922AbUHMB1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268922AbUHMB1B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268930AbUHMB1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:27:01 -0400
Received: from holomorphy.com ([207.189.100.168]:50575 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268922AbUHMB0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:26:51 -0400
Date: Thu, 12 Aug 2004 18:26:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Message-ID: <20040813012638.GU11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@muc.de>, Jesse Barnes <jbarnes@engr.sgi.com>,
	linux-kernel@vger.kernel.org
References: <2sxuC-429-3@gated-at.bofh.it> <m3657nu9dl.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3657nu9dl.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> writes:
>> The patch works by adding an alloc_page_round_robin routine that
>> simply allocates on successive nodes each time its called, based on
>> the value of a per-cpu variable modulo the number of nodes.  The
>> variable is per-cpu to avoid cacheline contention when many cpus try
>> to do page cache allocations at 

On Fri, Aug 13, 2004 at 03:14:46AM +0200, Andi Kleen wrote:
> I don't like this approach using a dynamic counter. I think it would
> be better to add a new function that takes the vma and uses the offset
> into the inode for static interleaving (anonymous memory would still
> use the vma offset). This way you would have a good guarantee that the
> interleaving stays interleaved even when the system swaps pages in and
> out and you're less likely to get anomalies in the page distribution.

If we're going to go that far, why not use a better coloring algorithm?
IIRC linear_page_index(vma, vaddr) % MAX_NR_NODES has issues with
various semiregular access patterns where others do not (most are
relatively simple hash functions). This reminds me that getting the vma
and vaddr accessible to the allocator helps with normal page coloring.


-- wli
