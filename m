Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbTBFOuV>; Thu, 6 Feb 2003 09:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267323AbTBFOuV>; Thu, 6 Feb 2003 09:50:21 -0500
Received: from very.disjunkt.com ([195.167.192.238]:42987 "EHLO disjunkt.com")
	by vger.kernel.org with ESMTP id <S267320AbTBFOuR> convert rfc822-to-8bit;
	Thu, 6 Feb 2003 09:50:17 -0500
Date: Thu, 6 Feb 2003 15:59:43 +0100 (CET)
From: Jean-Daniel Pauget <jd@disjunkt.com>
X-X-Sender: jd@mint
To: Alan Cox <alan@redhat.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21pre4-ac2 : hangs at flushing hda hdc
In-Reply-To: <20030205053440.GA1239@middle.of.nowhere>
Message-ID: <Pine.LNX.4.51.0302061547550.443@mint>
References: <200302041702.h14H2O112078@devserv.devel.redhat.com>
 <20030205053440.GA1239@middle.of.nowhere>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003, about 2.4.21-pre4-ac2, Jurriaan wrote:
> Some of these may be responsible for something new: my system hangs at shutdown,
> saying 'flushing ide devices: hda hdc'. This didn't happen with
> 2.4.21pre3-ac5. hdc is a cdwriter, used as ide-scsi.

same thing for me:
2.4.21-pre4-ac1 seems the most stable ever for my hardware (not a single
hang or freeze, any other kernel would freeze more or less once a day)
but still needs longer testing for validation regarding my troubles.

2.4.21-pre4-ac2 systematically hangs at shutdown/reboot ending with:
flushing ide devices: hda hdc

here below my lspci / hdparm -I / /proc/interrupts / /proc/pci

**************************************************************************

3 [15:54] sjd@mint:/home/jd# lspci
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] (rev a3)
02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

**************************************************************************

4 [15:55] sjd@mint:/home/jd# hdparm -I /dev/hda

/dev/hda:

non-removable ATA device, with non-removable media
        Model Number:           Maxtor 6Y120P0
        Serial Number:          Y40FKPWE
        Firmware Revision:      YAR41VW0
Standards:
        Supported: 1 2 3 4 5 6 7
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    0               (obsolete)
        bytes/sector:   0               (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 240121728
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 7936.0kB   ECC bytes: 57   Queue depth: 1
        Standby timer values: spec'd by standard, no device specific minimum
        r/w multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

**************************************************************************

5 [15:55] sjd@mint:/home/jd# hdparm -I /dev/hdc

/dev/hdc:

ATAPI CD-ROM, with removable media
        Model Number:           JLMS DVD-ROM LTD-166S
        Serial Number:
        Firmware Revision:      DS0B
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-2
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(cannot be disabled)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=227ns  IORDY flow control=120ns

**************************************************************************

6 [15:56] sjd@mint:/home/jd# cat /proc/interrupts
           CPU0
  0:      62486          XT-PIC  timer
  1:       3195          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      11820          XT-PIC  eth0, Intel ICH4
 10:          1          XT-PIC  ohci1394
 11:      45676          XT-PIC  nvidia
 12:      15124          XT-PIC  PS/2 Mouse
 14:      11519          XT-PIC  ide0
 15:         16          XT-PIC  ide1
NMI:          0
LOC:      62452
ERR:          0
MIS:          0

**************************************************************************

7 [15:56] sjd@mint:/home/jd# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 2).
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 2).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 130).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 2).
      IRQ 9.
      I/O at 0xf000 [0xf00f].
      Non-prefetchable 32 bit memory at 0x10000000 [0x100003ff].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 2).
      IRQ 5.
      I/O at 0xa800 [0xa8ff].
      I/O at 0xa400 [0xa43f].
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe40001ff].
      Non-prefetchable 32 bit memory at 0xe3800000 [0xe38000ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] (rev 163).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe6000000 [0xe6ffffff].
      Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].
      Prefetchable 32 bit memory at 0xe7800000 [0xe787ffff].
  Bus  2, device   3, function  0:
    FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 128).
      IRQ 10.
      Master Capable.  Latency=32.  Max Lat=32.
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe50007ff].
      I/O at 0xb800 [0xb87f].
  Bus  2, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 16).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xb400 [0xb4ff].
      Non-prefetchable 32 bit memory at 0xe4800000 [0xe48000ff].

--
Quand les plombs pêtent : « Ðïsjüñ£t.¢¤× »
