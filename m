Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVHCOPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVHCOPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVHCOPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:15:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63885 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262249AbVHCOPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:15:31 -0400
Date: Wed, 3 Aug 2005 16:15:29 +0200
From: Andi Kleen <ak@suse.de>
To: Martin Hicks <mort@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linux MM <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] VM: add vm.free_node_memory sysctl
Message-ID: <20050803141529.GX10895@wotan.suse.de>
References: <20050801113913.GA7000@elte.hu> <20050801102903.378da54f.akpm@osdl.org> <20050801195426.GA17548@elte.hu> <20050802171050.GG26803@localhost> <20050802210746.GA26494@elte.hu> <20050803135646.GO26803@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803135646.GO26803@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 09:56:46AM -0400, Martin Hicks wrote:
> 
> On Tue, Aug 02, 2005 at 11:07:46PM +0200, Ingo Molnar wrote:
> > 
> > * Martin Hicks <mort@sgi.com> wrote:
> > 
> > > On Mon, Aug 01, 2005 at 09:54:26PM +0200, Ingo Molnar wrote:
> > > > 
> > > > * Andrew Morton <akpm@osdl.org> wrote:
> > > > 
> > > > > >  We could perhaps add a CAP_SYS_ADMIN-only sysctl for this hack,
> > > > > 
> > > > > That would be more appropriate.
> > > > > 
> > > > > (I'm still not sure what happened to the idea of adding a call to 
> > > > > "clear out this node+zone's pagecache now" rather than "set this 
> > > > > noed+zone's policy")
> > > > 
> > > > lets do that as a sysctl hack. It would be useful for debugging purposes 
> > > > anyway. But i'm not sure whether it's the same issue - Martin?
> > > 
> > > (Sorry..I was on vacation yesterday)
> > > 
> > > Yes, this is the same issue with a different way of making it happen. 
> > > Setting a zone's policy allows reclaim to happen automatically.
> > > 
> > > I'll send in a patch to add a sysctl to do the manual dumping of 
> > > pagecache really soon.
> > 
> > cool! [ Incidentally, when i found this problem i was looking for 
> > existing bits in the kernel to write such a patch myself (which i wanted 
> > to use on non-NUMA to create more reproducable workloads for 
> > performance-testing) - now i'll wait for your patch. ]
> 
> Here's the promised sysctl to dump a node's pagecache.  Please review!
> 
> This patch depends on the zone reclaim atomic ops cleanup:
> http://marc.theaimsgroup.com/?l=linux-mm&m=112307646306476&w=2

Doesn't numactl --bind=node memhog nodesize-someslack do the same?

It just might kick in the oom killer if someslack is too small
or someone has unfreeable data there. But then there should be 
already an sysctl to turn that one off.


-Andi
