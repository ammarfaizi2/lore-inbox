Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUBCX42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbUBCX41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:56:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:56708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266205AbUBCX40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:56:26 -0500
Date: Tue, 3 Feb 2004 15:57:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, stelian@popies.net
Subject: Re: [PATCH] meye: correct printk of dma_addr_t
Message-Id: <20040203155752.17a8e274.akpm@osdl.org>
In-Reply-To: <20040203153606.76442b9c.rddunlap@osdl.org>
References: <20040203153606.76442b9c.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> diff -Naurp ./drivers/media/video/meye.c~meye_dma ./drivers/media/video/meye.c
> --- ./drivers/media/video/meye.c~meye_dma	2004-01-08 22:59:44.000000000 -0800
> +++ ./drivers/media/video/meye.c	2004-02-03 14:43:42.000000000 -0800
> @@ -162,7 +162,7 @@ static void rvfree(void * mem, unsigned 
>  
>  /* return a page table pointing to N pages of locked memory */
>  static int ptable_alloc(void) {
> -	u32 *pt;
> +	dma_addr_t *pt;
>  	int i;
>  
>  	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
> @@ -176,7 +176,7 @@ static int ptable_alloc(void) {
>  		return -1;
>  	}
>  
> -	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
> +	pt = (dma_addr_t *)meye.mchip_ptable[MCHIP_NB_PAGES];
>  	for (i = 0; i < MCHIP_NB_PAGES; i++) {
>  		meye.mchip_ptable[i] = dma_alloc_coherent(&meye.mchip_dev->dev, 
>  							  PAGE_SIZE,

mchip_ptable[] just contains pointers to kernel memory.  It doesn't seem
appropriate to be casting these to dma_addr_t's


