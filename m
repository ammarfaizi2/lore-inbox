Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbUKPAHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbUKPAHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 19:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUKPAHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 19:07:54 -0500
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:40170 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261683AbUKPAHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 19:07:46 -0500
Date: Mon, 15 Nov 2004 19:07:39 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@lazuli.engin.umich.edu
To: Werner Almesberger <werner@almesberger.net>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generalize prio_tree (1/3)
In-Reply-To: <20041115195946.Z28802@almesberger.net>
Message-ID: <Pine.GSO.4.58.0411151814440.6691@lazuli.engin.umich.edu>
References: <20041114235646.K28802@almesberger.net>
 <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu>
 <20041115175415.X28802@almesberger.net> <Pine.LNX.4.58.0411151559070.30860@red.engin.umich.edu>
 <20041115184240.Y28802@almesberger.net> <Pine.GSO.4.58.0411151705260.6691@lazuli.engin.umich.edu>
 <20041115195946.Z28802@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Nov 2004, Werner Almesberger wrote:
> > If we impose that there can be only 2 types of prio_tree, then
> > we can simply add an if-else condition in the GET_INDEX macro.
> > IMHO, that will not lead to any noticeable performance drop.
>
> Yes, that sounds better. It would also allow for a later transition
> of VMA_PRIO_TREE to GENERIC_PRIO_TREE.

Yeap. That will be my preference. Make a small patch to generalize
prio_tree using the split VMA_PRIO_TREE and GENERIC_PRIO_TREE. A small
patch has a better chance of getting merged too. Giving a strong
reason for the generalization and showing that the VMA_PRIO_TREE
and GENERIC_PRIO_TREE split does not affect performance noticeably,
we can hope to convince Andrew to merge. We can worry about
changing vm_area_struct's layout later.

> Now, if we want to prepare things already now for a later migration,
> it would be nice to call the generic one "struct prio_tree_node",
> since it would eventually become the only node type anyway.
>
> Perhaps something along these lines:
>
> struct prio_tree_node {
> 	struct vma_prio_tree_node prio_tree_node;
> 	unsigned long r_index, h_index;
> };
>
> Or would you consider this as premature optimization ?

Yeap. That looks sane. However, if you are planning to produce
a patch, please consider the following names:

	struct prio_tree_node {
		unsigned long start, end;
		struct raw_prio_tree_node prio_tree_node;
	};

I think the r_index and h_index names are only meaningful in
prio_tree.c. My guess is start and end will be more palatable
to users of prio_tree.

Thank you,
Rajesh
