Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbUKKV6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbUKKV6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbUKKV5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:57:00 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:11512 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262386AbUKKV4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:56:11 -0500
Date: Thu, 11 Nov 2004 13:55:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
Message-ID: <111920000.1100210158@flay>
In-Reply-To: <20041111030837.12a2090b.akpm@osdl.org>
References: <20041111012333.1b529478.akpm@osdl.org> <20041111030837.12a2090b.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Needs a fixup for CONFIG_HIGHMEM
> 
> --- linux-bix/include/asm/highmem.h~a	2004-11-11 03:07:37.105728944 -0800
> +++ linux-bix-akpm/include/asm/highmem.h	2004-11-11 03:07:49.511842928 -0800
> @@ -62,7 +62,7 @@ void kunmap(struct page *page);
>  char *kmap_atomic(struct page *page, enum km_type type);
>  void kunmap_atomic(char *kvaddr, enum km_type type);
>  char *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
> -struct page *kmap_atomic_to_page(void *ptr);
> +struct page *kmap_atomic_to_page(char *ptr);
>  
>  #define flush_cache_kmaps()	do { } while (0)

That works. But something broke shmem:

ipc/shm.c:171: error: `shmem_set_policy' undeclared here (not in a function)
ipc/shm.c:171: error: initializer element is not constant
ipc/shm.c:171: error: (near initialization for `shm_vm_ops.set_policy')
ipc/shm.c:172: error: `shmem_get_policy' undeclared here (not in a function)
ipc/shm.c:172: error: initializer element is not constant
ipc/shm.c:172: error: (near initialization for `shm_vm_ops.get_policy')
make[1]: *** [ipc/shm.o] Error 1
make[1]: *** Waiting for unfinished jobs....

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/config.numaq

Oddly, I can't see anything that changes shmem_get/set_policy in -mm patch.
But 2.6.10-rc1 compiles fine ... boggle.

M.

