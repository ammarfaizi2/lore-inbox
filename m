Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUHISqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUHISqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266863AbUHISqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:46:33 -0400
Received: from fmr12.intel.com ([134.134.136.15]:55514 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S266845AbUHISpD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:45:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Hugetlb demanding paging for -mm tree
Date: Mon, 9 Aug 2004 11:43:32 -0700
Message-ID: <01EF044AAEE12F4BAAD955CB7506494302005232@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hugetlb demanding paging for -mm tree
Thread-Index: AcR7+XF2ZTVnVwEMSpOlhuzmrE2wFACOoLFAAAL0TyA=
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Hirokazu Takahashi" <taka@valinux.co.jp>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 09 Aug 2004 18:43:35.0261 (UTC) FILETIME=[C6DD38D0:01C47E40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W <mailto:kenneth.w.chen@intel.com> wrote on Monday,
August 09, 2004 11:19 AM:

> William Lee Irwin III wrote on Friday, August 06, 2004 2:08 PM
>> On Fri, Aug 06, 2004 at 01:55:38PM -0700, Chen, Kenneth W wrote:
>>> diff -Nurp linux-2.6.7/mm/hugetlb.c linux-2.6.7.hugetlb/mm/hugetlb.c
>>> --- linux-2.6.7/mm/hugetlb.c	2004-08-06 11:44:59.000000000
-0700
>>> +++ linux-2.6.7.hugetlb/mm/hugetlb.c	2004-08-06
13:15:24.000000000
>>>  	-0700 @@ -276,9 +276,10 @@ retry: }
>>> 
>>>  	spin_lock(&mm->page_table_lock);
>>> -	if (pte_none(*pte))
>>> +	if (pte_none(*pte)) {
>>>  		set_huge_pte(mm, vma, page, pte, vma->vm_flags &
VM_WRITE);
>>> -	else +		update_mmu_cache(vma, addr, *pte);
>>> +	} else
>>>  		put_page(page);
>>>  out:
>>>  	spin_unlock(&mm->page_table_lock);
>> 
>> update_mmu_cache() does not appear to check the size of the
>> translation to be established in many architectures. e.g. on
>> arch/ia64/ it does flush_icache_range(addr, addr + PAGE_SIZE)
>> unconditionally, and only sets PG_arch_1 on a single struct page.
>> Similar comments apply to sparc64 and ppc64; I didn't check any
>> others. 
> 
> I suppose this is fixable in update_mmu_cache() where it can check the
> type of pte and do appropriate sizing and other things.  ia64 would
> have 
> to check the address instead of looking at the pte.


Why do we need update_mmu_cache for hugepages?
