Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292714AbSBUTAv>; Thu, 21 Feb 2002 14:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292715AbSBUTAl>; Thu, 21 Feb 2002 14:00:41 -0500
Received: from max.hkust.se ([194.18.100.146]:1200 "EHLO max.hkust.se")
	by vger.kernel.org with ESMTP id <S292714AbSBUTAb>;
	Thu, 21 Feb 2002 14:00:31 -0500
Message-ID: <3C7543C8.BA00BB8B@hkust.se>
Date: Thu, 21 Feb 2002 20:00:24 +0100
From: Magnus Stenman <stone@hkust.se>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Seagate IDE tape problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having trouble with a Seagate IDE tape drive that previously
worked with 2.2.x kernels. (tape is a STT8000A travan drive)

The box has an ABIT m/b with intel 815 chipset.

On 2.2 I used the ide tape modules which let me access the drive on
ht0, but that did not work at all on 2.4.x.

I'm now using scsi_mod, ide-scsi and st and it seems
to mostly work. However, sometimes backups fail, and
I always get a couple of error messages every backup.

Any tweaks I can make, maybe at modiule load? The tape unit
worked fine under 2.2.x on an intel 440BX m/b.
I sifted thru google but it did not turn up much helpful stuff.


/magnus

Relevant(?) parts from dmesg:
----------------
Linux version 2.4.9-21 (bhcompile@stripples.devel.redhat.com) (gcc
version 2.96 20000731 (Red Hat Linux 7.1 2.\
96-98)) #1 Thu Jan 17 14:16:30 EST 2002
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 17
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SV2042H, ATA DISK drive
hdc: SAMSUNG SV3063H, ATA DISK drive
hdd: Seagate STT8000A, ATAPI TAPE drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c0350660, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0350660, I/O limit 4095Mb (mask 0xffffffff)
hda: 39865392 sectors (20411 MB) w/426KiB Cache, CHS=39549/16/63,
UDMA(100)
blk: queue c03509a4, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03509a4, I/O limit 4095Mb (mask 0xffffffff)
hdc: 59797584 sectors (30616 MB) w/426KiB Cache, CHS=59323/16/63,
UDMA(100)
SCSI subsystem driver Revision: 1.00
hdd: set_drive_speed_status: status=0x11 { SeekComplete Error }
hdd: set_drive_speed_status: error=0x04
.....end boot I believe.  the rest is after a couple of backups

scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: Seagate   Model: STT8000A          Rev: 5.02
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20010812, bufsize 32768, wrt 30720, max init. bufs 4, s/g
segs 16
Attached scsi tape st0 at scsi0, channel 0, id 0, lun 0
st0: Error with sense data: Current st09:00: sense key Illegal Request
Additional sense indicates Invalid command operation code
st0: Error with sense data: Current st09:00: sense key Illegal Request
Additional sense indicates Invalid command operation code
hdd: status error: status=0x7f { DriveReady DeviceFault SeekComplete
DataRequest CorrectedError Index Error }
hdd: status error: error=0x7f
hdd: DMA disabled
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x7f { DriveReady DeviceFault SeekComplete
DataRequest CorrectedError Index Error }
hdd: status error: error=0x7f
hdd: drive not ready for command
hdd: ATAPI reset complete
st0: Error 27070000 (sugg. bt 0x20, driver bt 0x7, host bt 0x7).
st0: Error with sense data: Current st09:00: sense key Not Ready
Additional sense indicates Logical unit is in process of becoming ready
st0: Error on write filemark.
st0: Error with sense data: Current st09:00: sense key Not Ready
Additional sense indicates Logical unit is in process of becoming ready


parts from lspci -v
-------------
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 04)
        Subsystem: ABIT Computer Corp.: Unknown device 0407
        Flags: bus master, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [88] #09 [e104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 04)
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32

00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 11) (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d4000000-d5ffffff

00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 11)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 11)
(prog-if 80 [Master])
        Subsystem: ABIT Computer Corp.: Unknown device 0407
        Flags: bus master, medium devsel, latency 0
        I/O ports at f000 [size=16]
