Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSKKVNw>; Mon, 11 Nov 2002 16:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261372AbSKKVNw>; Mon, 11 Nov 2002 16:13:52 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:8103 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261371AbSKKVNw>;
	Mon, 11 Nov 2002 16:13:52 -0500
Message-ID: <3DD01F1E.2040705@colorfullife.com>
Date: Mon, 11 Nov 2002 22:20:30 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flush_cache_page while pte valid
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	/* Nuke the page table entry. */
>+	flush_cache_page(vma, address);
> 	pte = ptep_get_and_clear(ptep);
> 	flush_tlb_page(vma, address);
>-	flush_cache_page(vma, address);
> 

Is it correct that this are 3 arch hooks that must appear back to back?
What about one hook with all parameters?

	pte = ptep_get_and_clear_and_flush(ptep, vma, address);

The current implementation just asks for such errors.

Documentation:
ptep_get_and_clear_and_flush() removes the page table entry *ptep from the page tables and clears all caches (tlb, cpu cache if virtually tagged).
The return value contains the final value of the pte. The critical information is the dirty bit in the pte - on SMP one cpu can call ptep_get_and_clear_and_flush() while another cpu accesses the mmap'ing from user space.


--
	Manfred


