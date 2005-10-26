Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVJZSrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVJZSrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 14:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVJZSrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 14:47:03 -0400
Received: from fmr21.intel.com ([143.183.121.13]:64170 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S964858AbVJZSrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 14:47:01 -0400
Message-Id: <200510261844.j9QIiqg22461@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "Adam Litke" <agl@us.ibm.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>, <hugh@veritas.com>,
       "William Irwin" <wli@holomorphy.com>
Subject: RE: RFC: Cleanup / small fixes to hugetlb fault handling
Date: Wed, 26 Oct 2005 11:44:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXZ3A5NQVmMt/EAQKqXci72cdXaSgAfrkgA
In-Reply-To: <20051026024831.GB17191@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Tuesday, October 25, 2005 7:49 PM
> +int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> +		  unsigned long address, int write_access)
> +{
> +	pte_t *ptep;
> +	pte_t entry;
> +
> +	ptep = huge_pte_alloc(mm, address);
> +	if (! ptep)
> +		/* OOM */
> +		return VM_FAULT_SIGBUS;
> +
> +	entry = *ptep;
> +
> +	if (pte_none(entry))
> +		return hugetlb_no_page(mm, vma, address, ptep);
> +
> +	/* we could get here if another thread instantiated the pte
> +	 * before the test above */
> +
> +	return VM_FAULT_SIGBUS;
>  }

Are you sure about the last return?  Looks like a typo to me, if *ptep
is present, it should return VM_FAULT_MINOR.

But the bigger question is: don't you need some lock when checking *ptep?

- Ken

