Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318743AbSIFPjx>; Fri, 6 Sep 2002 11:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318746AbSIFPjw>; Fri, 6 Sep 2002 11:39:52 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:31648 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S318743AbSIFPjo>;
	Fri, 6 Sep 2002 11:39:44 -0400
Message-ID: <3D78CD5D.9060002@colorfullife.com>
Date: Fri, 06 Sep 2002 17:44:29 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Imran Badr" <imran.badr@cavium.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> adr = user_address;
> pgd_offset(current->mm, adr);
> 
> if (!pgd_none(*pgd)) {
> 	pmd = pmd_offset(pgd, adr);
> 	if (!pmd_none(*pmd)) {
> 		ptep = pte_offset(pmd, adr);
> 		pte = *ptep;
> 		if(pte_present(pte)) {
> 			kaddr  = (unsigned long) page_address(pte_page(pte));
> 			kaddr |= (adr & (PAGE_SIZE - 1));
> 		}
> 	}
> }
> 
> Will this code always give me correct kernel logical address?
> 
What about

	kmalloc_buffer+(user_address-vma->vm_start)

?
A driver should avoid accessing the page tables.

--
	Manfred

