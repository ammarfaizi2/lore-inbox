Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWGGPiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWGGPiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWGGPiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:38:52 -0400
Received: from smtp.ono.com ([62.42.230.12]:19160 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S1751215AbWGGPiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:38:52 -0400
Date: Fri, 7 Jul 2006 17:38:37 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.17-mm6
Message-ID: <20060707173837.578fafb2@werewolf.auna.net>
In-Reply-To: <20060706145752.64ceddd0.akpm@osdl.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	<20060705234347.47ef2600@werewolf.auna.net>
	<20060705155602.6e0b4dce.akpm@osdl.org>
	<20060706015706.37acb9af@werewolf.auna.net>
	<20060705170228.9e595851.akpm@osdl.org>
	<20060706163646.735f419f@werewolf.auna.net>
	<20060706164802.6085d203@werewolf.auna.net>
	<20060706234425.678cbc2f@werewolf.auna.net>
	<20060706145752.64ceddd0.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.3.1cvs64 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 14:57:52 -0700, Andrew Morton <akpm@osdl.org> wrote:

> "J.A. Magallón" <jamagallon@ono.com> wrote:
> >
> > On Thu, 6 Jul 2006 16:48:02 +0200, "J.A. Magallón" <jamagallon@ono.com> wrote:
> > 
> > > On Thu, 6 Jul 2006 16:36:46 +0200, "J.A. Magallón" <jamagallon@ono.com> wrote:
> > > 
> > > > On Wed, 5 Jul 2006 17:02:28 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > > > 
> > > > 
> > > > This a shot till I can try to get a full dmesg.
> > > > 
> > > > http://belly.cps.unizar.es/~magallon/tmp/shot.jpg
> > > > 
> > > > Anyways, what I wanted to point above was that previous kernels talk
> > > > about 'sda1(8,1)', and newer use 'dev(8,19)'.
> > > > Perhaps somebedy did a strcpy( ... , "dev" ), instead of strcpy( ... , dev ) ?
> > > > 
> > > 
> > > Hey !!. I disabled md and usb to get more useful messages in my screen, and
> > > now I have realized that libata is managing my IDE drive !! And I did not
> > > boot with any 'libata.atapi_enable'....
> > > 
> > > In -mm1,
> > > sda -> 200Gb sata
> > > hda -> HL-DT-ST DVDRAM GSA-4120B
> > > hdb -> (zip drive)
> > > hdc -> 120Gb ide
> > > hdd -> DVD-ROM
> > > 
> > > In -mm6,
> > > 
> > > sda -> (zip drive) ?
> > > sdb -> 120Gb
> > > sdc -> 200Gb
> > > 
> > 
> > Well, booting onto sdc1 let me get to single user mode at least so I got
> > a full dmesg. Relevant parts for -mm1 and -mm6 are below (if you want it
> > full I can provide). Basically it looks like libata 2.0 by default handles
> > PATA drives. This can break a lot of systems. In my opinion, PATA hosts
> > should be detected _after_ real sata hosts in the same chipset (now it
> > looks like its done _before_). What is handled by IDE will break anyways,
> > but this way at least real SATA will stay at the same /dev/sdX devices.
> > 
> > -mm1:
> > ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> > ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> > ICH5: IDE controller at PCI slot 0000:00:1f.1
> >     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> > 
> > -mm6:
> > 
> > ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> > ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> > ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> > ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> > 
> 
> Ah-hah, thanks.  I think this is a relatively-FAQ, but I forget the answer.
> Alan's the man.
> 

I thought libata.atapi_enabled=0 could make things like before, but:

libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00tj1ac5
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
scsi0 : ata_piix
ata1.00: configured for PIO3
ata1.01: configured for PIO3
ata1.00: WARNING: ATAPI is disabled, device ignored.
ata1.01: WARNING: ATAPI is disabled, device ignored.
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi1 : ata_piix
ata2.00: configured for UDMA/33
ata2.01: configured for UDMA/33
  Vendor: ATA       Model: ST3120022A        Rev: 3.06
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2.01: WARNING: ATAPI is disabled, device ignored.
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
scsi2 : ata_piix
ata3: ENTER, pcs=0x13 base=0
ata3: LEAVE, pcs=0x13 present_mask=0x1
ata3.00: configured for UDMA/133
scsi3 : ata_piix
ata4: ENTER, pcs=0x13 base=2
ata4: LEAVE, pcs=0x11 present_mask=0x0
ata4: SATA port has no device.
ATA: abnormal status 0x7F on port 0xC807
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 1:0:0:0: Attached scsi disk sda
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)

Buses are still there, disks named, but ignored. So old hda becomes sda,
and old sda becomes sdb.

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
