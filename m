Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268921AbUHMBOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268921AbUHMBOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUHMBOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:14:53 -0400
Received: from zero.aec.at ([193.170.194.10]:26373 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268921AbUHMBOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:14:52 -0400
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
References: <2sxuC-429-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 13 Aug 2004 03:14:46 +0200
In-Reply-To: <2sxuC-429-3@gated-at.bofh.it> (Jesse Barnes's message of "Fri,
 13 Aug 2004 01:50:06 +0200")
Message-ID: <m3657nu9dl.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> writes:

> On a NUMA machine, page cache pages should be spread out across the system 
> since they're generally global in nature and can eat up whole nodes worth of 
> memory otherwise.  This can end up hurting performance since jobs will have 
> to make off node references for much or all of their non-file data.
>
> The patch works by adding an alloc_page_round_robin routine that simply 
> allocates on successive nodes each time its called, based on the value of a 
> per-cpu variable modulo the number of nodes.  The variable is per-cpu to 
> avoid cacheline contention when many cpus try to do page cache allocations at 

I don't like this approach using a dynamic counter. I think it would
be better to add a new function that takes the vma and uses the offset
into the inode for static interleaving (anonymous memory would still
use the vma offset). This way you would have a good guarantee that the
interleaving stays interleaved even when the system swaps pages in and
out and you're less likely to get anomalies in the page distribution.

-Andi


