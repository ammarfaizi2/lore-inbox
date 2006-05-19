Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWESODP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWESODP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 10:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWESODP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 10:03:15 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:4074 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932315AbWESODO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 10:03:14 -0400
Date: Fri, 19 May 2006 15:03:10 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, davej@codemonkey.org.uk,
       tony.luck@intel.com, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       ak@suse.de, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and free_area_init_nodes
In-Reply-To: <20060514203158.216a966e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605191447060.29077@skynet.skynet.ie>
References: <20060508141030.26912.93090.sendpatchset@skynet>
 <20060508141211.26912.48278.sendpatchset@skynet> <20060514203158.216a966e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 May 2006, Andrew Morton wrote:

> Mel Gorman <mel@csn.ul.ie> wrote:
>>
>> Size zones and holes in an architecture independent manner for ia64.
>>
>
> This one makes my ia64 die very early in boot.   The trace is pretty useless.
>
> config at http://www.zip.com.au/~akpm/linux/patches/stuff/config-ia64
>

An indirect fix for this has been set out with a patchset with the subject 
"[PATCH 0/2] Fixes for node alignment and flatmem assumptions" . For 
arch-independent-zone-sizing, the issue was that FLATMEM assumes that 
NODE_DATA(0)->node_start_pfn == 0. This is not the case with 
arch-independent-zone-sizing and IA64. With arch-independent-zone-sizing, 
a nodes node_start_pfn will be at the first valid PFN.

> <log snipped>
>
> Note the misaligned pfns.
>

You will still get the message about misaligned PFNs on IA64. This is 
because the lowest zone starts at the lowest available PFN which may not 
be 0 or any other aligned number. It shouldn't make a different - or at 
least I couldn't cause any problems.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
