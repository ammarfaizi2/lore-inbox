Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWF2TlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWF2TlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWF2TlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:41:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:65426 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750948AbWF2TlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:41:16 -0400
Message-ID: <44A42CD9.8050200@garzik.org>
Date: Thu, 29 Jun 2006 15:41:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] 64bit resource: fix up printks for resources in ide drivers
References: <200606291800.k5TI0qfD002870@hera.kernel.org>
In-Reply-To: <200606291800.k5TI0qfD002870@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit 08f46de9a0e7c293db34cf44f9451d18ef609770
> tree 83c28b79165adee350aad8cb9d4e2e59486acf56
> parent 176dfc633bbe4e03f4557d2beeefb4f0cc7f0efa
> author Greg Kroah-Hartman <gregkh@suse.de> Tue, 13 Jun 2006 05:15:59 -0700
> committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 27 Jun 2006 23:23:59 -0700
> 
> [PATCH] 64bit resource: fix up printks for resources in ide drivers
> 
> This is needed if we wish to change the size of the resource structures.
> 
> Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>
> 
> Cc: Vivek Goyal <vgoyal@in.ibm.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
>  drivers/ide/pci/aec62xx.c      |    3 ++-
>  drivers/ide/pci/cmd64x.c       |    3 ++-
>  drivers/ide/pci/hpt34x.c       |    2 +-
>  drivers/ide/pci/pdc202xx_new.c |    4 ++--
>  drivers/ide/pci/pdc202xx_old.c |    4 ++--
>  5 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
> index c743e68..8d5b872 100644
> --- a/drivers/ide/pci/aec62xx.c
> +++ b/drivers/ide/pci/aec62xx.c
> @@ -254,7 +254,8 @@ static unsigned int __devinit init_chips
>  
>  	if (dev->resource[PCI_ROM_RESOURCE].start) {
>  		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> -		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
> +		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
> +			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
>  	}
>  
>  	if (bus_speed <= 33)
> diff --git a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
> index 3d9c7af..9828039 100644
> --- a/drivers/ide/pci/cmd64x.c
> +++ b/drivers/ide/pci/cmd64x.c
> @@ -609,7 +609,8 @@ static unsigned int __devinit init_chips
>  #ifdef __i386__
>  	if (dev->resource[PCI_ROM_RESOURCE].start) {
>  		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> -		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
> +		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
> +			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
>  	}
>  #endif
>  
> diff --git a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
> index be334da..7da5502 100644
> --- a/drivers/ide/pci/hpt34x.c
> +++ b/drivers/ide/pci/hpt34x.c
> @@ -176,7 +176,7 @@ static unsigned int __devinit init_chips
>  			pci_write_config_dword(dev, PCI_ROM_ADDRESS,
>  				dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
>  			printk(KERN_INFO "HPT345: ROM enabled at 0x%08lx\n",
> -				dev->resource[PCI_ROM_RESOURCE].start);
> +				(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
>  		}
>  		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
>  	} else {
> diff --git a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
> index acd6317..20d5965 100644
> --- a/drivers/ide/pci/pdc202xx_new.c
> +++ b/drivers/ide/pci/pdc202xx_new.c
> @@ -313,8 +313,8 @@ static unsigned int __devinit init_chips
>  	if (dev->resource[PCI_ROM_RESOURCE].start) {
>  		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
>  			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> -		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
> -			name, dev->resource[PCI_ROM_RESOURCE].start);
> +		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
> +			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
>  	}
>  
>  #ifdef CONFIG_PPC_PMAC
> diff --git a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
> index 22d1754..ffbef74 100644
> --- a/drivers/ide/pci/pdc202xx_old.c
> +++ b/drivers/ide/pci/pdc202xx_old.c
> @@ -544,8 +544,8 @@ static unsigned int __devinit init_chips
>  	if (dev->resource[PCI_ROM_RESOURCE].start) {
>  		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
>  			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> -		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
> -			name, dev->resource[PCI_ROM_RESOURCE].start);
> +		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
> +			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);

Why cast to unsigned long here?  Won't that truncate the data in certain 
cases, now that it is 64bit?

Other printk patches seem to use unsigned long long, as I would expect.

	Jeff


