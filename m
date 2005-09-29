Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVI2GLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVI2GLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVI2GLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:11:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751199AbVI2GLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:11:00 -0400
Date: Wed, 28 Sep 2005 23:10:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Litke <agl@us.ibm.com>
Cc: agl@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3 htlb-fault] Demand faulting for huge pages
Message-Id: <20050928231029.6dd60fc3.akpm@osdl.org>
In-Reply-To: <1127939538.26401.36.camel@localhost.localdomain>
References: <1127939141.26401.32.camel@localhost.localdomain>
	<1127939538.26401.36.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke <agl@us.ibm.com> wrote:
>
> +int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  +			unsigned long address, int write_access)
>  +{
>  +	pte_t *ptep;
>  +	int rc = VM_FAULT_MINOR;
>  +
>  +	spin_lock(&mm->page_table_lock);
>  +
>  +	ptep = huge_pte_alloc(mm, address);
>  +	if (!ptep) {
>  +		rc = VM_FAULT_SIGBUS;
>  +		goto out;
>  +	}
>  +	if (pte_none(*ptep))
>  +		rc = hugetlb_pte_fault(mm, vma, address, write_access);
>  +out:
>  +	if (rc == VM_FAULT_MINOR)
>  +		flush_tlb_page(vma, address);
>  +
>  +	spin_unlock(&mm->page_table_lock);
>  +	return rc;
>  +}

label `out' can be moved down a couple of lines.

