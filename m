Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265020AbTF1Bk1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 21:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbTF1Bk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 21:40:27 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:54532 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265020AbTF1BkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 21:40:20 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: ldl@aros.net
Subject: 2.5.73-mm1 nbd: boot hang in add_disk at first call from nbd_init
Date: Sat, 28 Jun 2003 09:51:33 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306271943.13297.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes were recently made to the nbd.c in 2.5.73-mm1

When using nbd.c ex 2.5.73 boot OK. 
acpi=off no effect

----------------------------
dmesg using nbd.c ex 2.5.73:

loop: loaded (max 8 devices)
anticipatory scheduling elevator

(Using nbd.c ex 2.5.73-mm1
 nbd: registered device at major 43
  hang)

PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 00:10.0
 pci_irq-0294 [19] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.0
ACPI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xedb0-0xedb7, BIOS settings: hda:DMA, hdb:pio
ALI15X3: simplex device: DMA forced
    ide1: BM-DMA at 0xedb8-0xedbf, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DARA-212000, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: host protected area => 1
hda: 23579136 sectors (12073 MB) w/418KiB Cache, CHS=23392/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0


-----------------------------------------------------------
lspci
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)

-----------------------------------------------------------
hdparm -iI /dev/hda:
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=23579136
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4


ATA device, with non-removable media
        Model Number:       IBM-DARA-212000
        Serial Number:      AH0AHG94390
        Firmware Revision:  AR4OA51A
Standards:
        Used: ATA/ATAPI-4 T13 1153D revision 17
        Supported: 4 3 2 1 & some of 5
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   23579136
        device size with M = 1024*1024:       11513 MBytes
        device size with M = 1000*1000:       12072 MBytes (12 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 418.0kB    bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Vendor, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: 128 (0x80)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
                Address Offset Reserved Area Boot
           *    Advanced Power Management feature set

Regards
Michael

-- 
Powered by linux-2.5.73, compiled with gcc-2.95-3 - not fancy but rock solid

My current linux related activities:
- Test script development and testing of swsusp
- Everyday usage of 2.5 kernel

More info on the 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt

