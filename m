Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSGURSG>; Sun, 21 Jul 2002 13:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSGURSF>; Sun, 21 Jul 2002 13:18:05 -0400
Received: from mikrolahti.fi ([195.237.35.128]:49668 "EHLO pleco.mikrolahti.fi")
	by vger.kernel.org with ESMTP id <S316662AbSGURR6> convert rfc822-to-8bit;
	Sun, 21 Jul 2002 13:17:58 -0400
Date: Sun, 21 Jul 2002 20:21:01 +0300
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de, sami.louko@mikrolahti.fi
Subject: troubles using RAID on Alpha and compiling 2.4.19rc1-aa2
Message-ID: <20020721172101.GA2789@pleco.mikrolahti.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.28i
From: samppa@pleco.mikrolahti.fi (Sami Louko)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been fighting with several 2.2 and 2.4 kernels for a week to get
soft-RAID working on my Alpha. I've tried both 2.2.20-kernel patched
with RAID-patch, and 2.4.18, 2.4.19rc1 and 2.4.19rc1-aa2 patched kernels.
Now i do have normally working 2.4.18 and 2.2.21 kernels for that alpha.
They did compile correctly and does almost everything i do need.
Only missing thing is RAID-support. Actually 2.2.21 was able to use RAID-0
made with raidtools (not raidtools2) but i need to use RAID-1.
The md-driver in 2.2.21 kernel is too old, v0.35... or something and
raidtools2 does require driver v0.90.

What is the problem. I'd like to use 2.4 kernel, because of journaled fs-
support. Kernel 2.2 would be a little bit more stable, so it would be the
another choice but it must be raid-patched.
When i compile 2.4.18, the progress completes successfully. But the md-
driver crashes the machine.
I patched the kernel with patch-2.4.19rc1 and tried again, same thing.
A friend of mine recommended me to use Andrea's patch 2.4.19rc1-aa2,
so i patch it to kernel and tried again.
It doesn't compile. I log everything and put them into files on my web-
server at http://mikrolahti.fi/kernel

# compiler i used #
pleco:/usr/src/2.4.19rc1aa2# gcc -v
Reading specs from /usr/lib/gcc-lib/alpha-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

At first i make mrproper, then i configured kernel by make menuconfig.
Configuration file: http://mikrolahti.fi/kernel/config-2.4.19rc1aa2

then i make dep and while logging, i got an error:
pleco:/usr/src/2.4.19rc1aa2# make dep > /2.4.19rc1aa2.deplog
md5sum: can't open hfc_pci.

Logfile can be found: http://mikrolahti.fi/kernel/2.4.19rc1aa2.deplog

and the kernel compile died soon after beginning:
pleco:/usr/src/2.4.19rc1aa2# make boot > /2.4.19rc1aa2.compile

Logfile can be found: http://mikrolahti.fi/kernel/2.4.19rc1aa2.compile
stdout errors can be found: http://mikrolahti.fi/kernel/2.4.19rc1aa2.comperr

tail of the stdout errors:
arch/alpha/kernel/kernel.o: In function 'ret_from_fork':
arch/alpha/kernel/kernel.o(.text+0xa28): undefined reference to 'schedule_tail'
arch/alpha/kernel/kernel.o(.text+0xa2c): undefined reference to 'schedule_tail'
arch/alpha/kernel/kernel.o: In function 'f_select':
arch/alpha/kernel/kernel.o(.text+0x4990): undefined reference to 'get_fd_set'
arch/alpha/kernel/kernel.o(.text+0x4994): undefined reference to 'get_fd_set'
arch/alpha/kernel/kernel.o(.text+0x49b4): undefined reference to 'get_fd_set'
arch/alpha/kernel/kernel.o(.text+0x49b8): undefined reference to 'get_fd_set'
arch/alpha/kernel/kernel.o(.text+0x49dc): undefined reference to 'get_fd_set'
arch/alpha/kernel/kernel.o(.text+0x49e0): more undefined references to 'get_fd_set' follow
arch/alpha/kernel/kernel.o: In function 'f_select':
arch/alpha/kernel/kernel.o(.text+0x4a00): undefined reference to 'zero_fd_set'
arch/alpha/kernel/kernel.o(.text+0x4a04): undefined reference to 'zero_fd_set'
arch/alpha/kernel/kernel.o(.text+0x4a18): undefined reference to 'zero_fd_set'
arch/alpha/kernel/kernel.o(.text+0x4a1c): undefined reference to 'zero_fd_set'
arch/alpha/kernel/kernel.o(.text+0x4a30): undefined reference to 'zero_fd_set'
arch/alpha/kernel/kernel.o(.text+0x4a34): more undefined references to 'zero_fd_set' follow
make: *** [vmlinux] Error 1

