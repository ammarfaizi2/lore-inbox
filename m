Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbUCNApX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbUCNApX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:45:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:51886 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263233AbUCNApS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:45:18 -0500
Date: Sat, 13 Mar 2004 16:52:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
In-Reply-To: <20040314002348.GQ30940@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0403131647000.900@ppc970.osdl.org>
References: <20040310080000.GA30940@dualathlon.random>
 <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com>
 <20040310135012.GM30940@dualathlon.random> <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu>
 <20040312172600.GC30940@dualathlon.random> <Pine.GSO.4.58.0403121548530.2624@sapphire.engin.umich.edu>
 <Pine.LNX.4.58.0403131246580.28574@ruby.engin.umich.edu>
 <20040313181606.GO30940@dualathlon.random> <Pine.GSO.4.58.0403131426590.12823@blue.engin.umich.edu>
 <20040314002348.GQ30940@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Mar 2004, Andrea Arcangeli wrote:
>
> linus-unshare-mremap guarantees that a certain physical page will be
> only at a certain virtual address in every mm, so prio_tree taking pgoff
> into account isn't needed there, find_vma is more than enough.

Yes. However, I'd at least personally hope that we don't even need the 
find_vma() all the time.

When removing a page using the reverse mapping, there really is very
little reason to even look up the vma, although right now the
"flush_tlb_page()" interface is done for vma only so we'd need to change 
that or at least add a "flush_tlb_page_mm(mm, virt)" flusher (and if any 
architecture wants to look up the vma, they could do so).

It would be silly to look up the vma if we don't actually need it, and I
don't think we do. It's likely faster to just look up the page tables
directly than to even worry about anything else.

But find_vma() certainly would be sufficient.

		Linus
