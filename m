Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWDUJCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWDUJCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 05:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWDUJCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 05:02:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:22740 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750913AbWDUJCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 05:02:08 -0400
Date: Fri, 21 Apr 2006 11:02:06 +0200
From: Nick Piggin <npiggin@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mm: introduce remap_vmalloc_range (pls. drop previous patchset)
Message-ID: <20060421090206.GT21660@wotan.suse.de>
References: <20060421084503.GS21660@wotan.suse.de> <84144f020604210157s406a08a7yd3c43d9ef2939ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020604210157s406a08a7yd3c43d9ef2939ce@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 11:57:32AM +0300, Pekka Enberg wrote:
> Hi Nick,
> 
> On 4/21/06, Nick Piggin <npiggin@suse.de> wrote:
> > +       addr = (void *)((unsigned long)addr + (pgoff << PAGE_SHIFT));
> 
> As Andrew said, you can get rid of the casting 

So he did...

---
Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -725,7 +725,7 @@ int remap_vmalloc_range(struct vm_area_s
 		goto out_einval_locked;
 	read_unlock(&vmlist_lock);
 
-	addr = (void *)((unsigned long)addr + (pgoff << PAGE_SHIFT));
+	addr += pgoff << PAGE_SHIFT;
 	do {
 		struct page *page = vmalloc_to_page(addr);
 		ret = vm_insert_page(vma, uaddr, page);
@@ -733,7 +733,7 @@ int remap_vmalloc_range(struct vm_area_s
 			return ret;
 
 		uaddr += PAGE_SIZE;
-		addr = (void *)((unsigned long)addr+PAGE_SIZE);
+		addr += PAGE_SIZE;
 		usize -= PAGE_SIZE;
 	} while (usize > 0);
 
