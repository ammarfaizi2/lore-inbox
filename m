Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWDLPye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWDLPye (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 11:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWDLPyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 11:54:33 -0400
Received: from mga03.intel.com ([143.182.124.21]:16940 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750992AbWDLPyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 11:54:33 -0400
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="22344554:sNHT43072897"
Date: Wed, 12 Apr 2006 08:54:29 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@skynet.ie>
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture independent manner
Message-ID: <20060412155429.GA10645@agluck-lia64.sc.intel.com>
References: <20060411103946.18153.83059.sendpatchset@skynet> <20060411222029.GA7743@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie> <20060412000500.GA8532@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That seems to register memory about the 0-2G mark and 6-8G with some small 
> holes here and there. Sounds like what you expected to happen. In case the 
> 1:1 virt->phys mapping is not always true on IA64, I decided to use __pa() 
> instead of PAGE_OFFSET like;
> 
> add_active_range(node, __pa(start) >> PAGE_SHIFT, __pa(end) >> PAGE_SHIFT);
> 
> Is this the correct thing to do or is "start - PAGE_OFFSET" safer? 
> Optimistically assuming __pa() is ok, the following patch (which replaces 
> Patch 5/6 again) should boot (passed compile testing here). If it doesn't, 
> can you send the console log again please?

Almost all of "region 7" (0xE000000000000000-0xFFFFFFFFFFFFFFFF) of the kernel
address space is defined to have a 1:1 mapping with physical memory (the exception
being the top 64K (0xFFFFFFFFFFFF0000-0xFFFFFFFFFFFFFFFF) which is mapped as
a per-cpu area).  So __pa(x) is simply defined as ((x) - PAGE_OFFSET). Using
__pa(start) is effectively identical to (start - PAGE_OFFSET), but __pa() is
a bit cleaner and easier to read.


-Tony
