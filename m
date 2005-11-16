Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbVKPBfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbVKPBfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVKPBfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:35:04 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:19915 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932261AbVKPBfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:35:02 -0500
Date: Wed, 16 Nov 2005 01:34:51 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Paul Jackson <pj@sgi.com>
Cc: linux-mm@kvack.org, mingo@elte.hu, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 0/5] Light Fragmentation Avoidance V20
In-Reply-To: <20051115145451.671a29ec.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0511160122040.8470@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
 <20051115145451.671a29ec.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Paul Jackson wrote:

> I'm sure you've stated this before, but could you repeat it?
>
> What's the driving motivation for this, and what's the essential
> capability required?
>

For me, the ultimate aim is the transparent support of huge pages which
would be a general benefit to any application that uses large amounts of
address space or uses their address space sparsely.  Low fragmentation is
a prerequisite before you even start trying.  Patches have been submitted
for the demand paging of huge pages but obviously more is needed. This
patchset should help the demand allocation of huge pages.

Other benefits are;

1. Benefits hotplug on some architectures, particularly ppc64 (fringe benefit)
2. HPC jobs that need to reset a system to a state with large pages
   available without rebooting the system benefit from this are likely to
   get their huge pages if they stop all running processes, dd a large
   file from /dev/zero and delete it again (fringe benefit)
3. Lower fragmentation means the per-cpu allocation is likely to be able
   to allocate pages in large batches avoiding multiple calls to the
   allocator. Jobs that are cache sensitive may benefit if they tend to
   fault their address space in chunks as they get pages that are
   contiguous in physical and virtual memoet (general benefit, patch
   available)
4. Prezeroing pages in large batches becomes a lot more feasible (general
   benefit, needs patch that does not regress performance)
5. Potentially reduces the blocks used for scatter/gather IO. In an
   earlier thread, it was noted that Windows is much better at providing
   large pages for DMA than Linux is (potential benefit, haven't measured it)

Think that covers the main points. Someone will chime in if I missed
something important.

Lastly, benchmarks on my testbed show the patches to be as fast or faster
than the standard allocator. Benchmark results that show the contrary are
missing.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
