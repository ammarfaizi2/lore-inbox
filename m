Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRBXMU2>; Sat, 24 Feb 2001 07:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129300AbRBXMUT>; Sat, 24 Feb 2001 07:20:19 -0500
Received: from oxmail1.ox.ac.uk ([129.67.1.1]:41460 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129282AbRBXMUM>;
	Sat, 24 Feb 2001 07:20:12 -0500
Message-ID: <3A97A72E.EC2A85EC@computing-services.oxford.ac.uk>
Date: Sat, 24 Feb 2001 12:21:02 +0000
From: A E Lawrence <adrian.lawrence@computing-services.oxford.ac.uk>
Organization: Not much
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Disc corruption on stock 2.4.2 [Atlon on Abit KT7R]
Content-Type: multipart/mixed;
 boundary="------------49A65ABE9475B7062150C4F4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------49A65ABE9475B7062150C4F4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


-- 
Dr A E Lawrence
--------------49A65ABE9475B7062150C4F4
Content-Type: text/plain; charset=us-ascii;
 name="2.4.2_bugs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.2_bugs"

Disc corruption on stock 2.4.2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Looks similar to problems on 2.4.2-pre{3,4}, but those were seen when
overclocking. This report refers to an Athlon at standard clock frequency.

Activity: under X, running several tars with gzip writing onto an ide disc
/dev/hdb1. Some of the tar images reading from scsi discs. 

(This machine is not well balanced, and tends to be disc bound: there was 
thus intense disc activity.)

Mounts:-

/dev/hda1 on / type ext2 (rw)
/dev/sdb4 on /usr type ext2 (rw)
/dev/sda2 on /home type ext2 (rw)
/dev/hda3 on /fs0 type ext2 (rw)
/dev/hdb1 on /fs1 type ext2 (rw)
/dev/sda1 on /dos type msdos (rw)
/dev/sdb1 on /doze95 type vfat (rw)

Feb 23 21:24:32 conquest2 kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Feb 23 21:24:32 conquest2 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 23 21:24:32 conquest2 kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
Feb 23 21:24:32 conquest2 kernel: VP_IDE: chipset revision 16

[Note:  
        /sbin/hdparm -d1 -m16  /dev/hdb
        /sbin/hdparm -d1 -m8  /dev/hda
  in rc.local ]


Feb 23 21:24:23 conquest2 fsck: /dev/sda2: clean, 93394/1007616 files, 2263187/4025226 blocks 
Feb 23 21:24:32 conquest2 kernel: VP_IDE: not 100%% native mode: will probe irqs later
Feb 23 21:24:23 conquest2 fsck: /dev/sdb4: clean, 144574/610304 files, 2089495/2436588 blocks 
Feb 23 21:24:32 conquest2 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 23 21:24:23 conquest2 fsck: /dev/hda3: clean, 1725/573440 files, 1335775/2288160 blocks 
Feb 23 21:24:32 conquest2 kernel: VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
Feb 23 21:24:23 conquest2 fsck: /dev/hdb1: clean, 14322/4126720 files, 6507086/16506756 blocks

Feb 23 21:24:33 conquest2 kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
Feb 23 21:24:23 conquest2 rc.sysinit: Checking filesystems succeeded 
Feb 23 21:24:33 conquest2 kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
Feb 23 21:24:23 conquest2 rc.sysinit: Mounting local filesystems:  succeeded 
Feb 23 21:24:33 conquest2 kernel: hda: JTS Corporation CHAMPION MODEL C3000-3A, ATA DISK drive
Feb 23 21:24:23 conquest2 rc.sysinit: Turning on user and group quotas for local filesystems:  succeeded 
Feb 23 21:24:33 conquest2 kernel: hdb: IBM-DTTA-351680, ATA DISK drive
Feb 23 21:24:24 conquest2 rc.sysinit: Enabling swap space:  succeeded 
Feb 23 21:24:33 conquest2 kernel: hdc: CRD-8160B, ATAPI CD/DVD-ROM drive
Feb 23 21:24:26 conquest2 init: Entering runlevel: 3 
Feb 23 21:24:33 conquest2 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 23 21:24:26 conquest2 rc: Starting hotplug:  succeeded 
Feb 23 21:24:33 conquest2 kernel: ide1 at 0x170-0x177,0x376 on irq 15

Feb 23 21:24:33 conquest2 kernel: hda: 5870592 sectors (3006 MB) w/256KiB Cache, CHS=5824/16/63, DMA

Feb 23 21:24:34 conquest2 kernel: hdb: 33022080 sectors (16907 MB) w/462KiB Cache, CHS=2055/255/63, UDMA(33)

The first errors logged (later) involved /dev/sda2. Scsi driver init messages:-

 ....
Feb 23 21:24:34 conquest2 kernel: sym53c8xx: at PCI bus 0, device 15, function 0Feb 23 21:24:34 conquest2 kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Feb 23 21:24:35 conquest2 kernel: sym53c8xx: 53c875 detected 
Feb 23 21:24:35 conquest2 kernel: sym53c875-0: rev 0x3 on pci bus 0 device 15 function 0 irq 11
Feb 23 21:24:35 conquest2 kernel: sym53c875-0: ID 7, Fast-20, Parity Checking
Feb 23 21:24:35 conquest2 kernel: sym53c875-0: on-chip RAM at 0xde002000
Feb 23 21:24:35 conquest2 kernel: sym53c875-0: restart (scsi reset).
Feb 23 21:24:35 conquest2 kernel: sym53c875-0: Downloading SCSI SCRIPTS.
Feb 23 21:24:35 conquest2 kernel: scsi0 : sym53c8xx - version 1.6b
Feb 23 21:24:35 conquest2 kernel:   Vendor: IBM       Model: DCAS-34330        Rev: S65A
Feb 23 21:24:35 conquest2 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb 23 21:24:35 conquest2 kernel:   Vendor: IBM       Model: DCAS-34330W       Rev: S61A
Feb 23 21:24:35 conquest2 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb 23 21:24:35 conquest2 kernel: sym53c875-0-<4,0>: tagged command queue depth set to 8

Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<6,0>: tagged command queue depth set to 8
Feb 23 21:24:36 conquest2 kernel: Detected scsi disk sda at scsi0, channel 0, id 4, lun 0
Feb 23 21:24:36 conquest2 kernel: Detected scsi disk sdb at scsi0, channel 0, id 6, lun 0
Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<4,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
Feb 23 21:24:36 conquest2 kernel: SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
Feb 23 21:24:36 conquest2 kernel:  sda: sda1 sda2
Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<6,0>: wide msgout: 1-2-3-1.
Feb 23 21:24:36 conquest2 kernel: sym53c875-0-<6,0>: wide msgin: 1-2-3-1.
Feb 23 21:24:37 conquest2 kernel: sym53c875-0-<6,0>: wide: wide=1 chg=0.
Feb 23 21:24:37 conquest2 kernel: sym53c875-0-<6,0>: wide msgout: 1-2-3-1.
Feb 23 21:24:37 conquest2 kernel: sym53c875-0-<6,0>: wide msgin: 1-2-3-1.
Feb 23 21:24:37 conquest2 kernel: sym53c875-0-<6,0>: wide: wide=1 chg=0.
Feb 23 21:24:37 conquest2 kernel: sym53c875-0-<6,0>: sync msgout: 1-3-1-c-10.
Feb 23 21:24:37 conquest2 kernel: sym53c875-0-<6,0>: sync msg in: 1-3-1-c-f.
Feb 23 21:24:37 conquest2 kernel: sym53c875-0-<6,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
Feb 23 21:24:37 conquest2 kernel: sym53c875-0-<6,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 15)
Feb 23 21:24:37 conquest2 kernel: SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
Feb 23 21:24:37 conquest2 kernel:  sdb: sdb1 sdb2 sdb3 sdb4

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The first errors logged:-
Feb 23 21:31:51 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:51 conquest2 kernel: 08:02: rw=0, want=1522206734, limit=4025226
Feb 23 21:31:51 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:51 conquest2 kernel: 08:02: rw=0, want=880975962, limit=4025226
Feb 23 21:31:51 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:51 conquest2 kernel: 08:02: rw=0, want=953522888, limit=4025226
Feb 23 21:31:51 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:51 conquest2 kernel: 08:02: rw=0, want=1416357739, limit=4025226
Feb 23 21:31:51 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:51 conquest2 kernel: 08:02: rw=0, want=1016746691, limit=4025226
Feb 23 21:31:51 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:51 conquest2 kernel: 08:02: rw=0, want=696609941, limit=4025226
Feb 23 21:31:51 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:52 conquest2 kernel: 08:02: rw=0, want=703242561, limit=4025226
Feb 23 21:31:52 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:52 conquest2 kernel: 08:02: rw=0, want=1595346901, limit=4025226
Feb 23 21:31:52 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:52 conquest2 kernel: 08:02: rw=0, want=1023922416, limit=4025226
Feb 23 21:31:53 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:53 conquest2 kernel: 08:02: rw=0, want=1923471391, limit=4025226
Feb 23 21:31:53 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:53 conquest2 kernel: 08:02: rw=0, want=475674278, limit=4025226
Feb 23 21:31:54 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:54 conquest2 kernel: 08:02: rw=0, want=375212988, limit=4025226
Feb 23 21:31:54 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:54 conquest2 kernel: 08:02: rw=0, want=1874283964, limit=4025226
Feb 23 21:31:55 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:55 conquest2 kernel: 08:02: rw=0, want=792733106, limit=4025226
Feb 23 21:31:55 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:55 conquest2 kernel: 08:02: rw=0, want=1198363528, limit=4025226
Feb 23 21:31:55 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:55 conquest2 kernel: 08:02: rw=0, want=1881647817, limit=4025226
Feb 23 21:31:55 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:55 conquest2 kernel: 08:02: rw=0, want=254809089, limit=4025226
Feb 23 21:31:56 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:56 conquest2 kernel: 08:02: rw=0, want=1347352538, limit=4025226
Feb 23 21:31:56 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:56 conquest2 kernel: 08:02: rw=0, want=638899224, limit=4025226
Feb 23 21:31:56 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:56 conquest2 kernel: 08:02: rw=0, want=862908286, limit=4025226
Feb 23 21:31:57 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:57 conquest2 kernel: 08:02: rw=0, want=1015448884, limit=4025226
Feb 23 21:31:57 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:57 conquest2 kernel: 08:02: rw=0, want=1158300708, limit=4025226
Feb 23 21:31:57 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:57 conquest2 kernel: 08:02: rw=0, want=1931753295, limit=4025226
Feb 23 21:31:58 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:58 conquest2 kernel: 08:02: rw=0, want=449852662, limit=4025226
Feb 23 21:31:58 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:58 conquest2 kernel: 08:02: rw=0, want=1444334445, limit=4025226
Feb 23 21:31:58 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:58 conquest2 kernel: 08:02: rw=0, want=831170758, limit=4025226
Feb 23 21:31:58 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:58 conquest2 kernel: 08:02: rw=0, want=1270180463, limit=4025226
Feb 23 21:31:58 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:59 conquest2 kernel: 08:02: rw=0, want=136595738, limit=4025226
Feb 23 21:31:59 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:31:59 conquest2 kernel: 08:02: rw=0, want=1076953962, limit=4025226
Feb 23 21:31:59 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:32:00 conquest2 kernel: 08:02: rw=0, want=309535248, limit=4025226
Feb 23 21:32:00 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:32:00 conquest2 kernel: 08:02: rw=0, want=469059007, limit=4025226
Feb 23 21:32:00 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:32:00 conquest2 kernel: 08:02: rw=0, want=654997506, limit=4025226
Feb 23 21:32:01 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:32:01 conquest2 kernel: 08:02: rw=0, want=1522206734, limit=4025226
Feb 23 21:32:01 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:32:01 conquest2 kernel: 08:02: rw=0, want=880975962, limit=4025226
Feb 23 21:32:01 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:32:01 conquest2 kernel: 08:02: rw=0, want=953522888, limit=4025226
Feb 23 21:32:02 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:32:02 conquest2 kernel: 08:02: rw=0, want=1416357739, limit=4025226
 followed by scsi complaints:-
