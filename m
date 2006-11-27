Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758265AbWK0O46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265AbWK0O46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 09:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758266AbWK0O45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 09:56:57 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:54508 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1758265AbWK0O45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 09:56:57 -0500
Date: Mon, 27 Nov 2006 14:56:55 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add debugging aid for memory initialisation problems
In-Reply-To: <200611271514.03612.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0611271437560.15577@skynet.skynet.ie>
References: <20061127140804.GA15405@skynet.ie> <200611271514.03612.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, Andi Kleen wrote:

> On Monday 27 November 2006 15:08, Mel Gorman wrote:
>> A number of bug reports have been submitted related to memory initialisation
>> that would have been easier to debug if the PFN of page addresses were
>> available. The dmesg output is often insufficient to find that information
>> so debugging patches need to be sent to the reporting user.
>
> So how many new lines does that add overall?

I don't know for sure, but it's probably around the 150 LOC mark from 
about 12 patches, mainly in page_alloc.c. A significant portion of the 
patches were documentation, comments and providing debugging information. 
As it is, any bug fix or improvement in that code will now apply to all 
architectures using the API, not just one.

I expect the net code difference to drop as some of the mem= parsing 
(which currently does not always work AFAIK) gets handled in generic 
rather than arch-specific code. These type of cleanups will take a while. 
I would also expect the net difference to drop if more architectures used 
the API instead of arch-specific code but I couldn't test on all arches.

> Your memmap patches overall
> were already one of the most noisy additions we had for a very long time.
>

The worst of the noise should be over now. The last patch I sent isn't 
necessary. I only sent it on because it would have cut down on the time 
needed to fix Andre's issue.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
