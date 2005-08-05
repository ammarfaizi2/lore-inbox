Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbVHEViz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbVHEViz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbVHEVfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:35:50 -0400
Received: from fmr23.intel.com ([143.183.121.15]:41921 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261912AbVHEVec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:34:32 -0400
Message-Id: <200508052133.j75LXig31835@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adam Litke'" <agl@us.ibm.com>, <linux-kernel@vger.kernel.org>
Cc: <ak@suse.de>, <christoph@lameter.com>, <dwg@au1.ibm.com>
Subject: RE: [RFC] Demand faulting for large pages
Date: Fri, 5 Aug 2005 14:33:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWZ00XQTpOmHs4TRqi/fjGiR6pjDwAL+WHA
In-Reply-To: <1123255298.3121.46.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke wrote on Friday, August 05, 2005 8:22 AM
> +int hugetlb_pte_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> +			unsigned long address, int write_access)
> +{
> +	int ret = VM_FAULT_MINOR;
> +	unsigned long idx;
> +	pte_t *pte;
> +	struct page *page;
> +	struct address_space *mapping;
> +
> +	WARN_ON(!is_vm_hugetlb_page(vma));

Spurious WARN_ON.  Calls to hugetlb_pte_fault() is conditioned upon 
if (is_vm_hugetlb_page(vma))



> +int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> +			unsigned long address, int write_access)
> +{
> +   ....
> +	if (pte_none(*ptep))
> +		rc = hugetlb_pte_fault(mm, vma, address, write_access);
> +}

Broken here.  Return VM_FAULT_SIGBUS when *pte is present??  Why
can't you move all the logic into hugetlb_pte_fault and simply call
it directly from handle_mm_fault?

