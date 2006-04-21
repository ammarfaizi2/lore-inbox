Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWDUHdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWDUHdS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWDUHdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:33:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:54472 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751275AbWDUHdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:33:16 -0400
Date: Fri, 21 Apr 2006 09:33:15 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch 1/5] mm: remap_vmalloc_range
Message-ID: <20060421073315.GL21660@wotan.suse.de>
References: <20060301045901.12434.54077.sendpatchset@linux.site> <20060301045910.12434.4844.sendpatchset@linux.site> <20060421001712.4cd5625e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421001712.4cd5625e.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 12:17:12AM -0700, Andrew Morton wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> >
> > Add a remap_vmalloc_range and get rid of as many remap_pfn_range and
> > vm_insert_page loops as possible.
> > 
> > remap_vmalloc_range can do a whole lot of nice range checking even
> > if the caller gets it wrong (which it looks like one or two do).
> > 
> > 
> > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> > -		if (remap_pfn_range(vma, start, page + vma->vm_pgoff,
> > -						PAGE_SIZE, vma->vm_page_prot))
> > -		if (remap_pfn_range(vma, addr, pfn, PAGE_SIZE, PAGE_READONLY))
> 
> You've removed the ability for the caller to set the pte protections - it
> now always uses vma->vm_page_prot.
> 
> please explain...

They should use vma->vm_page_prot?

The callers affected are the PAGE_SHARED ones (the others are unchanged).
Isn't it correct to provide readonly mappings if userspace asks for it?

I assumed this is why Linus went this way too with the new vm_insert_page
interface.
