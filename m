Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVBLBcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVBLBcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 20:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVBLBcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 20:32:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:14763 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261910AbVBLBcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:32:15 -0500
Date: Fri, 11 Feb 2005 17:32:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [PATCH] kmalloc() bug in pci-dma.c
Message-Id: <20050211173208.49a961bd.akpm@osdl.org>
In-Reply-To: <20050211172439.A21261@unix-os.sc.intel.com>
References: <20050211172439.A21261@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
>
>  After burning my fingers with a similar mistake in one of the patches 
>  that I am working on, I did a quick grep to find out all faulty kmalloc() 
>  calls and found this.
> 
>  dma_declare_coherent_memory() is calling kmalloc with wrong arguments. 
>  Attached patch fixes this.
> 
>  Please apply.
> 
>  Thanks,
>  Venki
> 
>  Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
>  --- linux-2.6.10/arch/i386/kernel/pci-dma.c.org	2005-02-11 15:18:42.596362296 -0800
>  +++ linux-2.6.10/arch/i386/kernel/pci-dma.c	2005-02-11 15:19:18.446912184 -0800
>  @@ -89,11 +89,11 @@ int dma_declare_coherent_memory(struct d
>   	if (!mem_base)
>   		goto out;
>   
>  -	dev->dma_mem = kmalloc(GFP_KERNEL, sizeof(struct dma_coherent_mem));
>  +	dev->dma_mem = kmalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);

erp.  I'll add that to the 2.6.11 queue, thanks.
