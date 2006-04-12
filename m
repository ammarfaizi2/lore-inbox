Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWDLACZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWDLACZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 20:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDLACZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 20:02:25 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:42925 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751117AbWDLACY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 20:02:24 -0400
Date: Wed, 12 Apr 2006 01:02:10 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: Bob Picco <bob.picco@hp.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linuxppc-dev@ozlabs.org,
       davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
 independent manner
In-Reply-To: <20060411232944.GE23742@localhost>
Message-ID: <Pine.LNX.4.64.0604120053080.10268@skynet.skynet.ie>
References: <20060411103946.18153.83059.sendpatchset@skynet>
 <20060411222029.GA7743@agluck-lia64.sc.intel.com> <20060411232944.GE23742@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2006, Bob Picco wrote:

> luck wrote:	[Tue Apr 11 2006, 06:20:29PM EDT]
>> On Tue, Apr 11, 2006 at 11:39:46AM +0100, Mel Gorman wrote:
>>
>>> The patches have only been *compile tested* for ia64 with a flatmem
>>> configuration. At attempt was made to boot test on an ancient RS/6000
>>> but the vanilla kernel does not boot so I have to investigate there.
>>
>> The good news: Compilation is clean on the ia64 config variants that
>> I usually build (all 10 of them).
>>
>> The bad (or at least consistent) news: It doesn't boot on an Intel
>> Tiger either (oops at kmem_cache_alloc+0x41).
>>
>> -Tony
> I had a reply queued to report the same failure with
> DISCONTIG+NUMA+VIRTUAL_MEM_MAP.  This was 2 CPU HP rx2600. I'll take a closer
> look at the code tomorrow.
>

hmm, ok, so discontig.c is in use which narrows things down. When 
build_node_maps() is called, I assumed that the start and end pfn passed 
in was for a valid page range. Was this a valid assumption? When I re-read 
the comment, it implies that memory holes could be within this range which 
would cause boot failures. If that is the case, the correct thing to do 
was to call add_active_range() in count_node_pages() instead of 
build_node_maps().

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
