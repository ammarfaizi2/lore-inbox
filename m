Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWEEQWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWEEQWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWEEQWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:22:13 -0400
Received: from ccerelrim04.cce.hp.com ([161.114.21.25]:47419 "EHLO
	ccerelrim04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751624AbWEEQWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:22:12 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Fri, 5 May 2006 12:22:09 -0400
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, Bob Picco <bob.picco@hp.com>,
       Andy Whitcroft <apw@shadowen.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060505162209.GC5708@localhost>
References: <1146756066.22503.17.camel@localhost.localdomain> <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu> <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org> <20060505135503.GA5708@localhost> <1146839590.22503.48.camel@localhost.localdomain> <20060505145018.GI19859@localhost> <1146841064.22503.53.camel@localhost.localdomain> <445B6926.20109@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445B6926.20109@mbligh.org>
User-Agent: Mutt/1.5.11
X-PMX-Version: 5.1.2.240295, Antispam-Engine: 2.3.0.1, Antispam-Data: 2006.5.5.85507
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:	[Fri May 05 2006, 11:03:02AM EDT]
> >Ahhh.  I hadn't made the ia64 connection.  I wonder if it is worth
> >making CONFIG_HOLES_IN_ZONE say ia64 or something about vmem_map in it
> >somewhere.  Might be worth at least a comment like this:
> >
> >+               if (page_in_zone_hole(buddy)) /* noop on all but ia64 */
> >+                       break;
> >+               else if (page_zonenum(buddy) != page_zonenum(page))
> >+                       break;
> >+               else if (!page_is_buddy(buddy, order))
> >                        break;          /* Move the buddy up one level. */
> >
> >BTW, wasn't the whole idea of discontig to have holes in zones (before
> >NUMA) without tricks like this? ;)
> 
> Sparsemem should fix this - that was one of the things Andy designed it
> for. Then we can remove the virtual memmap stuff (and discontig).
> Indeed, I'd hope we're ready to do that real soon now ... has anyone
> got an ia64 box that needed virtual memmap that they could test this
> on?
> 
> M.
I totally agree about SPARSEMEM. I believe most ia64 boxes use
VIRTUAL_MEM_MAP. I only know of Fujitsu and myself that use SPARSEMEM
for ia64 (perhaps Andy too in his testing). Dave and I have advocated its use
more than once.

bob
