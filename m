Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUCUXvW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUCUXvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:51:22 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10890
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261498AbUCUXvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:51:15 -0500
Date: Mon, 22 Mar 2004 00:52:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040321235207.GC3649@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2924080000.1079886632@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2924080000.1079886632@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 08:30:34AM -0800, Martin J. Bligh wrote:
> >> Mmmm, if you have a broken out patch, it'd be preferable. If I were to 
> >> apply the whole of -mjb, I'll get a damned sight better results than 
> >> any of them, but that's not really a fair comparison ;-) I'll can at 
> >> least check it's stable for me that way though. 
> >> 
> >> I did find your broken-out anon-vma patch, but it's against something
> >> else, maybe half-way up your tree or something, and I didn't bother
> >> trying to fix it ;-)
> > 
> > this one is against mainline, but you must use my objrmap patch too
> > which is fixed so it doesn't crash in 2.6.5-rc1.
> > 
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa2/00100_objrmap-core-1.gz
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa2/00101_anon_vma-2.gz
> > 
> > just backout your objrmap and apply the above two, it should apply
> > pretty well.
> 
> I tried the aa3 equiv of the above, just on top of virgin 2.6.5-rc1, but 
> it doesn't work cleanly. Your whole aa3 tree runs nicely, but I'd prefer
> to have the broken out patch before publishing comparisons, as otherwise
> it's a bit unfair ;-) I'm not sure if the results come from your anon_vma
> approach, or other patches in your tree ...
> 
> I'm presuming you shifted the cost of find_get_page into find_trylock_page
> and pgd_ctor into pgd_alloc from the profiles below ...

I cannot see how can find_trylock_page be affected by my anon_vma
changes. The only difference I can see is taht Andrew's -mm writeback
code is adding the _irq to the spinlocks there and I don't see other
obvious changes in that function. I included all -mm writeback changes
primarly to avoid me to maintain two slightly different versions of
anon_vma and secondly to nuke the page->list. Other trees I'm dealing
with daily have those applied already.  At the very least that
additional cost that you measured cannot be associated in any way with
the allocation and maintainace of the anon_vma, since that
find_trylock_page cost is a per-page pagecache thing absolutely
unrelated to the anon_vmas costs.

It's probably best that I port my version of objrmap (basically the same
as yours but with the shm swapout fixes) + anon_vma to your tree, it's
not a big effort to do the porting once, I applied Andrew's patches
primarly to avoid porting back and forth all the time.

Just tell me which is exactly the codebase I should port against and
I'll send you a patch shortly.

Thanks!
