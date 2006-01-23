Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWAWXw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWAWXw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAWXw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:52:57 -0500
Received: from holomorphy.com ([66.93.40.71]:44013 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S932423AbWAWXw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:52:56 -0500
Date: Mon, 23 Jan 2006 15:52:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Don Dupuis <dondster@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Adam Litke <agl@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't mlock hugetlb in 2.6.15
Message-ID: <20060123235234.GB7655@holomorphy.com>
References: <632b79000601181149o67f1c013jfecc5e32ee17fe7e@mail.gmail.com> <20060120235240.39d34279.akpm@osdl.org> <43D24167.1010007@yahoo.com.au> <632b79000601221832w4cb44582y823ee7dc80e9a34f@mail.gmail.com> <Pine.LNX.4.61.0601231917210.5915@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601231917210.5915@goblin.wat.veritas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 07:51:51PM +0000, Hugh Dickins wrote:
> This has nothing to do with mlock or MAP_LOCKED - which by the way do
> make more sense in 2.6.15, since they provide a way of prefaulting the
> hugepage area like in earlier releases (now hugepages are being faulted
> in on demand, though never paged out, as Andrew said).
> Please try the patch below, and let us know if it works for you - thanks.
> Looks like we'll need this in 2.6.16-rc-git and 2.6.15-stable.
> 2.6.15's hugepage faulting introduced huge_pages_needed accounting into
> hugetlbfs: to count how many pages are already in cache, for spot check
> on how far a new mapping may be allowed to extend the file.  But it's
> muddled: each hugepage found covers HPAGE_SIZE, not PAGE_SIZE.  Once
> pages were already in cache, it would overshoot, wrap its hugepages
> count backwards, and so fail a harmless repeat mapping with -ENOMEM.
> Fixes the problem found by Don Dupuis.
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

Acked-by: William Irwin <wli@holomorphy.com>

A unit conversion error, as usual. It's difficult to understand why
such a natural decision as to use only one radix tree entry per
hugepage is so difficult to cope with. If only my eyes had been sharp
enough to catch it on its way in.

Excellent detective work as always. Thanks again, Hugh.


-- wli
