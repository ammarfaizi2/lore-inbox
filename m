Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318258AbSIFDbb>; Thu, 5 Sep 2002 23:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318259AbSIFDbb>; Thu, 5 Sep 2002 23:31:31 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:22179 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S318258AbSIFDbb>; Thu, 5 Sep 2002 23:31:31 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: <linux-kernel@vger.kernel.org>
Subject: Calculating kernel logical address ..
Date: Thu, 5 Sep 2002 20:34:07 -0700
Message-ID: <00d301c25556$4290f5e0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E17n9im-0006Ef-00@starship>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need help to correctly calculate kernel logical address for a user pointer
which I mmaped from device driver. In mmap() file operation, I allocate some
memory using kmalloc() and call :

remap_page_range(vma->vm_start,
virt_to_phys((void *)(Uint32)kmalloc_buffer),
size,
PAGE_SHARED);

after reserving all pages and doing some other stuff. Now when I get a user
pointer and I need to calculate correspoding kernel logical address, I use
following code:

adr = user_address;
pgd_offset(current->mm, adr);

if (!pgd_none(*pgd)) {
	pmd = pmd_offset(pgd, adr);
	if (!pmd_none(*pmd)) {
		ptep = pte_offset(pmd, adr);
		pte = *ptep;
		if(pte_present(pte)) {
			kaddr  = (unsigned long) page_address(pte_page(pte));
			kaddr |= (adr & (PAGE_SIZE - 1));
		}
	}
}

Will this code always give me correct kernel logical address?

I will really appreciate any guidance.

Thanks,
Imran.


