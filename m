Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265726AbUFXWdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbUFXWdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbUFXWdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:33:19 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:61191 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S265760AbUFXWaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:30:11 -0400
Date: Thu, 24 Jun 2004 17:28:57 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Andi Kleen <ak@suse.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, Andi Kleen <ak@muc.de>,
       discuss@x86-64.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
       andrea@suse.de
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624222857.GM615@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20040624161539.GC8085@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624161539.GC8085@wotan.suse.de>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.23 
X-OriginalArrivalTime: 24 Jun 2004 22:29:59.0170 (UTC) FILETIME=[C880BE20:01C45A3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 09:15:40AM -0700, ak@suse.de wrote:
> I would prefer if the default value would work for most users
> because any special options are a very high support load.
> Do you think 64MB (minus other users so maybe 30-40MB in practice)  
> would be still sufficient to give reasonable performance without
> hickups?

that's what we're currently asking users to do for our current swiotlb
code. we are seeing some hickups in ut2004, but I haven't investigated
if this is related to limited memory resources (actually, it shouldn't
be, as we'd have paniced instead of failing to allocate memory).

I think I would push for 128M by default, just to make sure there's
plenty. I don't think this should be too bad, since this would only
kick in if the user has 4+ Gigs of memory, in which 128M is a small
portion of the total.


> Agreed, the panics should be made optional at least. I will
> take a look at doing this for swiotlb too. I like
> them as options though because for debugging it's better to get
> a clear panic than a weird malfunction.

it makes perfect sense to have a debugging option for that, it'd just
be nice to have that not be the default.

> But why didn't you implement addressing capability for >32bit
> in your hardware then? I imagine the memory requirements won't 
> stop at 4GB (or rather 2-3GB because not all phys mapping
> space below 4GB can be dedicated to graphics) 

I suspect the addressing capability is due to cost/die size tradeoffs.

and I didn't mean to imply that these setups would be common, or
really use that much additional memory. just pointing out that it's
not uncommon to have some odd frankenstein setups that would use a
little more memory than normal. you are correct that in these cases, a
little more end user tweaking is acceptable.


after talking to some of the other developers here, we wanted to
re-inquiry about the extra dma zone approach, and how
feasible/acceptable that might be. one of the thoughts is that the
swiotlb approach would probably be the easiest to get in place
quickly, but that the dma zone approach would be more robust.
we wouldn't need to set aside an allocation pool, there wouldn't need
to be end user tweaking for the corner cases, etc..


Thanks,
Terence

