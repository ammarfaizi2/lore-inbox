Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbUKKWeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUKKWeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKKWcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:32:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:56813 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262377AbUKKWcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:32:07 -0500
Date: Thu, 11 Nov 2004 14:31:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH] VM routine fixes
Message-Id: <20041111143148.76dcaba4.akpm@osdl.org>
In-Reply-To: <200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
References: <200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dhowells@redhat.com wrote:
>
> The attached patch fixes a number of problems in the VM routines:
> 
>  (1) Some inline funcs don't compile if CONFIG_MMU is not set.
> 
>  (2) swapper_pml4 needn't exist if CONFIG_MMU is not set.
> 
>  (3) __free_pages_ok() doesn't counter set_page_refs() different behaviour if
>      CONFIG_MMU is not set.
> 
>  (4) swsusp.c invokes TLB flushing functions without including the header file
>      that declares them.
> 

I spy a secret, uncommented, unchangelogged hunk:

> @@ -112,7 +112,9 @@ int shmem_zero_setup(struct vm_area_stru
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	vma->vm_file = file;
> +#ifdef CONFIG_MMU
>  	vma->vm_ops = &generic_file_vm_ops;
> +#endif
>  	return 0;
>  }
>  

What's happening there?
