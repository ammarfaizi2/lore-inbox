Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUIUOv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUIUOv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUIUOv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:51:58 -0400
Received: from [217.153.99.178] ([217.153.99.178]:53386 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267730AbUIUOvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:51:51 -0400
Date: Tue, 21 Sep 2004 16:54:51 +0200
From: Przemyslaw Hausman <hausman@grafit.mech.pw.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: udma5 Hard Drive + SiI680 = udma3 (or less) Hard Drive
Message-ID: <20040921145451.GA24951@reynevan>
Reply-To: hausman@grafit.mech.pw.edu.pl
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

ATA100 HD connected to ATA133 PCI IDE controller (SiI680) works
like it was ATA33 HD.

I have PCI ATA Controller based on SiI680 chip (with RAID). To its
primary channel is connected WD Caviar 80 GB, ATA100 hard drive
(WD800JB-00ETA0). hdparm says, that this HD is udma5 but `hdparm -t
/dev/hde` suggests something else.

I have the same problem on 2.4.20, 2.6.2 and 2.6.8.1 kernels.

This is my hardware:


1. Motherboard
~~~~~~~~~~~~~~
Model: P6BAT A+
Vendor: Elite Computer Systems Co.
Chipset: ET82C693/596A

The board is compiliant with PCI Rev. 2.1 operating at 33 MHz


2. Hard drive
~~~~~~~~~~~~~

# hdparm -i /dev/hde

/dev/hde:

 Model=WDC WD800JB-00ETA0, FwRev=77.07W77, SerialNo=WD-WMAHL1879422
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs
FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16,
MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5 6

----------------------------------------------------------------------

# dmesg
[...]
hde: WDC WD800JB-00ETA0, ATA DISK drive
ide2 at 0xc8c03080-0xc8c03087,0xc8c0308a on irq 11
hde: max request size: 64KiB
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 >
[...]

----------------------------------------------------------------------

# hdparm -t /dev/hde

/dev/hde:
 Timing buffered disk reads:  64 MB in  2.59 seconds = 24.70 MB/sec

----------------------------------------------------------------------

# hdparm -tT /dev/hde

/dev/hde:
 Timing buffer-cache reads:   128 MB in  2.19 seconds = 58.38 MB/sec
 Timing buffered disk reads:  64 MB in  2.48 seconds = 25.80 MB/sec

----------------------------------------------------------------------

# hdparm /dev/hde

/dev/hde:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 16383/255/63, sectors = 156301488, start = 0


3. PCI IDE Controller
~~~~~~~~~~~~~~~~~~~~~
# lspci -vvvv
[...]
00:0c.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 02)
        Subsystem: CMD Technology Inc: Unknown device 3680
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr-
	Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, cache line size 01
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 2: I/O ports at dc00 [size=8]
        Region 3: I/O ports at e000 [size=4]
        Region 4: I/O ports at e400 [size=16]
        Region 5: Memory at ea000000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at e9000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
	Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
	    PME(D0-,D1-,D2-,D3hot-,D3cold-) 
	Status: D0 PME-Enable- DSel=0 DScale=2 PME-
[...]

----------------------------------------------------------------------

# dmesg
[...]
SiI680: IDE controller at PCI slot 0000:00:0c.0
PCI: Found IRQ 11 for device 0000:00:0c.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 11
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
[...]


Even, when I set `hdparm -m 10 -c 3 -u 1 /dev/hde` I have the same
test results (hdparm -t and -tT).

I have discussed about this on polish linux news-group --
there were a few people, who had the same problem with SiI PCI IDE
controllers.

Best Regards,
Przemyslaw Hausman
