Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVKQVBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVKQVBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVKQVBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:01:15 -0500
Received: from holomorphy.com ([66.93.40.71]:18621 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S964862AbVKQVBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:01:14 -0500
Date: Thu, 17 Nov 2005 12:59:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Mackerras <paulus@samba.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] unpaged: VM_UNPAGED
Message-ID: <20051117205928.GL6916@holomorphy.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com> <Pine.LNX.4.61.0511171932440.4563@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511171932440.4563@goblin.wat.veritas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 07:34:55PM +0000, Hugh Dickins wrote:
> Although we tend to associate VM_RESERVED with remap_pfn_range, quite a
> few drivers set VM_RESERVED on areas which are then populated by nopage.
> The PageReserved removal in 2.6.15-rc1 changed VM_RESERVED not to free
> pages in zap_pte_range, without changing those drivers not to set it:
> so their pages just leak away.
> Let's not change miscellaneous drivers now: introduce VM_UNPAGED at the
> core, to flag the special areas where the ptes may have no struct page,
> or if they have then it's not to be touched.  Replace most instances of
> VM_RESERVED in core mm by VM_UNPAGED.  Force it on in remap_pfn_range,
> and the sparc and sparc64 io_remap_pfn_range.
> Revert addition of VM_RESERVED to powerpc vdso, it's not needed there.
> Is it needed anywhere?  It still governs the mm->reserved_vm statistic,
> and special vmas not to be merged, and areas not to be core dumped; but
> could probably be eliminated later (the drivers are probably specifying
> it because in 2.4 it kept swapout off the vma, but in 2.6 we work from
> the LRU, which these pages don't get on).

Eminently reasonable. This solves a lot of problems.
Acked-by: William Irwin <wli@holomorphy.com>


-- wli
