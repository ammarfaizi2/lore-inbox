Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbUCMTkT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbUCMTkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:40:19 -0500
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:23433 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S263181AbUCMTkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:40:15 -0500
Date: Sat, 13 Mar 2004 14:40:09 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@blue.engin.umich.edu
To: Andrea Arcangeli <andrea@suse.de>
cc: riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: anon_vma RFC2
In-Reply-To: <20040313181606.GO30940@dualathlon.random>
Message-ID: <Pine.GSO.4.58.0403131426590.12823@blue.engin.umich.edu>
References: <20040310080000.GA30940@dualathlon.random>
 <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com>
 <20040310135012.GM30940@dualathlon.random> <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu>
 <20040312172600.GC30940@dualathlon.random> <Pine.GSO.4.58.0403121548530.2624@sapphire.engin.umich.edu>
 <Pine.LNX.4.58.0403131246580.28574@ruby.engin.umich.edu>
 <20040313181606.GO30940@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> prio_tree can only sit on top of anon_vma, not on top of
> anonmm+linus-unshare-mremap (and yes, I cannot share
> vma.shared.prio_tree_node) but pratically it's not needed for the
> anon_vmas.

Agreed. prio_tree is only useful for anon_vma. But, after
linus-unshare-mremap, the anon_vma patch can be modified
(simplified ?) a lot. You don't need any as.anon_vma, as.vma
pointers in the page struct. You just need the already existing
page->mapping and page->index, and a prio_tree of all anon vmas.
The prio_tree can be used to get to the "interesting vmas" without
walking all mms. However, the new prio_tree node adds 16 bytes
per-vma. Considering there may not be much sharing of anon vmas
in common case, I am not sure whether that is worthwhile. Maybe
we can wait for someone to write a program that locks the machine :)

Rajesh


