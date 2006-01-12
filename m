Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWALHkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWALHkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWALHkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:40:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750891AbWALHkf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:40:35 -0500
Date: Wed, 11 Jan 2006 23:40:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andre Hessling <ahessling@gmx.de>
Cc: linux-kernel@vger.kernel.org, Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: Kernel 2.6.15 sometimes only detects one of two SATA drives and
 panics
Message-Id: <20060111234011.451c5c36.akpm@osdl.org>
In-Reply-To: <1137003241.7603.20.camel@localhost.localdomain>
References: <1137003241.7603.20.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hessling <ahessling@gmx.de> wrote:
>
> Hello!
> 
> I recently upgraded from 2.6.14 to 2.6.15 vanilla and I encountered some
> random kernel panics on boot so far.
> 
> The panic is:
> "Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)"

Reuben, do you think this is the same as the bug you're seeing?

> My config hasn't changed since 2.6.14 and I never encountered such an
> error under 2.6.14.
> 
> My system configuration: I have two SATA drives, /dev/sdb7 is the root
> partition using reiserfs.
> SATA, SCSI and reiserfs are compiled into the kernel.
> My kernel command line is just: root=/dev/sdb7
> 
> lspci -v gives for the SATA controller:
> 
> 0000:00:1f.2 IDE interface: Intel Corp. 82801FB/FW (ICH6/ICH6W) SATA
> Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device
> 7091
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
>         I/O ports at e400 [size=8]
>         I/O ports at e500 [size=4]
>         I/O ports at e600 [size=8]
>         I/O ports at e700 [size=4]
>         I/O ports at e800 [size=16]
>         Capabilities: [70] Power Management version 2
> 
> 
> Sometimes the kernel boots without an error and sometimes it just
> panics. I found out (using a camera, since I can't log the sys messages
> at this time) that there is one big difference between booting the
> kernel with and without a panic.
> 
> Usually it looks like this:
> Jan 11 17:57:43 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] ->
> GSI 19 (level, low) -> IRQ 18
> Jan 11 17:57:43 localhost kernel: ata1: SATA max UDMA/133 cmd 0xE400 ctl
> 0xE502 bmdma 0xE800 irq 18
> Jan 11 17:57:43 localhost kernel: ata2: SATA max UDMA/133 cmd 0xE600 ctl
> 0xE702 bmdma 0xE808 irq 18
> Jan 11 17:57:43 localhost kernel: ata1: dev 0 ATA-6, max UDMA/133,
> 312581808 sectors: LBA48
> Jan 11 17:57:43 localhost kernel: ata1: dev 0 configured for UDMA/133
> Jan 11 17:57:43 localhost kernel: scsi0 : ata_piix
> Jan 11 17:57:43 localhost kernel: ata2: dev 0 ATA-6, max UDMA/133,
> 312581808 sectors: LBA48
> Jan 11 17:57:43 localhost kernel: ata2: dev 0 configured for UDMA/133
> Jan 11 17:57:43 localhost kernel: scsi1 : ata_piix
> Jan 11 17:57:43 localhost kernel:   Vendor: ATA       Model: WDC
> WD1600JD-00H  Rev: 08.0
> Jan 11 17:57:43 localhost kernel:   Type:   Direct-Access
> ANSI SCSI revision: 05
> Jan 11 17:57:43 localhost kernel:   Vendor: ATA       Model: WDC
> WD1600JD-22H  Rev: 08.0
> Jan 11 17:57:43 localhost kernel:   Type:   Direct-Access
> ANSI SCSI revision: 05
> Jan 11 17:57:43 localhost kernel: SCSI device sda: 312581808 512-byte
> hdwr sectors (160042 MB)
> Jan 11 17:57:43 localhost kernel: SCSI device sda: drive cache: write
> back
> Jan 11 17:57:43 localhost kernel: SCSI device sda: 312581808 512-byte
> hdwr sectors (160042 MB)
> Jan 11 17:57:43 localhost kernel: SCSI device sda: drive cache: write
> back
> Jan 11 17:57:43 localhost kernel:  sda: sda1 sda2 < sda5 >
> Jan 11 17:57:43 localhost kernel: sd 0:0:0:0: Attached scsi disk sda
> Jan 11 17:57:43 localhost kernel: SCSI device sdb: 312581808 512-byte
> hdwr sectors (160042 MB)
> Jan 11 17:57:43 localhost kernel: SCSI device sdb: drive cache: write
> back
> Jan 11 17:57:43 localhost kernel: SCSI device sdb: 312581808 512-byte
> hdwr sectors (160042 MB)
> Jan 11 17:57:43 localhost kernel: SCSI device sdb: drive cache: write
> back
> Jan 11 17:57:43 localhost kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 >
> Jan 11 17:57:43 localhost kernel: sd 1:0:0:0: Attached scsi disk sdb
> Jan 11 17:57:43 localhost kernel: sd 0:0:0:0: Attached scsi generic sg0
> type 0
> Jan 11 17:57:43 localhost kernel: sd 1:0:0:0: Attached scsi generic sg1
> type 0
> [some other drivers]
> Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: found reiserfs format
> "3.6" with standard journal
> Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: using ordered data
> mode
> Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: journal params: device
> sdb7, size 8192, journal first block 18, max trans len 1024, max batch
> 900, max commit age 30, max trans age 30
> Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: checking transaction
> log (sdb7)
> Jan 11 17:57:43 localhost kernel: ReiserFS: sdb7: Using r5 hash to sort
> names
> Jan 11 17:57:43 localhost kernel: VFS: Mounted root (reiserfs
> filesystem) readonly.
> [...]
> 
> And an extract of the syslog booting a kernel that will panic looks like
> this:
> Jan 11 17:57:43 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] ->
> GSI 19 (level, low) -> IRQ 18
> Jan 11 17:57:43 localhost kernel: ata1: SATA max UDMA/133 cmd 0xE400 ctl
> 0xE502 bmdma 0xE800 irq 18
> Jan 11 17:57:43 localhost kernel: ata2: SATA max UDMA/133 cmd 0xE600 ctl
> 0xE702 bmdma 0xE808 irq 18
> Jan 11 17:57:43 localhost kernel: ata1: dev 0 ATA-6, max UDMA/133,
> 312581808 sectors: LBA48
> Jan 11 17:57:43 localhost kernel: ata1: dev 0 configured for UDMA/133
> Jan 11 17:57:43 localhost kernel: scsi0 : ata_piix
> Jan 11 17:57:43 localhost kernel: ata2: dev 0 ATA-6, max UDMA/133,
> 312581808 sectors: LBA48
> Jan 11 17:57:43 localhost kernel: ata2: dev 0 configured for UDMA/133
> Jan 11 17:57:43 localhost kernel: scsi1 : ata_piix
> Jan 11 17:57:43 localhost kernel:   Vendor: ATA       Model: WDC
> WD1600JD-00H  Rev: 08.0
> Jan 11 17:57:43 localhost kernel: SCSI device sda: 312581808 512-byte
> hdwr sectors (160042 MB)
> Jan 11 17:57:43 localhost kernel: SCSI device sda: drive cache: write
> back
> Jan 11 17:57:43 localhost kernel: SCSI device sda: 312581808 512-byte
> hdwr sectors (160042 MB)
> Jan 11 17:57:43 localhost kernel: SCSI device sda: drive cache: write
> back
> Jan 11 17:57:43 localhost kernel:  sda: sda1 sda2 < sda5 >
> Jan 11 17:57:43 localhost kernel: sd 0:0:0:0: Attached scsi disk sda
> Jan 11 17:57:43 localhost kernel: sd 0:0:0:0: Attached scsi generic sg0
> type 0
> [some other drivers]
> ->Panic
> 
> Notice that sda is detected, but sdb is not. But as my Linux partition
> is on sdb, it is obvious that a kernel panic appears.
> 
> So why is sdb sometimes detected and sometimes not?
> 
> Of course I already double-checked that the config really hasn't changed
> and the fact that it sometimes works should clarify that the config is
> correct.
> 
> Thanks so far.
> -- 
> Regards,
> André
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
