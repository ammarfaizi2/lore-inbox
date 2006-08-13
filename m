Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWHMXzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWHMXzT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 19:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWHMXzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 19:55:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17283
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751383AbWHMXzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 19:55:17 -0400
Date: Sun, 13 Aug 2006 16:55:40 -0700 (PDT)
Message-Id: <20060813.165540.56347790.davem@davemloft.net>
To: phillips@google.com
Cc: riel@redhat.com, tgraf@suug.ch, a.p.zijlstra@chello.nl, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: David Miller <davem@davemloft.net>
In-Reply-To: <44DFA225.1020508@google.com>
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Phillips <phillips@google.com>
Date: Sun, 13 Aug 2006 15:05:25 -0700

> By the way, another way to avoid impact on the normal case is an
> experimental option such as CONFIG_PREVENT_NETWORK_BLOCKIO_DEADLOCK.

That would just make the solution look more like a hack, and "bolted
on" rather than designed.

I think there is more profitability from a solution that really does
something about "network memory", and doesn't try to say "these
devices are special" or "these sockets are special".  Special cases
generally suck.

We already limit and control TCP socket memory globally in the system.
If we do this for all socket and anonymous network buffer allocations,
which is sort of implicity in Evgeniy's network tree allocator design,
we can solve this problem in a more reasonable way.

And here's the kick, there are other unrelated highly positive
consequences to using Evgeniy's network tree allocator.

It doesn't just solve the _one_ problem it was built for, it solves
several problems.  And that is the hallmark signature of good design.
