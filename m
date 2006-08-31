Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWHaAIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWHaAIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 20:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWHaAIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 20:08:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9143 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751231AbWHaAIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 20:08:09 -0400
Date: Wed, 30 Aug 2006 17:08:06 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH 3/9] actual generic PAGE_SIZE infrastructure
In-Reply-To: <20060830221606.40937644@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608301658130.5789@schroedinger.engr.sgi.com>
References: <20060830221604.E7320C0F@localhost.localdomain>
 <20060830221606.40937644@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006, Dave Hansen wrote:

>  #endif	/* CONFIG_ARCH_HAVE_GET_ORDER */
> -#endif /*  __ASSEMBLY__ */
> +#endif  /* __ASSEMBLY__ */
         ^^^ Extra blank.

> +	prompt "Kernel Page Size"
	               page size?

> +	  This lets you select the page size of the kernel.  For best
> +	  32-bit compatibility on 64-bit architectures, a page size of 4KB
> +	  should be selected (although most binaries work perfectly fine with
> +	  a larger page size).  For best performance, a page size of larger
> +	  than 4KB is recommended.  However, there are a number of
> +	  side-effects of larger page sizes, like small files fitting poorly
> +	  into the page cache.

Could we change this somewhat? Avoid the direct address and maybe say:

 The kernel page size determines the basic chunk of memory handled
 by the Linux VM. The bigger the page size the less page objects
 have to be managed by the kernel which reduces the VM overhead in
 handling large amounts of data. However, larger pages also lead
 to memory being wasted by the kernel since small files will
 at mininum require one page of memory. A 4K pagesize is fairly standard 
 and may be required for 32 bit compatibility on many platforms.

 It is usually not wise to select another page size than the default
 unless one knows what one is doing or has some time to spend on
 getting to know the kernel.


Note that the default pagesize on IA64 is 16K and some important things 
would change if a lesser size is selected. I have never run a 4K kernel. 
I do not think we can just say that 4KB is okay. There may be other 
platforms that have other default page sizes.

