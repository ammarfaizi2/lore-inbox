Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWGMIY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWGMIY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWGMIY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:24:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932284AbWGMIY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:24:26 -0400
Date: Thu, 13 Jul 2006 01:24:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/5] UML - Fix ZONE_HIGHMEM compilation error
Message-Id: <20060713012421.b59f05d4.akpm@osdl.org>
In-Reply-To: <200607121639.k6CGdiMw021221@ccure.user-mode-linux.org>
References: <200607121639.k6CGdiMw021221@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 12:39:43 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> References to ZONE_HIGHMEM need to depend on CONFIG_HIGHMEM.
> 

There are several such references in mm/page_alloc.c

> 
> Index: linux-2.6.17/arch/um/kernel/mem.c
> ===================================================================
> --- linux-2.6.17.orig/arch/um/kernel/mem.c	2006-07-12 11:29:02.000000000 -0400
> +++ linux-2.6.17/arch/um/kernel/mem.c	2006-07-12 11:29:11.000000000 -0400
> @@ -226,7 +226,9 @@ void paging_init(void)
>  	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 

I spy an ARRAY_SIZE().

>  		zones_size[i] = 0;
>  	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
> +#ifdef CONFIG_HIGHMEM
>  	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
> +#endif
>  	free_area_init(zones_size);
>  

Maybe this is an rc1-mm1 fix?  Did Christoph's patches break UML, perhaps??
