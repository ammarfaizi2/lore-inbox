Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVKAOKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVKAOKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVKAOKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:10:37 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:64443 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750796AbVKAOKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:10:37 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051101135651.GA8502@elte.hu>
References: <20051030235440.6938a0e9.akpm@osdl.org>
	 <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au>
	 <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au>
	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>
	 <Pine.LNX.4.58.0511011014060.14884@skynet>  <20051101135651.GA8502@elte.hu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 15:10:23 +0100
Message-Id: <1130854224.14475.60.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 14:56 +0100, Ingo Molnar wrote:
> * Mel Gorman <mel@csn.ul.ie> wrote:
> 
> > The set of patches do fix a lot and make a strong start at addressing 
> > the fragmentation problem, just not 100% of the way. [...]
> 
> do you have an expectation to be able to solve the 'fragmentation 
> problem', all the time, in a 100% way, now or in the future?

In a word, yes.

The current allocator has no design for measuring or reducing
fragmentation.  These patches provide the framework for at least
measuring fragmentation.

The patches can not do anything magical and there will be a point where
the system has to make a choice: fragment, or fail an allocation when
there _is_ free memory.

These patches take us in a direction where we are capable of making such
a decision.

> > So, with this set of patches, how fragmented you get is dependant on 
> > the workload and it may still break down and high order allocations 
> > will fail. But the current situation is that it will defiantly break 
> > down. The fact is that it has been reported that memory hotplug remove 
> > works with these patches and doesn't without them. Granted, this is 
> > just one feature on a high-end machine, but it is one solid operation 
> > we can perform with the patches and cannot without them. [...]
> 
> can you always, under any circumstance hot unplug RAM with these patches 
> applied? If not, do you have any expectation to reach 100%?

With these patches, no.  There are currently some very nice,
pathological workloads which will still cause fragmentation.  But, in
the interest of incremental feature introduction, I think they're a fine
first step.  We can effectively reach toward a more comprehensive
solution on top of these patches.

Reaching truly 100% will require some other changes such as being able
to virtually remap things like kernel text.

-- Dave

