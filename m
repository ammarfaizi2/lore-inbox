Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVJXDNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVJXDNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 23:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVJXDNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 23:13:13 -0400
Received: from silver.veritas.com ([143.127.12.111]:26205 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750939AbVJXDNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 23:13:12 -0400
Date: Mon, 24 Oct 2005 04:12:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: clameter@sgi.com, rmk@arm.linux.org.uk, matthew@wil.cx, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mm: split page table lock
In-Reply-To: <20051023144900.4a23704d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0510240409590.22131@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
 <20051023144900.4a23704d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Oct 2005 03:13:11.0547 (UTC) FILETIME=[DD8234B0:01C5D848]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >  + * When freeing, reset page->mapping so free_pages_check won't complain.
> >  + */
> >  +#define __pte_lockptr(page)	((spinlock_t *)&((page)->private))
> >  +#define pte_lock_init(_page)	do {					\
> >  +	BUILD_BUG_ON((size_t)(__pte_lockptr((struct page *)0) + 1) >	\
> >  +						sizeof(struct page));	\
> >  +	spin_lock_init(__pte_lockptr(_page));				\
> >  +} while (0)
> >  +#define pte_lock_deinit(page)	((page)->mapping = NULL)
> >  +#define pte_lockptr(mm, pmd)	({(void)(mm); __pte_lockptr(pmd_page(*(pmd)));})
> >  +#else
> 
> Why does pte_lock_deinit() zap ->mapping?  That doesn't seem to have
> anything to do with anything?

Nick had wondered the same originally, so I did add the comment above.
Bring it down to immediately above the deinit line if you prefer.

Hugh
