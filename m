Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273507AbRIYUXX>; Tue, 25 Sep 2001 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273506AbRIYUXO>; Tue, 25 Sep 2001 16:23:14 -0400
Received: from jgateadsl.cais.net ([205.252.5.196]:56870 "EHLO
	tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S273505AbRIYUXC>; Tue, 25 Sep 2001 16:23:02 -0400
Date: Tue, 25 Sep 2001 16:23:22 -0400 (EDT)
From: Maxwell Spangler <maxwax@mindspring.com>
X-X-Sender: <maxwell@tyan.doghouse.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Greg Ward <gward@python.net>, David Grant <davidgrant79@hotmail.com>,
        <bugs@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
In-Reply-To: <E15kpB7-0003XS-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109251614330.5310-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[deleted information about ide DMA timeouts and alan writes:]

On Sat, 22 Sep 2001, Alan Cox wrote:
> The timeout is it issuing DMA requests that failed.

> Older trees take one DMA timeout and go PIO. That turns out to be bad
> because very very occasionally other things (I guess drive calibration etc)
> will cause the DMA to timeout.
>
> With the 2.4.9-ac tree I have two boxes which get DMA timeouts. One of them
> very very rarely and the retry recovers nicely, the other DMA does not work
> and after poking around I discovered windows also disables DMA on this
> mini notebook..

I have an otherwise rock solid system which has been experiencing DMA timeouts
for some time.  This is a Tyan Tiger100 (Intel BX chipset) with two PII-400Mhz
processors, 512M Corsair RAM, at least one Promise Ultra66 or Ultra100
controller, and two IBM Deskstar drives.

When it runs, it runs well, but occasionally I'll find this in the logs.  This
hsould be 2.2.8:

Sep 13 22:19:50 tyan kernel: hde: timeout waiting for DMA
Sep 13 22:19:52 tyan kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Sep 13 22:19:52 tyan kernel: hde: irq timeout: status=0x50 { DriveReady SeekComplete }
Sep 13 22:20:12 tyan kernel: hde: timeout waiting for DMA
Sep 13 22:20:13 tyan kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Sep 13 22:20:13 tyan kernel: hde: irq timeout: status=0x50 { DriveReady SeekComplete }
Sep 13 22:20:34 tyan kernel: hde: timeout waiting for DMA
Sep 13 22:20:35 tyan kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Sep 13 22:20:35 tyan kernel: hde: irq timeout: status=0x50 { DriveReady SeekComplete }
Sep 13 22:20:56 tyan kernel: hde: timeout waiting for DMA
Sep 13 22:20:56 tyan kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Sep 13 22:20:56 tyan kernel: hde: irq timeout: status=0x50 { DriveReady SeekComplete }
Sep 13 22:20:59 tyan kernel: hde: DMA disabled
Sep 13 22:20:59 tyan kernel: ide2: reset: success
Sep 14 04:02:19 tyan kernel: hdg: timeout waiting for DMA
Sep 14 04:02:20 tyan kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Sep 14 04:02:20 tyan kernel: hdg: irq timeout: status=0x50 { DriveReady SeekComplete }
Sep 14 04:02:29 tyan kernel: hde: lost interrupt
Sep 14 04:02:41 tyan kernel: hdg: timeout waiting for DMA
Sep 14 04:02:42 tyan kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Sep 14 04:02:42 tyan kernel: hdg: irq timeout: status=0x50 { DriveReady SeekComplete }
Sep 14 04:03:03 tyan kernel: hdg: timeout waiting for DMA
Sep 14 04:03:04 tyan kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Sep 14 04:03:04 tyan kernel: hdg: irq timeout: status=0x50 { DriveReady SeekComplete }
Sep 14 04:03:13 tyan kernel: hde: lost interrupt
Sep 14 04:03:25 tyan kernel: hdg: timeout waiting for DMA
Sep 14 04:03:25 tyan kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Sep 14 04:03:25 tyan kernel: hdg: irq timeout: status=0x50 { DriveReady SeekComplete }
Sep 14 04:03:25 tyan kernel: hdg: DMA disabled
Sep 14 04:03:26 tyan kernel: ide3: reset: success
Sep 14 04:04:17 tyan kernel: hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Sep 14 04:04:17 tyan kernel: hde: drive not ready for command
Sep 14 04:04:34 tyan kernel: hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Sep 14 04:04:34 tyan kernel: hde: drive not ready for command
Sep 14 04:04:42 tyan kernel: hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Sep 14 04:04:42 tyan kernel: hdg: drive not ready for command
Sep 14 10:20:33 tyan kernel: hde: irq timeout: status=0xd0 { Busy }
Sep 14 10:20:34 tyan kernel: ide2: reset: success

I've regularly found this occuring at 4AM.  Anybody have any idea why?
Perhaps the drive is sleeping due to no other activity and sudenly the cron
activities attempt to use the drive before it's ready?

A reboot resets my system to happy operation but it happens again some hours
or days later.

I'm on 2.2.10 now--wondering if the behaviour to retry DMA timeouts more than
once is in my kernel?

Nice to see someone else is having this problem other than me.

fyi:

[root@tyan /root]# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev
03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:11.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:12.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev
01)
00:13.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 02)
00:14.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10]
(rev 08)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)

-------------------------------------------------------------------------------
Maxwell Spangler
Program Writer
Greenbelt, Maryland, U.S.A.
Washington D.C. Metropolitan Area

