Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267587AbSLNKVD>; Sat, 14 Dec 2002 05:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267590AbSLNKVD>; Sat, 14 Dec 2002 05:21:03 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:24495 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267587AbSLNKVB>;
	Sat, 14 Dec 2002 05:21:01 -0500
Date: Sat, 14 Dec 2002 11:28:42 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Aryix <aryix@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx probable incorrect detection (urgency=low)........
Message-ID: <20021214112842.A8790@ucw.cz>
References: <courier.3DF9A5CE.00001047@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <courier.3DF9A5CE.00001047@softhome.net>; from aryix@softhome.net on Thu, Dec 12, 2002 at 08:14:53AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 08:14:53AM -0300, Aryix wrote:
> I am Argentino <- i don't speak english, please be patient
> 
> Kernel-2.4.20-final
> 
> lspci -vvv
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8
> a [Master SecP PriP])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 32
>         Region 4: I/O ports at d000 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
> -,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 
> 
> cat /proc/pci
>  Bus  0, device   7, function  0:
>     ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 33).
>   Bus  0, device   7, function  1:
>     IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 16).
>       Master Capable.  Latency=32.  
>       I/O at 0xd000 [0xd00f].
> 
> dmesg 
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 16
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx <- is my error?
> VP_IDE: VIA vt82c686a (rev 21) IDE UDMA66 controller on pci00:07.1
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: QUANTUM FIREBALLlct20 30, ATA DISK drive
> hdc: ST36421A, ATA DISK drive
> hdd: ATAPI 44X CDROM, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> blk: queue c030a5c4, I/O limit 4095Mb (mask 0xffffffff)
> hda: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=3649/255/63, (U)DMA <- ??????????

The drive doesn't say to the OS which DMA mode is enabled on it.

> blk: queue c030a928, I/O limit 4095Mb (mask 0xffffffff)
> hdc: 12596850 sectors (6450 MB) w/256KiB Cache, CHS=13330/15/63, UDMA(66) <- this is ok
> hdd: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33) <- ok!
> 
> i have a chip via82c686a (Epox 7-kxa)
> at boot time is been detected via82c686a
> proc says via82c586b
> lspci -vvv no says 

Because all VIA IDE chips say they're 586b.

> the udma capabilities is not work propetly i set manually with "hdparm -m 8 -W 1 -X udma5 /dev/hda"

The chip doesn't support UDMA5. The highest speed it supports
is UDMA3 (UDMA66).

> whats happening here?

Nothing unusual.

-- 
Vojtech Pavlik
SuSE Labs
