Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262799AbRE3OLl>; Wed, 30 May 2001 10:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262809AbRE3OLb>; Wed, 30 May 2001 10:11:31 -0400
Received: from chiara.elte.hu ([157.181.150.200]:13835 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262800AbRE3OLY>;
	Wed, 30 May 2001 10:11:24 -0400
Date: Wed, 30 May 2001 16:09:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <mdaljeet@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: pte_page
In-Reply-To: <CA256A5C.002E4CF0.00@d73mta01.au.ibm.com>
Message-ID: <Pine.LNX.4.33.0105301602430.1328-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 May 2001 mdaljeet@in.ibm.com wrote:

> I use the 'pgt_offset', 'pmd_offset', 'pte_offset' and 'pte_page'
> inside a module to get the physical address of a user space virtual
> address. The physical address returned by 'pte_page' is not page
> aligned whereas the virtual address was page aligned. Can somebody
> tell me the reason?

__pa(page_address(pte_page(pte))) is the address you want. [or
pte_val(*pte) & (PAGE_SIZE-1) on x86 but this is platform-dependent.]

> Also, can i use these functions to get the physical address of a
> kernel virtual address using init_mm?

nope. Eg. on x86 these functions only walk normal 4K page pagetables, they
do not walk 4MB pages correctly. (which are set up on pentiums and better
CPUs, unless mem=nopentium is specified.)

a kernel virtual address can be decoded by simply doing __pa(kaddr). If
the page is a highmem page [and you have the struct page pointer] then you
can do [(page-mem_map) << PAGE_SHIFT] to get the physical address, but
only on systems where mem_map[] starts at physical address 0.

	Ingo

