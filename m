Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWASSUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWASSUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWASSUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:20:16 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:46316 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1161075AbWASSUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:20:14 -0500
Message-ID: <43CFD852.8040702@dgreaves.com>
Date: Thu, 19 Jan 2006 18:20:02 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ	0xb/00/00
 status=0x51 { DriveReady SeekComplete Error }
References: <1136369920.18235.10.camel@localhost>
In-Reply-To: <1136369920.18235.10.camel@localhost>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:

>Hi all,
>
>does anyone know what this could sata error message could mean ?
>
>ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
>ata2: status=0x51 { DriveReady SeekComplete Error }
>ata2: error=0x0c { DriveStatusError }
>
>I get *lots* of this when I copy files from the sata disk to some
>ieee1394 device and it seems they are sharing interrupt 16:
>
> 16:     430796   IO-APIC-level  ide2, ide3, libata, ohci1394
>
>Happens with kernel 2.6.15, asus a7v8x, sata_promise tx2/4 ...
>  
>
FYI

I'm getting similar issues.

I'm assuming that since the problems span 4 disks on two controllers
(more counting Soeren's problems) that it's unlikely to be a hardware
fault. Of course I could be wrong!1

kernel 2.6.15, mb: ASUS A7V600-X (KT600 chipset I think)
4 sata disks (Maxtor + Seagate). SMART is showing them OK

sata_sil for a cheap PCI-plugin sata controller:
0000:00:0a.0 Unknown mass storage controller: Silicon Image, Inc.
(formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] SerialATA
Controller (rev 02)

sata_via for the onboard VIA sata:
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA
RAID Controller (rev 80)

during boot I get:
...
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5e30
ACPI: RSDT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb000
ACPI: FADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb0b2
ACPI: BOOT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb030
ACPI: MADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb058
ACPI: DSDT (v001   ASUS A7V600-X 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/md0 ro
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
...


Here's the ata/scsi bit:
Jan 10 21:48:31 localhost kernel: ata1: SATA max UDMA/100 cmd 0xF881F080
ctl 0xF881F08A bmdma 0xF881F000 irq 169
Jan 10 21:48:31 localhost kernel: ata2: SATA max UDMA/100 cmd 0xF881F0C0
ctl 0xF881F0CA bmdma 0xF881F008 irq 169
Jan 10 21:48:31 localhost kernel: ata1: dev 0 ATA, max UDMA/100,
390721968 sectors: lba48
Jan 10 21:48:31 localhost kernel: ata1: dev 0 configured for UDMA/100
Jan 10 21:48:31 localhost kernel: scsi0 : sata_sil
Jan 10 21:48:31 localhost kernel: ata2: dev 0 ATA, max UDMA/133,
398297088 sectors: lba48
Jan 10 21:48:31 localhost kernel: ata2: dev 0 configured for UDMA/100
Jan 10 21:48:31 localhost kernel: scsi1 : sata_sil
Jan 10 21:48:31 localhost kernel: Using anticipatory io scheduler
Jan 10 21:48:31 localhost kernel:   Vendor: ATA       Model: Maxtor
6B200M0    Rev: BANC
Jan 10 21:48:31 localhost kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 05
Jan 10 21:48:31 localhost kernel:   Vendor: ATA       Model: Maxtor
6B200M0    Rev: BANC
Jan 10 21:48:31 localhost kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 05
Jan 10 21:48:31 localhost kernel: ACPI: PCI interrupt 0000:00:0f.0[B] ->
GSI 20 (level, low) -> IRQ 185
Jan 10 21:48:31 localhost kernel: sata_via(0000:00:0f.0): routed to hard
irq line 0
Jan 10 21:48:31 localhost kernel: ata3: SATA max UDMA/133 cmd 0x9800 ctl
0x9402 bmdma 0x8400 irq 185
Jan 10 21:48:31 localhost kernel: ata4: SATA max UDMA/133 cmd 0x9000 ctl
0x8802 bmdma 0x8408 irq 185
Jan 10 21:48:31 localhost kernel: ata3: dev 0 ATA, max UDMA/133,
312581808 sectors: lba48
Jan 10 21:48:31 localhost kernel: ata3: dev 0 configured for UDMA/133
Jan 10 21:48:31 localhost kernel: scsi2 : sata_via
Jan 10 21:48:31 localhost kernel: ata4: dev 0 ATA, max UDMA/133,
398297088 sectors: lba48
Jan 10 21:48:31 localhost kernel: ata4: dev 0 configured for UDMA/133
Jan 10 21:48:31 localhost kernel: scsi3 : sata_via

Then, during udev initialisation I get a timeout and eventually:
ata2: command 0x25 timeout, stat 0x51 host_stat 0x0
ata2: no sense translation for status: 0x51
ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 393554465
raid1: Disk failure on sdb2, disabling device.
        Operation continuing on 1 devices
raid1: sdb2: rescheduling sector 2837600
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sdd2
 disk 1, wo:1, o:0, dev:sdb2
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sdd2
raid1: sdd2: redirecting sector 2837600 to another mirror

(BTW, badblocks shows no bad blocks and mdadm --remove/--add returns
just fine)

Then later:
Jan 19 15:23:05 haze kernel: ata1: PIO error
Jan 19 15:23:05 haze kernel: ata1: status=0x50 { DriveReady SeekComplete }
Jan 19 15:23:05 haze kernel: ata1: PIO error
Jan 19 15:23:05 haze kernel: ata1: status=0x50 { DriveReady SeekComplete }
Jan 19 15:23:05 haze kernel: ata1: PIO error
...
Jan 19 15:23:06 haze kernel: ata1: status=0x51 { DriveReady SeekComplete
Error }
Jan 19 15:23:06 haze kernel: ata1: error=0x04 { DriveStatusError }
Jan 19 15:23:06 haze kernel: ata1: PIO error
Jan 19 15:23:06 haze kernel: ata1: status=0x51 { DriveReady SeekComplete
Error }
Jan 19 15:23:06 haze kernel: ata1: error=0x04 { DriveStatusError }
Jan 19 15:23:06 haze kernel: ata1: PIO error
...
Jan 19 15:23:06 haze kernel: ata2: PIO error
Jan 19 15:23:06 haze kernel: ata2: status=0x50 { DriveReady SeekComplete }
Jan 19 15:23:06 haze kernel: ata2: PIO error
Jan 19 15:23:06 haze kernel: ata2: status=0x50 { DriveReady SeekComplete }
...
Jan 19 15:23:08 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jan 19 15:23:08 haze kernel: ata2: error=0x04 { DriveStatusError }
Jan 19 15:23:08 haze kernel: ata2: PIO error
Jan 19 15:23:08 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jan 19 15:23:08 haze kernel: ata2: error=0x04 { DriveStatusError }
Jan 19 15:23:08 haze kernel: ata2: PIO error
...
Jan 19 15:23:08 haze kernel: ata3: PIO error
Jan 19 15:23:08 haze kernel: ata3: status=0x50 { DriveReady SeekComplete }
Jan 19 15:23:08 haze kernel: ata3: PIO error
Jan 19 15:23:08 haze kernel: ata3: status=0x50 { DriveReady SeekComplete }
...
Jan 19 15:23:09 haze kernel: ata4: PIO error
Jan 19 15:23:09 haze kernel: ata4: status=0x50 { DriveReady SeekComplete }
Jan 19 15:23:09 haze kernel: ata4: PIO error
Jan 19 15:23:09 haze kernel: ata4: status=0x50 { DriveReady SeekComplete }
Jan 19 15:23:09 haze kernel: ata4: PIO error
...



smartctl -a -data /dev/sd[abcd] shows all is well.

and thereafter it all seems to work fine.

config: (grep APIC|SATA|IDE)
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_SIL=y
CONFIG_SCSI_SATA_VIA=y

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
# Please see Documentation/ide.txt for help/info on IDE drives
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
# IDE chipset support/bugfixes
# CONFIG_IDE_GENERIC is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y


          CPU0
  0:    2480491    IO-APIC-edge  timer
  1:       7431    IO-APIC-edge  i8042
  9:          0   IO-APIC-level  acpi
 12:     165332    IO-APIC-edge  i8042
 14:     177275    IO-APIC-edge  ide0
 16:      56964   IO-APIC-level  libata
 17:    2842493   IO-APIC-level  libata
 18:          0   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2,
uhci_hcd:usb3, uhci_hcd:usb4, ehci_hcd:usb5
 19:     275949   IO-APIC-level  skge
 21:       4031   IO-APIC-level  VIA8237
NMI:          0
LOC:    2480522
ERR:          0
MIS:          0

Any other diagnostics I can provide? Any patches to try?

David

-- 

