Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWEQPet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWEQPet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWEQPet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:34:49 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:48531 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1750708AbWEQPet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:34:49 -0400
Message-ID: <446B4294.7080800@bootc.net>
Date: Wed, 17 May 2006 16:34:44 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5 (X11/20060309)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Cc: IMB Recipient 1 <mspop3connector.stefan@mehnert-edv.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org> <44649CE1.4060407@bootc.net> <000001c675dd$42268240$0b64a8c0@mehnertedv.local> <44650907.1080903@gmail.com>
In-Reply-To: <44650907.1080903@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Chris Boot wrote:
>> Chris Boot wrote:
>>> Tejun Heo wrote:
>>>> Patches against v2.6.16.16 is avaialbe at the following URL.
>>>>
>>>>  http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.16.16-20060512.tar.bz2 
>>>>
>>>>
>>>> Please read README carefully before testing the patches.  Keep in mind
>>>> that these are still quite experimental and not ready for production
>>>> use.
>>>
>>> Are these patches likely to work alongside Alan's PATA patches? 
>>> Specifically I have a DVD-RW and an IDE tape that I'd like to use.
>>
>> I'll answer my own question: this fails miserably!
> 
> Yeap, it would require some updates to all those pata_* drivers. Updates 
> are mostly straight forward though.  I think once EH stuff gets 
> stabilized and gets merged into libata-dev #upstream, PATA patches will 
> be updated accordingly and merged soon.
> 
>> I'll test 'em anyway, screw the DVD and tape for now. :-P
> 
> Heh heh.  Cool.

Right, well, I've finally got round to booting a working kernel with your 
patches (been trying Xen unstable without luck). I built a kernel with the 
latest Xen 3.0 testing patches and your -tj patch (which applies fine). I also 
tried hotplugging one of my drives on my sata_sil controller. Here are the 
relevant messages:

[    1.855133] libata version 1.30 loaded.
[    1.855175] sata_sil 0000:00:0a.0: version 1.0
[    1.855253] ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 17
[    1.856452] ata1: SATA max UDMA/100 cmd 0xF1002080 ctl 0xF100208A bmdma 
0xF1002000 irq 17
[    1.857527] ata2: SATA max UDMA/100 cmd 0xF10020C0 ctl 0xF10020CA bmdma 
0xF1002008 irq 17
[    1.858571] scsi0 : sata_sil
[    2.108048] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.109549] ata1.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 
87:4023 88:207f
[    2.109555] ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 
0/32)
[    2.111463] ata1.00: configured for UDMA/100
[    2.111941] scsi1 : sata_sil
[    2.361045] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.362537] ata2.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 
87:4023 88:207f
[    2.362542] ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 
0/32)
[    2.364456] ata2.00: configured for UDMA/100
[    2.365043]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[    2.365747]   Type:   Direct-Access                      ANSI SCSI revision: 05
[    2.366780]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[    2.367498]   Type:   Direct-Access                      ANSI SCSI revision: 05
[    2.368484] sata_via 0000:00:0f.0: version 1.2
[    2.368925] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 11, using IRQ 20
[    2.369830] ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
[    2.370297] ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 
(level, low) -> IRQ 18
[    2.371224] PCI: Via IRQ fixup for 0000:00:0f.0, from 11 to 2
[    2.371706] sata_via 0000:00:0f.0: routed to hard irq line 2
[    2.372235] ata3: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC800 irq 18
[    2.373195] ata4: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xC808 irq 18
[    2.375546] scsi2 : sata_via
[    2.576029] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.727918] ata3.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 
87:4023 88:407f
[    2.727923] ata3.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 
0/32)
[    2.731229] ata3.00: configured for UDMA/133
[    2.733149] scsi3 : sata_via
[    2.936028] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.139026] ata4.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 
87:4023 88:407f
[    3.139031] ata4.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 
0/32)
[    3.142741] ata4.00: configured for UDMA/133
[    3.145018]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[    3.147485]   Type:   Direct-Access                      ANSI SCSI revision: 05
[    3.150318]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[    3.152859]   Type:   Direct-Access                      ANSI SCSI revision: 05
[    3.155738] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[    3.158039] sda: Write Protect is off
[    3.160276] sda: Mode Sense: 00 3a 00 00
[    3.160294] SCSI device sda: drive cache: write back
[    3.162594] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[    3.164874] sda: Write Protect is off
[    3.167148] sda: Mode Sense: 00 3a 00 00
[    3.167164] SCSI device sda: drive cache: write back
[    3.169427]  sda: sda1 sda2 sda3
[    3.192371] sd 0:0:0:0: Attached scsi disk sda
[    3.194705] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[    3.197037] sdb: Write Protect is off
[    3.199818] sdb: Mode Sense: 00 3a 00 00
[    3.199835] SCSI device sdb: drive cache: write back
[    3.202211] SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
[    3.204558] sdb: Write Protect is off
[    3.206864] sdb: Mode Sense: 00 3a 00 00
[    3.206880] SCSI device sdb: drive cache: write back
[    3.209201]  sdb: sdb1 sdb2 sdb3
[    3.233992] sd 1:0:0:0: Attached scsi disk sdb
[    3.236298] SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
[    3.238833] sdc: Write Protect is off
[    3.241115] sdc: Mode Sense: 00 3a 00 00
[    3.241132] SCSI device sdc: drive cache: write back
[    3.243481] SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
[    3.245770] sdc: Write Protect is off
[    3.248081] sdc: Mode Sense: 00 3a 00 00
[    3.248098] SCSI device sdc: drive cache: write back
[    3.250405]  sdc: sdc1 sdc2 sdc3
[    3.275627] sd 2:0:0:0: Attached scsi disk sdc
[    3.278048] SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
[    3.280355] sdd: Write Protect is off
[    3.282644] sdd: Mode Sense: 00 3a 00 00
[    3.282661] SCSI device sdd: drive cache: write back
[    3.285009] SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
[    3.287292] sdd: Write Protect is off
[    3.289569] sdd: Mode Sense: 00 3a 00 00
[    3.289586] SCSI device sdd: drive cache: write back
[    3.291830]  sdd: sdd1 sdd2 sdd3
[    3.315821] sd 3:0:0:0: Attached scsi disk sdd

