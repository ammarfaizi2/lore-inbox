Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVAZEAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVAZEAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 23:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVAZEAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 23:00:31 -0500
Received: from ultra7.eskimo.com ([204.122.16.70]:9228 "EHLO ultra7.eskimo.com")
	by vger.kernel.org with ESMTP id S262237AbVAZEAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 23:00:12 -0500
From: Rick Bressler <bressler@the-bresslers.com>
Message-Id: <200501260357.j0Q3vw2X017393@colossus.loc>
Subject: Banging my head on SATA / ATAPI DMA problem.  Help?
To: linux-kernel@vger.kernel.org (kernel)
Date: Tue, 25 Jan 2005 19:57:58 -0800 (PST)
Reply-To: Rick Bressler <rick@the-bresslers.com>
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've played with a lot of hardware since the Linux 1.0.9 days but not
yet run into something quite like this.  Alan has been talking a lot
lately about ATA/SATA patches, and while I mostly lurk on this list,
thought this one might be interesting enough for somebody to give me
some advice.

A friend of mine won an IBM 8482-2RU at Linux World last year and he is
trying to get it working with a 2.6.x kernel.

The problem I'm unable to resolve is that his primary drive, a Seagate
ST3160023AS (SATA) works fine in DMA mode, but whenever it is plugged
in, he can't get his PLEXTOR PX-716A DVD/CD-RW (PATA) to come up in DMA
mode.  (Works in PIO mode.)

At first I was wondering if it wasn't a BIOS setting (legacy mode ATA
etc) but he swears he can't find anything like that in his BIOS.  (He's
on the latest BIOS that IBM has for the box.)

He's in California and I'm in Washington so I have to take his word for
it.

hdparm says the DVD/CD can do DMA, and in theory is being configured by the
BIOS

	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

The kernel doesn't detect it.  It can't be turned on manually with
hdparm.  If the hard drive is unplugged, I note that it is recognizes
the CD as as being on an ICH5 chipset, but it doesn't seem to identify
it as such with the hard drive plugged in.  Odd hardware?  Strange
hardware detection?  Something subtle in the kernel config that I keep
missing?  (BLK_DEV_PIIX is turned on.)

Both drives come up DMA on 2.4.x (no libata). but no 2.6 kernel we've
tried (2.6.6, 2.6.9, 2.6.10 2.6.10-ac10) seems to be able to manage it.

I've been working with him for a couple of weeks, but have exhausted my
luck on Google, list archives etc. and decided it is time to see if
anybody can give me some ideas on how to proceed.  Maybe it is just
flakey hardware...

Any help, pointers or suggestions  that you may care to offer would be
appreciated.

I monitor the list (in nightly batch mode) so feel free to reply any way
you like, list or email...

Thanks in advance.

His PCI layout:

# lspci
0000:00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub (rev 02)
0000:00:03.0 PCI bridge: Intel Corp. 82875P/E7210 Processor to PCI to CSA Bridge (rev 02)
0000:00:1c.0 PCI bridge: Intel Corp. 6300ESB 64-bit PCI-X Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 6300ESB USB Universal Host Controller (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 6300ESB USB Universal Host Controller (rev 02)
0000:00:1d.4 System peripheral: Intel Corp. 6300ESB Watchdog Timer (rev 02)
0000:00:1d.5 PIC: Intel Corp. 6300ESB I/O Advanced Programmable Interrupt Controller (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 6300ESB USB2 Enhanced Host Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 0a)
0000:00:1f.0 ISA bridge: Intel Corp. 6300ESB LPC Interface Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 6300ESB SATA Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 6300ESB SMBus Controller (rev 02)
0000:02:01.0 Ethernet controller: Intel Corp. 82547GI Gigabit Ethernet Controller
0000:03:04.0 SCSI storage controller: Adaptec AIC-7901 U320 (rev 10)
0000:04:02.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
0000:04:08.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)

A boot from a Knoppix CD with the hard drive unplugged yielded a working
DMA enabled CDROM with a 2.6.9 kernel.

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive

Bits of dmesg for the failure case:

No DMA on CD-ROM with hd plugged in

Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache
Uniform CD-ROM driver Revision: 3.20

The SATA drive comes up fine.

libata version 1.10 loaded.
ata_piix version 1.03
ata_piix: combined mode detected
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ata: 0x1f0 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1478 irq 15
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

He does get an error when first accessing the CD-ROM, but it keeps on
working in PIO mode.

hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { AbortedCommand }


Anything else you'd like to see?  Let me know and I'll get it from him.

-- 
Rick Bressler                                      rick@the-bresslers.com
   Eagles may soar, but weasels never get sucked into jet air intakes.