Feb 23 21:32:21 conquest2 kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 6, lun 0 Read (10) 00 00 4c f7 de 00 00 7a 00 
Feb 23 21:32:21 conquest2 kernel: sym53c8xx_abort: pid=0 serial_number=39153 serial_number_at_timeout=39153
Feb 23 21:32:21 conquest2 kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 6, lun 0 Read (10) 00 00 4c f8 58 00 00 8a 00 
Feb 23 21:32:21 conquest2 kernel: sym53c8xx_abort: pid=0 serial_number=39157 serial_number_at_timeout=39157
Feb 23 21:32:21 conquest2 kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 4, lun 0 Read (10) 00 00 36 d9 02 00 00 02 00 
Feb 23 21:32:21 conquest2 kernel: sym53c8xx_abort: pid=0 serial_number=39159 serial_number_at_timeout=39159
Feb 23 21:32:23 conquest2 kernel: SCSI host 0 abort (pid 0) timed out - resetting
Feb 23 21:32:23 conquest2 kernel: SCSI bus is being reset for host 0 channel 0.
Feb 23 21:32:23 conquest2 kernel: sym53c8xx_reset: pid=0 reset_flags=2 serial_number=39153 serial_number_at_timeout=39153
Feb 23 21:32:23 conquest2 kernel: sym53c875-0: restart (scsi reset).
Feb 23 21:32:23 conquest2 kernel: sym53c875-0: Downloading SCSI SCRIPTS.
Feb 23 21:32:24 conquest2 kernel: sym53c875-0-<6,0>: wide msgout: 1-2-3-1.
Feb 23 21:32:24 conquest2 kernel: sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
Feb 23 21:32:24 conquest2 kernel: sym53c875-0-<6,0>: wide msgin: 1-2-3-1.
Feb 23 21:32:24 conquest2 kernel: sym53c875-0-<6,0>: wide: wide=1 chg=0.
Feb 23 21:32:24 conquest2 kernel: sym53c875-0-<6,0>: wide msgout: 1-2-3-1.
Feb 23 21:32:24 conquest2 kernel: sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
Feb 23 21:32:24 conquest2 kernel: sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
Feb 23 21:32:24 conquest2 kernel: sym53c875-0-<4,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
Feb 23 21:32:25 conquest2 kernel: sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
Feb 23 21:32:25 conquest2 kernel: sym53c875-0-<6,0>: wide msgin: 1-2-3-1.
Feb 23 21:32:25 conquest2 kernel: sym53c875-0-<6,0>: wide: wide=1 chg=0.
Feb 23 21:32:26 conquest2 kernel: sym53c875-0-<6,0>: sync msgout: 1-3-1-c-10.
Feb 23 21:32:26 conquest2 kernel: sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
Feb 23 21:32:26 conquest2 kernel: sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
Feb 23 21:32:26 conquest2 kernel: sym53c875-0-<6,0>: sync msg in: 1-3-1-c-f.
Feb 23 21:32:26 conquest2 kernel: sym53c875-0-<6,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
Feb 23 21:32:26 conquest2 kernel: sym53c875-0-<6,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 15)

