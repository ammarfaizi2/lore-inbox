Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbUDLTiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUDLTiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 15:38:14 -0400
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:38865 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S263058AbUDLTiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 15:38:10 -0400
Date: Mon, 12 Apr 2004 15:38:01 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@red.engin.umich.edu
To: Hugh Dickins <hugh@veritas.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Apr 2004, Hugh Dickins wrote:
> On Mon, 12 Apr 2004, Martin J. Bligh wrote:
> >
> > If it were just a list, maybe RCU would be appropriate. It might be
> > rather write-heavy though ? I think I played with an rwsem instead
> > of a sem in the past too (though be careful if you try this, as for
> > no good reason the return codes are inverted ;-()
>
> Yes, I think all the common paths have to write, in case the
> uncommon paths (truncation and swapout) want to read: the wrong
> way round for any kind of read-write optimization, isn't it?

In common workloads e.g., add libc mapping using  __vma_prio_tree_insert,
mostly you do not add new nodes to the tree. Instead, you just add to
a vm_set list. I am currently considering using rwsem to optimize
such cases. Similarly __vma_prio_tree_remove can also be optimized
in some common cases. I don't know whether it will help. Let us see...

Rajesh



