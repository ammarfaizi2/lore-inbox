Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289487AbSA2Kmq>; Tue, 29 Jan 2002 05:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289481AbSA2Kmh>; Tue, 29 Jan 2002 05:42:37 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:55955 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S289462AbSA2KmW>;
	Tue, 29 Jan 2002 05:42:22 -0500
Date: Tue, 29 Jan 2002 11:42:07 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: Tim Moore <timothymoore@bigfoot.com>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.21pre2; ide_set_handler; DMA timeout
In-Reply-To: <3C562B7C.A9BF209C@bigfoot.com>
Message-ID: <Pine.LNX.4.33.0201291122500.16536-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

On Mon, 28 Jan 2002, Tim Moore wrote:

> 2.2.21pre2 + ide.2.2.21.05042001-Ole.patch + raid-2.2.20-A0
> Abit BP6 w EC10, RU BIOS, 1.28 hpt366 BIOS
>
> Got this error
>
> hdi: timeout waiting for DMA
> hdi: ide_dma_timeout: Lets do it again!stat = 0x58, dma_stat = 0x20
> hdi: DMA disabled
> hdi: irq timeout: status=0xd0 { Busy }
> hdi: DMA disabled
> hdi: ide_set_handler: handler not null; old=c019c89c, new=c019c89c
> bug: kernel timer added twice at c019c73e.
> ide4: reset: success
>
> during I/O testing on a RAID0 set but no freeze, crash or oops.
> Hopefully there are not SMP spinlock problems still hanging around.
> I am willing to do specific testing if requested.  Machine data below.
Hm.. ide.2.2.21.05042001-Ole.patch is just Hedrick's ide.2.2.19.05042001.patch
modified to apply cleanly to 2.2.21pre2+new via driver. Did you have this
problem before (2.2.19/2.2.20)?

> Also note CPU ID reporting changed from 2.2.20 as this board
> has always running PGA370 Celeron 533's which used to be correctly
> identified "Intel Celeron (Mendocino) stepping 05" and are now
> incorrectly identified "Intel Mobile Pentium II stepping 05".
Hm.. That is strange. You should ask Alan Cox. He is the maintainer of
2.2.x kernels.

> smp kernel: HPT366: onboard version of chipset, pin1=1 pin2=2
> smp kernel: PCI: HPT366: Fixing interrupt 18 pin 2 to ZERO
> smp kernel: HPT366: IDE controller on PCI bus 00 dev 99
> smp kernel: HPT366: chipset revision 1
> smp kernel: HPT366: not 100% native mode: will probe irqs later
> smp kernel:     ide4: BM-DMA at 0xc000-0xc007, BIOS settings: hdi:pio, hdj:pio
<CIACH>
> smp kernel: hdi: FUJITSU MPE3084AE, ATA DISK drive

Is this FUJITSU (hdi) connected to HPT? If so, the problem may be in hpt
driver. You may check some more recent version of IDE backport from
2.4.x: http://www.ans.pl/ide/testing - the latest is ide.2.2.21.01282002-Ole,
but the new version of hpt driver has not been yet backported. I'm going
to do it tomorrow.


Best regards,

				Krzysztof Oledzki

