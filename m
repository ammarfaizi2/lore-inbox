Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWFTDAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWFTDAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWFTDAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:00:44 -0400
Received: from taz.net.au ([203.16.167.1]:32940 "EHLO taz.net.au")
	by vger.kernel.org with ESMTP id S965066AbWFTDAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:00:44 -0400
Date: Tue, 20 Jun 2006 13:00:38 +1000
From: Craig Sanders <cas@taz.net.au>
To: linux-kernel@vger.kernel.org
Subject: Re: problems with sata_nv and 2.6.17
Message-ID: <20060620030038.GA7115@taz.net.au>
References: <20060620001221.GA17082@taz.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620001221.GA17082@taz.net.au>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 10:12:22AM +1000, Craig Sanders wrote:
> hmmm. i just noticed that lspci says this M/B has two entries for SATA
> controllers, even though there are only 2 SATA connectors:

actually, wrong. there are 4 SATA connectors on the motherboard as i
would have noticed had i only looked at the board or the manual.  2 x
nvidea nforce3 ports and 2 x Sil3512 ports.

the Sil3512 ports are allegedly RAID, but i wont be using them as raid
controllers - even if it worked in linux, i trust linux software raid a
lot more than i trust pseudo-HW-raid from cheap controllers.


> 00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2)
> 02:0d.0 Mass storage controller: Silicon Image, Inc. SiI 3512 [SATALink/SATARaid] Serial ATA Controller (rev 01)
> 
> i have sata_nv compiled in, but not SiI - which one should i use? or both?
> i'm recompiling now with SiI support.

ok, i recompiled the kernel with both nv_sata and SiI sata. powered
down and swapped SATA drives from the nv ports to the sil3512 ports.
rebooted.

success!

managed to partition sdb with no hassles, and added both sda and sdb to
a new raid-1 array (which is resyncing now in the background - will be
finished in about 70 minutes). as soon as it's finished, i'll format it
with XFS and thrash-test it for the next few days before i trust any
data to it.


conclusion: at least on my box, the silicon images sata driver works, while
the nvidea nforce3 sata doesn't.



relevant parts of kernel boot log:

