Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbTHWKKL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 06:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbTHWKKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 06:10:10 -0400
Received: from mail.mediaways.net ([193.189.224.113]:15804 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262462AbTHWKKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 06:10:03 -0400
Subject: HPT37x hangs on bus load (IDE DMA hangs on KT400 (shared IRQ
	problem?))
From: Soeren Sonnenburg <kernel@nn7.de>
To: chuck@encinc.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061632825.13919.18.camel@localhost>
Mime-Version: 1.0
Date: 23 Aug 2003 12:00:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a machine with a Soyo Dragon motherboard (Via KT400 chipset). It has
> an onboard Highpoint HPT372 IDE controller in addition to the Via
> chipset's. I run into trouble reading from these drives with DMA enabled at
> the same time as heavy network activity. (a hang with or without errors or
> a panic, depending on the kernel version). If it manages to work for a few
> minutes, I'll get corruption on the disk reads. With DMA off, everything
> seems OK.

Wow, that seems to be exactly/very close to the problem that I do
observe. When I turn off DMA everything is fine here too.

> IRQ 11 is shared between two of these controllers and the network interface.
> Also sharing that IRQ is a SCSI controller I'm booting off of, but activity on
> that device at the same time as the others doesn't seem to cause any problem.
>
> With 2.4.22-rc2 and 2.6.0-test3, I get these messages:
>
> hdc: dma_timer_expiry: dma status == 0x24

I get mostly nothing (i.e. just a hang, where num look etc is ok, but
the ide stuff seems to wait forever sysrq-t/b is no longer working or
u/s finally hangs the machine completely (no more num working).

Sometimes I see this: 
hde: dma_intr: bad DMA status (dma_stat=76)
hde: dma_intr: status=0x50 { DriveReady SeekComplete }


I have a hpt370a which does not share interrupts. When I play a movie
through a dxr3 while causing some disk activity the machine hangs sooner
or later.

This happens without on a asus a7v8x (KT400 via) with highmem disabled
all pci cards - except for the dxr3 a plain s3 graphics adapter and the
htp370 card - removed.

My guess is that the hpt driver is waiting for some event that never
happens... maybe because it gets interrupted by the network device or
the dxr3 in my case.

that happens with kernel versions 2.4.21 and 2.4.22-rc2 here.

does anyone know where it could hang ?

Soeren.