Then an EXT2-fs error (is this the underlying problem?):-

Feb 23 21:44:52 conquest2 kernel: EXT2-fs error (device sd(8,20)): ext2_readdir: directory #450899 contains a hole at offset 0
 
Feb 23 21:45:57 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:45:57 conquest2 kernel: 08:14: rw=0, want=170060801, limit=2436588
Feb 23 21:45:57 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:45:57 conquest2 kernel: 08:14: rw=0, want=170074113, limit=2436588
Feb 23 21:45:57 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:45:57 conquest2 kernel: 08:14: rw=0, want=170075137, limit=2436588
Feb 23 21:47:41 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:47:41 conquest2 kernel: 08:14: rw=0, want=151682049, limit=2436588
Feb 23 21:47:41 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:47:41 conquest2 kernel: 08:14: rw=0, want=151687169, limit=2436588
Feb 23 21:47:41 conquest2 kernel: attempt to access beyond end of device
Feb 23 21:47:41 conquest2 kernel: 08:14: rw=0, want=151688193, limit=2436588

Feb 23 21:47:44 conquest2 kernel: EXT2-fs warning (device sd(8,20)): ext2_update_dynamic_rev: updating to rev 1 because of new feature flag, running e2fsck is recommended

--- At which point the system was shutdown. ---

