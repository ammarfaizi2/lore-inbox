Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWBFWRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWBFWRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWBFWRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:17:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:28048 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932264AbWBFWRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:17:08 -0500
Date: Mon, 6 Feb 2006 14:16:54 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <200602062222.28630.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602061415560.18919@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <20060206131026.53dbd8d5.akpm@osdl.org> <200602062222.28630.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andi Kleen wrote:

> At least remnants from my old 80% hack to avoid this (huge_page_needed)
> seem to be still there in mainline:
> 
> fs/hugetlbfs/inode.c:hugetlbfs_file_mmap
> 
>    bytes = huge_pages_needed(mapping, vma);
>    if (!is_hugepage_mem_enough(bytes))
>           return -ENOMEM;
> 
> 
> So something must be broken if this doesn't work. Or did you allocate
> the pages in some other way? 

huge pages are now allocated in the huge fault handler. If it would be 
returning an OOM then the OOM killer may be activated.
