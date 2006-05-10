Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWEJTsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWEJTsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWEJTsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:48:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:10218 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751341AbWEJTr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:47:59 -0400
Subject: Re: [RFC] Hugetlb demotion for x86
From: Dave Hansen <haveblue@us.ibm.com>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-mm@kvack.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1147287400.24029.81.camel@localhost.localdomain>
References: <1147287400.24029.81.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 May 2006 12:46:40 -0700
Message-Id: <1147290400.17933.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 13:56 -0500, Adam Litke wrote:
> +install_demotion_ptes(struct mm_struct *mm, struct page *page,
> +                       pgprot_t prot, unsigned long address)
> +{
> +       pgd_t *pgd;
> +       pud_t *pud;
> +       pmd_t *pmd;
> +       pte_t entry, *ptep;
> +       int pfn, i;
> +
> +       pgd = pgd_offset(mm, address);
> +       pud = pud_alloc(mm, pgd, address);
> +       if (!pud)
> +               return -ENOMEM;
> +       pmd = pmd_alloc(mm, pud, address);
> +       if (!pmd)
> +               return -ENOMEM; 

That looks to be a pretty direct copy of what is already in
__handle_mm_fault().  Can they be consolidated?

-- Dave

