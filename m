Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbRE3RIz>; Wed, 30 May 2001 13:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261682AbRE3RIq>; Wed, 30 May 2001 13:08:46 -0400
Received: from quasar.osc.edu ([192.148.249.15]:61571 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S261666AbRE3RIj>;
	Wed, 30 May 2001 13:08:39 -0400
Date: Wed, 30 May 2001 13:08:30 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Ingo Molnar <mingo@elte.hu>
Cc: mdaljeet@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: pte_page
Message-ID: <20010530130830.F14433@osc.edu>
In-Reply-To: <CA256A5C.002E4CF0.00@d73mta01.au.ibm.com> <Pine.LNX.4.33.0105301602430.1328-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105301602430.1328-100000@localhost.localdomain>; from mingo@elte.hu on Wed, May 30, 2001 at 04:09:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo@elte.hu said:
> On Wed, 30 May 2001 mdaljeet@in.ibm.com wrote:
> > I use the 'pgt_offset', 'pmd_offset', 'pte_offset' and 'pte_page'
> > inside a module to get the physical address of a user space virtual
> > address. The physical address returned by 'pte_page' is not page
> > aligned whereas the virtual address was page aligned. Can somebody
> > tell me the reason?
> 
> __pa(page_address(pte_page(pte))) is the address you want. [or
> pte_val(*pte) & (PAGE_SIZE-1) on x86 but this is platform-dependent.]

Does this work on x86 non-kmapped highmem user pages too?  (i.e. is
page->virtual valid for every potential user page.)

		-- Pete

> > Also, can i use these functions to get the physical address of a
> > kernel virtual address using init_mm?
> 
> nope. Eg. on x86 these functions only walk normal 4K page pagetables, they
> do not walk 4MB pages correctly. (which are set up on pentiums and better
> CPUs, unless mem=nopentium is specified.)
> 
> a kernel virtual address can be decoded by simply doing __pa(kaddr). If
> the page is a highmem page [and you have the struct page pointer] then you
> can do [(page-mem_map) << PAGE_SHIFT] to get the physical address, but
> only on systems where mem_map[] starts at physical address 0.
