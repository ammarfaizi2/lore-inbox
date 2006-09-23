Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWIWMpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWIWMpu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWIWMpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:45:50 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:22246 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751087AbWIWMpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:45:49 -0400
Date: Sat, 23 Sep 2006 14:43:59 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Amol Lad <amol@verismonetworks.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: Re: ioremap balanced with iounmap for drivers/mtd subsystem
Message-ID: <20060923124359.GA17408@electric-eye.fr.zoreil.com>
References: <200609222101.k8ML1oW5019174@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609222101.k8ML1oW5019174@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> :
> commit 25f0c659fe64832d8ee06aa623fffaad708dcf8b
[...]
> diff --git a/drivers/mtd/maps/arctic-mtd.c b/drivers/mtd/maps/arctic-mtd.c
> index d95ae58..642d96b 100644
> --- a/drivers/mtd/maps/arctic-mtd.c
> +++ b/drivers/mtd/maps/arctic-mtd.c
> @@ -96,6 +96,8 @@ static struct mtd_partition arctic_parti
>  static int __init
>  init_arctic_mtd(void)
>  {
> +	int err = 0;

Unneeded initialization.

> @@ -109,12 +111,20 @@ init_arctic_mtd(void)
>  	printk("%s: probing %d-bit flash bus\n", NAME, BUSWIDTH * 8);
>  	arctic_mtd = do_map_probe("cfi_probe", &arctic_mtd_map);
>  
> -	if (!arctic_mtd)
> +	if (!arctic_mtd) {
> +		iounmap((void *) arctic_mtd_map.virt);

Useless cast.

These two patterns are repeated all over the patch.

A grep for iounmap in drivers/mtd/nand would not hurt.

-- 
Ueimor
