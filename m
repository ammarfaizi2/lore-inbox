Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUBDVQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUBDVPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:15:42 -0500
Received: from imh.informatik.uni-bremen.de ([134.102.224.4]:219 "EHLO
	imh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S266509AbUBDVNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:13:45 -0500
Date: Wed, 4 Feb 2004 22:13:38 +0100
From: Sven Schumacher <sschu@informatik.uni-bremen.de>
To: linux-kernel@vger.kernel.org
Subject: DMA BadCRC, cables exchanged, problem resists, any idea?
Message-ID: <20040204211338.GA31768@x20.informatik.uni-bremen.de>
Reply-To: sschu@tzi.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.20-28.9 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got the following error for 3 of my 4 harddrives:

hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdf: DMA disabled
ide2: reset: success
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_timer_expiry: dma status == 0x20
hdg: timeout waiting for DMA

and so on. First I used round IDE-Cables, 80c Ribbon, now I use
flat 80c Ribbon. I tried with an CMD680-IDE-offboad-Controller and
the onboard Promise PDC20276. Both show the same effect. The
onboard-VIA VT 8233 (used for hda) never shows this error.

cat /proc/interrupts:
           CPU0
  0:    1264293    IO-APIC-edge  timer
  1:      23806    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:      10688    IO-APIC-edge  PS/2 Mouse
 14:      14589    IO-APIC-edge  ide0
 15:         97    IO-APIC-edge  ide1
 16:        449   IO-APIC-level  ide2, ide3
 17:       9142   IO-APIC-level  eth0
 21:          0   IO-APIC-level  ehci_hcd, usb-uhci
NMI:          0
LOC:    1264212
ERR:          0
MIS:          0

IRQ 16 is the CMD680, ide0 and ide1 is the onboard VIA VT8235.
The machine acts as a fileserver, so it's worse falling back to
PIO instead of DMA. The Mainboard is an MSI-Tech KT3 Ultra 2 with
an VIA KT 333 Chipset (Athlon 1800 XP).
For testing purposes I tried the CMD680 in an Intel P4-based
Computer (same cables) but none of these nasty errors! The P4 was
running a 2.4.23 and the Athlon a 2.4.23.

Used harddrives:

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1232/255/63, sectors = 19807200, start = 0

 Model=IBM-DTTA-351010, FwRev=T56OA73A, SerialNo=WF0WF036521
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=466kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=19807200
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4

/dev/hde:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 36024/16/63, sectors = 234493056, start = 0

 Model=SAMSUNG SV1204H, FwRev=RK100-15, SerialNo=0450J1BW401217
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=234493056
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 1:

/dev/hdf:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 41608/16/63, sectors = 240121728, start = 0

 Model=Maxtor 6Y120L0, FwRev=YAR41BW0, SerialNo=Y3K7N66E
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

/dev/hdg:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 19929/255/63, sectors = 320173056, start = 0

 Model=Maxtor 6Y160P0, FwRev=YAR41BW0, SerialNo=Y42BANHE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

Any ideas, what I can change to get rid of these errors?

TIA Sven

(please CC)

-- 
Sven Schumacher, Department of Computer Science
University of Bremen, Bibliothekstraﬂe 1, 28359 Bremen
