Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUDHASs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUDHASs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:18:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58315
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261410AbUDHASr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:18:47 -0400
Date: Thu, 8 Apr 2004 02:18:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040408001845.GX26888@dualathlon.random>
References: <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay> <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay> <20040407231806.GV26888@dualathlon.random> <33900000.1081380891@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33900000.1081380891@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 04:34:51PM -0700, Martin J. Bligh wrote:
> I measured it - IIRC it was 5-10% on kernel compile ... and that was on a
> high ratio NUMA which it should have made *better* (as with highmem, the
> PTEs can be allocated node locally). I'll try to dig up the old profiles.

but this is a kind of machine where I assume you've plenty of ram and
you really want pte_highmem enabled (the sysctl can still be added but
you really must know what you're doing if you disable pte_highmem
there), I was more interested to hear the impact on mid-low end 1-2G
machines where pte_highmem isn't really necessary for most apps, and
there the sysctl may be useful for general purpose too. If it payoffs
significantly the sysctl could then be elaborated in an heuristic that
prefers lowmem pagetables until a certain threshold, and then it
fallbacks in highmem allocations, and the threshold depends on the
highmem/lowmem ratio plus a further tuning via sysctl).
