Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129460AbQK3MGM>; Thu, 30 Nov 2000 07:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129437AbQK3MFv>; Thu, 30 Nov 2000 07:05:51 -0500
Received: from Unable.to.handle.kernel.NULL.pointer.dereference.de ([212.6.215.146]:50180
        "EHLO inode.real-linux.de") by vger.kernel.org with ESMTP
        id <S129226AbQK3MFo>; Thu, 30 Nov 2000 07:05:44 -0500
Date: Thu, 30 Nov 2000 12:33:22 +0100
From: Florian Heinz <sky@dereference.de>
To: linux-kernel@vger.kernel.org
Subject: Some problems with the raid-stuff in 2.4.0-test12pre3
Message-ID: <20001130123322.A672@inode.real-linux.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello people,

I have some trouble with the raid-stuff.
My machine is a Pentium-III, 256 MB ram and 7 scsi-disks (IBM DNES-318350W
17B). I'm using raid5 for 6 of these disks (chunk-size 8).
Machine boots, I do mkraid /dev/md0 and then mke2fs /dev/md0 and that's
where the problems start. mkfs tries to write 684 inode-tables and after the
first 30 it gets very slow. ps ax (with wchan) tells me it hangs in
wakeup_bdflush.
I'm rather sure it's related to the raidcode, because without raid the disks
work as expected.
I'm using an Adaptec 7892A with the aic7xxx-driver, I have disabled the TCQ
and the extra checks for the new queueing code, but I have tried with both
activated, too.
No related messages from the kernel in the syslog.
It worked fine with 2.2.x.

I've attached several (maybe) relevant informations, if you need more,
please tell me.

Regards

Florian Heinz

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=info

