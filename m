Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVCRXFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVCRXFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVCRXFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:05:31 -0500
Received: from ozlabs.org ([203.10.76.45]:32935 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262100AbVCRXFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:05:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16955.23669.792362.539790@cargo.ozlabs.ibm.com>
Date: Sat, 19 Mar 2005 09:55:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, akpm@osdl.org,
       davem@davemloft.net, wli@holomorphy.com, riel@redhat.com,
       kurt@garloff.de, Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH 1/4] io_remap_pfn_range: add for all arch-es
In-Reply-To: <20050318113352.0baaaf5e.rddunlap@osdl.org>
References: <20050318112545.6f5f7635.rddunlap@osdl.org>
	<20050318113352.0baaaf5e.rddunlap@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap writes:

> diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk3-pv/include/asm-ppc/pgtable.h linux-2611-bk3-pfn/include/asm-ppc/pgtable.h
> --- linux-2611-bk3-pv/include/asm-ppc/pgtable.h	2005-03-07 11:02:18.000000000 -0800
> +++ linux-2611-bk3-pfn/include/asm-ppc/pgtable.h	2005-03-07 11:04:59.000000000 -0800
> @@ -735,11 +735,27 @@ static inline int io_remap_page_range(st
>  	phys_addr_t paddr64 = fixup_bigphys_addr(paddr, size);
>  	return remap_pfn_range(vma, vaddr, paddr64 >> PAGE_SHIFT, size, prot);
>  }
> +
> +static inline int io_remap_pfn_range(struct vm_area_struct *vma,
> +					unsigned long vaddr,
> +					unsigned long pfn,
> +					unsigned long size,
> +					pgprot_t prot)
> +{
> +	phys_addr_t paddr64 = fixup_bigphys_addr(pfn << PAGE_SHIFT, size);
> +	return remap_pfn_range(vma, vaddr, pfn, size, prot);

Just by inspection, this looks like pfn should be changed to
paddr64 >> PAGE_SHIFT in that last line.

Paul.