Jun 20 12:34:50 ganesh kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
Jun 20 12:34:51 ganesh kernel: Inspecting /boot/System.map-2.6.17
Jun 20 12:34:51 ganesh kernel: Loaded 27756 symbols from /boot/System.map-2.6.17.
Jun 20 12:34:51 ganesh kernel: Symbols match kernel version 2.6.17.
Jun 20 12:34:51 ganesh kernel: No module symbols loaded - kernel modules not enabled. 
Jun 20 12:34:51 ganesh kernel: aptec 2940 Ultra SCSI adapter>
Jun 20 12:34:51 ganesh kernel: [4294677.952000]         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
Jun 20 12:34:51 ganesh kernel: [4294677.952000] 
Jun 20 12:34:51 ganesh kernel: [4294681.891000] libata version 1.20 loaded.
Jun 20 12:34:51 ganesh kernel: [4294681.891000] sata_sil 0000:02:0d.0: version 0.9
Jun 20 12:34:51 ganesh kernel: [4294681.892000] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
Jun 20 12:34:51 ganesh kernel: [4294681.893000] ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 18
Jun 20 12:34:51 ganesh kernel: [4294681.893000] sata_sil 0000:02:0d.0: Applying R_ERR on DMA activate FIS errata fix
Jun 20 12:34:51 ganesh kernel: [4294681.893000] ata1: SATA max UDMA/100 cmd 0xF8806080 ctl 0xF880608A bmdma 0xF8806000 irq 18
Jun 20 12:34:51 ganesh kernel: [4294681.893000] ata2: SATA max UDMA/100 cmd 0xF88060C0 ctl 0xF88060CA bmdma 0xF8806008 irq 18
Jun 20 12:34:51 ganesh kernel: [4294682.245000] ata1: SATA link up 1.5 Gbps (SStatus 113)
Jun 20 12:34:51 ganesh kernel: [4294682.248000] ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4773 85:7c69 86:3e01 87:4763 88:207f
Jun 20 12:34:51 ganesh kernel: [4294682.248000] ata1: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
Jun 20 12:34:51 ganesh kernel: [4294682.252000] ata1: dev 0 configured for UDMA/100
Jun 20 12:34:51 ganesh kernel: [4294682.252000] scsi1 : sata_sil
Jun 20 12:34:51 ganesh kernel: [4294682.604000] ata2: SATA link up 1.5 Gbps (SStatus 113)
Jun 20 12:34:51 ganesh kernel: [4294682.607000] ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4773 85:7c69 86:3e01 87:4763 88:207f
Jun 20 12:34:51 ganesh kernel: [4294682.607000] ata2: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
Jun 20 12:34:51 ganesh kernel: [4294682.611000] ata2: dev 0 configured for UDMA/100
Jun 20 12:34:51 ganesh kernel: [4294682.611000] scsi2 : sata_sil
Jun 20 12:34:51 ganesh kernel: [4294682.611000]   Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
Jun 20 12:34:51 ganesh kernel: [4294682.612000]   Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 20 12:34:51 ganesh kernel: [4294682.612000]   Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
Jun 20 12:34:51 ganesh kernel: [4294682.613000]   Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 20 12:34:51 ganesh kernel: [4294682.613000] sata_nv 0000:00:0a.0: version 0.8
Jun 20 12:34:51 ganesh kernel: [4294682.615000] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
Jun 20 12:34:51 ganesh kernel: [4294682.615000] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level, high) -> IRQ 19Jun 20 12:34:51 ganesh kernel: [4294682.615000] PCI: Setting latency timer of device 0000:00:0a.0 to 64
Jun 20 12:34:51 ganesh kernel: [4294682.616000] ata3: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 19
Jun 20 12:34:51 ganesh kernel: [4294682.616000] ata4: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 19
Jun 20 12:34:51 ganesh kernel: [4294682.817000] ata3: SATA link down (SStatus 0)
Jun 20 12:34:51 ganesh kernel: [4294682.817000] scsi3 : sata_nv
Jun 20 12:34:51 ganesh kernel: [4294683.018000] ata4: SATA link down (SStatus 0)
Jun 20 12:34:51 ganesh kernel: [4294683.018000] scsi4 : sata_nv
Jun 20 12:34:51 ganesh kernel: [4294683.018000] st: Version 20050830, fixed bufsize 32768, s/g segs 256
Jun 20 12:34:51 ganesh kernel: [4294683.018000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
Jun 20 12:34:51 ganesh kernel: [4294683.018000] sda: Write Protect is off
Jun 20 12:34:51 ganesh kernel: [4294683.018000] sda: Mode Sense: 00 3a 00 00
Jun 20 12:34:51 ganesh kernel: [4294683.018000] SCSI device sda: drive cache: write back
Jun 20 12:34:51 ganesh kernel: [4294683.018000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
Jun 20 12:34:51 ganesh kernel: [4294683.018000] sda: Write Protect is off
Jun 20 12:34:51 ganesh kernel: [4294683.018000] sda: Mode Sense: 00 3a 00 00
Jun 20 12:34:51 ganesh kernel: [4294683.018000] SCSI device sda: drive cache: write back
Jun 20 12:34:51 ganesh kernel: [4294683.018000]  sda: sda1
Jun 20 12:34:51 ganesh kernel: [4294683.041000] sd 1:0:0:0: Attached scsi disk sda
Jun 20 12:34:51 ganesh kernel: [4294683.042000] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
Jun 20 12:34:51 ganesh kernel: [4294683.042000] sdb: Write Protect is off
Jun 20 12:34:51 ganesh kernel: [4294683.042000] sdb: Mode Sense: 00 3a 00 00
Jun 20 12:34:51 ganesh kernel: [4294683.042000] SCSI device sdb: drive cache: write back
Jun 20 12:34:51 ganesh kernel: [4294683.042000] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
Jun 20 12:34:51 ganesh kernel: [4294683.042000] sdb: Write Protect is off
Jun 20 12:34:51 ganesh kernel: [4294683.042000] sdb: Mode Sense: 00 3a 00 00
Jun 20 12:34:51 ganesh kernel: [4294683.042000] SCSI device sdb: drive cache: write back
Jun 20 12:34:51 ganesh kernel: [4294683.042000]  sdb: sdb1
Jun 20 12:34:51 ganesh kernel: [4294683.067000] sd 2:0:0:0: Attached scsi disk sdb


craig

-- 
craig sanders <cas@taz.net.au>           (part time cyborg)
