Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUCRChR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 21:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUCRChR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 21:37:17 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42659 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262347AbUCRChL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 21:37:11 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Dave Croal <dcroal@cantecsystems.com>
Subject: Re: PROBLEM: alim15x3 later than 2.6.1 won't allow DMA to be turned on
Date: Thu, 18 Mar 2004 03:45:42 +0100
User-Agent: KMail/1.5.3
References: <40590737.9060001@cantecsystems.com>
In-Reply-To: <40590737.9060001@cantecsystems.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403180345.42571.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 of March 2004 03:19, Dave Croal wrote:
> The alim15x3 module in kernels 2.6.3 and 2.6.4 does not allow me to turn
> on DMA via hdparm:
>
> hdparm -d1 /dev/hda
> HDIO_SET_DMA failed: Operation not permitted using_dma = 0 (off)
>
> dmesg |grep -i ali
> ALI15X3: IDE controller at PCI slot 0000:00:0f.0
> ALI15X3: chipset revision 32
> ALI15X3: not 100% native mode: will probe irqs later
> ALI15X3: port 0x01f0 already claimed by ide0
> ALI15X3: port 0x0170 already claimed by ide1
> ALI15X3: neither IDE port enabled (BIOS)
>
> ---
>
> In kernel 2.6.1 it worked OK:
>
> hdparm -d1 /dev/hda
> /dev/hda:
>   setting using_dma to 1 (on)
>   using_dma    =  1 (on)
>
> dmesg |grep -i ali
> ALI15X3: IDE controller at PCI slot 0000:00:0f.0
> ALI15X3: chipset revision 32
> ALI15X3: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0x78c0-0x78c7, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0x78c8-0x78cf, BIOS settings: hdc:DMA, hdd:pio
> ide0: I/O resource 0x3F6-0x3F6 not free.
> hda: ERROR, PORTS ALREADY IN USE
> register_blkdev: cannot get major 3 for ide0
> ide1: I/O resource 0x376-0x376 not free.
> hdc: ERROR, PORTS ALREADY IN USE
> register_blkdev: cannot get major 22 for ide1
> Module alim15x3 cannot be unloaded due to unsafe usage in
> include/linux/module.h:483

These are errors - ide0 and ide1 are already used by generic IDE driver.
It was fixed in 2.6.2 but side-effect of the fix is that you must make sure
that ide_generic driver is not compiled in or loaded if it's modular.

Please make sure CONFIG_IDE_GENERIC is 'n' in your .config.

Regards,
Bartlomiej

