Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWBFVW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWBFVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWBFVWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:22:53 -0500
Received: from ns2.suse.de ([195.135.220.15]:9929 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932132AbWBFVWv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:22:51 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: OOM behavior in constrained memory situations
Date: Mon, 6 Feb 2006 22:22:28 +0100
User-Agent: KMail/1.8.2
Cc: Christoph Lameter <clameter@engr.sgi.com>, pj@sgi.com,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com> <20060206131026.53dbd8d5.akpm@osdl.org>
In-Reply-To: <20060206131026.53dbd8d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200602062222.28630.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 22:10, Andrew Morton wrote:

> Do we really want to kill the application?  A more convetional response
> would be to return NULL from the page allocator and let that trickle back.

Yes that is what it's supposed to be doing.
 
> The hugepage thing is special, because it's a pagefault, not a syscall.

At least remnants from my old 80% hack to avoid this (huge_page_needed)
seem to be still there in mainline:

fs/hugetlbfs/inode.c:hugetlbfs_file_mmap

   bytes = huge_pages_needed(mapping, vma);
   if (!is_hugepage_mem_enough(bytes))
          return -ENOMEM;


So something must be broken if this doesn't work. Or did you allocate
the pages in some other way? 

>From taking a quick look at ipc/shm.c it might be missing an equivalent 
check when allocating a huge page segment.

-Andi
