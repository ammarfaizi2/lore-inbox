Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWECMQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWECMQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWECMQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:16:49 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:12745 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S965170AbWECMQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:16:47 -0400
Date: Wed, 3 May 2006 14:16:43 +0200
From: Sander <sander@humilis.net>
To: Mark Lord <mlord@pobox.com>
Cc: sander@humilis.net, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>,
       Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060503121643.GA21882@favonius>
Reply-To: sander@humilis.net
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca> <20060322170959.GA3222@favonius> <4428BCBF.2050000@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4428BCBF.2050000@pobox.com>
X-Uptime: 12:27:04 up 4 days, 16:32, 26 users,  load average: 2.19, 1.64, 1.41
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been idle on the test system for a while, but am back in business
again. Consider me and my test system your happy lab rat if things need
testing.

I've added two Marvell MV88SX6081 controller (total of three now),
removed the bad disks from the system (all I hope), added new ones
(total of 12, 300GB Maxtor DiamondMax, connected to the controllers
now (each four disks)), and added two 2.5" disks for the OS (connected
to the onboard Nvidia).

I also upgraded to 2.6.17-rc3-mm1, which seemed oke using badblocks, but
dd and mdadm give trouble.

First of all, Linux does not always see all disks during boot. Sometimes
one or two disks are missing. I haven't checked yet if these are always
the same disks (which I can do if that would help).

The controllers during boot always see all disks.

It doesn't matter if it is a cold boot, a boot after pressing the reset
button, a boot after alt-sysrq-b, or a boot after a 'shutdown -r now'.

Doesn't bother me too much though.

This is an excerpt from dmesg, starting from the first line which
mentions 'mv'.

I've googled the errors
status=0x50 { DriveReady SeekComplete }
error=0x01 { AddrMarkNotFound }

and

sata_mv: PCI ERROR; PCI IRQ cause=0x40000100

but that did not give me a clue on what is wrong.

I'm not totally sure the disks are oke, but OTOH, the sata_mv driver is
work in progress too.

Can someone please shine a light on this? I'm curious if this is
hardware or software. If it is software, I'm of course more than happy
to test any patches.

	With kind regards, Sander

ps, I did not include the .config as the mail is pretty large already,
but can supply if needed.

[cut]

