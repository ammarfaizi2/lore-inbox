Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWASOuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWASOuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWASOuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:50:18 -0500
Received: from mx1.suse.de ([195.135.220.2]:63882 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161196AbWASOuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:50:16 -0500
Date: Thu, 19 Jan 2006 15:50:08 +0100
From: Nick Piggin <npiggin@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       David Miller <davem@davemloft.net>
Subject: Re: [patch 3/3] mm: PageActive no testset
Message-ID: <20060119145008.GA20126@wotan.suse.de>
References: <20060118024106.10241.69438.sendpatchset@linux.site> <20060118024139.10241.73020.sendpatchset@linux.site> <20060118141346.GB7048@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118141346.GB7048@dmt.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Wed, Jan 18, 2006 at 12:13:46PM -0200, Marcelo Tosatti wrote:
> Hi Nick,
> 
> On Wed, Jan 18, 2006 at 11:40:58AM +0100, Nick Piggin wrote:
> > PG_active is protected by zone->lru_lock, it does not need TestSet/TestClear
> > operations.
> 
> page->flags bits (including PG_active and PG_lru bits) are touched by
> several codepaths which do not hold zone->lru_lock. 
> 
> AFAICT zone->lru_lock guards access to the LRU list, and no more than
> that.
> 

Yep.

> Moreover, what about consistency of the rest of page->flags bits?
> 

That's OK, set_bit and clear_bit are atomic as well, they just don't
imply memory barriers and can be implemented a bit more simply.

The test-set / test-clear operations also kind of imply that it is
being used for locking or without other synchronisation (usually).

> PPC for example implements test_and_set_bit() with:
> 
> 	lwarx	reg, addr   (load and create reservation for 32-bit addr)
> 	or 	reg, BITOP_MASK(nr)	
> 	stwcx	reg, addr  (store word upon reservation validation, otherwise loop)
> 

Thanks,
Nick
