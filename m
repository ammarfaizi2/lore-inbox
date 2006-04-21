Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWDUHSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWDUHSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWDUHSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:18:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751250AbWDUHSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:18:12 -0400
Date: Fri, 21 Apr 2006 00:17:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: [patch 1/5] mm: remap_vmalloc_range
Message-Id: <20060421001712.4cd5625e.akpm@osdl.org>
In-Reply-To: <20060301045910.12434.4844.sendpatchset@linux.site>
References: <20060301045901.12434.54077.sendpatchset@linux.site>
	<20060301045910.12434.4844.sendpatchset@linux.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> Add a remap_vmalloc_range and get rid of as many remap_pfn_range and
> vm_insert_page loops as possible.
> 
> remap_vmalloc_range can do a whole lot of nice range checking even
> if the caller gets it wrong (which it looks like one or two do).
> 
> 
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> -		if (remap_pfn_range(vma, start, page + vma->vm_pgoff,
> -						PAGE_SIZE, vma->vm_page_prot))
> -		if (remap_pfn_range(vma, addr, pfn, PAGE_SIZE, PAGE_READONLY))

You've removed the ability for the caller to set the pte protections - it
now always uses vma->vm_page_prot.

please explain...
