Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312576AbSEPNJu>; Thu, 16 May 2002 09:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312581AbSEPNJt>; Thu, 16 May 2002 09:09:49 -0400
Received: from dc-mx13.cluster1.charter.net ([209.225.8.23]:48545 "EHLO
	dc-mx13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S312576AbSEPNJs>; Thu, 16 May 2002 09:09:48 -0400
To: linux-kernel@vger.kernel.org
Subject: Kernel PCMCIA/CardBus on a Tecra 8200
From: Norman Walsh <ndw@nwalsh.com>
X-URL: http://nwalsh.com/
Date: Thu, 16 May 2002 09:09:35 -0400
Message-ID: <874rh8jl2o.fsf@nwalsh.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having no luck getting kernel PCMCIA/CardBus support working on my
Toshiba Tecra 8200 laptop. My conclusion that it's a kernel issue (because
pcmcia-cs works fine if I disable kernel PCMCIA) may be in error. (I need
kernel PCMCIA/CardBus support because that's what the IEEE1394 drivers
require and I'm hoping to use, um, an IEEE1394 driver ;-)

lspci -vv reports

02:0c.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Lucent Technologies: Unknown device ab01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f7d00000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:0d.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 31)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f7d01000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:0d.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 31)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at f7d02000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

But I've been told that the bridge is in fact a ToPIC100 and that some mapping file
is apparently out-of-date. I'm not sure.

Anyway, with 2.4.18 (of my own construction) on a Debian (woody) box
with Kernel PCMCIA/CardBus support, booting reports

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 02:0c.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 02:0c.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Sharing IRQ 11 with 02:0d.0
PCI: Enabling device 02:0d.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 02:0d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Sharing IRQ 11 with 02:0c.0
PCI: Enabling device 02:0d.1 (0000 -> 0002)
PCI: Found IRQ 11 for device 02:0d.1
PCI: Sharing IRQ 11 with 00:1f.2
PCI: Sharing IRQ 11 with 02:07.0
Yenta IRQ list 0000, PCI irq11
Socket status: 30000011
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000007
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000007

which looks ok (to my naive eyes). But when booting finishes and I run
'cardctl ident' (from pcmcia-cs 3.1.33, I suppose), I get:

Socket 0:
cs: warning: no high memory space available!
cs: unable to map card memory!
Socket 1:
cs: unable to map card memory!
Socket 2:
cs: unable to map card memory!

That happens the first time. If I run cardctl ident again, it just
says "no product info available" for all three slots. (The 8200 has a
builtin wifi, so there's always something in slot 0.)

Building PCMCIA/CardBus into the kernel (instead of modules) doesn't
change anything.

I'm looking for hints or suggestions. I'm happy to hack about in the
kernel and provide more debugging info, if that'll help.

                                        Be seeing you,
                                          norm

P.S. Jonathan Buzzard has the same model laptop and it works for him,
so it seems reasonable to assume I'm being an idiot, but I'd be ever
so grateful if someone could give me a clue about precisely what kind
of idiot I'm being in this case :-)

-- 
Norman Walsh <ndw@nwalsh.com> | Impatient people always arrive too
http://nwalsh.com/            | late.--Jean Dutourd
