Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268291AbTBYRz0>; Tue, 25 Feb 2003 12:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268293AbTBYRz0>; Tue, 25 Feb 2003 12:55:26 -0500
Received: from holomorphy.com ([66.224.33.161]:64438 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268291AbTBYRzZ>;
	Tue, 25 Feb 2003 12:55:25 -0500
Date: Tue, 25 Feb 2003 10:04:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225180438.GC10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
	linux-kernel@vger.kernel.org
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random> <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225175928.GP29467@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 09:43:59AM -0800, William Lee Irwin III wrote:
>> The pagetable cache is gone in 2.5, so pte_alloc_one() takes the
>> bitblitting hit for pagetables.

On Tue, Feb 25, 2003 at 06:59:28PM +0100, Andrea Arcangeli wrote:
> I'm talking about do_anonymous_page, do_wp_page, do_no_page fork and all
> the other places that introduces spinlocks (per-page) and allocations of
> 2 pieces of ram rather than just 1 (and in turn potentially global
> spinlocks too if the cpu-caches are empty). Just grep for
> pte_chain_alloc or page_add_rmap in mm/memory.c, that's what I mean, I'm
> not talking about pagetables.

Well, pte_alloc_one() has a clear explanation.

The fact that the rmap accounting is not free is not news.

For anonymous pages performing the analogous vma-based lookup as with
Dave McCracken's patch for file-backed pages would require a
significant anonymous page accounting rework.


-- wli
