Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVKJBrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVKJBrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVKJBrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:47:01 -0500
Received: from fmr21.intel.com ([143.183.121.13]:55692 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751370AbVKJBrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:47:00 -0500
Subject: Re: [PATCH 4/4] Hugetlb: Copy on Write support
From: Rohit Seth <rohit.seth@intel.com>
To: Adam Litke <agl@us.ibm.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       David Gibson <david@gibson.dropbear.id.au>, wli@holomorphy.com,
       hugh@veritas.com, kenneth.w.chen@intel.com
In-Reply-To: <1131579596.28383.25.camel@localhost.localdomain>
References: <1131578925.28383.9.camel@localhost.localdomain>
	 <1131579596.28383.25.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 09 Nov 2005 17:52:44 -0800
Message-Id: <1131587564.16514.53.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2005 01:45:40.0717 (UTC) FILETIME=[74CAE1D0:01C5E598]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 17:39 -0600, Adam Litke wrote:

>  
> +#define huge_ptep_set_wrprotect(mm, addr, ptep) \
> +	ptep_set_wrprotect(mm, addr, ptep)
> +static inline void set_huge_ptep_writable(struct vm_area_struct *vma,
> +		unsigned long address, pte_t *ptep)
> +{
> +	pte_t entry;
> +
> +	entry = pte_mkwrite(pte_mkdirty(*ptep));
> +	ptep_set_access_flags(vma, address, ptep, entry, 1);
> +	update_mmu_cache(vma, address, entry);
> +}

lazy_mmu_prot_update will need to called here to make caches coherent
for some archs.

-rohit

