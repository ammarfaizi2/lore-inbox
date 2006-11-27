Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756540AbWK0TDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbWK0TDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757858AbWK0TDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:03:10 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:60177 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1756540AbWK0TDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:03:08 -0500
Date: Mon, 27 Nov 2006 20:03:01 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Message-ID: <20061127190301.GA75765@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <200611252159.59414.ak@suse.de> <20061126131532.GA41703@dspnet.fr.eu.org> <200611262028.04638.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611262028.04638.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 08:28:04PM +0100, Andi Kleen wrote:
> On Sunday 26 November 2006 14:15, Olivier Galibert wrote:
> > Ok, here you go, what about that?  I'll be able to test it on i386 on
> > monday, not before.  It's hard to doa full 32bits install remotely :-)
> 
> Sorry, please don't put it all into a single patch. Do one patch
> that just moves code, then add new functionality later.
> Otherwise nobody can review it properly.

Ok, I have it split in 5 parts, but the testing on i386 failed simply
because the vanilla code there just does not work.  Symptom is the
SATA driver not seeing the disk somehow.

With a 64bits kernel:

ata_piix 0000:00:1f.2: version 2.00ac6
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 20
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 20
scsi0 : ata_piix
ata1.00: ATA-7, max UDMA/133, 156250000 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 8
ata1.00: configured for UDMA/133
scsi1 : ata_piix
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: port failed to respond (30 secs, Status 0xff)
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: reset failed, giving up
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6V080E0   VA13 PQ: 0 ANSI: 5
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0



With a 32bits, pci=nommconf kernel:

ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 18
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 18
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 18
scsi0 : ata_piix
ata1.00: ATA-7, max UDMA/133, 156250000 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 8
ata1.00: configured for UDMA/133
scsi1 : ata_piix
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: port failed to respond (30 secs, Status 0xff)
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: reset failed, giving up
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6V080E0   VA13 PQ: 0 ANSI: 5
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0



With a 5d48545e5e88ab7a27ba6a5cb1e8fff617754b61 kernel in 32 bits and
no pci= parameter:

ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 18
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 18
scsi0 : ata_piix
scsi1 : ata_piix
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: port failed to respond (30 secs, Status 0xff)
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: reset failed, giving up


00:00.0 Host bridge: Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation 945G/GZ/P/PL Express PCI Express Root Port (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1e.2 Multimedia audio controller: Intel Corporation 82801G (ICH7 Family) AC'97 Audio Controller (rev 01)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controller IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc RV380 [Radeon X600 (PCIE)]
01:00.1 Display controller: ATI Technologies Inc RV380 [Radeon X600]
02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 Gigabit Ethernet PCI Express (rev 01)


So, do you want the untested-on-i386-because-I-can't version?

  OG.

