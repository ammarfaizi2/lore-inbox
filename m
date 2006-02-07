Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWBGRuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWBGRuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWBGRuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:50:24 -0500
Received: from math.ut.ee ([193.40.36.2]:61946 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932225AbWBGRuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:50:22 -0500
Date: Tue, 7 Feb 2006 19:50:20 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <1139324653.18391.41.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0602071947030.15961@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor> 
 <1139310335.18391.2.camel@localhost.localdomain>  <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
  <1139312330.18391.14.camel@localhost.localdomain>
 <1139324653.18391.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've put up a -ide2 patch at
>
> http://zeniv.linux.org.uk/~alan/IDE

Tried it on a Intel 815 mainboard with ICH2, 1 IDE disk and 1 Sony CDROM 
that had problems before (DMA timeout, PIO only, since about 2.4.21). 
Got the following panic. First it paused several seconds after
scsi1 : ata_piix
and then gave the panic + double fault.

ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata1: dev 0 ATA-5, max UDMA/100, 40132503 sectors: LBA
ata1: dev 0 configured for UDMA/66
scsi0 : ata_piix
   Vendor: ATA       Model: QUANTUM FIREBALL  Rev: A1Y.
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
ata2: command 0xa0 timeout, stat 0xd0 host_stat 0x24
ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
SCSI device sda: 40132503 512-byte hdwr sectors (20548 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
int3: 0000 [#1]
CPU:    0
EIP:    0060:[<c0148711>]    Not tainted VLI
EFLAGS: 00000282   (2.6.16-rc2-PATA)
EIP is at get_super+0x1/0x80
eax: c146d040   ebx: c146d040   ecx: dfe83db8   edx: 00000001
esi: 00000000   edi: 00000000   ebp: 00000000   esp: dfe83db4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dfe83000 task=dfe82a30)
Stack: <0>00000000 c01441e9 c146d040 00000000 c01ac931 c146d040 dfc97ec0 c016ff4e
        c01ed05e dfcbf120 c146d040 dfc97ec0 c02b7153 dfe83e1c c146d040 dfc97ec0
        00000000 00000000 c0149a31 c146d04c 00000000 dfe83ea0 c146d040 00000001
Call Trace:
  [<c01441e9>] fsync_bdev+0x9/0x30
  [<c01ac931>] invalidate_partition+0x21/0x40
  [<c016ff4e>] rescan_partitions+0x2e/0x210
  [<c01ed05e>] get_device+0xe/0x20
  [<c02b7153>] sd_open+0x43/0x100
  [<c0149a31>] do_open+0x201/0x280
  [<c0149b53>] blkdev_get+0x53/0x60
  [<c0170207>] register_disk+0xd7/0xf0
  [<c01ac492>] add_disk+0x32/0x40
  [<c01ac420>] exact_match+0x0/0x10
  [<c01ac450>] exact_lock+0x0/0x10
  [<c02b892f>] sd_probe+0x21f/0x300
  [<c01ee6d0>] __driver_attach+0x0/0x60
  [<c01ee608>] driver_probe_device+0x38/0xa0
  [<c01ee72a>] __driver_attach+0x5a/0x60
  [<c01edcf8>] bus_for_each_dev+0x38/0x60
  [<c01ee4e1>] driver_attach+0x11/0x20
  [<c01ee6d0>] __driver_attach+0x0/0x60
  [<c01edfca>] bus_add_driver+0x5a/0x100
  [<c01eea10>] klist_devices_get+0x0/0x10
  [<c0100311>] init+0x81/0x1e0
  [<c0100290>] init+0x0/0x1e0
  [<c0100bd5>] kernel_thread_helper+0x5/0x10
Code: 14 00 00 00 89 44 24 58 8b 44 24 2c 89 44 24 5c 8b 44 24 7c e8 01 d1 06 00 85 c0 74 c7 bb f2 ff ff ff eb c0 8d b6 00 00 00 00 56 <85> c0 53 89 c6 75 08 31 db 89 d8 5b 5e c3 90 8b 1d 90 6f 37 c0
  <0>Kernel panic - not syncing: Attempted to kill init!
  double fault, gdt at c036f000 [255 bytes]
double fault, tss at c0370000
eip = c011270a, esp = dfe83ce0
eax = 00000000, ebx = 00000000, ecx = c043d280, edx = 00000000
esi = dfe82a30, edi = 00000000


-- 
Meelis Roos (mroos@linux.ee)
