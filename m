Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWBCQE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWBCQE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWBCQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:04:57 -0500
Received: from ezoffice.mandriva.com ([84.14.106.134]:46341 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1750988AbWBCQE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:04:56 -0500
From: Thierry Vignaud <tvignaud@mandriva.com>
To: linux-kernel@vger.kernel.org
Cc: rudolph@faex.net, B.Zolnierkiewicz@elka.pw.edu.pl, davej@codemonkey.org.uk,
       mm-commits@vger.kernel.org
Subject: Re: + sis5513-support-sis-965l.patch added to -mm tree
Organization: Mandrakesoft
References: <200602030128.k131SaF5018921@shell0.pdx.osdl.net>
X-URL: <http://www.linux-mandrake.com/
Date: Fri, 03 Feb 2006 17:04:00 +0100
In-Reply-To: <200602030128.k131SaF5018921@shell0.pdx.osdl.net>
	(akpm@osdl.org's message of "Thu, 2 Feb 2006 17:30:42 -0800")
Message-ID: <m2y80sh1jj.fsf@vador.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org writes:

> From: Rudolph Pereira <rudolph@faex.net>
> 
> Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> Cc: Dave Jones <davej@codemonkey.org.uk>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/ide/pci/sis5513.c |    6 ++++++
>  1 files changed, 6 insertions(+)
> 
> diff -puN drivers/ide/pci/sis5513.c~sis5513-support-sis-965l drivers/ide/pci/sis5513.c
> --- 25/drivers/ide/pci/sis5513.c~sis5513-support-sis-965l	Thu Feb  2 17:29:51 2006
> +++ 25-akpm/drivers/ide/pci/sis5513.c	Thu Feb  2 17:29:51 2006
> @@ -780,7 +780,12 @@ static unsigned int __devinit init_chips
>  					pci_write_config_dword(dev, 0x54, idemisc | 0x40000000);
>  					printk(KERN_INFO "SIS5513: Switching to 5513 register mapping\n");
>  				}
> +			} else if (trueid == 0x180) { /* sis965L */
> +				chipset_family = ATA_133;
> +				printk(KERN_INFO "SIS5513: SiS 965 IDE "
> +						"UDMA133 controller\n");
>  			}
> +
>  	}
>  
>  	if (!chipset_family) { /* Belongs to pci-quirks */
> @@ -955,6 +960,7 @@ static int __devinit sis5513_init_one(st
>  static struct pci_device_id sis5513_pci_tbl[] = {
>  	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>  	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> +	{ PCI_VENDOR_ID_SI, 0x180,                 PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 0},

this is one is already claimed by drivers/scsi/sata_sis.c

