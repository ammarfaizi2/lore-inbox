Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288008AbSAQAPN>; Wed, 16 Jan 2002 19:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSAQAPD>; Wed, 16 Jan 2002 19:15:03 -0500
Received: from arm.t19.ds.pwr.wroc.pl ([156.17.236.105]:20996 "EHLO
	arm.t19.ds.pwr.wroc.pl") by vger.kernel.org with ESMTP
	id <S288008AbSAQAOw>; Wed, 16 Jan 2002 19:14:52 -0500
To: linux-kernel@vger.kernel.org
Subject: Andre IDE patches + Promise, UDMA detection
X-Attribution: arekm
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
Organization: PLD Linux Distribution Team
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
Date: 17 Jan 2002 01:14:30 +0100
Message-ID: <87n0zd25qx.fsf@arm.t19.ds.pwr.wroc.pl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm using 2.4.17 with ide.2.4.16.12102001.patch.bz2 + other
patches (listed here: http://cvs.pld.org.pl/SPECS/kernel.spec?rev=1.70.2.390)
on FIC LX based (quite old) mainboard + external PCI controller:

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:08.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)

My IDE setup is fully modular (well, whole kernel is):
xfs                   479200   4  (autoclean)
xfs_support             6216   0  (autoclean) [xfs]
pagebuf                22112   4  (autoclean) [xfs xfs_support]
nls_iso8859-1           2880   1  (autoclean)
nls_cp437               4384   1  (autoclean)
vfat                    9788   1  (autoclean)
fat                    30680   0  (autoclean) [vfat]
sr_mod                 13656   0  (autoclean) (unused)
scsi_mod               86776   1  (autoclean) [sr_mod]
ide-cd                 27552   0 
cdrom                  28320   0  [sr_mod ide-cd]
ext3                   58772   1  (autoclean)
ide-disk                9712   8  (autoclean)
ide-mod               153756   8  (autoclean) [ide-cd ide-disk]
jbd                    34424   1  (autoclean) [ext3]

Kernel boots fine:
Linux version 2.4.17 (builder@kenny) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Jan 15 13:19:47 UTC 2002
...
Freeing initrd memory: 174k freed
VFS: Mounted root (romfs filesystem) readonly.
Journalled Block Device driver loaded
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
PDC20268: IDE controller on PCI bus 00 dev 40
PCI: Found IRQ 11 for device 00:08.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xea000000
    ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:pio, hdh:pio
hda: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307030, ATA DISK drive
hdf: IBM-DTLA-305040, ATA DISK drive
hdh: ST360021A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xd400-0xd407,0xd802 on irq 11
ide3 at 0xdc00-0xdc07,0xe002 on irq 11
hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(33)
hdf: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=79780/16/63, UDMA(33)
hdh: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
Partition check:
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
 /dev/ide/host2/bus0/target1/lun0: p1 p2
 /dev/ide/host2/bus1/target1/lun0: p1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.

Unfortunately it thinks that all my harddrives (connected to promise
via 80wire cable) are UDMA33! Now _sometimes_ after boot it detects
these (properly) as UDMA100 and sometimes (seems more frequently)
as UDMA33.

Now when ide module detect my disk as UDMA33 and I have in my
initscripts hdparm (4.6) -X69 -c1 -d1 -m16 then some my processes
hang in D-state accessing hardrive (hdh for example).
Removing -X69 fixes that even if my kernel thinks that my drivers
are UDMA33 only... 

So now it will be great to get ide module properly detecting UDMA.
-- 
Arkadiusz Mi¶kiewicz   IPv6 ready PLD Linux at http://www.pld.org.pl
misiek(at)pld.org.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PWr

