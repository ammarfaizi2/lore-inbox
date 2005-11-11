Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVKKAKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVKKAKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVKKAKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:10:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24844 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932262AbVKKAKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:10:50 -0500
Date: Fri, 11 Nov 2005 00:10:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-ID: <20051111001044.GD28700@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
	mingo@elte.hu, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com> <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com> <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu> <Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com> <20051110045144.40751a42.akpm@osdl.org> <Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com> <20051110114950.03a5946b.akpm@osdl.org> <Pine.LNX.4.64.0511101155160.4627@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511101155160.4627@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 11:56:52AM -0800, Linus Torvalds wrote:
> On Thu, 10 Nov 2005, Andrew Morton wrote:
> > 
> > IOW we're assuming that no 32-bit architectures will obtain pagetables from
> > slab?
> 
> I thought ARM does?

ARM26 does.  On ARM, we play some games to weld to page tables together.
(We also duplicate them to give us a level of independence from the MMU
architecture and to give us space for things like young and dirty bits.)

As far as Linux is concerned, a 2nd level page table is one struct page
and L1 entries are two words in size.

I wrote up some docs on this and threw them into a comment in
include/asm-arm/pgtable.h...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
