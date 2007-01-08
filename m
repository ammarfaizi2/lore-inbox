Return-Path: <linux-kernel-owner+w=401wt.eu-S1750996AbXAHTnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbXAHTnw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbXAHTnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:43:51 -0500
Received: from waikiki.ops.eusc.inter.net ([84.23.254.155]:53338 "EHLO
	waikiki.ops.eusc.inter.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750996AbXAHTnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:43:50 -0500
X-Greylist: delayed 2116 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 14:43:50 EST
X-Trace: 4d7c6d2e6275656b6572406265726c696e2e64657c39312e36342e302e3139397c
	3148337a72452d3030304c6b302d47467c31313638323833333132
Message-ID: <45A29690.3040003@berlin.de>
Date: Mon, 08 Jan 2007 20:08:00 +0100
From: Michael Bueker <m.bueker@berlin.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: No DMA with HTP370 IDE controller
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[please CC me upon replying - thank you]

I have a Highpoint 370 PCI IDE controller, and both my 2.6.18.2 and 
Knoppix 5's 2.6.17 display the following messages:

> HPT370: IDE controller at PCI slot 0000:01:09.0
> HPT370: chipset revision 3
> HPT370: 100% native mode on irq 11
> HPT37X: using 33MHz PCI clock
>     ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:DMA
> HPT37X: using 33MHz PCI clock
>     ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
> Probing IDE interface ide2...
> hde: ST340823A, ATA DISK drive
> hdf: ExcelStor Technology J840, ATA DISK drive
> ide2 at 0x9000-0x9007,0x9402 on irq 11
> Probing IDE interface ide3...
> hdg: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive
> ide3 at 0x9800-0x9807,0x9c02 on irq 11
> hde: max request size: 128KiB
> hde: 78165360 sectors (40020 MB) w/1024KiB Cache, CHS=65535/16/63, UDMA(100)
> hde: cache flushes not supported
>  hde:<4>hde: dma_timer_expiry: dma status == 0x61
> hde: DMA timeout error
> hde: 0 bytes in FIFO
> hde: timeout waiting for DMA
> hde: dma timeout error: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hde: DMA disabled
> hdf: DMA disabled
> ide2: reset: success
>  hde1 hde2 <<4>hde: dma_timer_expiry: dma status == 0x21
> hde: DMA timeout error
> hde: 0 bytes in FIFO
> hde: timeout waiting for DMA
> hde: dma timeout error: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hde: DMA disabled
> ide2: reset: success
>  hde5<4>hde: dma_timer_expiry: dma status == 0x21
> hde: DMA timeout error
> hde: 0 bytes in FIFO
> hde: timeout waiting for DMA
> hde: dma timeout error: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hde: DMA disabled
> ide2: reset: success
>  hde6 >
> hdf: max request size: 512KiB
> hdf: 80418240 sectors (41174 MB) w/1719KiB Cache, CHS=16383/255/63
> hdf: cache flushes supported
>  hdf: unknown partition table
> hde: dma_timer_expiry: dma status == 0x21
> hde: DMA timeout error
> hde: 0 bytes in FIFO
> hde: timeout waiting for DMA
> hde: dma timeout error: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hde: DMA disabled
> ide2: reset: success

(hdf is naked, there's no error in partition detection)

The same messages appear when manually trying to enable DMA with hdparm. 
The hdparm reading of hde is:

> /dev/hde:
>  multcount    = 16 (on)
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 65535/16/63, sectors = 78165360, start = 0

hda, which is on the mainboard controller and works as hde used to as 
well, reads:

> /dev/hda:
>  multcount    = 16 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 65535/16/63, sectors = 117231408, start = 0

In the controller's setup utility, I can choose access modes. If i 
switch it from UDMA5 to PIO0, the only difference during boot is:

> ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio

instead of

> ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:DMA

Please help me getting DMA to work with this controller.

Thanks in advance,
~Mik

-- 
So, how can you tell me you're lonely?
And say that you don't have no life?
Let me take you by the hand and show you all the geeks of London
I'll show you something to make you change your mind!
