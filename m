Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVAZPBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVAZPBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 10:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVAZPBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 10:01:36 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:54668 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262324AbVAZPB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 10:01:28 -0500
Date: Wed, 26 Jan 2005 10:01:27 -0500
To: Rick Bressler <rick@the-bresslers.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Banging my head on SATA / ATAPI DMA problem.  Help?
Message-ID: <20050126150127.GB17865@csclub.uwaterloo.ca>
References: <200501260357.j0Q3vw2X017393@colossus.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501260357.j0Q3vw2X017393@colossus.loc>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 07:57:58PM -0800, Rick Bressler wrote:
> I've played with a lot of hardware since the Linux 1.0.9 days but not
> yet run into something quite like this.  Alan has been talking a lot
> lately about ATA/SATA patches, and while I mostly lurk on this list,
> thought this one might be interesting enough for somebody to give me
> some advice.
> 
> A friend of mine won an IBM 8482-2RU at Linux World last year and he is
> trying to get it working with a 2.6.x kernel.
> 
> The problem I'm unable to resolve is that his primary drive, a Seagate
> ST3160023AS (SATA) works fine in DMA mode, but whenever it is plugged
> in, he can't get his PLEXTOR PX-716A DVD/CD-RW (PATA) to come up in DMA
> mode.  (Works in PIO mode.)
> 
> At first I was wondering if it wasn't a BIOS setting (legacy mode ATA
> etc) but he swears he can't find anything like that in his BIOS.  (He's
> on the latest BIOS that IBM has for the box.)
> 
> He's in California and I'm in Washington so I have to take his word for
> it.
> 
> hdparm says the DVD/CD can do DMA, and in theory is being configured by the
> BIOS
> 
> 	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
> 
> The kernel doesn't detect it.  It can't be turned on manually with
> hdparm.  If the hard drive is unplugged, I note that it is recognizes
> the CD as as being on an ICH5 chipset, but it doesn't seem to identify
> it as such with the hard drive plugged in.  Odd hardware?  Strange
> hardware detection?  Something subtle in the kernel config that I keep
> missing?  (BLK_DEV_PIIX is turned on.)
> 
> Both drives come up DMA on 2.4.x (no libata). but no 2.6 kernel we've
> tried (2.6.6, 2.6.9, 2.6.10 2.6.10-ac10) seems to be able to manage it.
> 
> I've been working with him for a couple of weeks, but have exhausted my
> luck on Google, list archives etc. and decided it is time to see if
> anybody can give me some ideas on how to proceed.  Maybe it is just
> flakey hardware...
> 
> Any help, pointers or suggestions  that you may care to offer would be
> appreciated.
> 
> I monitor the list (in nightly batch mode) so feel free to reply any way
> you like, list or email...
> 
> Thanks in advance.
> 
> His PCI layout:
> 
> # lspci
> 0000:00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub (rev 02)
> 0000:00:03.0 PCI bridge: Intel Corp. 82875P/E7210 Processor to PCI to CSA Bridge (rev 02)
> 0000:00:1c.0 PCI bridge: Intel Corp. 6300ESB 64-bit PCI-X Bridge (rev 02)
> 0000:00:1d.0 USB Controller: Intel Corp. 6300ESB USB Universal Host Controller (rev 02)
> 0000:00:1d.1 USB Controller: Intel Corp. 6300ESB USB Universal Host Controller (rev 02)
> 0000:00:1d.4 System peripheral: Intel Corp. 6300ESB Watchdog Timer (rev 02)
> 0000:00:1d.5 PIC: Intel Corp. 6300ESB I/O Advanced Programmable Interrupt Controller (rev 02)
> 0000:00:1d.7 USB Controller: Intel Corp. 6300ESB USB2 Enhanced Host Controller (rev 02)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 0a)
> 0000:00:1f.0 ISA bridge: Intel Corp. 6300ESB LPC Interface Controller (rev 02)
> 0000:00:1f.2 IDE interface: Intel Corp. 6300ESB SATA Storage Controller (rev 02)
> 0000:00:1f.3 SMBus: Intel Corp. 6300ESB SMBus Controller (rev 02)
> 0000:02:01.0 Ethernet controller: Intel Corp. 82547GI Gigabit Ethernet Controller
> 0000:03:04.0 SCSI storage controller: Adaptec AIC-7901 U320 (rev 10)
> 0000:04:02.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
> 0000:04:08.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
> 
> A boot from a Knoppix CD with the hard drive unplugged yielded a working
> DMA enabled CDROM with a 2.6.9 kernel.
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH5: IDE controller at PCI slot 0000:00:1f.1
> ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> ICH5: chipset revision 2
> ICH5: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive

Above the piix drive was loaded and took care of the IDE channel.

> Bits of dmesg for the failure case:
> 
> No DMA on CD-ROM with hd plugged in
> 
> Probing IDE interface ide0...
> hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
> ide1: I/O resource 0x170-0x177 not free.
> ide1: ports already in use, skipping probe
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache
> Uniform CD-ROM driver Revision: 3.20

This looks like ide-generic which doesn't do DMA since it isn't chipset
specific.  Make SURE you load the piix driver for the PATA channels, and
don't let the system auto load ide-generic when you try to access the
CD.  On debian I add these lines to /etc/modules to ensure they are
loaded in that order early in boot:

piix
ide-generic
ide-cd

Without it, trying to access /dev/hda causes ide-generic to be loaded
since that is what modprobe tries.  There is probably an alias that
could be set to make ide always try piix first but I don't know what it
is, and I want piix loaded at all times anyhow.

> The SATA drive comes up fine.
> 
> libata version 1.10 loaded.
> ata_piix version 1.03
> ata_piix: combined mode detected
> ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
> ata: 0x1f0 IDE port busy
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1478 irq 15
> ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
> ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
> ata1: dev 0 configured for UDMA/133
> scsi0 : ata_piix
>   Vendor: ATA       Model: ST3160023AS       Rev: 3.18
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> 
> He does get an error when first accessing the CD-ROM, but it keeps on
> working in PIO mode.
> 
> hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hda: drive_cmd: error=0x04 { AbortedCommand }
> 
> 
> Anything else you'd like to see?  Let me know and I'll get it from him.

Try doing lsmod and seeing what modules are actually in use.  I see piix
with use 1 and ide-generic with use 0.

Len Sorensen
