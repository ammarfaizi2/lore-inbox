Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUGWOWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUGWOWf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 10:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267755AbUGWOWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 10:22:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:39067 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264045AbUGWOW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 10:22:29 -0400
Date: Fri, 23 Jul 2004 16:21:48 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackeras <paulus@samba.org>
Subject: Re: reserve legacy io regions on powermac
Message-ID: <20040723142148.GC9715@suse.de>
References: <20040721091249.GA1336@suse.de> <1090421466.2002.24.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1090421466.2002.24.camel@gaston>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jul 21, Benjamin Herrenschmidt wrote:

> Note that this is still all workarounds... Nothing prevents you (and some
> people actually do that) to put a PCI card with legacy serial ports on it
> inside a pmac....

I just tried it on a powerbook pismo, its a pccard combo card, network
and modem. Unmodified 2.6.8-rc2 kernel.

putting this into pmac_pcibios_fixup() will break pcmcia.

request_region(0x0UL, 0x1000UL, "reserved legacy io");


0001:01:1a.0 CardBus bridge: Texas Instruments PCI1211
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 58
        Region 0: Memory at a0000000 (32-bit, non-prefetchable)
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 90000000-9ffff000 (prefetchable)
        Memory window 1: f3000000-f31ff000
        I/O window 0: 00001000-00008fff
        I/O window 1: 00009000-000090ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001


Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0001:01:1a.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0001:01:1a.0, mfunc 0x00000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 58
Socket status: 30000006

cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
cs: memory probe 0xa0000000-0xa0ffffff: excluding 0xa0000000-0xa00fffff
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
IN from bad port 3f9 at cdc1b030
IN from bad port 3f9 at cdc1b030
IN from bad port 3f9 at cdc1b030
IN from bad port 2f9 at cdc1b030
IN from bad port 2f9 at cdc1b030
IN from bad port 2f9 at cdc1b030
IN from bad port 3e9 at cdc1b030
IN from bad port 3e9 at cdc1b030
IN from bad port 3e9 at cdc1b030
IN from bad port 2e9 at cdc1b030
IN from bad port 2e9 at cdc1b030
IN from bad port 2e9 at cdc1b030
eth%d: autonegotiation failed; using 10mbs
eth%d: MII selected
eth%d: media 10BaseT, silicon revision 5
eth1: Compaq: port 0x300, irq 58, hwaddr 00:08:C7:64:68:7B
ttyS3 at I/O 0x2e8 (irq = 58) is a 16550A

Module                  Size  Used by
serial_cs              11484  1 
8250                   24036  1 serial_cs
serial_core            26752  1 8250
xirc2ps_cs             29904  1 
sg                     38756  0 
st                     43004  0 
sd_mod                 22176  0 
sr_mod                 20068  0 
scsi_mod              139276  4 sg,st,sd_mod,sr_mod
ohci1394               40036  0 
ieee1394              125128  1 ohci1394
ohci_hcd               25476  0 
sungem                 34788  0 
crc32                   4736  1 sungem
sungem_phy              9856  1 sungem
ds                     22916  4 serial_cs,xirc2ps_cs
yenta_socket           22688  1 
pcmcia_core            73876  4 serial_cs,xirc2ps_cs,ds,yenta_socket

 /proc/ioports 
00000000-007fffff : /pci@f2000000
  000002e8-000002ef : pcmcia_socket0
    000002e8-000002ef : serial
  00000300-0000030f : pcmcia_socket0
  00001000-00008fff : PCI CardBus #02
  00009000-000090ff : PCI CardBus #02
00802000-01001fff : /pci@f0000000
  00802400-008024ff : 0000:00:10.0
ff7fe000-ffffdfff : /pci@f4000000
 /proc/iomem
80000000-afffffff : /pci@f2000000
  80000000-8007ffff : 0001:01:17.0
    80000034-80000034 : media-bay
    80008a00-80008aff : ide-pmac (dma)
    80008b00-80008bff : ide-pmac (dma)
    80008c00-80008cff : ide-pmac (dma)
    80016000-80017fff : via-pmu
    8001f000-8001ffff : ide-pmac (ports)
    80020000-80020fff : ide-pmac (ports)
    80040000-8007ffff : interrupt-controller
  90000000-9fffffff : PCI CardBus #02
  a0000000-a0000fff : 0001:01:1a.0
    a0000000-a0000fff : yenta_socket
  a0001000-a0001fff : 0001:01:19.0
    a0001000-a0001fff : ohci_hcd
  a0002000-a0002fff : 0001:01:18.0
    a0002000-a0002fff : ohci_hcd
  a0100000-a0100fff : pcmcia_socket0
  a0101000-a0101fff : pcmcia_socket0
b0000000-bfffffff : /pci@f0000000
  b0000000-b0003fff : 0000:00:10.0
    b0000000-b0003fff : aty128fb MMIO
  b4000000-b7ffffff : 0000:00:10.0
    b4000000-b7ffffff : aty128fb FB
f1000000-f1ffffff : /pci@f0000000
f3000000-f3ffffff : /pci@f2000000
  f3000000-f31fffff : PCI CardBus #02
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : 0002:06:0e.0
    f5000000-f50007ff : ohci1394
  f5200000-f53fffff : 0002:06:0f.0
    f5200000-f53fffff : sungem
f8000000-f8ffffff : uni-n


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
