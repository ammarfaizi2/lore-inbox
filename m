Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422667AbVLOJg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbVLOJg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbVLOJg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:36:57 -0500
Received: from mx1.suse.de ([195.135.220.2]:7307 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422667AbVLOJg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:36:57 -0500
Date: Thu, 15 Dec 2005 10:36:45 +0100
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, dada1@cosmobay.com
Subject: Re: [patch 3/3] x86_64: Node local pda take 2 -- node local pda allocation
Message-ID: <20051215093645.GW23384@wotan.suse.de>
References: <20051215023345.GB3787@localhost.localdomain> <20051215023748.GD3787@localhost.localdomain> <43A127D3.1070106@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A127D3.1070106@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have an idea of the performance gain we could expect from this node 
> local pda allocation ?

I wouldn't expect very much.

> Say a CPU is on Node 1,  was a change in pda (allocated on Node 0) 
> immediatly mirrored on remote node or not ?

The Opteron caches are write back afaik - this means data only leaves
the L2 cache when other data pushes it out.
But the additional traffic on the interconnect was likely negligible. 

If anything I would expect the reduced latency when a user space program eat up all 
cache and the PDA is needed on the next kernel entry to be helpful.

But it's not very much at least on an Opteron because the NUMA factor
isn't that bad. On Kiran's machines which likely have a higher NUMA 
factor I guess it helps more.

-Andi
