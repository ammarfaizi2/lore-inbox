Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760636AbWLFOSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760636AbWLFOSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760634AbWLFOSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:18:41 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2138 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760636AbWLFOSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:18:41 -0500
Message-ID: <4576D129.90909@shadowen.org>
Date: Wed, 06 Dec 2006 14:18:17 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Peter Zijlstra <peter@programming.kicks-ass.net>
CC: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       clameter@sgi.com, Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
References: <20061130170746.GA11363@skynet.ie>	 <20061130173129.4ebccaa2.akpm@osdl.org>	 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie>	 <20061201110103.08d0cf3d.akpm@osdl.org> <20061204140747.GA21662@skynet.ie>	 <20061204113051.4e90b249.akpm@osdl.org> <1165264640.23363.18.camel@lappy>
In-Reply-To: <1165264640.23363.18.camel@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Mon, 2006-12-04 at 11:30 -0800, Andrew Morton wrote:
> 
>> I'd also like to pin down the situation with lumpy-reclaim versus
>> anti-fragmentation.  No offence, but I would of course prefer to avoid
>> merging the anti-frag patches simply based on their stupendous size.  It
>> seems to me that lumpy-reclaim is suitable for the e1000 problem, but
>> perhaps not for the hugetlbpage problem.  Whereas anti-fragmentation adds
>> vastly more code, but can address both problems?  Or something.
> 
>>From my understanding they complement each other nicely. Without some
> form of anti fragmentation there is no guarantee lumpy reclaim will ever
> free really high order pages. Although it might succeed nicely for the
> network sized allocations we now have problems with.
> 
> - Andy, do you have any number on non largepage order allocations? 

Currently no, we have focused on the worst case huge pages and assumed 
lower orders would be easier and more successful.  Though it is (now) on 
my todo list to see if we can do the same tests at some lower order; 
with the aim of trying that on base+lumpy.

> But anti fragmentation as per Mel's patches is not good enough to
> provide largepage allocations since we would need to shoot down most of
> the LRU to obtain such a large contiguous area. Lumpy reclaim however
> can quickly achieve these sizes.

-apw
