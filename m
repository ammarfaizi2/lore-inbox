Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFTMcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFTMcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 08:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVFTMcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 08:32:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:27610 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261236AbVFTMcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 08:32:35 -0400
From: Marcel Naziri <silent@zwobbl.de>
Organization: FB Mathematik - =?iso-8859-15?q?Universit=E4t?= Mainz
To: linux-kernel@vger.kernel.org
Subject: Re: sata_promise KERNEL_BUG on 2.6.12
Date: Mon, 20 Jun 2005 14:32:29 +0200
User-Agent: KMail/1.8.1
Cc: Jeff Garzik <jgarzik@pobox.com>
References: <200506200402.55229.silent@zwobbl.de> <42B62901.3000500@pobox.com>
In-Reply-To: <42B62901.3000500@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201432.30628.silent@zwobbl.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:545ea3034f044b93d4367384da2b15f2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Jeff Garzik am Montag 20 Juni 2005 04:25:
> Marcel Naziri wrote:
> > Now, when I connect the drives to port 1 & 2 of the controller, booting
> > up stops with this:
> > ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
> > ata1: SATA max UDMA/133 cmd 0xF8802200 ctl 0xF8802238 bdma 0x0 irq 17
> > ata2: SATA max UDMA/133 cmd 0xF8802280 ctl 0xF88022B8 bdma 0x0 irq 17
> > ata3: SATA max UDMA/133 cmd 0xF8802300 ctl 0xF8802338 bdma 0x0 irq 17
> > ata4: SATA max UDMA/133 cmd 0xF8802380 ctl 0xF88023B8 bdma 0x0 irq 17
> > ata1: no device found (phy stat 00000000)
> > scsi0 : sata_promise
> > ata2: dev 0 ATA, max UDMA/100, 312581808 sectors: lba48
> > ------------[ cut here ]------------
> > kernel BUG at drivers/scsi/libata-core.c:2077!
> > invalid operand: 0000 [#1]
> > PREEMPT
> > Modules linked in:
> > CPU:    0
> > EIP:    0060:[<c025f60f>]     Not tainted VLI
> > EFLAGS: 00010246   (2.6.12)
> > EIP is at ata_dev_set_xfermode+0xcf/0xf0
>
> This is highly strange.  Do you have any patches applied, or is this
> vanilla 2.6.12 kernel?
>
> Can you turn off preempt and try to reproduce ?

With preempt disabled it boots up. drives attached to port 1 & 2 gets attached 
to ata4 & ata2:

libata version 1.11 loaded.
sata_promise version 1.01
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xF8802200 ctl 0xF8802238 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8802280 ctl 0xF88022B8 bmdma 0x0 irq 17
ata3: SATA max UDMA/133 cmd 0xF8802300 ctl 0xF8802338 bmdma 0x0 irq 17
ata4: SATA max UDMA/133 cmd 0xF8802380 ctl 0xF88023B8 bmdma 0x0 irq 17
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 
88:203f
ata2: dev 0 ATA, max UDMA/100, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_promise
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 
88:80ff
ata4: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_promise
  Vendor: ATA       Model: SAMSUNG SV1604N   Rev: TR10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 >
Attached scsi disk sdb at scsi3, channel 0, id 0, lun 0

What else can I try? What helpful information can I provide?

# lspci -v -s 0a.0
0000:00:0a.0 Unknown mass storage controller: Promise Technology, Inc.: 
Unknown device 3d18 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 3d18
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 17
        I/O ports at e800 [size=128]
        I/O ports at e400 [size=256]
        Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
        Memory at dffc0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at dffe0000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2

Hopefully with preempt disabled also these sporadic messages in syslog will 
disappear:

Jun 20 01:28:31 Carter kernel: ata3: status=0x51 { DriveReady SeekComplete 
Error }
Jun 20 01:28:31 Carter kernel: ata3: called with no error (51)!

But I think that the one bridged ATA-drive may cause this warning/error!? Is 
it harmful? 
On very rare conditions sometimes it results in harder errors like that ending 
up in lockup filesystems and my box:

May 25 01:25:50 Carter kernel: ata1: command timeout
May 25 01:25:50 Carter kernel: ata1: status=0x51 { DriveReady SeekComplete 
Error }
May 25 01:25:50 Carter kernel: ata1: called with no error (51)!
May 25 01:26:20 Carter kernel: ata1: command timeout
May 25 01:26:20 Carter kernel: ATA: abnormal status 0xFF on port 0xF880221C
May 25 01:26:20 Carter kernel: ata1: status=0xff { Busy }
May 25 01:26:20 Carter kernel: SCSI error : <0 0 0 0> return code = 0x8000002
May 25 01:26:20 Carter kernel: sda: Current: sense key: Aborted Command
May 25 01:26:20 Carter kernel: Additional sense: Scsi parity error
May 25 01:26:20 Carter kernel: end_request: I/O error, dev sda, sector 9079889
May 25 01:26:50 Carter kernel: ata1: command timeout
May 25 01:26:50 Carter kernel: ATA: abnormal status 0xFF on port 0xF880221C
May 25 01:26:50 Carter kernel: ata1: status=0xff { Busy }
May 25 01:26:50 Carter kernel: SCSI error : <0 0 0 0> return code = 0x8000002
May 25 01:26:50 Carter kernel: sda: Current: sense key: Aborted Command
May 25 01:26:50 Carter kernel: Additional sense: Scsi parity error
May 25 01:26:50 Carter kernel: end_request: I/O error, dev sda, sector 9079897
May 25 01:27:20 Carter kernel: ata1: command timeout
May 25 01:27:20 Carter kernel: ATA: abnormal status 0xFF on port 0xF880221C
May 25 01:27:20 Carter kernel: ata1: status=0xff { Busy }
May 25 01:27:20 Carter kernel: SCSI error : <0 0 0 0> return code = 0x8000002
May 25 01:27:20 Carter kernel: sda: Current: sense key: Aborted Command
May 25 01:27:20 Carter kernel: Additional sense: Scsi parity error
May 25 01:27:20 Carter kernel: end_request: I/O error, dev sda, sector 9079905
May 25 01:27:50 Carter kernel: ata1: command timeout
May 25 01:27:50 Carter kernel: ATA: abnormal status 0xFF on port 0xF880221C
May 25 01:27:50 Carter kernel: ata1: status=0xff { Busy }
May 25 01:27:50 Carter kernel: SCSI error : <0 0 0 0> return code = 0x8000002
May 25 01:27:50 Carter kernel: sda: Current: sense key: Aborted Command
May 25 01:27:50 Carter kernel: Additional sense: Scsi parity error
May 25 01:27:50 Carter kernel: end_request: I/O error, dev sda, sector 9079913
May 25 01:28:20 Carter kernel: ata1: command timeout
May 25 01:28:20 Carter kernel: ATA: abnormal status 0xFF on port 0xF880221C
May 25 01:28:20 Carter kernel: ata1: status=0xff { Busy }
May 25 01:28:20 Carter kernel: SCSI error : <0 0 0 0> return code = 0x8000002
May 25 01:28:20 Carter kernel: sda: Current: sense key: Aborted Command
May 25 01:28:20 Carter kernel: Additional sense: Scsi parity error
May 25 01:28:20 Carter kernel: end_request: I/O error, dev sda, sector 9079921
May 25 01:28:46 Carter syslog-ng[2376]: STATS: dropped 0
May 25 01:28:50 Carter kernel: ata1: command timeout
May 25 01:28:50 Carter kernel: ATA: abnormal status 0xFF on port 0xF880221C
May 25 01:28:50 Carter kernel: ata1: status=0xff { Busy }
May 25 01:28:50 Carter kernel: SCSI error : <0 0 0 0> return code = 0x8000002
May 25 01:28:50 Carter kernel: sda: Current: sense key: Aborted Command
May 25 01:28:50 Carter kernel: Additional sense: Scsi parity error
May 25 01:28:50 Carter kernel: end_request: I/O error, dev sda, sector 9079929
May 25 01:30:05 Carter syslog-ng[2680]: syslog-ng version 1.6.5 starting

Greets
   zwobbl>
