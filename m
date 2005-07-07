Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVGGKeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVGGKeC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVGGKeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:34:02 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:16275 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S261171AbVGGKdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:33:54 -0400
Date: Thu, 7 Jul 2005 13:33:46 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 hangs at boot
In-Reply-To: <20050707135928.A3314@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
 <9e47339105070618273dfb6ff8@mail.gmail.com> <20050707135928.A3314@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Thu, 07 Jul 2005 13:33:47 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Ivan Kokshaysky wrote:

> On Wed, Jul 06, 2005 at 09:27:11PM -0400, Jon Smirl wrote:
> > I'm dead on a Dell PE400SC without reverting this.
>
> Jon, can you try this one instead:
> http://lkml.org/lkml/2005/7/6/273
>
> If it doesn't help, I'd like to see 'lspci -vv' from your machine.
>
> Ivan.
>

Hi,

I tested that patch, but it didn't work.

When I boot 2.6.12 or 2.6.13-rc1 everything is fine.

Working 2.6.12 prints this while booting:

...
hda: IBM-DPLA-25120, ATA DISK drive
hdb: SANYO CRD-S372B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 10009440 sectors (5124 MB) w/468KiB Cache, CHS=10592/15/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 > hda4
...

2.6.13-rc2 with and without tested patch display this:
...
hda: cache flushes not supported
 hda: hda1 hda2 hda3 <

Then it hangs for a while and shows something like this:

dma_timer_expiry: dma status == 0x61

thanks,
Tero Roponen


lspci -vv output:


00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 64
	Region 0: Memory at <unassigned> (32-bit, prefetchable)

00:02.0 CardBus bridge: Texas Instruments PCI1250 (rev 02)
	Subsystem: IBM ThinkPad 600
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 04000000-043ff000 (prefetchable)
	Memory window 1: 04400000-047ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1250 (rev 02)
	Subsystem: IBM ThinkPad 600
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 51000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 04800000-04bff000 (prefetchable)
	Memory window 1: 04c00000-04fff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:03.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] (rev 01) (prog-if 00 [VGA])
	Subsystem: IBM MagicGraph 128XD
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 48000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at 49000000 (32-bit, non-prefetchable) [size=2M]
	Region 2: Memory at 49400000 (32-bit, non-prefetchable) [size=1M]

00:06.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:06.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at fcf0 [size=16]

00:06.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 48
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 9000 [size=32]

00:06.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

