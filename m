Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWFTAMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWFTAMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 20:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWFTAMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 20:12:37 -0400
Received: from taz.net.au ([203.16.167.1]:32967 "EHLO taz.net.au")
	by vger.kernel.org with ESMTP id S965005AbWFTAMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 20:12:36 -0400
Date: Tue, 20 Jun 2006 10:12:22 +1000
From: Craig Sanders <cas@taz.net.au>
To: linux-kernel@vger.kernel.org
Subject: problems with sata_nv and 2.6.17
Message-ID: <20060620001221.GA17082@taz.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC me on any replies as i am not subscribed to the list. thanks)


i just installed a pair of Maxtor 300GB SATA drives in my system
(intended to be a raid-1 array), was getting timeout errors when i tried
partitioning them under 2.6.15.2, so i tried upgrading to 2.6.17. i was
able to partition the first sata drive, but got timeout errors when i
tried paritioning sdb. then sda started timing out too when i tried
to make a (degraded) raid-1 array using only it. i can't even get a
partition listing from sda now, any access to it just times out.

i've done some googling, and this seems to be a recurring/intermittent
problem but with no solution (other than some people saying stuff like
"it works for me").

i've seen some reports (from last year) that maxtor drives have
compatibility problems with nforce3 chipset....but i've also seen
comments indicating that maxtor firmware updates have fixed that.

any idea what the problem is? is it the sata_nv driver? the motherboard?
the maxtor drives? or linux sata driver in general?

any idea on what the quickest fix would be? i've just spent nearly $300
on these drives and i want to get them working (running out of space).
i might be able to take them back and exchange them for IDE versions,
but a) that would take a lot of persuasion, and b) i would rather avoid
cluttering the case with yet more IDE ribbon cables. if it's the SATA
controller, i'm willing to spend a little more to buy a PCI card if
anyone can recommend one that is known to work.




system details:

CPU: amd64-3000
Motherboard: Gigabyte K8NS Ultra-939
RAM: 2GB
OS: debian "sid"
other drives: 2 x Seagate barracuda 200GB on M/B IDE connectors (raid-1)
              1 x Pioneer 111D DVDRW on a Silicon Image PCI0680 IDE card

i can post the kernel config or make it available via http if needed.


lspci:

00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2)
00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2)
00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2)
00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2)
00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1)
02:06.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
02:07.0 RAID bus controller: Silicon Image, Inc. PCI0680 Ultra ATA-133 Host Controller (rev 02)
02:08.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
02:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
02:0b.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
02:0d.0 Mass storage controller: Silicon Image, Inc. SiI 3512 [SATALink/SATARaid] Serial ATA Controller (rev 01)
02:0e.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link Layer Controller (rev 01)

hmmm. i just noticed that lspci says this M/B has two entries for SATA
controllers, even though there are only 2 SATA connectors:

00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2)
02:0d.0 Mass storage controller: Silicon Image, Inc. SiI 3512 [SATALink/SATARaid] Serial ATA Controller (rev 01)

i have sata_nv compiled in, but not SiI - which one should i use? or both?
i'm recompiling now with SiI support.



relevant parts of kernel boot logs (with comments, describing what i was
doing and what was happening):