[  416.445856] sata_mv 0000:09:02.0: version 0.6
[  416.471963] GSI 21 sharing vector 0xD9 and IRQ 21
[  416.500103] ACPI: PCI Interrupt 0000:09:02.0[A] -> GSI 26 (level, low) -> IRQ 21
[  416.547922] sata_mv 0000:09:02.0: 32 slots 8 ports SCSI mode IRQ via INTx
[  416.588601] ata5: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A2120 bmdma 0x0 irq 21
[  416.634488] ata6: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A4120 bmdma 0x0 irq 21
[  416.680359] ata7: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A6120 bmdma 0x0 irq 21
[  416.726213] ata8: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A8120 bmdma 0x0 irq 21
[  416.772072] ata9: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000B2120 bmdma 0x0 irq 21
[  416.817930] ata10: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000B4120 bmdma 0x0 irq 21
[  416.864308] ata11: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000B6120 bmdma 0x0 irq 21
[  416.910684] ata12: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000B8120 bmdma 0x0 irq 21
[  417.016463] BUG: warning at drivers/scsi/sata_mv.c:1904/__msleep()
[  417.053468] 
[  417.053469] Call Trace: <IRQ> <ffffffff803e8c33>{__mv_phy_reset+242}
[  417.099671]        <ffffffff803e811f>{mv_channel_reset+133} <ffffffff803e9297>{mv_interrupt+568}
[  417.152658]        <ffffffff8020ec91>{handle_IRQ_event+41} <ffffffff80282bbf>{__do_IRQ+155}
[  417.203033]        <ffffffff8025dd91>{do_IRQ+60} <ffffffff8025be52>{default_idle+0}
[  417.249254]        <ffffffff80256178>{ret_from_intr+0} <EOI> <ffffffff80258d00>{thread_return+86}
[  417.302853]        <ffffffff8025be7f>{default_idle+45} <ffffffff80243c0f>{cpu_idle+98}
[  417.350632]        <ffffffff806e8b74>{start_secondary+1127}
[  420.701529] ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
[  420.701533] ata5: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  420.761452] ata5: dev 0 configured for UDMA/133
[  420.788552] scsi4 : sata_mv
[  424.177163] ata6: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
[  424.177166] ata6: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  424.237086] ata6: dev 0 configured for UDMA/133
[  424.264228] scsi5 : sata_mv
[  425.355683] ata7: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:007f
[  425.355686] ata7: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  425.394224] Losing some ticks... checking if CPU frequency changed.
[  425.415607] ata7: dev 0 configured for UDMA/133
[  425.442729] scsi6 : sata_mv
[  428.831319] ata8: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
[  428.831323] ata8: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  428.891243] ata8: dev 0 configured for UDMA/133
[  428.921628] scsi7 : sata_mv
[  428.990942] ata9: no device found (phy stat 00000000)
[  429.021182] scsi8 : sata_mv
[  429.090816] ata10: no device found (phy stat 00000000)
[  429.121572] scsi9 : sata_mv
[  429.190691] ata11: no device found (phy stat 00000000)
[  429.221443] scsi10 : sata_mv
[  429.290565] ata12: no device found (phy stat 00000000)
[  429.321313] scsi11 : sata_mv
[  429.338639]   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
[  429.378845]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  429.422881]   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
[  429.463082]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  429.507110]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  429.547320]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  429.591346]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  429.631559]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  429.675572] GSI 22 sharing vector 0xE1 and IRQ 22
[  429.703706] ACPI: PCI Interrupt 0000:09:03.0[A] -> GSI 27 (level, low) -> IRQ 22
[  429.751543] sata_mv 0000:09:03.0: 32 slots 8 ports SCSI mode IRQ via INTx
[  429.792211] ata13: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000222120 bmdma 0x0 irq 22
[  429.838570] ata14: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000224120 bmdma 0x0 irq 22
[  429.884948] ata15: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000226120 bmdma 0x0 irq 22
[  429.931324] ata16: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000228120 bmdma 0x0 irq 22
[  429.977701] ata17: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000232120 bmdma 0x0 irq 22
[  430.024077] ata18: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000234120 bmdma 0x0 irq 22
[  430.070459] ata19: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000236120 bmdma 0x0 irq 22
[  430.116832] ata20: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000238120 bmdma 0x0 irq 22
[  431.238299] ata13: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:007f
[  431.238303] ata13: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  431.308209] ata13: dev 0 configured for UDMA/133
[  431.335859] scsi12 : sata_mv
[  435.323168] ata14: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c49 86:3e21 87:4663 88:007f
[  435.323172] ata14: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  435.393079] ata14: dev 0 configured for UDMA/133
[  435.420724] scsi13 : sata_mv
[  436.511675] ata15: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:007f
[  436.511679] ata15: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  436.571600] ata15: dev 0 configured for UDMA/133
[  436.599226] scsi14 : sata_mv
[  440.586559] ata16: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
[  440.586563] ata16: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  440.646483] ata16: dev 0 configured for UDMA/133
[  440.674122] scsi15 : sata_mv
[  440.746182] ata17: no device found (phy stat 00000000)
[  440.776953] scsi16 : sata_mv
[  440.846056] ata18: no device found (phy stat 00000000)
[  440.876824] scsi17 : sata_mv
[  440.945931] ata19: no device found (phy stat 00000000)
[  440.976694] scsi18 : sata_mv
[  441.045806] ata20: no device found (phy stat 00000000)
[  441.076564] scsi19 : sata_mv
[  441.093886]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  441.134094]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  441.178133]   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
[  441.218333]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  441.262364]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  441.302570]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  441.346600]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  441.386810]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  441.430820] GSI 23 sharing vector 0xE9 and IRQ 23
[  441.458957] ACPI: PCI Interrupt 0000:0a:03.0[A] -> GSI 30 (level, low) -> IRQ 23
[  441.506807] sata_mv 0000:0a:03.0: 32 slots 8 ports SCSI mode IRQ via INTx
[  441.547511] ata21: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003A2120 bmdma 0x0 irq 23
[  441.593876] ata22: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003A4120 bmdma 0x0 irq 23
[  441.640251] ata23: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003A6120 bmdma 0x0 irq 23
[  441.686625] ata24: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003A8120 bmdma 0x0 irq 23
[  441.733005] ata25: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003B2120 bmdma 0x0 irq 23
[  441.779382] ata26: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003B4120 bmdma 0x0 irq 23
[  441.825759] ata27: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003B6120 bmdma 0x0 irq 23
[  441.872137] ata28: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200003B8120 bmdma 0x0 irq 23
[  445.290676] ata21: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
[  445.290680] ata21: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  445.350599] ata21: dev 0 configured for UDMA/133
[  445.378259] scsi20 : sata_mv
[  449.365558] ata22: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
[  449.365562] ata22: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  449.425482] ata22: dev 0 configured for UDMA/133
[  449.453101] scsi21 : sata_mv
[  450.544078] ata23: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:007f
[  450.544082] ata23: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  450.604002] ata23: dev 0 configured for UDMA/133
[  450.631656] scsi22 : sata_mv
[  454.618962] ata24: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
[  454.618965] ata24: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  454.678886] ata24: dev 0 configured for UDMA/133
[  454.706499] scsi23 : sata_mv
[  454.778563] ata25: no device found (phy stat 00000000)
[  454.809330] scsi24 : sata_mv
[  454.878438] ata26: no device found (phy stat 00000000)
[  454.909201] scsi25 : sata_mv
[  454.978312] ata27: no device found (phy stat 00000000)
[  455.009072] scsi26 : sata_mv
[  455.078187] ata28: no device found (phy stat 00000000)
[  455.108941] scsi27 : sata_mv
[  455.126268]   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
[  455.166473]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  455.210509]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  455.250710]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  455.294741]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  455.334948]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  455.378977]   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
[  455.419187]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  455.463275] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[  455.502874] sda: Write Protect is off
[  455.524778] sda: Mode Sense: 00 3a 00 00
[  455.524790] SCSI device sda: drive cache: write back
[  455.554522] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[  455.594119] sda: Write Protect is off
[  455.616027] sda: Mode Sense: 00 3a 00 00
[  455.616038] SCSI device sda: drive cache: write back
[  455.645739]  sda: sda1
[  455.888279] sd 0:0:0:0: Attached scsi disk sda
[  455.914903] SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
[  455.954494] sdb: Write Protect is off
[  455.976400] sdb: Mode Sense: 00 3a 00 00
[  455.976412] SCSI device sdb: drive cache: write back
[  456.006133] SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
[  456.045743] sdb: Write Protect is off
[  456.067651] sdb: Mode Sense: 00 3a 00 00
[  456.067662] SCSI device sdb: drive cache: write back
[  456.097360]  sdb: sdb1
[  456.353290] sd 1:0:0:0: Attached scsi disk sdb
[  456.379926] SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
[  456.420037] sdc: Write Protect is off
[  456.441943] sdc: Mode Sense: 00 3a 00 00
[  456.441954] SCSI device sdc: drive cache: write back
[  456.471675] SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
[  456.511804] sdc: Write Protect is off
[  456.533712] sdc: Mode Sense: 00 3a 00 00
[  456.533723] SCSI device sdc: drive cache: write back
[  456.563421]  sdc: sdc1
[  456.594425] sd 4:0:0:0: Attached scsi disk sdc
[  456.621059] SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
[  456.661171] sdd: Write Protect is off
[  456.683076] sdd: Mode Sense: 00 3a 00 00
[  456.683087] SCSI device sdd: drive cache: write back
[  456.712810] SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
[  456.752937] sdd: Write Protect is off
[  456.774844] sdd: Mode Sense: 00 3a 00 00
[  456.774855] SCSI device sdd: drive cache: write back
[  456.804553]  sdd: sdd1
[  456.841630] sd 5:0:0:0: Attached scsi disk sdd
[  456.868267] SCSI device sde: 586114704 512-byte hdwr sectors (300091 MB)
[  456.908380] sde: Write Protect is off
[  456.930284] sde: Mode Sense: 00 3a 00 00
[  456.930295] SCSI device sde: drive cache: write back
[  456.960019] SCSI device sde: 586114704 512-byte hdwr sectors (300091 MB)
[  457.000146] sde: Write Protect is off
[  457.022053] sde: Mode Sense: 00 3a 00 00
[  457.022064] SCSI device sde: drive cache: write back
[  457.051761]  sde: sde1
[  457.087124] sd 6:0:0:0: Attached scsi disk sde
[  457.113764] SCSI device sdf: 586114704 512-byte hdwr sectors (300091 MB)
[  457.153873] sdf: Write Protect is off
[  457.175780] sdf: Mode Sense: 00 3a 00 00
[  457.175791] SCSI device sdf: drive cache: write back
[  457.205520] SCSI device sdf: 586114704 512-byte hdwr sectors (300091 MB)
[  457.245644] sdf: Write Protect is off
[  457.267549] sdf: Mode Sense: 00 3a 00 00
[  457.267560] SCSI device sdf: drive cache: write back
[  457.297256]  sdf: sdf1
[  457.334126] sd 7:0:0:0: Attached scsi disk sdf
[  457.360765] SCSI device sdg: 586114704 512-byte hdwr sectors (300091 MB)
[  457.400876] sdg: Write Protect is off
[  457.422781] sdg: Mode Sense: 00 3a 00 00
[  457.422793] SCSI device sdg: drive cache: write back
[  457.452514] SCSI device sdg: 586114704 512-byte hdwr sectors (300091 MB)
[  457.492643] sdg: Write Protect is off
[  457.514549] sdg: Mode Sense: 00 3a 00 00
[  457.514560] SCSI device sdg: drive cache: write back
[  457.544258]  sdg: sdg1
[  457.580008] sd 12:0:0:0: Attached scsi disk sdg
[  457.607193] SCSI device sdh: 586114704 512-byte hdwr sectors (300091 MB)
[  457.647305] sdh: Write Protect is off
[  457.669210] sdh: Mode Sense: 00 3a 00 00
[  457.669221] SCSI device sdh: drive cache: write through
[  457.700500] SCSI device sdh: 586114704 512-byte hdwr sectors (300091 MB)
[  457.740632] sdh: Write Protect is off
[  457.762536] sdh: Mode Sense: 00 3a 00 00
[  457.762547] SCSI device sdh: drive cache: write through
[  457.793803]  sdh: sdh1
[  457.831608] sd 13:0:0:0: Attached scsi disk sdh
[  457.858766] SCSI device sdi: 586114704 512-byte hdwr sectors (300091 MB)
[  457.898875] sdi: Write Protect is off
[  457.920782] sdi: Mode Sense: 00 3a 00 00
[  457.920794] SCSI device sdi: drive cache: write back
[  457.950514] SCSI device sdi: 586114704 512-byte hdwr sectors (300091 MB)
[  457.990645] sdi: Write Protect is off
[  458.012550] sdi: Mode Sense: 00 3a 00 00
[  458.012561] SCSI device sdi: drive cache: write back
[  458.042258]  sdi: sdi1
[  458.079129] sd 14:0:0:0: Attached scsi disk sdi
[  458.106286] SCSI device sdj: 586114704 512-byte hdwr sectors (300091 MB)
[  458.146396] sdj: Write Protect is off
[  458.168303] sdj: Mode Sense: 00 3a 00 00
[  458.168314] SCSI device sdj: drive cache: write back
[  458.198035] SCSI device sdj: 586114704 512-byte hdwr sectors (300091 MB)
[  458.238164] sdj: Write Protect is off
[  458.260072] sdj: Mode Sense: 00 3a 00 00
[  458.260083] SCSI device sdj: drive cache: write back
[  458.289781]  sdj: sdj1
[  458.322444] sd 15:0:0:0: Attached scsi disk sdj
[  458.349598] SCSI device sdk: 586114704 512-byte hdwr sectors (300091 MB)
[  458.389711] sdk: Write Protect is off
[  458.411616] sdk: Mode Sense: 00 3a 00 00
[  458.411627] SCSI device sdk: drive cache: write back
[  458.441350] SCSI device sdk: 586114704 512-byte hdwr sectors (300091 MB)
[  458.481478] sdk: Write Protect is off
[  458.503385] sdk: Mode Sense: 00 3a 00 00
[  458.503396] SCSI device sdk: drive cache: write back
[  458.533093]  sdk: sdk1
[  458.568717] sd 20:0:0:0: Attached scsi disk sdk
[  458.595874] SCSI device sdl: 586114704 512-byte hdwr sectors (300091 MB)
[  458.635985] sdl: Write Protect is off
[  458.657892] sdl: Mode Sense: 00 3a 00 00
[  458.657903] SCSI device sdl: drive cache: write back
[  458.687626] SCSI device sdl: 586114704 512-byte hdwr sectors (300091 MB)
[  458.727752] sdl: Write Protect is off
[  458.749660] sdl: Mode Sense: 00 3a 00 00
[  458.749671] SCSI device sdl: drive cache: write back
[  458.779369]  sdl: sdl1
[  458.812444] sd 21:0:0:0: Attached scsi disk sdl
[  458.839603] SCSI device sdm: 586114704 512-byte hdwr sectors (300091 MB)
[  458.879712] sdm: Write Protect is off
[  458.901620] sdm: Mode Sense: 00 3a 00 00
[  458.901631] SCSI device sdm: drive cache: write back
[  458.931355] SCSI device sdm: 586114704 512-byte hdwr sectors (300091 MB)
[  458.971481] sdm: Write Protect is off
[  458.993388] sdm: Mode Sense: 00 3a 00 00
[  458.993399] SCSI device sdm: drive cache: write back
[  459.023100]  sdm: sdm1
[  459.061055] sd 22:0:0:0: Attached scsi disk sdm
[  459.088215] SCSI device sdn: 586114704 512-byte hdwr sectors (300091 MB)
[  459.128325] sdn: Write Protect is off
[  459.150231] sdn: Mode Sense: 00 3a 00 00
[  459.150242] SCSI device sdn: drive cache: write back
[  459.179963] SCSI device sdn: 586114704 512-byte hdwr sectors (300091 MB)
[  459.220094] sdn: Write Protect is off
[  459.242000] sdn: Mode Sense: 00 3a 00 00
[  459.242011] SCSI device sdn: drive cache: write back
[  459.271708]  sdn: sdn1
[  459.308629] sd 23:0:0:0: Attached scsi disk sdn

