Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUJBFgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUJBFgl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 01:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUJBFgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 01:36:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:45961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267291AbUJBFgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 01:36:15 -0400
Date: Fri, 1 Oct 2004 22:35:53 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: Hanna Linder <hannal@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>, <greg@kroah.com>,
       <kernel-janitors@lists.osdl.org>, Judith Lebzelter <judith@osdl.org>,
       <davidm@hpl.hp.com>, <jbarnes@sgi.com>
Subject: Re: [PATCH 2.6.9-rc2-mm4 pci_bus_cvlink.c] Replace pci_find_device
 with pci_get_device
In-Reply-To: <112570000.1096654254@w-hlinder.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0410011514220.4332-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004, Hanna Linder wrote:

> As pci_find_device is going away soon I have replaced the call with pci_get_device.
> Judith, could you run these 3 ia64 ones through PLM, please?

All 3 patches are included in PLM in patch ID 3357:

http://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=3357

It shows no _additional_ errors or warnings compared to 2.6.9-rc2.  The
ia64 filter is comp-regress which runs quite a bit more than just the
defconfig.  Result summaries follow:

Kernel version: 2.6.9-rc2-mm4 ( with 3 pci_get patches)
Kernel build:
   Making vmlinux (defconfig): 20 warnings, 0 errors
   Making modules (defconfig): 9 warnings, 0 errors
   Making vmlinux (allnoconfig): 14 warnings, 5 errors
   Making vmlinux (allyesconfig): 506 warnings, 27 errors
   Making modules (allyesconfig): 16 warnings, 0 errors
   Making vmlinux (allmodconfig): 19 warnings, 9 errors
   Making modules (allmodconfig): 498 warnings, 11 errors

Compared to 2.6.9-rc2-mm4, PLM ID 3342
http://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=3342:

Kernel version: 2.6.9-rc2-mm4
Kernel build:
   Making vmlinux (defconfig): 20 warnings, 0 errors
   Making modules (defconfig): 9 warnings, 0 errors
   Making vmlinux (allnoconfig): 14 warnings, 5 errors
   Making vmlinux (allyesconfig): 506 warnings, 27 errors
   Making modules (allyesconfig): 16 warnings, 0 errors
   Making vmlinux (allmodconfig): 19 warnings, 9 errors
   Making modules (allmodconfig): 498 warnings, 11 errors


Judith

>
> Thanks a lot.
>
> Hanna Linder
> IBM Linux Technology Center
>
> Signed-off-by: Hanna Linder <hannal@us.ibm.com>
>
> ---
>
> diff -Nrup linux-2.6.9-rc2-mm4cln/arch/ia64/sn/io/machvec/pci_bus_cvlink.c linux-2.6.9-rc2-mm4patch2/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
> --- linux-2.6.9-rc2-mm4cln/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	2004-09-28 14:58:07.000000000 -0700
> +++ linux-2.6.9-rc2-mm4patch2/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	2004-09-30 16:56:57.454516072 -0700
> @@ -904,7 +904,7 @@ sn_pci_init (void)
>  	/*
>  	 * Initialize the device vertex in the pci_dev struct.
>  	 */
> -	while ((pci_dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL) {
> +	while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL) {
>  		ret = sn_pci_fixup_slot(pci_dev);
>  		if ( ret ) {
>  			printk(KERN_WARNING
>