Bootup:
-------
Nov 30 12:15:20 nstx kernel: Linux version 2.4.0-test12 (root@nstx) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #2 Thu Nov 30 12:07:07 CET 2000
Nov 30 12:15:20 nstx kernel: BIOS-provided physical RAM map:
Nov 30 12:15:20 nstx kernel:  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
Nov 30 12:15:20 nstx kernel:  BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
Nov 30 12:15:20 nstx kernel:  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
Nov 30 12:15:20 nstx kernel:  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Nov 30 12:15:20 nstx kernel:  BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
Nov 30 12:15:20 nstx kernel:  BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
Nov 30 12:15:20 nstx kernel:  BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
Nov 30 12:15:20 nstx kernel: On node 0 totalpages: 65520
Nov 30 12:15:20 nstx kernel: zone(0): 4096 pages.
Nov 30 12:15:20 nstx kernel: zone(1): 61424 pages.
Nov 30 12:15:20 nstx kernel: zone(2): 0 pages.
Nov 30 12:15:20 nstx kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=801 BOOT_FILE=/boot/vm2.4.0
Nov 30 12:15:20 nstx kernel: Initializing CPU#0
Nov 30 12:15:20 nstx kernel: Detected 650.029 MHz processor.
Nov 30 12:15:20 nstx kernel: Console: colour VGA+ 80x25
Nov 30 12:15:20 nstx kernel: Calibrating delay loop... 1297.61 BogoMIPS
Nov 30 12:15:20 nstx kernel: Memory: 255864k/262080k available (1046k kernel code, 5828k reserved, 62k data, 160k init, 0k highmem)
Nov 30 12:15:20 nstx kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Nov 30 12:15:20 nstx kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Nov 30 12:15:20 nstx kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Nov 30 12:15:20 nstx kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Nov 30 12:15:20 nstx kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Nov 30 12:15:20 nstx kernel: CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor = 0
Nov 30 12:15:20 nstx kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Nov 30 12:15:20 nstx kernel: CPU: L2 cache: 256K
Nov 30 12:15:20 nstx kernel: Intel machine check architecture supported.
Nov 30 12:15:20 nstx kernel: Intel machine check reporting enabled on CPU#0.
Nov 30 12:15:20 nstx kernel: CPU: After vendor init, caps: 0387f9ff 00000000 00000000 00000000
Nov 30 12:15:20 nstx kernel: CPU serial number disabled.
Nov 30 12:15:20 nstx kernel: CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
Nov 30 12:15:20 nstx kernel: CPU: Common caps: 0383f9ff 00000000 00000000 00000000
Nov 30 12:15:20 nstx kernel: CPU: Intel Pentium III (Coppermine) stepping 01
Nov 30 12:15:20 nstx kernel: Enabling fast FPU save and restore... done.
Nov 30 12:15:20 nstx kernel: Enabling unmasked SIMD FPU exception support... done.
Nov 30 12:15:20 nstx kernel: Checking 'hlt' instruction... OK.
Nov 30 12:15:20 nstx kernel: POSIX conformance testing by UNIFIX
Nov 30 12:15:20 nstx kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
Nov 30 12:15:20 nstx kernel: PCI: Using configuration type 1
Nov 30 12:15:20 nstx kernel: PCI: Probing PCI hardware
Nov 30 12:15:20 nstx kernel: Unknown bridge resource 2: assuming transparent
Nov 30 12:15:20 nstx kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Nov 30 12:15:20 nstx kernel: Limiting direct PCI/PCI transfers.
Nov 30 12:15:20 nstx kernel: Linux NET4.0 for Linux 2.4
Nov 30 12:15:20 nstx kernel: Based upon Swansea University Computer Society NET3.039
Nov 30 12:15:20 nstx kernel: Starting kswapd v1.8
Nov 30 12:15:20 nstx kernel: pty: 256 Unix98 ptys configured
Nov 30 12:15:20 nstx kernel: Real Time Clock Driver v1.10d
Nov 30 12:15:20 nstx kernel: 3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
Nov 30 12:15:20 nstx kernel: See Documentation/networking/vortex.txt
Nov 30 12:15:20 nstx kernel: eth0: 3Com PCI 3c905C Tornado at 0xe800,  00:50:da:dc:95:59, IRQ 10
Nov 30 12:15:20 nstx kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
Nov 30 12:15:20 nstx kernel:   MII transceiver found at address 24, status 782d.
Nov 30 12:15:20 nstx kernel:   Enabling bus-master transmits and whole-frame receives.
Nov 30 12:15:20 nstx kernel: eth1: 3Com PCI 3c905C Tornado at 0xec00,  00:01:02:c0:42:69, IRQ 11
Nov 30 12:15:20 nstx kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
Nov 30 12:15:20 nstx kernel:   MII transceiver found at address 24, status 7809.
Nov 30 12:15:20 nstx kernel:   Enabling bus-master transmits and whole-frame receives.
Nov 30 12:15:20 nstx kernel: SCSI subsystem driver Revision: 1.00
Nov 30 12:15:20 nstx kernel: (scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI 0/9/0
Nov 30 12:15:20 nstx kernel: (scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
Nov 30 12:15:20 nstx kernel: (scsi0) Downloading sequencer code... 392 instructions downloaded
Nov 30 12:15:20 nstx kernel: scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
Nov 30 12:15:20 nstx kernel:        <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
Nov 30 12:15:20 nstx kernel: (scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 31.
Nov 30 12:15:20 nstx kernel:   Vendor: IBM       Model: DNES-318350W      Rev: SA30
Nov 30 12:15:20 nstx kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 30 12:15:20 nstx kernel: (scsi0:0:1:0) Synchronous at 40.0 Mbyte/sec, offset 31.
Nov 30 12:15:20 nstx kernel:   Vendor: IBM       Model: DNES-318350W      Rev: SA30
Nov 30 12:15:20 nstx kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 30 12:15:20 nstx kernel: (scsi0:0:2:0) Synchronous at 20.0 Mbyte/sec, offset 16.
Nov 30 12:15:20 nstx kernel:   Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
Nov 30 12:15:20 nstx kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Nov 30 12:15:20 nstx kernel: (scsi0:0:3:0) Synchronous at 40.0 Mbyte/sec, offset 31.
Nov 30 12:15:20 nstx kernel:   Vendor: IBM       Model: DNES-318350W      Rev: SA30
Nov 30 12:15:20 nstx kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 30 12:15:20 nstx kernel: (scsi0:0:4:0) Synchronous at 40.0 Mbyte/sec, offset 31.
Nov 30 12:15:20 nstx kernel:   Vendor: IBM       Model: DNES-318350W      Rev: SA30
Nov 30 12:15:20 nstx kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 30 12:15:20 nstx kernel: (scsi0:0:5:0) Synchronous at 40.0 Mbyte/sec, offset 31.
Nov 30 12:15:20 nstx kernel:   Vendor: IBM       Model: DNES-318350W      Rev: SA30
Nov 30 12:15:20 nstx kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 30 12:15:20 nstx kernel: (scsi0:0:6:0) Synchronous at 40.0 Mbyte/sec, offset 31.
Nov 30 12:15:20 nstx kernel:   Vendor: IBM       Model: DNES-318350W      Rev: SA30
Nov 30 12:15:20 nstx kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 30 12:15:20 nstx kernel: (scsi0:0:8:0) Synchronous at 40.0 Mbyte/sec, offset 31.
Nov 30 12:15:20 nstx kernel:   Vendor: IBM       Model: DNES-318350W      Rev: SA30
Nov 30 12:15:20 nstx kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov 30 12:15:20 nstx kernel: Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Nov 30 12:15:20 nstx kernel: Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Nov 30 12:15:20 nstx kernel: Detected scsi disk sdc at scsi0, channel 0, id 3, lun 0
Nov 30 12:15:20 nstx kernel: Detected scsi disk sdd at scsi0, channel 0, id 4, lun 0
Nov 30 12:15:20 nstx kernel: Detected scsi disk sde at scsi0, channel 0, id 5, lun 0
Nov 30 12:15:20 nstx kernel: Detected scsi disk sdf at scsi0, channel 0, id 6, lun 0
Nov 30 12:15:20 nstx kernel: Detected scsi disk sdg at scsi0, channel 0, id 8, lun 0
Nov 30 12:15:20 nstx kernel: SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Nov 30 12:15:20 nstx kernel: Partition check:
Nov 30 12:15:20 nstx kernel:  sda: sda1 sda2 sda3 sda4
Nov 30 12:15:20 nstx kernel: SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
Nov 30 12:15:20 nstx kernel:  sdb: unknown partition table
Nov 30 12:15:20 nstx kernel: SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
Nov 30 12:15:20 nstx kernel:  sdc: unknown partition table
Nov 30 12:15:20 nstx kernel: SCSI device sdd: 35843670 512-byte hdwr sectors (18352 MB)
Nov 30 12:15:20 nstx kernel:  sdd: unknown partition table
Nov 30 12:15:20 nstx kernel: SCSI device sde: 35843670 512-byte hdwr sectors (18352 MB)
Nov 30 12:15:20 nstx kernel:  sde: unknown partition table
Nov 30 12:15:20 nstx kernel: SCSI device sdf: 35843670 512-byte hdwr sectors (18352 MB)
Nov 30 12:15:20 nstx kernel:  sdf: unknown partition table
Nov 30 12:15:20 nstx kernel: SCSI device sdg: 35843670 512-byte hdwr sectors (18352 MB)
Nov 30 12:15:20 nstx kernel:  sdg: unknown partition table
Nov 30 12:15:20 nstx kernel: raid5: measuring checksumming speed
Nov 30 12:15:20 nstx kernel:    8regs     :  1097.280 MB/sec
Nov 30 12:15:20 nstx kernel:    32regs    :   811.149 MB/sec
Nov 30 12:15:20 nstx kernel:    pIII_sse  :  1380.744 MB/sec
Nov 30 12:15:20 nstx kernel:    pII_mmx   :  1501.521 MB/sec
Nov 30 12:15:20 nstx kernel:    p5_mmx    :  1565.148 MB/sec
Nov 30 12:15:20 nstx kernel: raid5: using function: pIII_sse (1380.744 MB/sec)
Nov 30 12:15:20 nstx kernel: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Nov 30 12:15:20 nstx kernel: raid5 personality registered
Nov 30 12:15:20 nstx kernel: md.c: sizeof(mdp_super_t) = 4096
Nov 30 12:15:20 nstx kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov 30 12:15:20 nstx kernel: IP Protocols: ICMP, UDP, TCP
Nov 30 12:15:20 nstx kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Nov 30 12:15:20 nstx kernel: TCP: Hash tables configured (established 16384 bind 16384)
Nov 30 12:15:20 nstx kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Nov 30 12:15:20 nstx kernel: VFS: Mounted root (ext2 filesystem) readonly.
Nov 30 12:15:20 nstx kernel: Freeing unused kernel memory: 160k freed
Nov 30 12:15:20 nstx kernel: Adding Swap: 192772k swap-space (priority -1)
Nov 30 12:15:20 nstx kernel: eth0: using NWAY autonegotiation
Nov 30 12:15:20 nstx kernel: eth1: using NWAY autonegotiation
Nov 30 12:15:49 nstx kernel: bind<sdb,1>
Nov 30 12:15:49 nstx kernel: nonpersistent superblock ...
Nov 30 12:15:49 nstx kernel: bind<sdc,2>
Nov 30 12:15:49 nstx kernel: nonpersistent superblock ...
Nov 30 12:15:49 nstx kernel: bind<sdd,3>
Nov 30 12:15:49 nstx kernel: nonpersistent superblock ...
Nov 30 12:15:49 nstx kernel: bind<sde,4>
Nov 30 12:15:49 nstx kernel: nonpersistent superblock ...
Nov 30 12:15:49 nstx kernel: bind<sdf,5>
Nov 30 12:15:49 nstx kernel: nonpersistent superblock ...
Nov 30 12:15:49 nstx kernel: bind<sdg,6>
Nov 30 12:15:49 nstx kernel: nonpersistent superblock ...
Nov 30 12:15:49 nstx kernel: sdg's event counter: 00000000
Nov 30 12:15:49 nstx kernel: sdf's event counter: 00000000
Nov 30 12:15:49 nstx kernel: sde's event counter: 00000000
Nov 30 12:15:49 nstx kernel: sdd's event counter: 00000000
Nov 30 12:15:49 nstx kernel: sdc's event counter: 00000000
Nov 30 12:15:49 nstx kernel: sdb's event counter: 00000000
Nov 30 12:15:49 nstx kernel: md: md0: raid array is not clean -- starting background reconstruction
Nov 30 12:15:49 nstx kernel: md0: max total readahead window set to 1240k
Nov 30 12:15:49 nstx kernel: md0: 5 data-disks, max readahead per data-disk: 248k
Nov 30 12:15:49 nstx kernel: raid5: device sdg operational as raid disk 5
Nov 30 12:15:49 nstx kernel: raid5: device sdf operational as raid disk 4
Nov 30 12:15:49 nstx kernel: raid5: device sde operational as raid disk 3
Nov 30 12:15:49 nstx kernel: raid5: device sdd operational as raid disk 2
Nov 30 12:15:49 nstx kernel: raid5: device sdc operational as raid disk 1
Nov 30 12:15:49 nstx kernel: raid5: device sdb operational as raid disk 0
Nov 30 12:15:49 nstx kernel: raid5: allocated 6451kB for md0
Nov 30 12:15:49 nstx kernel: raid5: raid level 5 set md0 active with 6 out of 6 devices, algorithm 2
Nov 30 12:15:49 nstx kernel: raid5: raid set md0 not clean; reconstructing parity
Nov 30 12:15:49 nstx kernel: RAID5 conf printout:
Nov 30 12:15:49 nstx kernel:  --- rd:6 wd:6 fd:0
Nov 30 12:15:49 nstx kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdb
Nov 30 12:15:49 nstx kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdc
Nov 30 12:15:49 nstx kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sdd
Nov 30 12:15:49 nstx kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sde
Nov 30 12:15:49 nstx kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:sdf
Nov 30 12:15:49 nstx kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:sdg
Nov 30 12:15:49 nstx kernel:  disk 6, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 7, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 8, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 9, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 10, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 11, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 12, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 13, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 14, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 15, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 16, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 17, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 18, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 19, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 20, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 21, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 22, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 23, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 24, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 25, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 26, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel: RAID5 conf printout:
Nov 30 12:15:49 nstx kernel:  --- rd:6 wd:6 fd:0
Nov 30 12:15:49 nstx kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdb
Nov 30 12:15:49 nstx kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdc
Nov 30 12:15:49 nstx kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sdd
Nov 30 12:15:49 nstx kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sde
Nov 30 12:15:49 nstx kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:sdf
Nov 30 12:15:49 nstx kernel:  disk 5, s:0, o:1, n:5 rd:5 us:1 dev:sdg
Nov 30 12:15:49 nstx kernel:  disk 6, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 7, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 8, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 9, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 10, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 11, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 12, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 13, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 14, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 15, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 16, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 17, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 18, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 19, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 20, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 21, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 22, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 23, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 24, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 25, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel:  disk 26, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Nov 30 12:15:49 nstx kernel: md: syncing RAID array md0
Nov 30 12:15:49 nstx kernel: md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
Nov 30 12:15:49 nstx kernel: md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
Nov 30 12:15:49 nstx kernel: md: using 124k window, over a total of 17921832 blocks.

kernel-config:
--------------
#
# Automatically generated by make menuconfig: don't edit
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
CONFIG_M686FXSR=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_FXSR=y
CONFIG_X86_XMM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
CONFIG_MD_RAID5=y
# CONFIG_MD_BOOT is not set
# CONFIG_AUTODETECT_RAID is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_LVM_PROC_FS is not set

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
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
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=10
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=y
# CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT is not set
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
# CONFIG_AIC7XXX_PROC_STATS is not set
CONFIG_AIC7XXX_RESET_DELAY=5
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
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
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
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
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
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
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
# CONFIG_PPP is not set
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
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
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
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_MOUNT_SUBDIR is not set
# CONFIG_NCPFS_NDS_DOMAINS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
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
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

/proc/scsi/aic7xxx/0:
---------------------
Adaptec AIC7xxx driver version: 5.2.1/5.2.0
Compile Options:
  TCQ Enabled By Default : Disabled
  AIC7XXX_PROC_STATS     : Disabled

Adapter Configuration:
           SCSI Adapter: Adaptec AIC-7892 Ultra 160/m SCSI host adapter
                           Ultra-160/m LVD/SE Wide Controller at PCI 0/9/0
    PCI MMAPed I/O Base: 0xeb000000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 11
                   SCBs: Active 6, Max Active 7,
                         Allocated 31, HW 32, Page 255
             Interrupts: 1143297
      BIOS Control Word: 0xb8f4
   Adapter Control Word: 0x745d
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0000
 Tag Queue Enable Flags: 0x0000
Ordered Queue Tag Flags: 0x0000
Default Tag Queue Depth: 8
    Tagged Queue By Device array for aic7xxx host instance 0:
      {255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255}
    Actual queue depth per device for aic7xxx host instance 0:
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi0:0:0:0)
  Device using Wide/Sync transfers at 40.0 MByte/sec, offset 31
  Transinfo settings: current(12/31/1/0), goal(9/127/1/0), user(9/127/1/2)
  Total transfers 1782 (1334 reads and 448 writes)


(scsi0:0:1:0)
  Device using Wide/Sync transfers at 40.0 MByte/sec, offset 31
  Transinfo settings: current(12/31/1/0), goal(9/127/1/0), user(9/127/1/2)
  Total transfers 189315 (79550 reads and 109765 writes)


(scsi0:0:2:0)
  Device using Narrow/Sync transfers at 20.0 MByte/sec, offset 16
  Transinfo settings: current(12/16/0/0), goal(10/127/0/0), user(9/127/1/2)
  Total transfers 0 (0 reads and 0 writes)


(scsi0:0:3:0)
  Device using Wide/Sync transfers at 40.0 MByte/sec, offset 31
  Transinfo settings: current(12/31/1/0), goal(9/127/1/0), user(9/127/1/2)
  Total transfers 190311 (79821 reads and 110490 writes)


(scsi0:0:4:0)
  Device using Wide/Sync transfers at 40.0 MByte/sec, offset 31
  Transinfo settings: current(12/31/1/0), goal(9/127/1/0), user(9/127/1/2)
  Total transfers 189961 (79775 reads and 110186 writes)


(scsi0:0:5:0)
  Device using Wide/Sync transfers at 40.0 MByte/sec, offset 31
  Transinfo settings: current(12/31/1/0), goal(9/127/1/0), user(9/127/1/2)
  Total transfers 190089 (79889 reads and 110200 writes)


(scsi0:0:6:0)
  Device using Wide/Sync transfers at 40.0 MByte/sec, offset 31
  Transinfo settings: current(12/31/1/0), goal(9/127/1/0), user(9/127/1/2)
  Total transfers 188534 (79562 reads and 108972 writes)


(scsi0:0:8:0)
  Device using Wide/Sync transfers at 40.0 MByte/sec, offset 31
  Transinfo settings: current(12/31/1/0), goal(9/127/1/0), user(9/127/1/2)
  Total transfers 193035 (80562 reads and 112473 writes)


--MW5yreqqjyrRcusr--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
