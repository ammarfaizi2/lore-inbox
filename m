Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbUDLS6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 14:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUDLS6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 14:58:52 -0400
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:55226 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S263018AbUDLS6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 14:58:50 -0400
Date: Mon, 12 Apr 2004 14:58:44 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@rust.engin.umich.edu
To: Hugh Dickins <hugh@veritas.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <Pine.LNX.4.44.0404121904520.10436-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0404121453050.10128@rust.engin.umich.edu>
References: <Pine.LNX.4.44.0404121904520.10436-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unless we see a plausible way forward on your SDET numbers, I
> think it casts this project in doubt - but even so I do need

We can try a few fancy locking tricks. But, we don't know whether
such tricks will help.

> i_shared_lock changed to i_shared_sem to allow that cond_resched_lock
> in unmap_vmas to solve vmtruncate latency problems?  With i_mmap and
> i_mmap_shared as lists, isn't it easy to insert a dummy marker vma
> and drop the lock if we need resched?  Resuming from marker after.
>
> But, sadly, I doubt that can be done with the prio tree: Rajesh?

Yeap. With prio_tree it is tricky. We already have the marker for
prio_tree, i.e., prio_tree_iter. But, when you drop a lock new tree
nodes may be added to the prio_tree, and the marker does not provide
any consistent meaning after the node additions.

Rajesh

