Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263456AbSITUEb>; Fri, 20 Sep 2002 16:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263457AbSITUEb>; Fri, 20 Sep 2002 16:04:31 -0400
Received: from f4.pav1.hotmail.com ([64.4.31.4]:21011 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263456AbSITUE2>;
	Fri, 20 Sep 2002 16:04:28 -0400
X-Originating-IP: [12.9.24.195]
From: "Mehdi Hashemian" <mhashemian@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: PTE question
Date: Fri, 20 Sep 2002 13:09:25 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F4VcxjXHzfAbPM1EhXT000004c5@hotmail.com>
X-OriginalArrivalTime: 20 Sep 2002 20:09:26.0255 (UTC) FILETIME=[9E7AC7F0:01C260E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As I did not receive any response for the following question, I appreciate 
if someone guide me to the right email list to post this question, if there 
is any.

Appreciate it,
Mehdi

----Original Message Follows----
From: "Mehdi Hashemian" <mhashemian@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PTE question
Date: Wed, 18 Sep 2002 18:52:25 -0700

Hello,

Appreciate if someone checks this piece of code. I try to diable cache and 
write-through bits in PTE but somehow PTE address is within first 16MB of 
memory (DMA_ZONE) and later when Kernel tries to allocate more pages, it 
chooses the same address range and this piece of code corrupts memory by 
ORing these bits. Any help appreciated!

    {
        addr = __get_dma_pages(priority, order);

        int npages = __get_npages(order);
	unsigned long addr2 = addr;
	pgd_t *pgd;
	pmd_t *pmd;
	pte_t *pte;
	int i;

	for (i = 0; i < npages; i++)
	{
	    pgd = pgd_offset(&init_mm, addr2);
	    pmd = pmd_offset(pgd, addr2);
	    pte = pte_offset(pmd, addr2);
	    pte_val(*pte) |= (_PAGE_PCD | _PAGE_PWT);

	    addr2 += PAGE_SIZE;
	}
	__flush_tlb_all();
    }

Mehdi

_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