fsck found a large number of errors on /dev/sdb4 and /dev/hbd1 when rebooted 
under 2.2.18 for repair. 


~~~~~~~~~~~~~~~~~~~~ Machine details ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/proc/cpuinfo:-
===============

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 800.064
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips        : 1595.80
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

lspci -v:-
==========

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
	Flags: bus master, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable)
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: da000000-dcffffff
	Prefetchable memory behind bridge: d8000000-d9ffffff
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000
	Capabilities: <available only to root>

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel
	Capabilities: <available only to root>
00:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at dc00
	Memory at de000000 (32-bit, non-prefetchable)

00:0f.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 03)
	Flags: bus master, medium devsel, latency 144, IRQ 11
	I/O ports at e000
	Memory at de001000 (32-bit, non-prefetchable)
	Memory at de002000 (32-bit, non-prefetchable)

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at d8000000 (32-bit, prefetchable)
	Memory at da000000 (32-bit, non-prefetchable)
	Memory at db000000 (32-bit, non-prefetchable)
	Capabilities: <available only to root>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In rc.local:-
=============

/sbin/hdparm -d1 -m16  /dev/hdb
/sbin/hdparm -d1 -m8  /dev/hda

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_FWMARK is not set
CONFIG_IP_ROUTE_NAT=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_MARK is not set
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
# CONFIG_IP_NF_TARGET_REDIRECT is not set
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
# CONFIG_IP_NF_TARGET_MARK is not set
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDE_CHIPSETS=y

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_PDC4030 is not set
# CONFIG_BLK_DEV_QD6580 is not set
# CONFIG_BLK_DEV_UMC8672 is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=40
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT=y
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=m
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139TOO is not set
# CONFIG_RTL8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=m
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_CHARDEV is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#

#
# Game port support
#

#
# Gameport joysticks
#

#
# Serial port support
#

#
# Serial port joysticks
#

#
# Parallel port joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=y
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp850"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
CONFIG_SOUND_MPU401=m
# CONFIG_SOUND_NM256 is not set
CONFIG_SOUND_MAD16=m
# CONFIG_MAD16_OLDCARD is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
# CONFIG_SOUND_SB is not set
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=m
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
# CONFIG_USB_UHCI is not set
CONFIG_USB_UHCI_ALT=m
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_NET1080 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB misc drivers
#
# CONFIG_USB_RIO500 is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sorry not to be more helpful :-(

ael

--------------49A65ABE9475B7062150C4F4--

