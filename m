Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130581AbRCIRHj>; Fri, 9 Mar 2001 12:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130580AbRCIRH3>; Fri, 9 Mar 2001 12:07:29 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:62475 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S130579AbRCIRHX>; Fri, 9 Mar 2001 12:07:23 -0500
Date: Fri, 9 Mar 2001 09:06:41 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18, Intel i815 chipset and DMA
Message-ID: <20010309090641.C13905@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Gateway here with a Intel 815 chipset running 2.2.18.  Inside
it's a PIII 733 with 512MB and a Quantum lct15 drive.

The problem is that the IDE driver doesn't recognize the IDE
conroller, so DMA isn't enabled leading to some poor drive
performance.  Here's the relevant sections from lspci -v and the boot
logs, any chance of getting DMA working?  Is it safe to use hdparm to
turn it on?  The drive should be capable of 10-20MB/s, but I'm
only getting about 4MB/s with hdparm.  :-(

-Dave

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
        Flags: bus master, fast devsel, latency 0
        Memory at f8000000 (32-bit, prefetchable)
        Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: f0700000-f47fffff

00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fc900000-fc9fffff
        Prefetchable memory behind bridge: f0600000-f06fffff

00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev 01)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 244b (rev 01) (prog-if 80 [Master])
        Subsystem: Gateway 2000: Unknown device 0058
        Flags: bus master, medium devsel, latency 0
        I/O ports at ffa0

00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Gateway 2000: Unknown device 0058
        Flags: bus master, medium devsel, latency 0, IRQ 3
        I/O ports at ef40

00:1f.3 SMBus: Intel Corporation: Unknown device 2443 (rev 01)
        Subsystem: Gateway 2000: Unknown device 0058
        Flags: medium devsel, IRQ 10
        I/O ports at efa0

00:1f.4 USB Controller: Intel Corporation: Unknown device 2444 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Gateway 2000: Unknown device 0058
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at ef80

------------

PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=244b
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLlct15 15, ATA DISK drive
hdb: QUANTUM FIREBALLlct20 20, ATA DISK drive
hdc: _NEC DV-5700A, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: QUANTUM FIREBALLlct15 15, 14324MB w/418kB Cache, CHS=1826/255/63
hdb: QUANTUM FIREBALLlct20 20, 19470MB w/418kB Cache, CHS=2482/255/63
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache

------------

# hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1826/255/63, sectors = 29336832, start = 0

# hdparm -i /dev/hda

/dev/hda:

 Model=QUANTUM FIREBALLlct15 15, FwRev=A01.0F00, SerialNo=612020812285
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=29336832
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 

# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.90 seconds =142.22 MB/sec
 Timing buffered disk reads:  64 MB in 15.84 seconds =  4.04 MB/sec


