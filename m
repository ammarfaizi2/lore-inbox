Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQJ3VkL>; Mon, 30 Oct 2000 16:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbQJ3VkB>; Mon, 30 Oct 2000 16:40:01 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:23112 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129187AbQJ3Vjq>;
	Mon, 30 Oct 2000 16:39:46 -0500
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200010302139.NAA97387@google.engr.sgi.com>
Subject: Re: [PATCH] 2.4.0-test10-pre6  TLB flush race in establish_pte
To: slpratt@us.ibm.com (Steve Pratt/Austin/IBM)
Date: Mon, 30 Oct 2000 13:39:31 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, linux-mm@kvack.org
In-Reply-To: <OFB4731A18.0D8D8BC1-ON85256988.0074562B@raleigh.ibm.com> from "Steve Pratt/Austin/IBM" at Oct 30, 2000 03:31:22 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> So while there may be a more elegant solution down the road, I would like
> to see the simple fix put back into 2.4.  Here is the patch to essential
> put the code back to the way it was before the S/390 merge.  Patch is
> against 2.4.0-test10pre6.
> 
> --- linux/mm/memory.c    Fri Oct 27 15:26:14 2000
> +++ linux-2.4.0-test10patch/mm/memory.c  Fri Oct 27 15:45:54 2000
> @@ -781,8 +781,8 @@
>   */
>  static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
>  {
> -    flush_tlb_page(vma, address);
>      set_pte(page_table, entry);
> +    flush_tlb_page(vma, address);
>      update_mmu_cache(vma, address, entry);
>  }
>

Great, lets do it. Definitely solves one race. 

Kanoj 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
