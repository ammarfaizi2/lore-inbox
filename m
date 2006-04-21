Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWDUHl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWDUHl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWDUHl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:41:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:55497 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751269AbWDUHl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:41:58 -0400
Date: Fri, 21 Apr 2006 09:41:57 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch 1/5] mm: remap_vmalloc_range
Message-ID: <20060421074156.GM21660@wotan.suse.de>
References: <20060301045901.12434.54077.sendpatchset@linux.site> <20060301045910.12434.4844.sendpatchset@linux.site> <20060421002938.3878aec5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421002938.3878aec5.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 12:29:38AM -0700, Andrew Morton wrote:
> 
> When replacing calls to remap_pfn_rage() with calls to remap_valloc_range():
> 
> - remap_pfn_range() sets VM_IO|VM_RESERVED|VM_PFNMAP on the user's vma. 
>   remap_valloc_range() sets only VM_RESERVED.

Yep, it doesn't use PFNMAPs (we can always user the underlying struct
 page), nor is it IO space. The only change that should be seen, as
noted in patch 4/5, is that get_user_pages will work on all mappings
now. I don't think there is a downside to this?

> 
> - remap_pfn_range() has special handling for COWable user vma's, but
>   remap_valloc_range() does not.

That's only for PFNMAPs. COW should continue to work fine.

> 
> - are vma->vm_start and vma->vm_end always a multiple of PAGE_SIZE?  (I
>   always forget).  If not, remap_valloc_range() looks a tad buggy.

I hope so.

> 
> 
> pls explain.
> 
> 
> - remap_valloc_range() can use ~PAGE_MASK, not PAGE_SIZE-1

I initially did that when coding the function in mm/memory.c, but when
adding all the vmalloc range checking I tried to stick with vmalloc
convention.

> 
> - remap_valloc_range() would lose a whole buncha typecasts if you use the
>   gcc pointer-arith-with-void* extension.

Should I?
