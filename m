Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVKQS1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVKQS1p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVKQS1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:27:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56028 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932453AbVKQS1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:27:44 -0500
Date: Thu, 17 Nov 2005 10:27:35 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Robin Holt <holt@sgi.com>
cc: Mel Gorman <mel@csn.ul.ie>, Russ Anderson <rja@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to handle a hugepage with bad physical memory?
In-Reply-To: <20051117144332.GC4316@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.62.0511171026070.20976@schroedinger.engr.sgi.com>
References: <20051116131012.GE4573@lnx-holt.americas.sgi.com>
 <Pine.LNX.4.62.0511161155380.16434@schroedinger.engr.sgi.com>
 <20051117144332.GC4316@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005, Robin Holt wrote:

> > > With the new hugepages concept, would it be possible to only mark
> > > the default pagesize portion of a hugepage as bad and then return the
> > > remainder of the hugepage for normal use?  What would we basically need
> > > to do to accomplish this?  Are there patches in the community which we
> > > should wait to see how they progress before we do any work on this front?
> > 
> > On IA64 we have one PTE for a huge page in a different region, so we 
> > cannot unmap a page sized section. Other architectures may have PTEs for 
> > each page sized section of a huge page. For those it may make sense 
> > (but then the management of the page is done via the first page_struct, 
> > which likely results in some challenging VM issues).
> 
> I think you misunderstood me.  I was talking about killing the process.
> All the mappings get destroyed.  I want to reclaim as much of that huge
> page as possible.

You are right. If you can reclaim the whole page (as you can when killing 
a process) then you can isolate the bad page and free the rest. There 
would have to be special code for that in the hugetlb layer.

