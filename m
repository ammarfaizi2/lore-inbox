Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310309AbSCGNAa>; Thu, 7 Mar 2002 08:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310311AbSCGNAU>; Thu, 7 Mar 2002 08:00:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45837 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310309AbSCGNAS>; Thu, 7 Mar 2002 08:00:18 -0500
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
To: hanky@promise.com.tw (Hank Yang)
Date: Thu, 7 Mar 2002 13:15:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        crimsonh@promise.com.tw (Crimson Hung),
        jennyl@promise.com.tw (Jenny Liang),
        linusc@promise.com.tw (Linus Chen)
In-Reply-To: <014701c1c5b6$a0dfb620$59cca8c0@hank> from "Hank Yang" at Mar 07, 2002 05:01:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ixk4-0002D4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel Version: linux kernel 2.4.18

The big IDE update is going into 2.4.19pre. Thats going to overlap with this
patch I suspect. You might want to cross check with 2.4.19pre3 when it
appears and see how much you can remove.

> + * Support UltraDMA Mode 6 and 48 bit LBA Mode.
> + * Powered by PROMISE Technology, Inc. Portions Copyright (C)2001.
> + */
> +#define PCI_VENDOR_ID_PROMISE 0x105a

This define is already in pci_ids.h so shouldnt be needed here. Check the
file includes <linux/pci_ids.h>

>   /* Give size in megabytes (MB), not mebibytes (MiB). */
>   /* We compute the exact rounded value, avoiding overflow. */
> - printk (" (%ld MB)", (capacity - capacity/625 + 974)/1950);
> + printk (" (%ld GB)", ((capacity - capacity/625 + 974)/1950)/1024);

We use Mb for a reason (old disks look odd) - maybe using Gb once its >=
2Gb would work to make it look neater ?

>  {
> + if (HWIF(drive)->pci_devid.vid==0x105a)

elsewhere you switched to PCI_VENDOR_ID_PROMISE ? - trivial question

> -#define DEVID_PDC20268  ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
> PCI_DEVICE_ID_PROMISE_20268})
> -#define DEVID_PDC20268R ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE,
> PCI_DEVICE_ID_PROMISE_20268R})

You've removed the raid ones. The driver has to find those so that
the ataraid driver can then sit on top of them. 

Other than that it looks pretty sound. Your mailer seems to have messed
the tabs up so once 19pre3 appears and you've had a look at it can you
send me a copy as an attachment ?

Thanks
Alan
