Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbQLKUve>; Mon, 11 Dec 2000 15:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbQLKUvY>; Mon, 11 Dec 2000 15:51:24 -0500
Received: from front3m.grolier.fr ([195.36.216.53]:33269 "EHLO
	front3m.grolier.fr") by vger.kernel.org with ESMTP
	id <S129716AbQLKUvK> convert rfc822-to-8bit; Mon, 11 Dec 2000 15:51:10 -0500
Date: Mon, 11 Dec 2000 20:20:20 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: davej@suse.de, Martin Mares <mj@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <20001211002850.A14393@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.10.10012111956510.1805-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2000, Jamie Lokier wrote:

> Here are a few more:
> 
>  net/acenic.c: pci_write_config_byte(ap->pdev, PCI_CACHE_LINE_SIZE,
>  net/gmac.c: PCI_CACHE_LINE_SIZE, 8);

>  scsi/sym53c8xx.c: printk(NAME53C8XX ": PCI_CACHE_LINE_SIZE set to %d (fix-up).\n",

For this one, this happens on Intel:

- ONLY if PCI cache line size was configured to ZERO (i.e. not
  configured).

     AND

- ONLY if user asked for this through the boot command line.

Anyway, the driver WARNs user about if it shoe-horns some value as you can
see above.

Btw, there is a single case where using MWI is a workaround.

Given that all known systems have a known PCI CACHE LINE SIZE for L2/L3,
if POST software + O/S PCI driver are loose enough not to provide the
RIGHT value of the PCI CACHE LINE LINE for devices that support it, what
software drivers can do ?

May-be, they should just refuse to attach the device, at least when this
information _must_ be known in order to work-around a device problem. This
will remove some ugly code for non-Intel plat-forms from the sym53c8xx
source, by the way.

Having to call some pdev_enable_device() to have the cache line size
configured looks like shit to me. After all, the BARs, INT, LATENCY TIMER,
etc.. are configured prior to entering driver probe. Why should the cache
line size be deferred to some call to some obscure mismaned thing ?

[...]

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