It does compile it almost to the end, but it stops at the error, and i don't
know/understand why it does so.


I also logged the compiling of kernel 2.2.20. I used linux-2.2.20 source, and
i patched it succesfully with raidpatch by patch -p0 < raid-2.2.20-A0.
Then i make mrproper, make menuconfig, make dep and make boot.
Configuration can be found: http://mikrolahti.fi/kernel/config-2.2.20raid

Compilation started as 2.4.19rc1aa2,
pleco:/usr/src/2.2.20raid# make dep > /2.2.20raid.deplog
md5sum: can't open hfc_pci.

logfile can be found: http://mikrolahti.fi/kernel/2.2.20raid.deplog

then make boot, that fails right after beginning...
pleco:/usr/src/2.2.20raid# make boot
scripts/split-include include/linux/autoconf.h include/config
make: Circular /usr/src/2.2.20raid/include/asm/smp.h <- /usr/src/2.2.20raid/include/linux/sched.h dependency dropped.
make: Circular /usr/src/2.2.20raid/include/asm/pci.h <- /usr/src/2.2.20raid/include/linux/pci.h dependency dropped.
cc -D__KERNEL__ -I/usr/src/2.2.20raid/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-m21164a -DBWIO_ENABLED  -c -o init/main.o init/main.c
init/main.c:1016: warning: garbage at end of #ifdef' argument
In file included from /usr/src/2.2.20raid/include/linux/pci.h:1448,
                 from init/main.c:36:
/usr/src/2.2.20raid/include/asm/pci.h: In function ci_controller_num':
/usr/src/2.2.20raid/include/asm/pci.h:62: structure has no member named 'pci_host_index'
/usr/src/2.2.20raid/include/asm/pci.h:63: warning: control reaches end of non-void function
make: *** [init/main.o] Error 1

That was all of it. I really bored with these patches and raid-support. I've
been using Alphas since 1994 and i trust them, but now i'd like to have some
new features to make server a little better =)

I do have 2 alphas, and i've been trying to compile those on both of them,
and also tried the generic-compilation, with same incomplete result.
2.2.21 does compile and work, so does 2.4.18 and 2.4.19rc1 without the patch
but when using softraid (md) it crashes.
With 2.4.19rc1 building /dev/md0 completes succesfully, but when trying to
make filesystem by mke2fs (-j) /dev/md0 it does crash, or trying to mount,
it crashes and jams.

Hardware i used here is:

Alpha PC164LX 533MHz w/2MB cache, 512Mt SDRAM, Compaq 2ch 64-bit U2W-SCSI,
3Com905, Matrox Millennium. The Alpha-firmware is the latest SRM-firmware.

Here is also /var/log/messages from when booted 2.4.19rc1 and started raid:

