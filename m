Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261938AbREMXBe>; Sun, 13 May 2001 19:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261943AbREMXBZ>; Sun, 13 May 2001 19:01:25 -0400
Received: from smtp1.ihug.co.nz ([203.109.252.7]:33545 "EHLO smtp1.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S261938AbREMXBG>;
	Sun, 13 May 2001 19:01:06 -0400
Message-ID: <3AFF11F1.B886953E@ihug.co.nz>
Date: Mon, 14 May 2001 11:00:01 +1200
From: Paul Dorman <pdorman@ihug.co.nz>
Reply-To: pdorman@ihug.co.nz
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CMD64x - full DMA support?
In-Reply-To: <200105100721.f4A7LoN9021455@webber.adilger.int> <01051400150902.02742@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all. First time writing to the kernel list, so let me know if I break
any conventions. This is long, so I thank you all for your help now :o)

Paul Dorman.

I have two CMD648 PCI ATA66 controllers - one generic and one by
Leadtek. At the moment the Leadtek is installed. I have a dual PII 450
machine on a Gigabyte BXD motherboard. My current kernel is 2.4.4-ac4. I
understand that there may be hardware flaws with the CMD640 chipset. If
this is the case, is there any chance of a work-around? If not, how can
I get the best performance out of this card?

If I use hdparm to set DMA=1 on a drive attached to the controller I get
all kinds of errors when I attempt to access its filesystem:

...
...
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hde: lost interrupt

*or* 
...
...
/dev/ide/host2/bus0/target0/lun0: p1
/dev/ide/host2/bus0/target0/lun0: p1
reiserfs: checking transaction log (device 21:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hde: DMA disabled
ide2: reset: success
<computer hangs>

*or*
...
...
hde: dma_intr: status=0xff { Busy }
hde: DMA disabled
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:01 (hde), sector 95948856
hde: drive not ready for command
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:01 (hde), sector 95949360
hde: drive not ready for command
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:01 (hde), sector 95949368
...

I have:-

* Shifted cards around,
* Tried different interrupts,
* Tried THREE different 80 wire cables.

I hope this is the pertinent information...

=============================[DMESG output]============================
CMD648: IDE controller on PCI bus 00 dev 50
CMD648: chipset revision 1
CMD648: not 100% native mode: will probe irqs later
CMD648: ROM enabled at 0xee000000
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio

A little further down is:

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

I have tried to force DMA using boot parameters, but without success.

===========================[/proc/interrupts]==========================
           CPU0       CPU1
  0:    1834858    1823909    IO-APIC-edge  timer
  1:       5073       5179    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  7:          0          0    IO-APIC-edge  parport0
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 10:          4          4    IO-APIC-edge  advansys
 12:      97363     103087    IO-APIC-edge  PS/2 Mouse
 14:     181732     211754    IO-APIC-edge  ide0
 15:          2         10    IO-APIC-edge  ide1
 16:    1431214    1528254   IO-APIC-level  bttv, Ensoniq AudioPCI,
nvidia
 17:      55827      56939   IO-APIC-level  eth0
 19:          0          0   IO-APIC-level  usb-uhci
NMI:          0          0
LOC:    3667630    3667650
ERR:          0
MIS:         21

===========================[/proc/ide/cmd64x]==========================

                                CMD648 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    yes              no              no                no 
DMA Mode:       UDMA(4)           PIO(?)          PIO(?)           
PIO(?)
PIO Mode:       ?                ?               ?                 ?
                polling                          polling
                clear                            clear
                enabled                          enabled
CFR       = 0x40, HI = 0x04, LOW = 0x00
ARTTIM23  = 0x0c, HI = 0x00, LOW = 0x0c
MRDMODE   = 0x00, HI = 0x00, LOW = 0x00

======================[/proc/ide/hde/settings]========================

name                  value        min          max          mode
----                  -----        ---          ---          ----
bios_cyl              119150        0           65535         rw
bios_head             16            0           255           rw
bios_sect             63            0           63            rw
breada_readahead      4             0           127           rw
bswap                 0             0           1             r
current_speed         68            0           69            rw
file_readahead        0             0           2097151       rw
ide_scsi              0             0           1             rw
init_speed            68            0           69            rw
io_32bit              0             0           3             rw
keepsettings          0             0           1             rw
lun                   0             0           7             rw
max_kb_per_request    127           1           127           rw
multcount             0             0           8             rw
nice1                 1             0           1             rw
nowerr                0             0           1             rw
number                0             0           3             rw
pio_mode              write-only    0           255           w
slow                  0             0           1             rw
unmaskirq             0             0           1             rw
using_dma             1             0           1             rw

=============================[/proc/pci]==============================

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 2).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
2).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 19.
      Master Capable.  Latency=64.  
      I/O at 0xd000 [0xd01f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  0, device   8, function  0:
    RAID bus controller: CMD Technology Inc PCI0648 (rev 1).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      I/O at 0xd400 [0xd407].
      I/O at 0xd800 [0xd803].
      I/O at 0xdc00 [0xdc07].
      I/O at 0xe000 [0xe003].
      I/O at 0xe400 [0xe40f].
  Bus  0, device   9, function  0:
    Multimedia video controller: Brooktree Corporation Bt848 TV with DMA
push (rev 17).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xef000000 [0xef000fff].
  Bus  0, device  10, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
(rev 0).
      IRQ 18.
      I/O at 0xe800 [0xe81f].
  Bus  0, device  11, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 7).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
      I/O at 0xec00 [0xec3f].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS)
(rev 163).
      IRQ 16.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xec000000 [0xecffffff].
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
