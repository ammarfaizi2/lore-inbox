Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUDHGYd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 02:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUDHGYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 02:24:32 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:4305 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261661AbUDHGYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 02:24:31 -0400
Date: Wed, 07 Apr 2004 23:24:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <1479132704.1081405456@[10.10.2.4]>
In-Reply-To: <20040408001845.GX26888@dualathlon.random>
References: <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay> <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay> <20040407231806.GV26888@dualathlon.random> <33900000.1081380891@flay> <20040408001845.GX26888@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Apr 07, 2004 at 04:34:51PM -0700, Martin J. Bligh wrote:
>> I measured it - IIRC it was 5-10% on kernel compile ... and that was on a
>> high ratio NUMA which it should have made *better* (as with highmem, the
>> PTEs can be allocated node locally). I'll try to dig up the old profiles.
> 
> but this is a kind of machine where I assume you've plenty of ram and
> you really want pte_highmem enabled (the sysctl can still be added but
> you really must know what you're doing if you disable pte_highmem
> there), I was more interested to hear the impact on mid-low end 1-2G
> machines where pte_highmem isn't really necessary for most apps, and

I can't imagine why it'd be any less.

> there the sysctl may be useful for general purpose too. If it payoffs
> significantly the sysctl could then be elaborated in an heuristic that
> prefers lowmem pagetables until a certain threshold, and then it
> fallbacks in highmem allocations, and the threshold depends on the
> highmem/lowmem ratio plus a further tuning via sysctl).

Instead of fiddling with tuning knobs, I'd prefer to just do the UKVA
idea I've proposed before, and let each process have their own pagetables
mapped permanently ;-)

M.