Jul 20 22:48:42 pleco kernel: Linux version 2.4.19-rc1 (root@pleco) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Sat Jul 20 20:50:28 EEST 2002
Jul 20 22:48:42 pleco kernel: Booting on EB164 variation LX164 using machine vector LX164 from SRM
Jul 20 22:48:42 pleco kernel: Command line: ro root=/dev/sda3
Jul 20 22:48:42 pleco kernel: memcluster 0, usage 1, start        0, end 256
Jul 20 22:48:42 pleco kernel: memcluster 1, usage 0, start      256, end 65526
Jul 20 22:48:42 pleco kernel: memcluster 2, usage 1, start    65526, end 65536
Jul 20 22:48:42 pleco kernel: freeing pages 256:384
Jul 20 22:48:42 pleco kernel: freeing pages 733:65526
Jul 20 22:48:42 pleco kernel: reserving pages 733:734
Jul 20 22:48:42 pleco kernel: pci: cia revision 1 (pyxis)
Jul 20 22:48:42 pleco kernel: On node 0 totalpages: 65526
Jul 20 22:48:42 pleco kernel: zone(0): 65526 pages.
Jul 20 22:48:42 pleco kernel: zone(1): 0 pages.
Jul 20 22:48:42 pleco kernel: zone(2): 0 pages.
Jul 20 22:48:42 pleco kernel: Kernel command line: ro root=/dev/sda3
Jul 20 22:48:42 pleco kernel: Using epoch = 2000
Jul 20 22:48:42 pleco kernel: Console: colour VGA+ 80x25
Jul 20 22:48:42 pleco kernel: Calibrating delay loop... 1059.80 BogoMIPS
Jul 20 22:48:42 pleco kernel: Memory: 513688k/524208k available (1616k kernel code, 8472k reserved, 481k data, 360k init)
Jul 20 22:48:42 pleco kernel: Dentry cache hash table entries: 65536 (order: 7, 1048576 bytes)
Jul 20 22:48:42 pleco kernel: Inode cache hash table entries: 32768 (order: 6, 524288 bytes)
Jul 20 22:48:42 pleco kernel: Mount-cache hash table entries: 8192 (order: 4, 131072 bytes)
Jul 20 22:48:42 pleco kernel: Buffer-cache hash table entries: 32768 (order: 5, 262144 bytes)
Jul 20 22:48:42 pleco kernel: Page-cache hash table entries: 65536 (order: 6, 524288 bytes)
Jul 20 22:48:42 pleco kernel: POSIX conformance testing by UNIFIX
Jul 20 22:48:42 pleco kernel: pci: passed tb register update test
Jul 20 22:48:42 pleco kernel: pci: passed sg loopback i/o read test
Jul 20 22:48:42 pleco kernel: pci: passed pte write cache snoop test
Jul 20 22:48:42 pleco kernel: pci: failed valid tag invalid pte reload test (mcheck; workaround available)
Jul 20 22:48:42 pleco kernel: pci: passed pci machine check test
Jul 20 22:48:42 pleco kernel: pci: tbia workaround enabled
Jul 20 22:48:42 pleco kernel: PCI: dev LSI Logic / Symbios Logic (formerly NCR) 53c896 type 64-bit
Jul 20 22:48:42 pleco kernel: PCI: dev LSI Logic / Symbios Logic (formerly NCR) 53c896 (#2) type 64-bit
Jul 20 22:48:42 pleco kernel: PCI: dev LSI Logic / Symbios Logic (formerly NCR) 53c896 type 64-bit
Jul 20 22:48:42 pleco kernel: PCI: dev LSI Logic / Symbios Logic (formerly NCR) 53c896 (#2) type 64-bit
Jul 20 22:48:42 pleco kernel: SMC FDC37C93X Ultra I/O Controller found @ 0x370
Jul 20 22:48:42 pleco kernel: Linux NET4.0 for Linux 2.4
Jul 20 22:48:42 pleco kernel: Based upon Swansea University Computer Society NET3.039
Jul 20 22:48:42 pleco kernel: Initializing RT netlink socket
Jul 20 22:48:42 pleco kernel: Starting kswapd
Jul 20 22:48:42 pleco kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Jul 20 22:48:42 pleco kernel: pty: 1024 Unix98 ptys configured
Jul 20 22:48:42 pleco kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Jul 20 22:48:42 pleco kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jul 20 22:48:42 pleco kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jul 20 22:48:42 pleco kernel: rtc: SRM (post-2000) epoch (2000) detected
Jul 20 22:48:42 pleco kernel: Real Time Clock Driver v1.10e
Jul 20 22:48:42 pleco kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Jul 20 22:48:42 pleco kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 20 22:48:42 pleco kernel: Floppy drive(s): fd0 is 2.88M
Jul 20 22:48:42 pleco kernel: FDC 0 is a post-1991 82077
Jul 20 22:48:42 pleco kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Jul 20 22:48:42 pleco kernel: 00:06.0: 3Com PCI 3c905C Tornado at 0x8800. Vers LK1.1.16
Jul 20 22:48:42 pleco kernel: SCSI subsystem driver Revision: 1.00
Jul 20 22:48:42 pleco kernel: sym53c8xx: at PCI bus 0, device 7, function 0
Jul 20 22:48:42 pleco kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Jul 20 22:48:42 pleco kernel: sym53c8xx: setting PCI_COMMAND_INVALIDATE (fix-up)
Jul 20 22:48:42 pleco kernel: sym53c8xx: 53c896 detected 
Jul 20 22:48:42 pleco kernel: sym53c8xx: at PCI bus 0, device 7, function 1
Jul 20 22:48:42 pleco kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Jul 20 22:48:42 pleco kernel: sym53c8xx: setting PCI_COMMAND_INVALIDATE (fix-up)
Jul 20 22:48:42 pleco kernel: sym53c8xx: 53c896 detected 
Jul 20 22:48:42 pleco kernel: sym53c896-0: rev 0x5 on pci bus 0 device 7 function 0 irq 17
Jul 20 22:48:42 pleco kernel: sym53c896-0: ID 7, Fast-40, Parity Checking
Jul 20 22:48:42 pleco kernel: sym53c896-0: handling phase mismatch from SCRIPTS.
Jul 20 22:48:42 pleco kernel: sym53c896-1: rev 0x5 on pci bus 0 device 7 function 1 irq 24
Jul 20 22:48:42 pleco kernel: sym53c896-1: ID 7, Fast-40, Parity Checking
Jul 20 22:48:42 pleco kernel: sym53c896-1: handling phase mismatch from SCRIPTS.
Jul 20 22:48:42 pleco kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Jul 20 22:48:42 pleco kernel: scsi1 : sym53c8xx-1.7.3c-20010512
Jul 20 22:48:42 pleco kernel:   Vendor: SEAGATE   Model: ST34572W	Rev: 0876
Jul 20 22:48:42 pleco kernel:   Type:   Direct-Access			ANSI SCSI revision: 02
Jul 20 22:48:42 pleco kernel:   Vendor: SEAGATE   Model: ST318404LW	Rev: 0002
Jul 20 22:48:42 pleco kernel:   Type:   Direct-Access			ANSI SCSI revision: 03
Jul 20 22:48:42 pleco kernel:   Vendor: SEAGATE   Model: ST34502LW	Rev: 0004
Jul 20 22:48:42 pleco kernel:   Type:   Direct-Access			ANSI SCSI revision: 02
Jul 20 22:48:42 pleco kernel:   Vendor: SEAGATE   Model: ST34502LW	Rev: 0004
Jul 20 22:48:42 pleco kernel:   Type:   Direct-Access			ANSI SCSI revision: 02
Jul 20 22:48:42 pleco kernel: ncr53c8xx: at PCI bus 0, device 7, function 0
Jul 20 22:48:42 pleco kernel: ncr53c8xx: IO region 0x8000[0..127] is in use
Jul 20 22:48:42 pleco kernel: ncr53c8xx: at PCI bus 0, device 7, function 1
Jul 20 22:48:42 pleco kernel: ncr53c8xx: IO region 0x8400[0..127] is in use
Jul 20 22:48:42 pleco kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jul 20 22:48:42 pleco kernel: Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Jul 20 22:48:42 pleco kernel: Attached scsi disk sdc at scsi1, channel 0, id 4, lun 0
Jul 20 22:48:42 pleco kernel: Attached scsi disk sdd at scsi1, channel 0, id 5, lun 0
Jul 20 22:48:42 pleco kernel: sym53c896-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
Jul 20 22:48:42 pleco kernel: SCSI device sda: 8888924 512-byte hdwr sectors (4551 MB)
Jul 20 22:48:42 pleco kernel: Partition check:
Jul 20 22:48:42 pleco kernel:  sda: sda1 sda2 sda3
Jul 20 22:48:42 pleco kernel: sym53c896-0-<2,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 31)
Jul 20 22:48:42 pleco kernel: SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
Jul 20 22:48:42 pleco kernel:  sdb: sdb1
Jul 20 22:48:42 pleco kernel: sym53c896-1-<4,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
Jul 20 22:48:42 pleco kernel: SCSI device sdc: 8888924 512-byte hdwr sectors (4551 MB)
Jul 20 22:48:42 pleco kernel:  sdc: sdc1
Jul 20 22:48:42 pleco kernel: sym53c896-1-<5,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
Jul 20 22:48:42 pleco kernel: SCSI device sdd: 8888924 512-byte hdwr sectors (4551 MB)
Jul 20 22:48:42 pleco kernel:  sdd: sdd1
Jul 20 22:48:42 pleco kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 20 22:48:42 pleco kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jul 20 22:48:42 pleco kernel: IP: routing cache hash table of 4096 buckets, 64Kbytes
Jul 20 22:48:42 pleco kernel: TCP: Hash tables configured (established 32768 bind 32768)
Jul 20 22:48:42 pleco kernel: ip_conntrack (2047 buckets, 16376 max)
Jul 20 22:48:42 pleco kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Jul 20 22:48:42 pleco kernel: VFS: Mounted root (ext2 filesystem) readonly.
Jul 20 22:48:42 pleco kernel: Freeing unused kernel memory: 360k freed
Jul 20 22:48:42 pleco kernel: Adding Swap: 786760k swap-space (priority -1)
Jul 20 22:48:42 pleco kernel: via-rhine.c:v1.10-LK1.1.14  May-3-2002 Written by Donald Becker
Jul 20 22:48:42 pleco kernel:   http://www.scyld.com/network/via-rhine.html
Jul 20 22:48:42 pleco kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jul 20 22:48:42 pleco kernel: md: raid1 personality registered as nr 3
Jul 20 22:48:42 pleco kernel:  [events: 00000004]
Jul 20 22:48:42 pleco kernel:  [events: 00000004]
Jul 20 22:48:42 pleco kernel: md: autorun ...
Jul 20 22:48:42 pleco kernel: md: considering sdd1 ...
Jul 20 22:48:42 pleco kernel: md:  adding sdd1 ...
Jul 20 22:48:42 pleco kernel: md:  adding sdc1 ...
Jul 20 22:48:42 pleco kernel: md: created md0
Jul 20 22:48:42 pleco kernel: md: bind<sdc1,1>
Jul 20 22:48:42 pleco kernel: md: bind<sdd1,2>
Jul 20 22:48:42 pleco kernel: md: running: <sdd1><sdc1>
Jul 20 22:48:42 pleco kernel: md: sdd1's event counter: 00000004
Jul 20 22:48:42 pleco kernel: md: sdc1's event counter: 00000004
Jul 20 22:48:42 pleco kernel: md: RAID level 1 does not need chunksize! Continuing anyway.
Jul 20 22:48:42 pleco kernel: md0: max total readahead window set to 248k
Jul 20 22:48:42 pleco kernel: md0: 1 data-disks, max readahead per data-disk: 248k
Jul 20 22:48:42 pleco kernel: raid1: device sdd1 operational as mirror 1
Jul 20 22:48:42 pleco kernel: raid1: device sdc1 operational as mirror 0
Jul 20 22:48:42 pleco kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Jul 20 22:48:42 pleco kernel: md: updating md0 RAID superblock on device
Jul 20 22:48:42 pleco kernel: md: sdd1 [events: 00000005]<6>(write) sdd1's sb offset: 4440832
Jul 20 22:48:42 pleco kernel: md: sdc1 [events: 00000005]<6>(write) sdc1's sb offset: 4440832
Jul 20 22:48:42 pleco kernel: md: ... autorun DONE.
Jul 20 22:48:42 pleco lpd[192]: restarted

this far everything is fine, and server is up. when mke2fs /dev/md0 happens:

Jul 20 22:49:36 pleco kernel: pc = [<fffffffc002791cc>]  ra = [<fffffffc0027941c>]  ps = 0000    Not tainted
Jul 20 22:49:36 pleco kernel: v0 = 0000000000000008  t0 = 0000000000000000 t1 = 0000000000000006
Jul 20 22:49:36 pleco kernel: t2 = fffffc289f94c478  t3 = 0000000000000000 t4 = fffffc289f94c47c
Jul 20 22:49:36 pleco kernel: t5 = fffffc289f94c474  t6 = 0000000000000001 t7 = fffffc001e030000
Jul 20 22:49:36 pleco kernel: a0 = fffffc001f955000  a1 = fffffc001e0657a0 a2 = fffffc001e0657a0
Jul 20 22:49:36 pleco kernel: a3 = 0000000000000002  a4 = 0000000000000002 a5 = fffffc001f955018
Jul 20 22:49:36 pleco kernel: t8 = 0000000000000000  t9 = 000000287fff7480 t10= 0000000000000006
Jul 20 22:49:36 pleco kernel: t11= fffffc001f955020  pv = fffffffc00279240 at = fffffc001f95501c
Jul 20 22:49:36 pleco kernel: gp = fffffffc002845f0  sp = fffffc001e033c48
Jul 20 22:49:36 pleco kernel: pc = [<fffffc00004a0488>]  ra = [<fffffc0000342c60>]  ps = 0000    Not tainted
Jul 20 22:49:36 pleco kernel: v0 = 0000000000001b80  t0 = 0000000000000000 t1 = 0000000000000000
Jul 20 22:49:36 pleco kernel: t2 = 0000000000000000  t3 = 0000000000001b78 t4 = 000000000043c300
Jul 20 22:49:36 pleco kernel: t5 = fffffc001df4c480  t6 = 00000001200353c0 t7 = fffffc001e030000
Jul 20 22:49:36 pleco kernel: a0 = fffffc001df4e1a0  a1 = 0000000000000057 a2 = fffffc001df4e1a0
Jul 20 22:49:36 pleco kernel: a3 = 0000000000000001  a4 = fffffc000035ccc0 a5 = 000000011ffffc6c
Jul 20 22:49:36 pleco kernel: t8 = 0000000000002000  t9 = 000002000019f1d8 t10= 0000000000000008
Jul 20 22:49:36 pleco kernel: t11= 0000000000000001  pv = fffffc00004a0380 at = fffffc0000342c94
Jul 20 22:49:36 pleco kernel: gp = fffffc000057ddf0  sp = fffffc001e033e48
Jul 20 23:07:59 pleco syslogd 1.4.1#10: restart.

system crashed...
That all folks, could anybody help me. Please CC to me, samppa@mikrolahti.com.

--sl
