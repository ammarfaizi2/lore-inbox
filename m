Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSHBEgP>; Fri, 2 Aug 2002 00:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSHBEgP>; Fri, 2 Aug 2002 00:36:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17886 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S318210AbSHBEgO>;
	Fri, 2 Aug 2002 00:36:14 -0400
Date: Thu, 01 Aug 2002 21:38:49 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: large page patch
Message-ID: <861946523.1028237928@[10.10.2.3]>
In-Reply-To: <aid0he$1h4$1@penguin.transmeta.com>
References: <aid0he$1h4$1@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Direct email seemed to get seperated from the cc somewhere
along the line ... repeated for others on l-k (sorry Linus ;-))

> I doubt that.  At least the naive math says that it should get
> exponentially less likely(*) to merge up/down for each level, so by the
> time you've reached order-10, any merging is already in the noise and
> totally unmeasurable. 

Yeah, it's probably unmeasurable, just ugly ;-)
I guess it's more that it seems unnecessary ... if ia64 are the
only people that need it to be that ludicrously large, it'd be
better if they just did it in their arch tree. Just because they
could theoretically have 256Mb pages, do they really *need* them? ;-)
 
>> It also makes the config_nonlinear stuff harder (or we have to
>> # ifdef it, which just causes more unnecessary differentiation). 
> 
> Hmm..  This sounds like a good point, but I thought we already did all
> the math relative to the start of the zone, so that the alignment thing
> implied by MAX_ORDER shouldn't be an issue. 
> 
> Or were you thinking of some other effect?

The config_nonlinear stuff relies on a trick ... we shove physically
non-contig areas into the buddy allocator, but the buddy allocator
is guaranteed to return phys contig areas. That all works just fine
as long as the blocks we put in are of size greater than or equal to
2^MAX_ORDER * PAGE_SIZE, which is currently 4Mb. A 4Mb alignment is
not a problem for any known machine, but I think 256Mb may well be.
It's kind of a dirty trick, but it's a really neat, efficient 
solution that gets rid of lots of zone balancing and pgdat proliferation.
It also lets me spread around ZONE_NORMAL across nodes for ia32 NUMA.

M.