Jun 19 18:12:30 ganesh kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
Jun 19 18:12:30 ganesh kernel: Inspecting /boot/System.map-2.6.17
Jun 19 18:12:30 ganesh kernel: Loaded 27694 symbols from /boot/System.map-2.6.17.
Jun 19 18:12:30 ganesh kernel: Symbols match kernel version 2.6.17.
Jun 19 18:12:30 ganesh kernel: No module symbols loaded - kernel modules not enabled. 
Jun 19 18:12:30 ganesh kernel: 4294683.963000] sata_nv 0000:00:0a.0: version 0.8
Jun 19 18:12:30 ganesh kernel: [4294683.965000] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
Jun 19 18:12:30 ganesh kernel: [4294683.965000] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level, high) -> IRQ 18
Jun 19 18:12:30 ganesh kernel: [4294683.965000] PCI: Setting latency timer of device 0000:00:0a.0 to 64
Jun 19 18:12:30 ganesh kernel: [4294683.966000] ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 18
Jun 19 18:12:30 ganesh kernel: [4294683.966000] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 18
Jun 19 18:12:30 ganesh kernel: [4294684.167000] ata1: SATA link up 1.5 Gbps (SStatus 113)
Jun 19 18:12:30 ganesh kernel: [4294684.321000] ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4773 85:7c68 86:3e01 87:4763 88:407f
Jun 19 18:12:30 ganesh kernel: [4294684.321000] ata1: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
Jun 19 18:12:30 ganesh kernel: [4294684.322000] nv_sata: Primary device added
Jun 19 18:12:30 ganesh kernel: [4294684.322000] nv_sata: Primary device removed
Jun 19 18:12:30 ganesh kernel: [4294684.322000] nv_sata: Secondary device added
Jun 19 18:12:30 ganesh kernel: [4294684.322000] nv_sata: Secondary device removed
Jun 19 18:12:30 ganesh kernel: [4294684.325000] ata1: dev 0 configured for UDMA/133
Jun 19 18:12:30 ganesh kernel: [4294684.325000] scsi1 : sata_nv
Jun 19 18:12:30 ganesh kernel: [4294684.526000] ata2: SATA link up 1.5 Gbps (SStatus 113)
Jun 19 18:12:30 ganesh kernel: [4294684.680000] ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4773 85:7c68 86:3e01 87:4763 88:407f
Jun 19 18:12:30 ganesh kernel: [4294684.680000] ata2: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
Jun 19 18:12:30 ganesh kernel: [4294684.684000] ata2: dev 0 configured for UDMA/133
Jun 19 18:12:30 ganesh kernel: [4294684.684000] scsi2 : sata_nv
Jun 19 18:12:30 ganesh kernel: [4294684.684000]   Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
Jun 19 18:12:30 ganesh kernel: [4294684.685000]   Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 19 18:12:30 ganesh kernel: [4294684.685000]   Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
Jun 19 18:12:30 ganesh kernel: [4294684.686000]   Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 19 18:12:30 ganesh kernel: [4294684.686000] st: Version 20050830, fixed bufsize 32768, s/g segs 256
Jun 19 18:12:30 ganesh kernel: [4294684.686000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
Jun 19 18:12:30 ganesh kernel: [4294684.686000] sda: Write Protect is off
Jun 19 18:12:30 ganesh kernel: [4294684.686000] sda: Mode Sense: 00 3a 00 00
Jun 19 18:12:30 ganesh kernel: [4294684.686000] SCSI device sda: drive cache: write back
Jun 19 18:12:30 ganesh kernel: [4294684.686000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
Jun 19 18:12:30 ganesh kernel: [4294684.687000] sda: Write Protect is off
Jun 19 18:12:30 ganesh kernel: [4294684.687000] sda: Mode Sense: 00 3a 00 00
Jun 19 18:12:30 ganesh kernel: [4294684.687000] SCSI device sda: drive cache: write back
Jun 19 18:12:30 ganesh kernel: [4294684.687000]  sda: unknown partition table
Jun 19 18:12:30 ganesh kernel: [4294684.710000] sd 1:0:0:0: Attached scsi disk sda
Jun 19 18:12:30 ganesh kernel: [4294684.710000] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
Jun 19 18:12:30 ganesh kernel: [4294684.710000] sdb: Write Protect is off
Jun 19 18:12:30 ganesh kernel: [4294684.710000] sdb: Mode Sense: 00 3a 00 00
Jun 19 18:12:30 ganesh kernel: [4294684.710000] SCSI device sdb: drive cache: write back
Jun 19 18:12:30 ganesh kernel: [4294684.710000] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
Jun 19 18:12:30 ganesh kernel: [4294684.710000] sdb: Write Protect is off
Jun 19 18:12:30 ganesh kernel: [4294684.710000] sdb: Mode Sense: 00 3a 00 00
Jun 19 18:12:30 ganesh kernel: [4294684.710000] SCSI device sdb: drive cache: write back
Jun 19 18:12:30 ganesh kernel: [4294684.710000]  sdb: unknown partition table
Jun 19 18:12:30 ganesh kernel: [4294684.729000] sd 2:0:0:0: Attached scsi disk sdb


here i successfully partition the first sata drive (sda):

Jun 19 18:23:54 ganesh kernel: [4295411.145000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
Jun 19 18:23:54 ganesh kernel: [4295411.145000] sda: Write Protect is off
Jun 19 18:23:54 ganesh kernel: [4295411.145000] sda: Mode Sense: 00 3a 00 00
Jun 19 18:23:54 ganesh kernel: [4295411.145000] SCSI device sda: drive cache: write back
Jun 19 18:23:54 ganesh kernel: [4295411.145000]  sda: sda1
Jun 19 18:23:56 ganesh kernel: [4295413.157000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
Jun 19 18:23:56 ganesh kernel: [4295413.157000] sda: Write Protect is off
Jun 19 18:23:56 ganesh kernel: [4295413.157000] sda: Mode Sense: 00 3a 00 00
Jun 19 18:23:56 ganesh kernel: [4295413.157000] SCSI device sda: drive cache: write back
Jun 19 18:23:56 ganesh kernel: [4295413.157000]  sda: sda1

then i try to partition sdb:


Jun 19 18:24:49 ganesh kernel: [4295466.366000] ata2: command 0xca timeout, stat 0xd0 host_stat 0x21
Jun 19 18:24:49 ganesh kernel: [4295466.366000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:24:49 ganesh kernel: [4295466.366000] ata2: status=0xd0 { Busy }
Jun 19 18:24:49 ganesh kernel: [4295466.366000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:24:49 ganesh kernel: [4295466.366000] sdb: Current: sense key: Aborted Command
Jun 19 18:24:49 ganesh kernel: [4295466.366000]     Additional sense: Scsi parity error
Jun 19 18:24:49 ganesh kernel: [4295466.366000] Info fld=0x0
Jun 19 18:24:49 ganesh kernel: [4295466.366000] end_request: I/O error, dev sdb, sector 0
Jun 19 18:24:49 ganesh kernel: [4295466.366000] Buffer I/O error on device sdb, logical block 0
Jun 19 18:24:49 ganesh kernel: [4295466.366000] lost page write due to I/O error on sdb
Jun 19 18:24:49 ganesh kernel: [4295466.366000] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
Jun 19 18:24:49 ganesh kernel: [4295466.366000] sdb: Write Protect is off
Jun 19 18:24:49 ganesh kernel: [4295466.366000] sdb: Mode Sense: 00 3a 00 00
Jun 19 18:24:49 ganesh kernel: [4295466.366000] SCSI device sdb: drive cache: write back
Jun 19 18:25:19 ganesh kernel: [4295496.366000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:25:19 ganesh kernel: [4295496.366000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:25:19 ganesh kernel: [4295496.366000] ata2: status=0xd0 { Busy }
Jun 19 18:25:19 ganesh kernel: [4295496.366000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:25:19 ganesh kernel: [4295496.366000] sdb: Current: sense key: Aborted Command
Jun 19 18:25:19 ganesh kernel: [4295496.366000]     Additional sense: Scsi parity error
Jun 19 18:25:19 ganesh kernel: [4295496.366000] Info fld=0x0
Jun 19 18:25:19 ganesh kernel: [4295496.366000] end_request: I/O error, dev sdb, sector 0
Jun 19 18:25:19 ganesh kernel: [4295496.366000] Buffer I/O error on device sdb, logical block 0
Jun 19 18:25:49 ganesh kernel: [4295526.366000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:25:49 ganesh kernel: [4295526.366000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:25:49 ganesh kernel: [4295526.366000] ata2: status=0xd0 { Busy }
Jun 19 18:25:49 ganesh kernel: [4295526.366000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:25:49 ganesh kernel: [4295526.366000] sdb: Current: sense key: Aborted Command
Jun 19 18:25:49 ganesh kernel: [4295526.366000]     Additional sense: Scsi parity error
Jun 19 18:25:49 ganesh kernel: [4295526.366000] Info fld=0x0
Jun 19 18:25:49 ganesh kernel: [4295526.366000] end_request: I/O error, dev sdb, sector 0
Jun 19 18:25:49 ganesh kernel: [4295526.366000] Buffer I/O error on device sdb, logical block 0
Jun 19 18:25:49 ganesh kernel: [4295526.366000]  unable to read partition table
Jun 19 18:25:51 ganesh kernel: [4295528.542000] SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
Jun 19 18:25:51 ganesh kernel: [4295528.542000] sdb: Write Protect is off
Jun 19 18:25:51 ganesh kernel: [4295528.542000] sdb: Mode Sense: 00 3a 00 00
Jun 19 18:25:51 ganesh kernel: [4295528.542000] SCSI device sdb: drive cache: write back
Jun 19 18:26:21 ganesh kernel: [4295558.542000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:26:21 ganesh kernel: [4295558.542000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:26:21 ganesh kernel: [4295558.542000] ata2: status=0xd0 { Busy }
Jun 19 18:26:21 ganesh kernel: [4295558.542000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:26:21 ganesh kernel: [4295558.542000] sdb: Current: sense key: Aborted Command
Jun 19 18:26:21 ganesh kernel: [4295558.542000]     Additional sense: Scsi parity error
Jun 19 18:26:21 ganesh kernel: [4295558.542000] Info fld=0x0
Jun 19 18:26:21 ganesh kernel: [4295558.542000] end_request: I/O error, dev sdb, sector 0
Jun 19 18:26:21 ganesh kernel: [4295558.542000] Buffer I/O error on device sdb, logical block 0
Jun 19 18:26:51 ganesh kernel: [4295588.542000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:26:51 ganesh kernel: [4295588.542000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:26:51 ganesh kernel: [4295588.542000] ata2: status=0xd0 { Busy }
Jun 19 18:26:51 ganesh kernel: [4295588.542000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:26:51 ganesh kernel: [4295588.542000] sdb: Current: sense key: Aborted Command
Jun 19 18:26:51 ganesh kernel: [4295588.542000]     Additional sense: Scsi parity error
Jun 19 18:26:51 ganesh kernel: [4295588.542000] Info fld=0x0
Jun 19 18:26:51 ganesh kernel: [4295588.542000] end_request: I/O error, dev sdb, sector 0
Jun 19 18:26:51 ganesh kernel: [4295588.542000] Buffer I/O error on device sdb, logical block 0
Jun 19 18:26:51 ganesh kernel: [4295588.542000]  unable to read partition table
Jun 19 18:28:05 ganesh kernel: [4295662.652000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:28:05 ganesh kernel: [4295662.652000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:28:05 ganesh kernel: [4295662.652000] ata2: status=0xd0 { Busy }
Jun 19 18:28:35 ganesh kernel: [4295692.652000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:28:35 ganesh kernel: [4295692.652000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:28:35 ganesh kernel: [4295692.652000] ata2: status=0xd0 { Busy }
Jun 19 18:28:35 ganesh kernel: [4295692.652000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:28:35 ganesh kernel: [4295692.652000] sdb: Current: sense key: Aborted Command
Jun 19 18:28:35 ganesh kernel: [4295692.652000]     Additional sense: Scsi parity error
Jun 19 18:28:35 ganesh kernel: [4295692.652000] Info fld=0x0
Jun 19 18:28:35 ganesh kernel: [4295692.652000] end_request: I/O error, dev sdb, sector 0
Jun 19 18:28:35 ganesh kernel: [4295692.652000] Buffer I/O error on device sdb, logical block 0
Jun 19 18:29:05 ganesh kernel: [4295722.652000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:29:05 ganesh kernel: [4295722.652000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:29:05 ganesh kernel: [4295722.652000] ata2: status=0xd0 { Busy }
Jun 19 18:29:05 ganesh kernel: [4295722.652000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:29:05 ganesh kernel: [4295722.652000] sdb: Current: sense key: Aborted Command
Jun 19 18:29:05 ganesh kernel: [4295722.652000]     Additional sense: Scsi parity error
Jun 19 18:29:05 ganesh kernel: [4295722.652000] Info fld=0x8
Jun 19 18:29:05 ganesh kernel: [4295722.652000] end_request: I/O error, dev sdb, sector 8
Jun 19 18:29:05 ganesh kernel: [4295722.652000] Buffer I/O error on device sdb, logical block 1
Jun 19 18:29:35 ganesh kernel: [4295752.652000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:29:35 ganesh kernel: [4295752.652000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:29:35 ganesh kernel: [4295752.652000] ata2: status=0xd0 { Busy }
Jun 19 18:29:35 ganesh kernel: [4295752.652000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:29:35 ganesh kernel: [4295752.652000] sdb: Current: sense key: Aborted Command
Jun 19 18:29:35 ganesh kernel: [4295752.652000]     Additional sense: Scsi parity error
Jun 19 18:29:35 ganesh kernel: [4295752.652000] Info fld=0x10
Jun 19 18:29:35 ganesh kernel: [4295752.652000] end_request: I/O error, dev sdb, sector 16
Jun 19 18:29:35 ganesh kernel: [4295752.652000] Buffer I/O error on device sdb, logical block 2
Jun 19 18:30:05 ganesh kernel: [4295782.652000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:30:05 ganesh kernel: [4295782.652000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:30:05 ganesh kernel: [4295782.652000] ata2: status=0xd0 { Busy }
Jun 19 18:30:05 ganesh kernel: [4295782.652000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:30:05 ganesh kernel: [4295782.652000] sdb: Current: sense key: Aborted Command
Jun 19 18:30:05 ganesh kernel: [4295782.652000]     Additional sense: Scsi parity error
Jun 19 18:30:05 ganesh kernel: [4295782.652000] Info fld=0x18
Jun 19 18:30:05 ganesh kernel: [4295782.652000] end_request: I/O error, dev sdb, sector 24
Jun 19 18:30:05 ganesh kernel: [4295782.652000] Buffer I/O error on device sdb, logical block 3
Jun 19 18:30:08 ganesh kernel: [4295785.652000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:30:08 ganesh kernel: [4295785.652000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:30:08 ganesh kernel: [4295785.652000] ata2: status=0xd0 { Busy }
Jun 19 18:31:39 ganesh kernel: [4295876.986000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:31:39 ganesh kernel: [4295876.986000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:31:39 ganesh kernel: [4295876.986000] ata2: status=0xd0 { Busy }
Jun 19 18:31:39 ganesh kernel: [4295876.986000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:31:39 ganesh kernel: [4295876.986000] sdb: Current: sense key: Aborted Command
Jun 19 18:31:39 ganesh kernel: [4295876.986000]     Additional sense: Scsi parity error
Jun 19 18:31:39 ganesh kernel: [4295876.986000] Info fld=0x0
Jun 19 18:31:39 ganesh kernel: [4295876.986000] end_request: I/O error, dev sdb, sector 0
Jun 19 18:31:39 ganesh kernel: [4295876.986000] Buffer I/O error on device sdb, logical block 0
Jun 19 18:32:38 ganesh kernel: [4295936.050000] ata2: command 0xc8 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:32:38 ganesh kernel: [4295936.050000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:32:38 ganesh kernel: [4295936.050000] ata2: status=0xd0 { Busy }
Jun 19 18:32:38 ganesh kernel: [4295936.050000] sd 2:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:32:38 ganesh kernel: [4295936.050000] sdb: Current: sense key: Aborted Command
Jun 19 18:32:38 ganesh kernel: [4295936.050000]     Additional sense: Scsi parity error
Jun 19 18:32:38 ganesh kernel: [4295936.050000] Info fld=0x0
Jun 19 18:32:38 ganesh kernel: [4295936.050000] end_request: I/O error, dev sdb, sector 0
Jun 19 18:32:38 ganesh kernel: [4295936.050000] Buffer I/O error on device sdb, logical block 0
Jun 19 18:35:11 ganesh kernel: [4296088.911000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:35:11 ganesh kernel: [4296088.911000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:35:11 ganesh kernel: [4296088.911000] ata2: status=0xd0 { Busy }
Jun 19 18:35:14 ganesh kernel: [4296091.911000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:35:14 ganesh kernel: [4296091.911000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:35:14 ganesh kernel: [4296091.911000] ata2: status=0xd0 { Busy }
Jun 19 18:40:17 ganesh kernel: [4296395.184000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:40:17 ganesh kernel: [4296395.184000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:40:17 ganesh kernel: [4296395.184000] ata2: status=0xd0 { Busy }
Jun 19 18:40:20 ganesh kernel: [4296398.184000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:40:20 ganesh kernel: [4296398.184000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:40:20 ganesh kernel: [4296398.184000] ata2: status=0xd0 { Busy }


then i try adding /dev/sda1 as the only disk in raid1 md2, and it starts
timing out too:

Jun 19 18:43:53 ganesh kernel: [4296610.321000] ata1: command 0x35 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:43:53 ganesh kernel: [4296610.321000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:43:53 ganesh kernel: [4296610.321000] ata1: status=0xd0 { Busy }
Jun 19 18:43:53 ganesh kernel: [4296610.321000] sd 1:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:43:53 ganesh kernel: [4296610.321000] sda: Current: sense key: Aborted Command
Jun 19 18:43:53 ganesh kernel: [4296610.321000]     Additional sense: Scsi parity error
Jun 19 18:43:53 ganesh kernel: [4296610.321000] end_request: I/O error, dev sda, sector 586099263
Jun 19 18:43:53 ganesh kernel: [4296610.321000] Buffer I/O error on device sda1, logical block 146524800
Jun 19 18:43:53 ganesh kernel: [4296610.321000] lost page write due to I/O error on sda1
Jun 19 18:44:22 ganesh kernel: [4296640.321000] ata1: command 0x35 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:44:22 ganesh kernel: [4296640.321000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:44:22 ganesh kernel: [4296640.321000] ata1: status=0xd0 { Busy }
Jun 19 18:44:22 ganesh kernel: [4296640.321000] sd 1:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:44:22 ganesh kernel: [4296640.321000] sda: Current: sense key: Aborted Command
Jun 19 18:44:22 ganesh kernel: [4296640.321000]     Additional sense: Scsi parity error
Jun 19 18:44:22 ganesh kernel: [4296640.321000] end_request: I/O error, dev sda, sector 586099267
Jun 19 18:44:22 ganesh kernel: [4296640.321000] Buffer I/O error on device sda1, logical block 146524801
Jun 19 18:44:22 ganesh kernel: [4296640.321000] lost page write due to I/O error on sda1
Jun 19 18:44:52 ganesh kernel: [4296670.321000] ata1: command 0x25 timeout, stat 0xd0 host_stat 0x21
Jun 19 18:44:52 ganesh kernel: [4296670.321000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:44:52 ganesh kernel: [4296670.321000] ata1: status=0xd0 { Busy }
Jun 19 18:44:52 ganesh kernel: [4296670.321000] sd 1:0:0:0: SCSI error: return code = 0x8000002
Jun 19 18:44:52 ganesh kernel: [4296670.321000] sda: Current: sense key: Aborted Command
Jun 19 18:44:52 ganesh kernel: [4296670.321000]     Additional sense: Scsi parity error
Jun 19 18:44:52 ganesh kernel: [4296670.321000] end_request: I/O error, dev sda, sector 586099263
Jun 19 18:44:52 ganesh kernel: [4296670.321000] md: disabled device sda1, could not read superblock.
Jun 19 18:44:52 ganesh kernel: [4296670.321000] md: sda1 has invalid sb, not importing!
Jun 19 18:44:52 ganesh kernel: [4296670.321000] md: md_import_device returned -22
Jun 19 18:45:23 ganesh kernel: [4296701.329000] ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:45:23 ganesh kernel: [4296701.329000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:45:23 ganesh kernel: [4296701.329000] ata1: status=0xd0 { Busy }
Jun 19 18:45:26 ganesh kernel: [4296704.329000] ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:45:26 ganesh kernel: [4296704.329000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:45:26 ganesh kernel: [4296704.329000] ata1: status=0xd0 { Busy }
Jun 19 18:45:29 ganesh kernel: [4296707.329000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:45:29 ganesh kernel: [4296707.329000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:45:29 ganesh kernel: [4296707.329000] ata2: status=0xd0 { Busy }
Jun 19 18:45:32 ganesh kernel: [4296710.329000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:45:32 ganesh kernel: [4296710.329000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:45:32 ganesh kernel: [4296710.329000] ata2: status=0xd0 { Busy }
Jun 19 18:50:36 ganesh kernel: [4297013.486000] ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:50:36 ganesh kernel: [4297013.486000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:50:36 ganesh kernel: [4297013.486000] ata1: status=0xd0 { Busy }
Jun 19 18:50:39 ganesh kernel: [4297016.486000] ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:50:39 ganesh kernel: [4297016.486000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:50:39 ganesh kernel: [4297016.486000] ata1: status=0xd0 { Busy }


these errors continue all night, and i expect they will keep on occuring until
i reboot because the kernel is trying to flush data to the drives and failing:


Jun 19 18:50:42 ganesh kernel: [4297019.486000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:50:42 ganesh kernel: [4297019.486000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:50:42 ganesh kernel: [4297019.486000] ata2: status=0xd0 { Busy }
Jun 19 18:50:45 ganesh kernel: [4297022.486000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:50:45 ganesh kernel: [4297022.486000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:50:45 ganesh kernel: [4297022.486000] ata2: status=0xd0 { Busy }
Jun 19 18:55:48 ganesh kernel: [4297325.696000] ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:55:48 ganesh kernel: [4297325.696000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:55:48 ganesh kernel: [4297325.696000] ata1: status=0xd0 { Busy }
Jun 19 18:55:51 ganesh kernel: [4297328.696000] ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 19 18:55:51 ganesh kernel: [4297328.696000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 19 18:55:51 ganesh kernel: [4297328.696000] ata1: status=0xd0 { Busy }

......

Jun 20 09:08:50 ganesh kernel: [4348521.085000] ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 20 09:08:50 ganesh kernel: [4348521.085000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 20 09:08:50 ganesh kernel: [4348521.085000] ata1: status=0xd0 { Busy }
Jun 20 09:08:53 ganesh kernel: [4348524.085000] ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 20 09:08:53 ganesh kernel: [4348524.085000] ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 20 09:08:53 ganesh kernel: [4348524.085000] ata1: status=0xd0 { Busy }
Jun 20 09:08:56 ganesh kernel: [4348527.085000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 20 09:08:56 ganesh kernel: [4348527.085000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 20 09:08:56 ganesh kernel: [4348527.085000] ata2: status=0xd0 { Busy }
Jun 20 09:08:59 ganesh kernel: [4348530.085000] ata2: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Jun 20 09:08:59 ganesh kernel: [4348530.085000] ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Jun 20 09:08:59 ganesh kernel: [4348530.085000] ata2: status=0xd0 { Busy }

craig

-- 
craig sanders <cas@taz.net.au>           (part time cyborg)
