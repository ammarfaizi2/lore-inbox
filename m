Return-Path: <linux-kernel-owner+w=401wt.eu-S932088AbXAOHPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbXAOHPm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 02:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbXAOHPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 02:15:42 -0500
Received: from aun.it.uu.se ([130.238.12.36]:49155 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088AbXAOHPl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 02:15:41 -0500
X-Greylist: delayed 1623 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 02:15:41 EST
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <17835.9143.973552.427040@alkaid.it.uu.se>
Date: Mon, 15 Jan 2007 07:48:23 +0100
From: Mikael Pettersson <mikpe@it.uu.se>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
In-Reply-To: <20070114224409.GA17199@atjola.homenet>
References: <20070114224409.GA17199@atjola.homenet>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Steinbrink writes:
 > Hi,
 > 
 > with 2.6.20-rc{2,4,5} (no other tested yet) I see SATA exceptions quite
 > often, with 2.6.19 there are no such exceptions. dmesg and lspci -v
 > output follows. In the meantime, I'll start bisecting.
 > 
 > Thanks
 > Björn
 > 
 > 
 > Linux version 2.6.20-rc2 (doener@atjola) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #4 SMP Sun Dec 31 12:54:22 CET 2006

[uneventful kernel log omitted]

 > sata_nv 0000:00:07.0: Using ADMA mode
 > PCI: Setting latency timer of device 0000:00:07.0 to 64
 > ata1: SATA max UDMA/133 cmd 0xFFFFC20000004480 ctl 0xFFFFC200000044A0 bmdma 0xD400 irq 23
 > ata2: SATA max UDMA/133 cmd 0xFFFFC20000004580 ctl 0xFFFFC200000045A0 bmdma 0xD408 irq 23
 > scsi0 : sata_nv
 > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > ata1.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
 > ata1.00: ata1: dev 0 multi count 16
 > ata1.00: configured for UDMA/133
 > scsi1 : sata_nv
 > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > ata2.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
 > ata2.00: ata2: dev 0 multi count 16
 > ata2.00: configured for UDMA/133
 > scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
 > ata1: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
 > SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
 > sda: Write Protect is off
 > sda: Mode Sense: 00 3a 00 00
 > SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
 > sda: Write Protect is off
 > sda: Mode Sense: 00 3a 00 00
 > SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 >  sda: sda1 sda2 sda3
 > sd 0:0:0:0: Attached scsi disk sda
 > scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
 > ata2: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
 > SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
 > sdb: Write Protect is off
 > sdb: Mode Sense: 00 3a 00 00
 > SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
 > sdb: Write Protect is off
 > sdb: Mode Sense: 00 3a 00 00
 > SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 >  sdb: sdb1 sdb2 sdb3
 > sd 1:0:0:0: Attached scsi disk sdb

Things are fine so far.

[more uneventful kernel log omitted]

 > NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-9631  Thu Nov  9 17:35:27 PST 2006
 > ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
 > ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 in
 >          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
 > ata1: soft resetting port
 > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > ata1.00: configured for UDMA/133
 > ata1: EH complete
 > SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
 > sda: Write Protect is off
 > sda: Mode Sense: 00 3a 00 00
 > SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
 > ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 out
 >          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

and then things start to break.

Notice how the problems started exactly at the point the
"NVRM" NVIDIA module (whatever it is) was loaded ...
