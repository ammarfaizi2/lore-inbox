Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319450AbSIGHF4>; Sat, 7 Sep 2002 03:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319448AbSIGHF4>; Sat, 7 Sep 2002 03:05:56 -0400
Received: from dsl-213-023-021-052.arcor-ip.net ([213.23.21.52]:7094 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319447AbSIGHFy>;
	Sat, 7 Sep 2002 03:05:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: <imran.badr@cavium.com>, "'Manfred Spraul'" <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Calculating kernel logical address ..
Date: Sat, 7 Sep 2002 03:57:20 +0200
X-Mailer: KMail [version 1.3.2]
References: <00e901c255c8$bd144e80$9e10a8c0@IMRANPC>
In-Reply-To: <00e901c255c8$bd144e80$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17nUqf-0006Lk-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 September 2002 19:13, Imran Badr wrote:
> > adr = user_address;
> > pgd_offset(current->mm, adr);
> >
> > if (!pgd_none(*pgd)) {
> > 	pmd = pmd_offset(pgd, adr);
> > 	if (!pmd_none(*pmd)) {
> > 		ptep = pte_offset(pmd, adr);
> > 		pte = *ptep;
> > 		if(pte_present(pte)) {
> > 			kaddr  = (unsigned long) page_address(pte_page(pte));
> > 			kaddr |= (adr & (PAGE_SIZE - 1));
> > 		}
> > 	}
> > }
> >
> > Will this code always give me correct kernel logical address?
> 
> I was wondering if the code which I am using, will always give me addresses
> no matter whether HIGHMEM is defined in kernel configuration or not.

On second thought, this code does have problems with highmem.  The page in
question was never kmapped, so no kernel address was assigned if the page
was a high memory page.  Besides that, there are other other changes to
page address that imply it can't be used with a high memory page.  So the
above code isn't generic.

> I
> belive that it should not be problem because I am mmap'ing kmalloc'ed memory
> which always returns mapped memory. But whats happeing in my lab is
> different. If I define HIGHMEM in kernel configuration and install 2GB of
> memory in my server then I see a crash in the kernel where I try to access
> kaddr calculated bu above code. Any idea?

Because of what I just said.

> The problem with your suggestion is that at the point where user gives me an
> address for DMA, I do not know what kmalloc_buffer and vma->vm_start values
> are. Also, if there are more than one processes accessing the driver, then
> how am I going to keep track of all mmap'ed memory.

-- 
Daniel
