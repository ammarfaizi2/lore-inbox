Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSKLBCE>; Mon, 11 Nov 2002 20:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265755AbSKLBCD>; Mon, 11 Nov 2002 20:02:03 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:50631 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S265736AbSKLBCD>; Mon, 11 Nov 2002 20:02:03 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200211120108.CAA05101@faui11.informatik.uni-erlangen.de>
Subject: Re: [PATCH] flush_cache_page while pte valid
To: manfred@colorfullife.com
Date: Tue, 12 Nov 2002 02:08:46 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, uweigand@de.ibm.com, schwidefsky@de.ibm.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

>Is it correct that this are 3 arch hooks that must appear back to back?
>What about one hook with all parameters?
>
>        pte = ptep_get_and_clear_and_flush(ptep, vma, address);

This interface would help us on s390 very much.  We have a hardware
instruction (INVALIDATE PAGE TABLE ENTRY) that implements the combination 
of 
        pte = ptep_get_and_clear(ptep);
        flush_tlb_page(vma, address);

very efficiently, but we cannot use it to implement flush_tlb_page
alone, because it requires the pte to be valid.

This is why our current in-tree flush_tlb_page is quite inefficient
(it always flushes the complete TLB) ...

If we had a combined hook, we could use our IPTE instruction.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
