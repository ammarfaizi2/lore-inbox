Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSH3Uil>; Fri, 30 Aug 2002 16:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSH3Uil>; Fri, 30 Aug 2002 16:38:41 -0400
Received: from nilus-1824.adsl.datanet.hu ([195.56.95.46]:31360 "EHLO
	sunshine.trey.hu") by vger.kernel.org with ESMTP id <S317488AbSH3Uij>;
	Fri, 30 Aug 2002 16:38:39 -0400
Subject: 2.4.20-pre5-ac1: IDE DMA problem with Intel D845GVB, resource
	collisions
From: =?ISO-8859-1?Q?Micsk=F3_G=E1bor?= <trey@debian.szintezis.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Aug 2002 22:42:49 +0200
Message-Id: <1030740179.391.25.camel@sunshine>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a DMA problem with Intel D845GVB chipset. I use the latest BIOS
for this mainboard (29.08.2002). I try with 2.4.20-pre5-ac1,
2.4.20-pre4, but does not work. 

#hdparm -c 1 -d1 -m16 -X69 -k 1 /dev/hda

/dev/hda:
 setting 32-bit I/O support flag to 1
 setting multcount to 16
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting keep_settings to 1 (on)
 setting xfermode to 69 (UltraDMA mode5)
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 using_dma    =  0 (off)
 keepsettings =  1 (on)

(2.4.20-pre4)


#dmesg | less

[...]

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH4: (ide_setup_pci_device:) Could not enable device.
hda: IC35L080AVVA07-0, ATA DISK drive
hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
hdd: R/RW 4x4x32, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=10011/255/63
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4

[...]

#lspci

sunshine:/usr/src/linux# lspci
00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2561 (rev 01)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev
81)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)
00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
(rev b2)
02:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
08)
02:02.1 Input device controller: Creative Labs SB Live! (rev 08)
02:04.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
11)
02:04.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
02:08.0 Ethernet controller: Intel Corp.: Unknown device 1039 (rev 81)

#cat /proc/pci

sunshine:/usr/src# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
(rev 1).
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge
(rev 1).
      Master Capable.  Latency=32.  Min Gnt=8.
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 1).
      IRQ 11.
      I/O at 0xe800 [0xe81f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 1).
      IRQ 9.
      I/O at 0xe880 [0xe89f].
  Bus  0, device  29, function  2:
    USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 1).
      IRQ 10.
      I/O at 0xec00 [0xec1f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 129).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 1).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 1).
      IRQ 10.
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0xffa0 [0xffaf].
      Non-prefetchable 32 bit memory at 0x20000000 [0x200003ff].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82801DB SMBus (rev 1).
      IRQ 5.
      I/O at 0xe480 [0xe49f].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX]
(rev 178).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].
  Bus  2, device   2, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 8).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xd880 [0xd89f].
  Bus  2, device   2, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
8).
      Master Capable.  Latency=32.  
      I/O at 0xdc00 [0xdc07].
  Bus  2, device   4, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 17).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xf47fe000 [0xf47fefff].
  Bus  2, device   4, function  1:
    Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 17).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xf47ff000 [0xf47fffff].
  Bus  2, device   8, function  0:
    Ethernet controller: Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet
Controller (rev 129).
      IRQ 3.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfeaff000 [0xfeafffff].
      I/O at 0xd800 [0xd83f].


Any idea? 

Thx.

Gabor Micsko

