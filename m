Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266190AbTLIJkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266191AbTLIJkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:40:18 -0500
Received: from relay.inway.cz ([212.24.128.3]:20401 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S266190AbTLIJkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:40:03 -0500
Message-ID: <3FD59869.5000909@scssoft.com>
Date: Tue, 09 Dec 2003 10:39:53 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031125
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org>
In-Reply-To: <20031203204445.GA26987@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a little warning:

I have got a situation where the kernel won't boot when probing
for partition tables on SATA drives. I understand that this is
probably not related to libsata in any way... but... here it goes:

system is UP AMD Opteron 244/debian/sid
gcc (GCC) 3.3.3 20031206 (prerelease) (Debian)
binutils: Version: 2.14.90.0.7-3
kernel 2.6.0-test11

when compiling new kernel on a kernel optimized for Opteron
on an opteron machine, the kernel wont boot...

libata version 0.81 loaded.
sata_via version 0.11
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 20
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 20
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:407f
ata2: dev 0 ATA, max UDMA/133, 72303840 sectors (lba48)
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
   Vendor: ATA       Model: WDC WD2500JD-00F  Rev: 0.81
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 0.81
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write through
  sda: sda1
^^^ hangs right here with DMA timeout

when compiling new kernel on a kernel optimized for Athlon
on an opteron machine, the kernel boots ok
(same gcc, same binutils, same machine, just an athlon optimized kernel)

... the boot continues like this:
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write through
  sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 72303840 512-byte hdwr sectors (37020 MB)
SCSI device sdb: drive cache: write through
  sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
... and so on

Happened after I remotely restarted quite important server,
had to get up really early to workaround this :-)
[by compiling new opteron optimized kernel on an non opteron
kernel... duh, could wood chuck chuck a wood if wood chuck chuck ....]

I have no idea what might be wrong...

Regards,
Petr
