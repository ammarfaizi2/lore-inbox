Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWE1MGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWE1MGy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 08:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWE1MGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 08:06:54 -0400
Received: from rtr.ca ([64.26.128.89]:60334 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750749AbWE1MGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 08:06:53 -0400
Message-ID: <4479925C.2070909@rtr.ca>
Date: Sun, 28 May 2006 08:06:52 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Query: No IDE DMA for IBM 365X with PIIX chipset?
References: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com>
In-Reply-To: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> Hi there,
> 
> Have an old Thinkpad 365X laptop that 'hdparm -i' tells me is 
> running mdma2 but it refuses to set dma mode.  2.6.16.18 also 
> refuses to set dma.
...

No luck with "hdparm -d1 /dev/hda" ??

> ...
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIXa: IDE controller at PCI slot 00:01.0
> PIIXa: chipset revision 2
> PIIXa: not 100% native mode: will probe irqs later
> PIIXa: neither IDE port enabled (BIOS)
> hda: TOSHIBA MK6014MAP, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 11733120 sectors (6007 MB), CHS=776/240/63
> Partition check:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
...

Mmm.. there's a curious line: "PIIXa: neither IDE port enabled (BIOS)".
Can you enable DMA in the BIOS?  The IDE driver seems to be unwilling
to set up the bus-master DMA (BMDMA) portion of the chip unless
it was already initialized by the BIOS (paranoia, I suppose, or maybe a bug).

Cheers
