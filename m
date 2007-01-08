Return-Path: <linux-kernel-owner+w=401wt.eu-S1030450AbXAHC3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbXAHC3i (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 21:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbXAHC3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 21:29:37 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51691 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030450AbXAHC3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 21:29:37 -0500
Message-ID: <45A1AC8D.5090000@garzik.org>
Date: Sun, 07 Jan 2007 21:29:33 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Conke Hu <conke.hu@gmail.com>
CC: Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add pci class code for SATA
References: <Pine.LNX.4.64.0612171409340.9120@localhost.localdomain>	 <1166551886.2977.5.camel@localhost.localdomain>	 <45883E64.20400@garzik.org>	 <5767b9100612191913p29675249v18803c65f536bda4@mail.gmail.com>	 <5767b9100612191941n461f2b39k93d2cec43a31205a@mail.gmail.com> <5767b9100612191952o593a4c48w50f0d483533a3a09@mail.gmail.com>
In-Reply-To: <5767b9100612191952o593a4c48w50f0d483533a3a09@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conke Hu wrote:
> or, pls see this one:
> ------------------------
> diff -Nur linux-2.6.20-rc1.orig/drivers/ata/ahci.c
> linux-2.6.20-rc1/drivers/ata/ahci.c
> --- linux-2.6.20-rc1.orig/drivers/ata/ahci.c    2006-12-20 
> 10:25:00.000000000 +0800
> +++ linux-2.6.20-rc1/drivers/ata/ahci.c    2006-12-20 11:45:45.000000000 
> +0800
> @@ -418,7 +418,7 @@
> 
>     /* Generic, PCI class code for AHCI */
>     { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -      0x010601, 0xffffff, board_ahci },
> +      PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
> 
>     { }    /* terminate list */
> };
> @@ -1586,11 +1586,11 @@
>         speed_s = "?";
> 
>     pci_read_config_word(pdev, 0x0a, &cc);
> -    if (cc == 0x0101)
> +    if (cc == PCI_CLASS_STORAGE_IDE)
>         scc_s = "IDE";
> -    else if (cc == 0x0106)
> +    else if (cc == PCI_CLASS_STORAGE_SATA)
>         scc_s = "SATA";
> -    else if (cc == 0x0104)
> +    else if (cc == PCI_CLASS_STORAGE_RAID)
>         scc_s = "RAID";
>     else
>         scc_s = "unknown";
> diff -Nur linux-2.6.20-rc1.orig/include/linux/pci_ids.h
> linux-2.6.20-rc1/include/linux/pci_ids.h
> --- linux-2.6.20-rc1.orig/include/linux/pci_ids.h    2006-12-20
> 10:24:51.000000000 +0800
> +++ linux-2.6.20-rc1/include/linux/pci_ids.h    2006-12-20 
> 11:45:07.000000000 +0800
> @@ -15,6 +15,8 @@
> #define PCI_CLASS_STORAGE_FLOPPY    0x0102
> #define PCI_CLASS_STORAGE_IPI        0x0103
> #define PCI_CLASS_STORAGE_RAID        0x0104
> +#define PCI_CLASS_STORAGE_SATA        0x0106
> +#define PCI_CLASS_STORAGE_SATA_AHCI    0x010601
> #define PCI_CLASS_STORAGE_SAS        0x0107
> #define PCI_CLASS_STORAGE_OTHER        0x0180
> 
> 
> BTW, the 2 patches above are just my suggestion, not formal patch. If
> either of them is acceptible, I will send out a formal patch. Thanks!

The above seems OK to me...

	Jeff


