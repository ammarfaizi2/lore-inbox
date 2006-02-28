Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWB1Dpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWB1Dpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWB1Dpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:45:45 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:50532 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750735AbWB1Dpo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:45:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TrSBj2xycpm0x0T8X/51NH0Hi97djPwKiC1GW9L/vCsmOVCeNntnf/89MujsOWZX0Vb1ghq63NlmmIXzrc164WqKOf9iPhpDCeq99en85EZxmZ58SsJ7S9xYPy+y5G6kMDXppjFtzRgnRi44C1mA958w+UWjL0Yapa1a5+ICIdI=
Message-ID: <489ecd0c0602271945g1a4963c6kb7de7c6b0df90a07@mail.gmail.com>
Date: Tue, 28 Feb 2006 11:45:43 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] Replace "vmalloc_node" with "vmalloc" for no-mmu architectures in oprofile driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060227193322.7a78c585.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0602271920u7c0fc0b6p8a8cef0f408c6f3b@mail.gmail.com>
	 <20060227193322.7a78c585.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/06, Andrew Morton <akpm@osdl.org> wrote:

> You wanted CONFIG_MMU there.
    Yes.
>
> A better fix is to provide vmalloc_node() on nommu architectures.  COuld you
> compile-test this please?
    Tested.  Then my patch is obsolete. Thanks!

>
> --- devel/mm/nommu.c~nommu-implement-vmalloc_node       2006-02-27 19:30:47.000000000 -0800
> +++ devel-akpm/mm/nommu.c       2006-02-27 19:31:53.000000000 -0800
> @@ -53,7 +53,6 @@ DECLARE_RWSEM(nommu_vma_sem);
>  struct vm_operations_struct generic_file_vm_ops = {
>  };
>
> -EXPORT_SYMBOL(vmalloc);
>  EXPORT_SYMBOL(vfree);
>  EXPORT_SYMBOL(vmalloc_to_page);
>  EXPORT_SYMBOL(vmalloc_32);
> @@ -205,6 +204,13 @@ void *vmalloc(unsigned long size)
>  {
>         return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
>  }
> +EXPORT_SYMBOL(vmalloc);
> +
> +void *vmalloc_node(unsigned long size, int node)
> +{
> +       return vmalloc(size);
> +}
> +EXPORT_SYMBOL(vmalloc_node);
>
>  /*
>   *     vmalloc_32  -  allocate virtually continguos memory (32bit addressable)
> _
>
>


--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
