Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUCVPxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUCVPxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:53:07 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:1980 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262070AbUCVPxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:53:03 -0500
Date: Mon, 22 Mar 2004 07:53:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <1684742704.1079970781@[10.10.2.4]>
In-Reply-To: <20040321235207.GC3649@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2924080000.1079886632@[10.10.2.4]> <20040321235207.GC3649@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I tried the aa3 equiv of the above, just on top of virgin 2.6.5-rc1, but 
>> it doesn't work cleanly. Your whole aa3 tree runs nicely, but I'd prefer
>> to have the broken out patch before publishing comparisons, as otherwise
>> it's a bit unfair ;-) I'm not sure if the results come from your anon_vma
>> approach, or other patches in your tree ...
>> 
>> I'm presuming you shifted the cost of find_get_page into find_trylock_page
>> and pgd_ctor into pgd_alloc from the profiles below ...
> 
> I cannot see how can find_trylock_page be affected by my anon_vma
> changes. The only difference I can see is taht Andrew's -mm writeback
> code is adding the _irq to the spinlocks there and I don't see other
> obvious changes in that function. I included all -mm writeback changes
> primarly to avoid me to maintain two slightly different versions of
> anon_vma and secondly to nuke the page->list. Other trees I'm dealing
> with daily have those applied already.  At the very least that
> additional cost that you measured cannot be associated in any way with
> the allocation and maintainace of the anon_vma, since that
> find_trylock_page cost is a per-page pagecache thing absolutely
> unrelated to the anon_vmas costs.
> 
> It's probably best that I port my version of objrmap (basically the same
> as yours but with the shm swapout fixes) + anon_vma to your tree, it's
> not a big effort to do the porting once, I applied Andrew's patches
> primarly to avoid porting back and forth all the time.
> 
> Just tell me which is exactly the codebase I should port against and
> I'll send you a patch shortly.

Just against 2.6.5-rc1 virgin is easiest - that's what I was doing the
rest of it against ...

Thanks,

M.