[cut]

(s)fdisk to remove the partitions:

[55718.979371] SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
[55719.019503] sdc: Write Protect is off
[55719.041390] sdc: Mode Sense: 00 3a 00 00
[55719.041411] SCSI device sdc: drive cache: write back
[55719.071102]  sdc:
[55721.236422] SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
[55721.276587] sdc: Write Protect is off
[55721.298471] sdc: Mode Sense: 00 3a 00 00
[55721.298485] SCSI device sdc: drive cache: write back
[55721.328184]  sdc:
[55792.475119] SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
[55792.515218] sdd: Write Protect is off
[55792.537113] sdd: Mode Sense: 00 3a 00 00
[55792.537135] SCSI device sdd: drive cache: write back
[55792.566826]  sdd: sdd1
[55795.713009] SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
[55795.753134] sdd: Write Protect is off
[55795.775035] sdd: Mode Sense: 00 3a 00 00
[55795.775054] SCSI device sdd: drive cache: write back
[55795.804744]  sdd:
[55798.922349] SCSI device sde: 586114704 512-byte hdwr sectors (300091 MB)
[55798.962435] sde: Write Protect is off
[55798.984333] sde: Mode Sense: 00 3a 00 00
[55798.984352] SCSI device sde: drive cache: write back
[55799.014045]  sde: sde1
[55802.134949] SCSI device sde: 586114704 512-byte hdwr sectors (300091 MB)
[55802.175071] sde: Write Protect is off
[55802.196961] sde: Mode Sense: 00 3a 00 00
[55802.196981] SCSI device sde: drive cache: write back
[55802.226672]  sde:
[55805.344234] SCSI device sdf: 586114704 512-byte hdwr sectors (300091 MB)
[55805.384361] sdf: Write Protect is off
[55805.406260] sdf: Mode Sense: 00 3a 00 00
[55805.406282] SCSI device sdf: drive cache: write back
[55805.435970]  sdf: sdf1
[55808.546919] SCSI device sdf: 586114704 512-byte hdwr sectors (300091 MB)
[55808.587016] sdf: Write Protect is off
[55808.608915] sdf: Mode Sense: 00 3a 00 00
[55808.608934] SCSI device sdf: drive cache: write back
[55808.638629]  sdf:
[55811.758859] SCSI device sdg: 586114704 512-byte hdwr sectors (300091 MB)
[55811.799197] sdg: Write Protect is off
[55811.821123] sdg: Mode Sense: 00 3a 00 00
[55811.821139] SCSI device sdg: drive cache: write back
[55811.850832]  sdg: sdg1
[55814.968839] SCSI device sdg: 586114704 512-byte hdwr sectors (300091 MB)
[55815.008942] sdg: Write Protect is off
[55815.030843] sdg: Mode Sense: 00 3a 00 00
[55815.030862] SCSI device sdg: drive cache: write back
[55815.060554]  sdg:
[55818.188148] SCSI device sdh: 586114704 512-byte hdwr sectors (300091 MB)
[55818.228268] sdh: Write Protect is off
[55818.250164] sdh: Mode Sense: 00 3a 00 00
[55818.250183] SCSI device sdh: drive cache: write through
[55818.281432]  sdh: sdh1
[55821.400768] SCSI device sdh: 586114704 512-byte hdwr sectors (300091 MB)
[55821.440889] sdh: Write Protect is off
[55821.462792] sdh: Mode Sense: 00 3a 00 00
[55821.462811] SCSI device sdh: drive cache: write through
[55821.494060]  sdh:
[55824.610102] SCSI device sdi: 586114704 512-byte hdwr sectors (300091 MB)
[55824.650612] sdi: Write Protect is off
[55824.672505] sdi: Mode Sense: 00 3a 00 00
[55824.672525] SCSI device sdi: drive cache: write back
[55824.702217]  sdi: sdi1
[55827.882605] SCSI device sdi: 586114704 512-byte hdwr sectors (300091 MB)
[55827.922707] sdi: Write Protect is off
[55827.944598] sdi: Mode Sense: 00 3a 00 00
[55827.944617] SCSI device sdi: drive cache: write back
[55827.974308]  sdi:
[55831.074598] SCSI device sdj: 586114704 512-byte hdwr sectors (300091 MB)
[55831.114937] sdj: Write Protect is off
[55831.136864] sdj: Mode Sense: 00 3a 00 00
[55831.136879] SCSI device sdj: drive cache: write back
[55831.166572]  sdj: sdj1
[55834.274591] SCSI device sdj: 586114704 512-byte hdwr sectors (300091 MB)
[55834.314711] sdj: Write Protect is off
[55834.336610] sdj: Mode Sense: 00 3a 00 00
[55834.336631] SCSI device sdj: drive cache: write back
[55834.366322]  sdj:
[55837.490511] SCSI device sdk: 586114704 512-byte hdwr sectors (300091 MB)
[55837.530838] sdk: Write Protect is off
[55837.552770] sdk: Mode Sense: 00 3a 00 00
[55837.552785] SCSI device sdk: drive cache: write back
[55837.582479]  sdk: sdk1
[55840.706506] SCSI device sdk: 586114704 512-byte hdwr sectors (300091 MB)
[55840.746608] sdk: Write Protect is off
[55840.768508] sdk: Mode Sense: 00 3a 00 00
[55840.768529] SCSI device sdk: drive cache: write back
[55840.798218]  sdk:
[55843.905883] SCSI device sdl: 586114704 512-byte hdwr sectors (300091 MB)
[55843.945989] sdl: Write Protect is off
[55843.967888] sdl: Mode Sense: 00 3a 00 00
[55843.967906] SCSI device sdl: drive cache: write back
[55843.997599]  sdl: sdl1
[55847.108482] SCSI device sdl: 586114704 512-byte hdwr sectors (300091 MB)
[55847.148656] sdl: Write Protect is off
[55847.170543] sdl: Mode Sense: 00 3a 00 00
[55847.170562] SCSI device sdl: drive cache: write back
[55847.200253]  sdl:
[55850.317808] SCSI device sdm: 586114704 512-byte hdwr sectors (300091 MB)
[55850.357891] sdm: Write Protect is off
[55850.379790] sdm: Mode Sense: 00 3a 00 00
[55850.379809] SCSI device sdm: drive cache: write back
[55850.409502]  sdm: sdm1
[55853.530420] SCSI device sdm: 586114704 512-byte hdwr sectors (300091 MB)
[55853.570517] sdm: Write Protect is off
[55853.592417] sdm: Mode Sense: 00 3a 00 00
[55853.592436] SCSI device sdm: drive cache: write back
[55853.622129]  sdm:
[55856.739723] SCSI device sdn: 586114704 512-byte hdwr sectors (300091 MB)
[55856.779818] sdn: Write Protect is off
[55856.801718] sdn: Mode Sense: 00 3a 00 00
[55856.801737] SCSI device sdn: drive cache: write back
[55856.831427]  sdn: sdn1
[55859.952347] SCSI device sdn: 586114704 512-byte hdwr sectors (300091 MB)
[55859.992445] sdn: Write Protect is off
[55860.014345] sdn: Mode Sense: 00 3a 00 00
[55860.014364] SCSI device sdn: drive cache: write back
[55860.044054]  sdn:

[cut]

mdadm -C -l5 -n12 /dev/md1 /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg \
/dev/sdh /dev/sdi /dev/sdj /dev/sdk /dev/sdl /dev/sdm /dev/sdn

[55965.551825] raid5: device sdm operational as raid disk 10
[55965.584130] raid5: device sdl operational as raid disk 9
[55965.615912] raid5: device sdk operational as raid disk 8
[55965.647694] raid5: device sdj operational as raid disk 7
[55965.679480] raid5: device sdi operational as raid disk 6
[55965.711263] raid5: device sdh operational as raid disk 5
[55965.743048] raid5: device sdg operational as raid disk 4
[55965.774842] raid5: device sdf operational as raid disk 3
[55965.806616] raid5: device sde operational as raid disk 2
[55965.838399] raid5: device sdd operational as raid disk 1
[55965.870182] raid5: device sdc operational as raid disk 0
[55965.903101] raid5: allocated 12662kB for md1
[55965.928667] raid5: raid level 5 set md1 active with 11 out of 12 devices, algorithm 2
[55965.975524] RAID5 conf printout:
[55965.994825]  --- rd:12 wd:11 fd:1
[55966.014662]  disk 0, o:1, dev:sdc
[55966.034510]  disk 1, o:1, dev:sdd
[55966.054342]  disk 2, o:1, dev:sde
[55966.074179]  disk 3, o:1, dev:sdf
[55966.094018]  disk 4, o:1, dev:sdg
[55966.113858]  disk 5, o:1, dev:sdh
[55966.133696]  disk 6, o:1, dev:sdi
[55966.153537]  disk 7, o:1, dev:sdj
[55966.173376]  disk 8, o:1, dev:sdk
[55966.193212]  disk 9, o:1, dev:sdl
[55966.213053]  disk 10, o:1, dev:sdm
[55966.265282] RAID5 conf printout:
[55966.284620]  --- rd:12 wd:11 fd:1
[55966.304455]  disk 0, o:1, dev:sdc
[55966.324294]  disk 1, o:1, dev:sdd
[55966.344134]  disk 2, o:1, dev:sde
[55966.363972]  disk 3, o:1, dev:sdf
[55966.383810]  disk 4, o:1, dev:sdg
[55966.403651]  disk 5, o:1, dev:sdh
[55966.423488]  disk 6, o:1, dev:sdi
[55966.443328]  disk 7, o:1, dev:sdj
[55966.463168]  disk 8, o:1, dev:sdk
[55966.483377]  disk 9, o:1, dev:sdl
[55966.503209]  disk 10, o:1, dev:sdm
[55966.523569]  disk 11, o:1, dev:sdn
[55966.543983] md: syncing RAID array md1
[55966.566420] md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
[55966.608595] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
[55966.668964] md: using 128k window, over a total of 293057280 blocks.
[55968.588024] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55968.632290] ata23: status=0x50 { DriveReady SeekComplete }
[55968.665240] ata23: error=0x01 { AddrMarkNotFound }
[55968.694015] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55969.351471] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55969.395727] ata21: status=0x50 { DriveReady SeekComplete }
[55969.428679] ata21: error=0x01 { AddrMarkNotFound }
[55969.457453] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55969.615537] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55969.659814] ata23: status=0x50 { DriveReady SeekComplete }
[55969.692766] ata23: error=0x01 { AddrMarkNotFound }
[55970.347470] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55970.395026] ata22: status=0x50 { DriveReady SeekComplete }
[55970.428005] ata22: error=0x01 { AddrMarkNotFound }
[55970.456783] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55971.118078] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55971.162338] ata24: status=0x50 { DriveReady SeekComplete }
[55971.195289] ata24: error=0x01 { AddrMarkNotFound }
[55971.224062] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55971.881772] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55971.926033] ata21: status=0x50 { DriveReady SeekComplete }
[55971.958987] ata21: error=0x01 { AddrMarkNotFound }
[55972.613671] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55972.657948] ata22: status=0x50 { DriveReady SeekComplete }
[55972.690902] ata22: error=0x01 { AddrMarkNotFound }
[55972.846026] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55972.890305] ata23: status=0x50 { DriveReady SeekComplete }
[55972.923256] ata23: error=0x01 { AddrMarkNotFound }
[55973.577770] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55973.622012] ata24: status=0x50 { DriveReady SeekComplete }
[55973.654966] ata24: error=0x01 { AddrMarkNotFound }
[55973.683740] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55974.341099] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55974.385349] ata21: status=0x50 { DriveReady SeekComplete }
[55974.418302] ata21: error=0x01 { AddrMarkNotFound }
[55975.072635] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55975.116898] ata22: status=0x50 { DriveReady SeekComplete }
[55975.149853] ata22: error=0x01 { AddrMarkNotFound }
[55975.304911] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55975.349151] ata23: status=0x50 { DriveReady SeekComplete }
[55975.382104] ata23: error=0x01 { AddrMarkNotFound }
[55976.036631] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55976.080911] ata24: status=0x50 { DriveReady SeekComplete }
[55976.113865] ata24: error=0x01 { AddrMarkNotFound }
[55976.142636] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55976.799996] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55976.844245] ata21: status=0x50 { DriveReady SeekComplete }
[55976.877197] ata21: error=0x01 { AddrMarkNotFound }
[55977.531534] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55977.575796] ata22: status=0x50 { DriveReady SeekComplete }
[55977.608749] ata22: error=0x01 { AddrMarkNotFound }
[55977.763803] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55977.808048] ata23: status=0x50 { DriveReady SeekComplete }
[55977.841003] ata23: error=0x01 { AddrMarkNotFound }
[55980.560825] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55980.605093] ata23: status=0x50 { DriveReady SeekComplete }
[55980.638046] ata23: error=0x01 { AddrMarkNotFound }
[55980.666819] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55981.324243] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55981.368480] ata21: status=0x50 { DriveReady SeekComplete }
[55981.401431] ata21: error=0x01 { AddrMarkNotFound }
[55981.430205] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55981.588288] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55981.632568] ata23: status=0x50 { DriveReady SeekComplete }
[55981.665520] ata23: error=0x01 { AddrMarkNotFound }
[55982.319865] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55982.364119] ata22: status=0x50 { DriveReady SeekComplete }
[55982.397071] ata22: error=0x01 { AddrMarkNotFound }
[55982.425848] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55983.083573] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55983.127818] ata24: status=0x50 { DriveReady SeekComplete }
[55983.160771] ata24: error=0x01 { AddrMarkNotFound }
[55983.815265] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55983.859524] ata24: status=0x50 { DriveReady SeekComplete }
[55983.892478] ata24: error=0x01 { AddrMarkNotFound }
[55983.921251] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55984.578611] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55984.622861] ata21: status=0x50 { DriveReady SeekComplete }
[55984.655814] ata21: error=0x01 { AddrMarkNotFound }
[55985.310151] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55985.354411] ata22: status=0x50 { DriveReady SeekComplete }
[55985.387364] ata22: error=0x01 { AddrMarkNotFound }
[55985.542412] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55985.586663] ata23: status=0x50 { DriveReady SeekComplete }
[55985.619617] ata23: error=0x01 { AddrMarkNotFound }
[55986.274122] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55986.318371] ata24: status=0x50 { DriveReady SeekComplete }
[55986.351324] ata24: error=0x01 { AddrMarkNotFound }
[55986.380099] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55987.037454] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55987.081706] ata21: status=0x50 { DriveReady SeekComplete }
[55987.114659] ata21: error=0x01 { AddrMarkNotFound }
[55987.768995] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55987.813257] ata22: status=0x50 { DriveReady SeekComplete }
[55987.846210] ata22: error=0x01 { AddrMarkNotFound }
[55988.001258] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55988.045509] ata23: status=0x50 { DriveReady SeekComplete }
[55988.078463] ata23: error=0x01 { AddrMarkNotFound }
[55988.732952] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55988.777215] ata24: status=0x50 { DriveReady SeekComplete }
[55988.810170] ata24: error=0x01 { AddrMarkNotFound }
[55988.838943] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55989.496300] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55989.540551] ata21: status=0x50 { DriveReady SeekComplete }
[55989.573505] ata21: error=0x01 { AddrMarkNotFound }
[55990.227841] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55990.272102] ata22: status=0x50 { DriveReady SeekComplete }
[55990.305057] ata22: error=0x01 { AddrMarkNotFound }
[55990.460104] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55990.504355] ata23: status=0x50 { DriveReady SeekComplete }
[55990.537308] ata23: error=0x01 { AddrMarkNotFound }
[55991.191811] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55991.236063] ata24: status=0x50 { DriveReady SeekComplete }
[55991.269015] ata24: error=0x01 { AddrMarkNotFound }
[55991.297787] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55991.955146] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55991.999397] ata21: status=0x50 { DriveReady SeekComplete }
[55992.032349] ata21: error=0x01 { AddrMarkNotFound }
[55992.686685] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55992.730947] ata22: status=0x50 { DriveReady SeekComplete }
[55992.763902] ata22: error=0x01 { AddrMarkNotFound }
[55992.918950] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55992.963200] ata23: status=0x50 { DriveReady SeekComplete }
[55992.996154] ata23: error=0x01 { AddrMarkNotFound }
[55993.024982] sd 22:0:0:0: SCSI error: return code = 0x8000002
[55993.650647] ata24: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55993.650650] ata24: status=0x50 { DriveReady SeekComplete }
[55993.650652] ata24: error=0x01 { AddrMarkNotFound }
[55993.650656] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55994.276223] ata21: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55994.276226] ata21: status=0x50 { DriveReady SeekComplete }
[55994.276228] ata21: error=0x01 { AddrMarkNotFound }
[55994.901791] ata22: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55994.901793] ata22: status=0x50 { DriveReady SeekComplete }
[55994.901796] ata22: error=0x01 { AddrMarkNotFound }
[55995.284668] sdm: Current: sense key=0x3
[55995.307671]     ASC=0x13 ASCQ=0x0
[55995.327612] Info fld=0x1
[55995.342777] end_request: I/O error, dev sdm, sector 289024
[55995.375604] raid5: read error not correctable.
[55995.402195] raid5: Disk failure on sdm, disabling device. Operation continuing on 10 devices
[55995.452747] sd 23:0:0:0: SCSI error: return code = 0x8000002
[55995.486618] sdn: Current: sense key=0x3
[55995.509643]     ASC=0x13 ASCQ=0x0
[55995.529688] Info fld=0x1
[55995.544859] end_request: I/O error, dev sdn, sector 288800
[55995.577686] raid5: Disk failure on sdn, disabling device. Operation continuing on 10 devices
[55995.598247] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55995.598250] ata23: status=0x50 { DriveReady SeekComplete }
[55995.598253] ata23: error=0x01 { AddrMarkNotFound }
[55995.598257] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55995.731267] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55995.731270] ata23: status=0x50 { DriveReady SeekComplete }
[55995.731272] ata23: error=0x01 { AddrMarkNotFound }
[55995.731276] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55995.864275] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55995.864278] ata23: status=0x50 { DriveReady SeekComplete }
[55995.864280] ata23: error=0x01 { AddrMarkNotFound }
[55995.864283] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55995.997287] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55995.997290] ata23: status=0x50 { DriveReady SeekComplete }
[55995.997292] ata23: error=0x01 { AddrMarkNotFound }
[55995.997296] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55996.130300] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55996.130303] ata23: status=0x50 { DriveReady SeekComplete }
[55996.130305] ata23: error=0x01 { AddrMarkNotFound }
[55996.130309] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55996.279929] ata23: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
[55996.279931] ata23: status=0x50 { DriveReady SeekComplete }
[55996.279934] ata23: error=0x01 { AddrMarkNotFound }
[55996.279937] sata_mv: PCI ERROR; PCI IRQ cause=0x40000100
[55996.279962] sd 22:0:0:0: SCSI error: return code = 0x8000002
[55996.279965] sdm: Current: sense key=0x3
[55996.279966]     ASC=0x13 ASCQ=0x0
[55996.279969] Info fld=0x1
[55996.279972] end_request: I/O error, dev sdm, sector 289032
[55996.279974] raid5: read error not correctable.
[55996.607843] sd 20:0:0:0: SCSI error: return code = 0x8000002
[55996.641725] sdk: Current: sense key=0x3
[55996.664720]     ASC=0x13 ASCQ=0x0
[55996.684662] Info fld=0x1
[55996.699830] end_request: I/O error, dev sdk, sector 289280
[55996.732654] raid5: read error not correctable.
[55996.759246] raid5: Disk failure on sdk, disabling device. Operation continuing on 9 devices
[55996.809246] sd 21:0:0:0: SCSI error: return code = 0x8000002
[55996.843122] sdl: Current: sense key=0x3
[55996.866175]     ASC=0x13 ASCQ=0x0
[55996.886167] Info fld=0x1
[55996.901336] end_request: I/O error, dev sdl, sector 289280
[55996.934162] raid5: read error not correctable.
[55996.960752] raid5: Disk failure on sdl, disabling device. Operation continuing on 8 devices
[55997.011070] md: md1: sync done.
[55997.110709] RAID5 conf printout:
[55997.130006]  --- rd:12 wd:8 fd:4

[cut]

-- 
Humilis IT Services and Solutions
http://www.humilis.net
