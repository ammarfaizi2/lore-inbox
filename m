Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbUKOVnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUKOVnV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUKOVnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:43:21 -0500
Received: from almesberger.net ([63.105.73.238]:5900 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261414AbUKOVmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:42:51 -0500
Date: Mon, 15 Nov 2004 18:42:40 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generalize prio_tree (1/3)
Message-ID: <20041115184240.Y28802@almesberger.net>
References: <20041114235646.K28802@almesberger.net> <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu> <20041115175415.X28802@almesberger.net> <Pine.LNX.4.58.0411151559070.30860@red.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411151559070.30860@red.engin.umich.edu>; from vrajesh@umich.edu on Mon, Nov 15, 2004 at 04:14:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian wrote:
> I thought about this, but this will lead to a very intrusive patch.

Possibly yes, unfortunately :-( All places where a node's keys change
would have to be updated, yes. Are there cases where vm_pgoff,
vm_start, or vm_end can change without doing a prio_tree_insert or
vma_prio_tree_insert afterwards ? If not, the key update could just
be moved into vma_prio_tree_insert and vma_prio_tree_add.

> We have to change the meaning of vm_start and vm_end or increase
> the size of vm_area_struct.

Nope :-) We already have space for adding one more long, i.e. h_index.
So all we need to do it to calculate and set it before going to
prio_tree.

For r_index, one can use what I've described in the last mail.

> I am only worried about the micro-performance loss due to
> get_index in the hot-paths such as vma_prio_tree_insert.

Yes, it starts to look fairly heavy for what it does ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
