Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbUCZHRm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 02:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263856AbUCZHRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 02:17:42 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:41482 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263658AbUCZHRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 02:17:40 -0500
Date: Fri, 26 Mar 2004 07:17:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with remap_page_range/mmap
Message-ID: <20040326071739.B2637@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christian Leber <christian@leber.de>, linux-kernel@vger.kernel.org
References: <20040325234804.GA29507@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040325234804.GA29507@core.home>; from christian@leber.de on Fri, Mar 26, 2004 at 12:48:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 12:48:04AM +0100, Christian Leber wrote:
> addr = __get_free_pages(GFP_KERNEL,0);
> int atoll_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> {
>         vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
> 	
> 	if(remap_page_range_A(vma,
> 		vma->vm_start, addr, 4096,
> 		vma->vm_page_prot)) {
> 			printk("remapping send space failed\n");
> 			return -ENXIO;
> 	}

You can't call remap_page_range on normal kernel pages.  It works only
if you mark them PG_reserved, but even that use is usually not a good idea.

