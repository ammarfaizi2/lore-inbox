Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWAKSNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWAKSNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWAKSNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:13:55 -0500
Received: from mail.gmx.de ([213.165.64.21]:55425 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932422AbWAKSNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:13:54 -0500
X-Authenticated: #1890154
Subject: Kernel 2.6.15 sometimes only detects one of two SATA drives and
	panics
From: Andre Hessling <ahessling@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Jan 2006 19:14:01 +0100
Message-Id: <1137003241.7603.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I recently upgraded from 2.6.14 to 2.6.15 vanilla and I encountered some
random kernel panics on boot so far.

The panic is:
"Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)"

My config hasn't changed since 2.6.14 and I never encountered such an
error under 2.6.14.

My system configuration: I have two SATA drives, /dev/sdb7 is the root
partition using reiserfs.
SATA, SCSI and reiserfs are compiled into the kernel.
My kernel command line is just: root=/dev/sdb7

lspci -v gives for the SATA controller:

0000:00:1f.2 IDE interface: Intel Corp. 82801FB/FW (ICH6/ICH6W) SATA
Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
7091
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
        I/O ports at e400 [size=8]
        I/O ports at e500 [size=4]
        I/O ports at e600 [size=8]
        I/O ports at e700 [size=4]
        I/O ports at e800 [size=16]
        Capabilities: [70] Power Management version 2


Sometimes the kernel boots without an error and sometimes it just
panics. I found out (using a camera, since I can't log the sys messages
at this time) that there is one big difference between booting the
kernel with and without a panic.

Usually it looks like this:
Jan 11 17:57:43 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] ->
GSI 19 (level, low) -> IRQ 18
Jan 11 17:57:43 localhost kernel: ata1: SATA max UDMA/133 cmd 0xE400 ctl
0xE502 bmdma 0xE800 irq 18
Jan 11 17:57:43 localhost kernel: ata2: SATA max UDMA/133 cmd 0xE600 ctl
0xE702 bmdma 0xE808 irq 18
Jan 11 17:57:43 localhost kernel: ata1: dev 0 ATA-6, max UDMA/133,
312581808 sectors: LBA48
Jan 11 17:57:43 localhost kernel: ata1: dev 0 configured for UDMA/133
Jan 11 17:57:43 localhost kernel: scsi0 : ata_piix
Jan 11 17:57:43 localhost kernel: ata2: dev 0 ATA-6, max UDMA/133,
312581808 sectors: LBA48
Jan 11 17:57:43 localhost kernel: ata2: dev 0 configured for UDMA/133
Jan 11 17:57:43 localhost kernel: scsi1 : ata_piix
Jan 11 17:57:43 localhost kernel:   Vendor: ATA       Model: WDC
WD1600JD-00H  Rev: 08.0
Jan 11 17:57:43 localhost kernel:   Type:   Direct-Access
ANSI SCSI revision: 05
Jan 11 17:57:43 localhost kernel:   Vendor: ATA       Model: WDC
WD1600JD-22H  Rev: 08.0
Jan 11 17:57:43 localhost kernel:   Type:   Direct-Access
ANSI SCSI revision: 05
Jan 11 17:57:43 localhost kernel: SCSI device sda: 312581808 512-byte
hdwr sectors (160042 MB)
Jan 11 17:57:43 localhost kernel: SCSI device sda: drive cache: write
back
Jan 11 17:57:43 localhost kernel: SCSI device sda: 312581808 512-byte
hdwr sectors (160042 MB)
Jan 11 17:57:43 localhost kernel: SCSI device sda: drive cache: write
back
Jan 11 17:57:43 localhost kernel:  sda: sda1 sda2 < sda5 >
Jan 11 17:57:43 localhost kernel: sd 0:0:0:0: Attached scsi disk sda
Jan 11 17:57:43 localhost kernel: SCSI device sdb: 312581808 512-byte
hdwr sectors (160042 MB)
Jan 11 17:57:43 localhost kernel: SCSI device sdb: drive cache: write
back
Jan 11 17:57:43 localhost kernel: SCSI device sdb: 312581808 512-byte
hdwr sectors (160042 MB)
Jan 11 17:57:43 localhost kernel: SCSI device sdb: drive cache: write
back
Jan 11 17:57:43 localhost kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 >
Jan 11 17:57:43 localhost kernel: sd 1:0:0:0: Attached scsi disk sdb
Jan 11 17:57:43 localhost kernel: sd 0:0:0:0: Attached scsi generic sg0
type 0
Jan 11 17:57:43 localhost kernel: sd 1:0:0:0: Attached scsi generic sg1
type 0
[some other drivers]
Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: found reiserfs format
"3.6" with standard journal
Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: using ordered data
mode
Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: journal params: device
sdb7, size 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: checking transaction
log (sdb7)
Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: Using r5 hash to sort
names
Jan 11 17:57:43 localhost kernel: VFS: Mounted root (reiserfs
filesystem) readonly.
[...]

And an extract of the syslog booting a kernel that will panic looks like
this:
Jan 11 17:57:43 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] ->
GSI 19 (level, low) -> IRQ 18
Jan 11 17:57:43 localhost kernel: ata1: SATA max UDMA/133 cmd 0xE400 ctl
0xE502 bmdma 0xE800 irq 18
Jan 11 17:57:43 localhost kernel: ata2: SATA max UDMA/133 cmd 0xE600 ctl
0xE702 bmdma 0xE808 irq 18
Jan 11 17:57:43 localhost kernel: ata1: dev 0 ATA-6, max UDMA/133,
312581808 sectors: LBA48
Jan 11 17:57:43 localhost kernel: ata1: dev 0 configured for UDMA/133
Jan 11 17:57:43 localhost kernel: scsi0 : ata_piix
Jan 11 17:57:43 localhost kernel: ata2: dev 0 ATA-6, max UDMA/133,
312581808 sectors: LBA48
Jan 11 17:57:43 localhost kernel: ata2: dev 0 configured for UDMA/133
Jan 11 17:57:43 localhost kernel: scsi1 : ata_piix
Jan 11 17:57:43 localhost kernel:   Vendor: ATA       Model: WDC
WD1600JD-00H  Rev: 08.0
Jan 11 17:57:43 localhost kernel: SCSI device sda: 312581808 512-byte
hdwr sectors (160042 MB)
Jan 11 17:57:43 localhost kernel: SCSI device sda: drive cache: write
back
Jan 11 17:57:43 localhost kernel: SCSI device sda: 312581808 512-byte
hdwr sectors (160042 MB)
Jan 11 17:57:43 localhost kernel: SCSI device sda: drive cache: write
back
Jan 11 17:57:43 localhost kernel:  sda: sda1 sda2 < sda5 >
Jan 11 17:57:43 localhost kernel: sd 0:0:0:0: Attached scsi disk sda
Jan 11 17:57:43 localhost kernel: sd 0:0:0:0: Attached scsi generic sg0
type 0
[some other drivers]
->Panic

Notice that sda is detected, but sdb is not. But as my Linux partition
is on sdb, it is obvious that a kernel panic appears.

So why is sdb sometimes detected and sometimes not?

Of course I already double-checked that the config really hasn't changed
and the fact that it sometimes works should clarify that the config is
correct.

Thanks so far.
-- 
Regards,
André

