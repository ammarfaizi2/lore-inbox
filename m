Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264645AbTIDExQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264626AbTIDExQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:53:16 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:13735 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264645AbTIDExP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:53:15 -0400
Date: Wed, 03 Sep 2003 21:51:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: David Lang <david.lang@digitalinsight.com>
cc: Larry McVoy <lm@bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <21670000.1062651086@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0309032004120.17581-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0309032004120.17581-100000@dlang.diginsite.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as CPU speeds climb and the relative penalty for going off the chip for
> any reason climb even faster the hardware overhead of keeping a SMP
> machine coherant becomes more significant. sometimes this can be solved by
> changing the algorithm (the O(1) scheduler for example) but other times
> you just have to accept the costof bouncing a cache line from one CPU to
> another so that you can aquire a lock.
> 
> the advantage of multiple images is that the hardware only needs to
> maintain full speed consistancy between CPU's in one image, a higher level
> (the OS or the partitioning software) can deal with the issues of letting
> one image know what it needs to about what the others are doing.

All true, but multiple images isn't the only way to solve the problem
(I happen to like the idea, but let's go for full disclosure on all
possibilities ;-)). Take one example, the global pagemap_lru_lock in
2.4 ... either we could split the LRU by multiple OS images, or explicitly
split it per-node ... like we did in 2.6 (Andrew did that particular bit
of work IIRC, apologies if not).

The question is whether it's better to split *everything* to start with,
and glue back the global bits ... or start with everything global, and
split off the problematic bits explicitly. To date, we've been taking
the latter approach ... it's probably more pragmatic and evolutionary,
and is certainly a damned sight easier. The former approach is a fascinating
idea (to Larry and I at least, it seems ... now we've stepped over our
previous communication breakdown on one aspect at least), but unproven.
I wanna go play with it ;-)

M.

