Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVKAPXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVKAPXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVKAPXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:23:15 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:51142 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750860AbVKAPXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:23:14 -0500
Date: Tue, 1 Nov 2005 15:23:07 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <20051101144622.GC9911@elte.hu>
Message-ID: <Pine.LNX.4.58.0511011516480.14884@skynet>
References: <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]>
 <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet>
 <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu> <Pine.LNX.4.58.0511011358520.14884@skynet>
 <20051101144622.GC9911@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Ingo Molnar wrote:

>
> * Mel Gorman <mel@csn.ul.ie> wrote:
>
> > [...] The full 100% solution would be a large set of far reaching
> > patches that would touch a lot of the memory manager. This would get
> > rejected because the patches should have have arrived piecemeal. These
> > patches are one piece. To reach 100%, other mechanisms are also needed
> > such as;
> >
> > o Page migration to move unreclaimable pages like mlock()ed pages or
> >   kernel pages that had fallen back into easy-reclaim areas. A mechanism
> >   would also be needed to move things like kernel text. I think the memory
> >   hotplug tree has done a lot of work here
> > o Mechanism for taking regions of memory offline. Again, I think the
> >   memory hotplug crowd have something for this. If they don't, one of them
> >   will chime in.
> > o linear page reclaim that linearly scans a region of memory reclaims or
> >   moves all the pages it. I have a proof-of-concept patch that does the
> >   linear scan and reclaim but it's currently ugly and depends on this set
> >   of patches been applied.
>
> how will the 100% solution handle a simple kmalloc()-ed kernel buffer,
> that is pinned down, and to/from which live pointers may exist? That
> alone can prevent RAM from being removable.
>

It would require the page to have it's virtual->physical mapping changed
in the pagetables for each running process and the master page table. That
would be another step on the road to 100% support.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
