Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUKFBvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUKFBvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 20:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbUKFBvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 20:51:44 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:34796 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261275AbUKFBvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 20:51:42 -0500
Date: Sat, 6 Nov 2004 02:50:51 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041106015051.GU8229@dualathlon.random>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <418C2861.6030501@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418C2861.6030501@cyberone.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 12:26:57PM +1100, Nick Piggin wrote:
> need to be performed and have no failure path. For example __GFP_REPEAT.

all allocations should have a failure path to avoid deadlocks. But in
the meantime __GFP_REPEAT is at least localizing the problematic places ;)

> I think maybe __GFP_REPEAT allocations at least should be able to
> cause an OOM. Not sure though.

probably it should because this is also a case where no fail path exists.

My point was only that when a fail path exists, it's more reliable not
to invoke the oom killer and let userspace handle the failure.

> Also, I think it would do the wrong thing on NUMA machines because
> that has a per-node kswapd.

yep.
