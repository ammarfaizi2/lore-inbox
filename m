Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269728AbSISBr2>; Wed, 18 Sep 2002 21:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269729AbSISBr2>; Wed, 18 Sep 2002 21:47:28 -0400
Received: from f211.pav1.hotmail.com ([64.4.31.211]:43530 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S269728AbSISBr1>;
	Wed, 18 Sep 2002 21:47:27 -0400
X-Originating-IP: [12.9.24.195]
From: "Mehdi Hashemian" <mhashemian@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PTE question
Date: Wed, 18 Sep 2002 18:52:25 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F211Jl1MSc0Xd4zf8Mt00016176@hotmail.com>
X-OriginalArrivalTime: 19 Sep 2002 01:52:25.0846 (UTC) FILETIME=[340BA960:01C25F7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

