Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265066AbTLZKIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 05:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbTLZKIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 05:08:17 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:8867 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265066AbTLZKIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 05:08:16 -0500
Subject: Re: Page aging broken in 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>
In-Reply-To: <20031226093356.A8980@flint.arm.linux.org.uk>
References: <1072423739.15458.62.camel@gaston>
	 <20031225234023.20396cbc.akpm@osdl.org>
	 <20031226093356.A8980@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1072433251.15477.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Dec 2003 21:07:32 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ARM would strictly need the flush as well.  I seem to vaguely remember,
> however, that when this code went in there was some discussion about
> this very topic, and it was decided that the flush was not critical.
> 
> Indeed, 2.4 seems to have the same logic concerning not flushing the
> PTE:
> 
>         /* Don't look at this pte if it's been accessed recently. */
>         if ((vma->vm_flags & VM_LOCKED) || ptep_test_and_clear_young(page_table)) {
>                 mark_page_accessed(page);
>                 return 0;
>         }

I can imagine that an architecture with TLBs will usually evict
the entry from the TLB sooner or later and the accessed bit will end
up beeing set again. On PPC, that isn't the case, the entry can well
stay a loooong time in the hash and if not evicted, _PAGE_ACCESSED
will never be set again.

Ben.


