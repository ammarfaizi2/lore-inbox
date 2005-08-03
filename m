Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVHCOlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVHCOlG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVHCOko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:40:44 -0400
Received: from ns.suse.de ([195.135.220.2]:46763 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261938AbVHCOi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:38:56 -0400
Date: Wed, 3 Aug 2005 16:38:55 +0200
From: Andi Kleen <ak@suse.de>
To: Martin Hicks <mort@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: add vm.free_node_memory sysctl
Message-ID: <20050803143855.GA10895@wotan.suse.de>
References: <20050801113913.GA7000@elte.hu> <20050801102903.378da54f.akpm@osdl.org> <20050801195426.GA17548@elte.hu> <20050802171050.GG26803@localhost> <20050802210746.GA26494@elte.hu> <20050803135646.GO26803@localhost> <20050803141529.GX10895@wotan.suse.de> <20050803142440.GQ26803@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803142440.GQ26803@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 10:24:40AM -0400, Martin Hicks wrote:
> 
> On Wed, Aug 03, 2005 at 04:15:29PM +0200, Andi Kleen wrote:
> > On Wed, Aug 03, 2005 at 09:56:46AM -0400, Martin Hicks wrote:
> > > 
> > > Here's the promised sysctl to dump a node's pagecache.  Please review!
> > > 
> > > This patch depends on the zone reclaim atomic ops cleanup:
> > > http://marc.theaimsgroup.com/?l=linux-mm&m=112307646306476&w=2
> > 
> > Doesn't numactl --bind=node memhog nodesize-someslack do the same?
> > 
> > It just might kick in the oom killer if someslack is too small
> > or someone has unfreeable data there. But then there should be 
> > already an sysctl to turn that one off.
> 
> Doesn't the memhog hack also cause the machine to swap a lot?  The

Hack? - compared to your "solutions" it looks very clean to me.

> zone_reclaim() path doesn't let the memory reclaim code swap.

reclaim with bound policy should only swap on the bound nodemask
(or at least it did when I originally implemented NUMA policy) 

-Andi
