Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVC3QbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVC3QbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 11:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVC3QbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 11:31:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19156 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261917AbVC3QbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 11:31:05 -0500
Date: Wed, 30 Mar 2005 17:30:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
In-Reply-To: <20050326155254.E12809@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0503301717410.21413@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> 
    <20050325212234.F12715@flint.arm.linux.org.uk> 
    <4244C3B7.4020409@yahoo.com.au> 
    <20050326113530.A12809@flint.arm.linux.org.uk> 
    <424566E0.80001@yahoo.com.au> 
    <20050326155254.E12809@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Russell King wrote:
> 
> I don't think it'll be invasive to push my get_pgd_slow() fix before
> these freepgt patches appear.  For the record, this is the patch I'm
> using at present.  With a bit more effort, I could probably eliminate
> pmd_alloc (and therefore the unnecessary spinlocking) here.

Your get_pgd_slow patch looks good to me.  Yes, it slightly increases
the assumptions here about what is done in common, to the extent of a
pmd_populate, but even the nr_page_table_pages adjustment just nicely
balances what you were already having to do in free_pgd_slow.

Sorry for dumping you suddenly into this with my BUG_ON(mm->nr_ptes),
but I think we all agree it's a worthwhile check now.  And sorry for
being so slow to respond, but I needed to think through what's right
for your case.

I'll write separately about Nick's FIRST_USER_ADDRESS patch,
I'm still puzzled, and not quite happy with that one.

Hugh
