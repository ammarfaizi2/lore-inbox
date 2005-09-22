Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbVIVN57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVIVN57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVIVN56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:57:58 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:50841 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1030354AbVIVN55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:57:57 -0400
Date: Thu, 22 Sep 2005 09:59:46 -0400
From: Bob Picco <bob.picco@hp.com>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rddunlap@osdl.org,
       cosmos@visi.com
Subject: Re: [PATCH] Fix mmap() of /dev/hpet
Message-ID: <20050922135946.GV16066@localhost.localdomain>
References: <E1EIPh5-0001Xp-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EIPh5-0001Xp-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:	[Thu Sep 22 2005, 07:56:50AM EDT]
> The address passed to io_remap_pfn_range() in hpet_mmap() does not
> need to be converted using __pa(): it is already a physical
> address. This bug was found and the patch suggested by Clay Harris. 
> 
> I introduced this particular bug when making io_remap_pfn_range
> changes a few months ago. In fact mmap()ing /dev/hpet has *never*
> previously worked: before my changes __pa() was being executed on an
> ioremap()ed virtual address, which is also invalid.
> 
> Signed-off-by: Keir Fraser <keir@xensource.com>
> 

> diff -urpP linux-2.6.14-rc2.old/drivers/char/hpet.c linux-2.6.14-rc2.new/drivers/char/hpet.c
> --- linux-2.6.14-rc2.old/drivers/char/hpet.c	2005-09-22 12:47:00.773424663 +0100
> +++ linux-2.6.14-rc2.new/drivers/char/hpet.c	2005-09-22 12:47:18.216928551 +0100
> @@ -273,7 +273,6 @@ static int hpet_mmap(struct file *file, 
>  
>  	vma->vm_flags |= VM_IO;
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	addr = __pa(addr);
>  
>  	if (io_remap_pfn_range(vma, vma->vm_start, addr >> PAGE_SHIFT,
>  					PAGE_SIZE, vma->vm_page_prot)) {
Keir:

Well it looks definitely wrong. I wonder how my mmap test ever succeeded. 

thanks,

bob

