Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319259AbSIFRLJ>; Fri, 6 Sep 2002 13:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319261AbSIFRLI>; Fri, 6 Sep 2002 13:11:08 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:62918 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S319259AbSIFRLG>; Fri, 6 Sep 2002 13:11:06 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Manfred Spraul'" <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Calculating kernel logical address ..
Date: Fri, 6 Sep 2002 10:13:36 -0700
Message-ID: <00e901c255c8$bd144e80$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3D78CD5D.9060002@colorfullife.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Manfred Spraul [mailto:manfred@colorfullife.com]
Sent: Friday, September 06, 2002 8:44 AM
To: Imran Badr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..


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

I was wondering if the code which I am using, will always give me addresses
no matter whether HIGHMEM is defined in kernel configuration or not. I
belive that it should not be problem because I am mmap'ing kmalloc'ed memory
which always returns mapped memory. But whats happeing in my lab is
different. If I define HIGHMEM in kernel configuration and install 2GB of
memory in my server then I see a crash in the kernel where I try to access
kaddr calculated bu above code. Any idea?

The problem with your suggestion is that at the point where user gives me an
address for DMA, I do not know what kmalloc_buffer and vma->vm_start values
are. Also, if there are more than one processes accessing the driver, then
how am I going to keep track of all mmap'ed memory.

Thanks,
Imran.





