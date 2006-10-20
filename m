Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946452AbWJTPtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946452AbWJTPtz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946390AbWJTPtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:49:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4994 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932253AbWJTPtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:49:53 -0400
Date: Fri, 20 Oct 2006 08:49:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: David Miller <davem@davemloft.net>, ralf@linux-mips.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <4538DFAC.1090206@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
References: <1161275748231-git-send-email-ralf@linux-mips.org>
 <4537B9FB.7050303@yahoo.com.au> <20061019181346.GA5421@linux-mips.org>
 <20061019.155939.48528489.davem@davemloft.net> <4538DFAC.1090206@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Oct 2006, Nick Piggin wrote:
> 
> So moving the flush_cache_mm below the copy_page_range, to just
> before the flush_tlb_mm, would work then? This would make the
> race much smaller than with this patchset.
> 
> But doesn't that still leave a race?
> 
> What if another thread writes to cache after we have flushed it
> but before flushing the TLBs? Although we've marked the the ptes
> readonly, the CPU won't trap if the TLB is valid? There must be
> some special way for the arch to handle this, but I can't see it.

Why not do the cache flush _after_ the TLB flush? There's still a mapping, 
and never mind that it's read-only: the _mapping_ still exists, and I 
doubt any CPU will not do the writeback (the readonly bit had better 
affect the _frontend_ of the memory pipeline, but affectign the back end 
would be insane and very hard, since you can't raise a fault any more).

Hmm?

		Linus
