Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVKDSI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVKDSI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVKDSI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:08:26 -0500
Received: from fmr21.intel.com ([143.183.121.13]:34459 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750785AbVKDSI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:08:26 -0500
Subject: Re: [PATCH]: Clean up of __alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <4366C188.5090607@yahoo.com.au>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	 <4362DF80.3060802@yahoo.com.au>
	 <1130792107.4853.24.camel@akash.sc.intel.com>
	 <4366C188.5090607@yahoo.com.au>
Content-Type: text/plain
Organization: Intel 
Date: Fri, 04 Nov 2005 10:15:08 -0800
Message-Id: <1131128108.27563.11.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Nov 2005 18:08:11.0473 (UTC) FILETIME=[B7B3E410:01C5E16A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 12:14 +1100, Nick Piggin wrote:
> Rohit Seth wrote:
> > On Sat, 2005-10-29 at 12:33 +1000, Nick Piggin wrote:
> 
> >>If you don't do this, then a GFP_HIGH allocator can allocate right
> >>down to its limit before it kicks kswapd, then it either will fail or
> >>will have to do direct reclaim.
> >>
> > 
> > 
> > You are right if there are only GFP_HIGH requests coming in then the
> > allocation will go down to (min - min/2) before kicking in kswapd.
> > Though if the requester is not ready to wait, there is another good shot
> > at allocation succeed before we get into direct reclaim (and this is
> > happening based on can_try_harder flag).
> > 
> 
> Still, it is a change in behaviour that I would rather not introduce
> with a cleanup patch (and is something we don't want to introduce anyway).
> 
> So if you could fix that up it would be good.
> 

Nick, sorry for not responding earlier.  

I agree that it is slight change in behavior from original.  I doubt
though it will impact any one in any negative way (may be for some
higher order allocations if at all). On a little positive side, less
frequent calls to kswapd for some cases and clear up the code a little
bit.

But I really don't want to get stuck here. The pcp traversal and
flushing is where I want to go next.  

Thanks,
-rohit

