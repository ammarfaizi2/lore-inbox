Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTFMKE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 06:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbTFMKE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 06:04:27 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:46596 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S265325AbTFMKES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 06:04:18 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Fri, 13 Jun 2003 12:18:01 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide0: reset: master: ECC circuitry error
In-Reply-To: <1055494032.5163.18.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.OSF.4.51.0306131123130.393609@tao.natur.cuni.cz>
References: <Pine.OSF.4.51.0306121955001.303628@tao.natur.cuni.cz>
 <1055494032.5163.18.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Alan Cox wrote:

> On Iau, 2003-06-12 at 19:18, Martin MOKREJÅ  wrote:
> > I saw this with earlier kernels ... In principle the laptop ASUS 3800C
> > works fine. It happens only when "hdparm -d1 /dev/discs/disc0/disc" is
> > executed during boot. The ide devices are:
>
> You probably need to set up the DMA speed on the drive/controller too
>
> 	hdparm -X66 -d1

This renders my laptop unable to boot to multiuser mode with:

2.4.21-rc8+acpi
2.4.21-rc8
2.4.21-rc2-ac2

# ksymoops -o /lib/modules/2.4.21-rc-8 -m /usr/src/linux-2.4.21-rc8-acpi-20030523/System.map --no-lsmod --no-ksyms ~mokrejs/st
ksymoops 2.4.9 on i686 2.4.21-pre6.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.21-rc-8 (specified)
     -m /usr/src/linux-2.4.21-rc8-acpi-20030523/System.map (specified)

No modules in ksyms, skipping objects
CPU: 0
EIP: 0010:[<c01c4be8>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000024 ebx: f7da3200 ecx: f75ea000 edx: f750505c
esi: 00000000 edi: 0000001d ebp: f7da3200 esp: f7e8fec0
ds: 0018 es: 0018
Process kupdated (pid: 6, stackpage=f7e8f000)
Stack: c034674e c042fdc0 0000001d fa86f144 c01cff2a f7da3200 c0359400 00001000
       00000001 00000020 0000001e 00000000 f7512980 00000000 00000002 f74eb000
       00000004 c01d4041 f7da3200 fa86f144 00000001 00000006 fa8781bc 00000004
Call trace:     [<c01cff2a>] [<c01d4041>] [<c01d3205>] [<c01c1a00>] [<c013efcb>]
        [<c013e49c>] [<c013e7a1>] [<c0105000>] [<c0105000>] [<c01057be>] [<c013e6d0>]
Code: 0f 0b 4e 01 5a ac 34 c0 85 db 74 0e 0f b7 43 08 89 04 24 e8


>>EIP; c01c4be8 <reiserfs_panic+38/70>   <=====

Trace; c01cff2a <flush_commit_list+2da/460>
Trace; c01d4041 <do_journal_end+671/b90>
Trace; c01d3205 <flush_old_commits+125/1b0>
Trace; c01c1a00 <reiserfs_write_super+30/40>
Trace; c013efcb <sync_supers+bb/140>
Trace; c013e49c <sync_old_buffers+1c/50>
Trace; c013e7a1 <kupdate+d1/100>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c013e6d0 <kupdate+0/100>

Code;  c01c4be8 <reiserfs_panic+38/70>
00000000 <_EIP>:
Code;  c01c4be8 <reiserfs_panic+38/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01c4bea <reiserfs_panic+3a/70>
   2:   4e                        dec    %esi
Code;  c01c4beb <reiserfs_panic+3b/70>
   3:   01 5a ac                  add    %ebx,0xffffffac(%edx)
Code;  c01c4bee <reiserfs_panic+3e/70>
   6:   34 c0                     xor    $0xc0,%al
Code;  c01c4bf0 <reiserfs_panic+40/70>
   8:   85 db                     test   %ebx,%ebx
Code;  c01c4bf2 <reiserfs_panic+42/70>
   a:   74 0e                     je     1a <_EIP+0x1a>
Code;  c01c4bf4 <reiserfs_panic+44/70>
   c:   0f b7 43 08               movzwl 0x8(%ebx),%eax
Code;  c01c4bf8 <reiserfs_panic+48/70>
  10:   89 04 24                  mov    %eax,(%esp,1)
Code;  c01c4bfb <reiserfs_panic+4b/70>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

#

I had to write down the stack trace manually, so I hope I didn't make any errors. ;)
The stack trace is from 2.4.21-rc8+acpi.


It doesn't kill 2.4.21-pre5+some ide patch I received to my question from
lkml list, I remember with plain -pre5 I couldn't boot. Also with
2.4.21-pre6+acpi I can boot while "-X66 -d1".

> Your report also doesnt say which IDE controller

Asus 3800C laptop, firmware 1.18a if I remeber right the latest revision. dmesg says:

127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262137
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32761 pages.
Kernel command line: root=/dev/hda2 hdc=ide-scsi idebus=66
ide_setup: hdc=ide-scsi
ide_setup: idebus=66
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1800.092 MHz processor.
[...]
PCI: PCI BIOS revision 2.10 entry at 0xf0e40, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
[...]
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 66MHz system bus speed for PIO modes
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Found IRQ 9 for device 00:1f.1
PCI: Sharing IRQ 9 with 02:07.2
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8400-0x8407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8408-0x840f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23EA-60, ATA DISK drive
blk: queue c03e5cc0, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
[...]
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: status timeout: status=0xd0 { Busy }

hda: DMA disabled
hda: drive not ready for command
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
ide0: reset: master: error (0x00?)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: CHECK for good STATUS


# Controller: 0

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    no               no              yes               no
UDMA enabled:   yes              no              yes               no
UDMA enabled:   5                X               4                 X
UDMA
DMA
PIO

#

# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 4).
      Prefetchable 32 bit memory at 0xe0000000 [0xefffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 4).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 2).
      IRQ 5.
      I/O at 0xb800 [0xb81f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 2).
      IRQ 9.
      I/O at 0xb400 [0xb41f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 66).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801CAM IDE U100 (rev 2).
      IRQ 9.
      I/O at 0x8400 [0x840f].
      Non-prefetchable 32 bit memory at 0xd5800000 [0xd58003ff].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 2).
      IRQ 11.
      I/O at 0xe000 [0xe0ff].
      I/O at 0xe100 [0xe13f].
  Bus  0, device  31, function  6:
    Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 2).
      IRQ 11.
      I/O at 0xe200 [0xe2ff].
      I/O at 0xe300 [0xe37f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW (rev 0).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xd7000000 [0xd700ffff].
  Bus  2, device   5, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xa800 [0xa8ff].
      Non-prefetchable 32 bit memory at 0xd6800000 [0xd68000ff].
  Bus  2, device   7, function  0:
    CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 168).
      IRQ 5.
      Master Capable.  Latency=168.  Min Gnt=128.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x40000000 [0x40000fff].
  Bus  2, device   7, function  1:
    CardBus bridge: Ricoh Co Ltd RL5c476 II (#2) (rev 168).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=128.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x40001000 [0x40001fff].
  Bus  2, device   7, function  2:
    FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 0).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd60007ff].
#
This was 2.4.21-pre5

The "ide0: reset: master: error (0x00?)" is a bit different to the one I posted earlier
from 2.4.21-rc8+acpi kernel.

-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