Then I yanked sda:

[  143.141029] ata1: exception Emask 0x10 SAct 0x0 SErr 0x90000 action 0x1 frozen
[  143.142098] ata1: failed to recover some devices, retrying in 5 secs
[  148.647042] ata1: soft resetting port
[  148.647622] ata1: SATA link down (SStatus 0 SControl 310)
[  148.648151] ata1: failed to recover some devices, retrying in 5 secs
[  153.648043] ata1: hard resetting port
[  154.156040] ata1: SATA link down (SStatus 0 SControl 310)
[  154.156613] ata1.00: disabled
[  154.658048] ata1: EH complete
[  154.658633] ata1.00: detaching (SCSI 0:0:0:0)

And plugged it in again:

[  174.945730] ata1: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0x1 frozen
[  175.451043] ata1: soft resetting port
[  175.602069] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  175.603778] ata1.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 
87:4023 88:207f
[  175.603786] ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 
0/32)
[  175.605947] ata1.00: configured for UDMA/100
[  175.606494] ata1: EH complete
[  175.607347]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[  175.608171]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  175.610594] SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
[  175.611346] sde: Write Protect is off
[  175.611863] sde: Mode Sense: 00 3a 00 00
[  175.612136] SCSI device sde: drive cache: write back
[  175.613030] SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
[  175.613743] sde: Write Protect is off
[  175.614260] sde: Mode Sense: 00 3a 00 00
[  175.614509] SCSI device sde: drive cache: write back
[  175.615071]  sde: sde1 sde2 sde3
[  175.634366] sd 0:0:0:0: Attached scsi disk sde
[  175.634937] sd 0:0:0:0: Attached scsi generic sg0 type 0

It all looks good to me, other than the perhaps slightly scary messages when 
things get [un]plugged. Now I'm just waiting for my RAID arrays to rebuild.

I'd do similar testing on my sata_via controller if there was a patch, and it 
would be very nice to see NCQ for those too! ;-)

Many thanks,
Chris

PS: Sorry for the line-wrapping!

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
