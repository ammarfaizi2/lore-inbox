Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293106AbSBYSzF>; Mon, 25 Feb 2002 13:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293219AbSBYSy4>; Mon, 25 Feb 2002 13:54:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31954 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293106AbSBYSyq>; Mon, 25 Feb 2002 13:54:46 -0500
Date: Mon, 25 Feb 2002 10:55:03 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Erich Focht <focht@ess.nec.de>, Mike Kravetz <kravetz@us.ibm.com>
cc: Jesse Barnes <jbarnes@sgi.com>, Peter Rival <frival@zk3.dec.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
Message-ID: <20940000.1014663303@flay>
In-Reply-To: <Pine.LNX.4.21.0202251737420.30318-100000@sx6.ess.nec.de>
In-Reply-To: <Pine.LNX.4.21.0202251737420.30318-100000@sx6.ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - The load_balancing() concept is different:
> 	- there are no special time intervals for balancing across pool
> 	boundaries, the need for this can occur very quickly and I
> 	have the feeling that 2*250ms is a long time for keeping the 
> 	nodes unbalanced. This means: each time load_balance() is called
> 	it _can_ balance across pool boundaries (but doesn't have to).

Imagine for a moment that there's a short spike in workload on one node.
By agressively balancing across nodes, won't you incur a high cost
in terms of migrating all the cache data to the remote node (destroying
the cache on both the remote and local node), when it would be cheaper 
to wait for a few more ms, and run on the local node? This is a 
non-trivial problem to solve, and I'm not saying either approach is
correct, just that there are some disadvantages of being too agressive.
Perhaps it's architecture dependant (I'm used to NUMA-Q, which has 
caches on the interconnect, and a cache-miss access speed ratio of 
about 20:1 remote:local).

> Would be interesting to hear oppinions on initial balancing. What are the
> pros and cons of balancing at do_fork() or do_execve()? And it would be
> interesting to learn about other approaches, too...

Presumably exec-time balancing is cheaper, since there are fewer shared
pages to be bounced around between nodes, but less effective if the main
load on the machine is one large daemon app, which just forks a few copies
of itself ... I would have though that'd get sorted out a little later anyway
by the background rebalancing though?

M.

