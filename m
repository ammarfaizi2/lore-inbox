Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284737AbRLPRrC>; Sun, 16 Dec 2001 12:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284745AbRLPRqy>; Sun, 16 Dec 2001 12:46:54 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:17208 "EHLO
	tsmtp6.mail.isp") by vger.kernel.org with ESMTP id <S284737AbRLPRqi>;
	Sun, 16 Dec 2001 12:46:38 -0500
Date: Sun, 16 Dec 2001 18:48:36 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011216184836.A418@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
	I've boot up my linux box (2.4.17-rc1). I was readin the lkml when
I tried to mount my vfat partition on /win to listen mp3. (as a normal
user, of course). But  I couldn't mount it. Reason?:
	ls: mtab: permission denied
Then I log as root, but ls -l /etc/mtab said:
	ls: mtab: permission denied
any chmod in /etc/mtab: (as root)
	chmod: getting attributes of mtab: Permission denied
/etc/mtab is a reiserfs partition.

After this, the filesystem started to fail a lot in all other programs
Here is /var/log/messages. As you'll see, I tried to boot another time with
2.4.5-pre10 (This was my fault, I boot unstable kernels in another
partition,
where I'm running now and where I tried to run reiserfsck). I'll paste
bootup messages, too. I think I did a very,very hard reboot before this,
i'm not sure (shutting it down the power, without syncing)

---------------------------------------------------
Dec 16 16:54:41 diego kernel: Linux version 2.4.17-rc1 (root@diego) (gcc
version 2.95.4 20011006 (Debian prerelease)) #1 Fri Dec 14 00:37:21 CET
2001
Dec 16 16:54:41 diego kernel: BIOS-provided physical RAM map:
Dec 16 16:54:41 diego kernel:  BIOS-e820: 0000000000000000 -
00000000000a0000 (usable)
Dec 16 16:54:41 diego kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Dec 16 16:54:41 diego kernel:  BIOS-e820: 0000000000100000 -
0000000002000000 (usable)
Dec 16 16:54:41 diego kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Dec 16 16:54:41 diego kernel: On node 0 totalpages: 8192
Dec 16 16:54:41 diego kernel: zone(0): 4096 pages.
Dec 16 16:54:41 diego kernel: zone(1): 4096 pages.
Dec 16 16:54:41 diego kernel: zone(2): 0 pages.
Dec 16 16:54:41 diego kernel: Kernel command line: ro root=/dev/hdc5
vga=0x30a 
Dec 16 16:54:41 diego kernel: Initializing CPU#0
Dec 16 16:54:41 diego kernel: Detected 200.454 MHz processor.
Dec 16 16:54:41 diego kernel: Console: colour VGA+ 132x43
Dec 16 16:54:41 diego kernel: Calibrating delay loop... 399.76 BogoMIPS
Dec 16 16:54:41 diego kernel: Memory: 30444k/32768k available (807k kernel
code, 1940k reserved, 193k data, 180k init, 0k highmem)
Dec 16 16:54:41 diego kernel: Checking if this processor honours the WP bit
even in supervisor mode... Ok.
Dec 16 16:54:41 diego kernel: Dentry-cache hash table entries: 4096 (order:
3, 32768 bytes)
Dec 16 16:54:41 diego kernel: Inode-cache hash table entries: 2048 (order:
2, 16384 bytes)
Dec 16 16:54:41 diego kernel: Mount-cache hash table entries: 512 (order:
0, 4096 bytes)
Dec 16 16:54:41 diego kernel: Buffer-cache hash table entries: 1024 (order:
0, 4096 bytes)
Dec 16 16:54:41 diego kernel: Page-cache hash table entries: 8192 (order:
3, 32768 bytes)
Dec 16 16:54:41 diego kernel: CPU: Cyrix 6x86MX 3x Core/Bus Clock stepping
07
Dec 16 16:54:41 diego kernel: Checking 'hlt' instruction... OK.
Dec 16 16:54:41 diego kernel: POSIX conformance testing by UNIFIX
Dec 16 16:54:41 diego kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Dec 16 16:54:41 diego kernel: mtrr: detected mtrr type: Cyrix ARR
Dec 16 16:54:41 diego kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb3b0,
last bus=0
Dec 16 16:54:41 diego kernel: PCI: Using configuration type 1
Dec 16 16:54:41 diego kernel: PCI: Probing PCI hardware
Dec 16 16:54:41 diego kernel: Linux NET4.0 for Linux 2.4
Dec 16 16:54:41 diego kernel: Based upon Swansea University Computer
Society NET3.039
Dec 16 16:54:41 diego kernel: Initializing RT netlink socket
Dec 16 16:54:41 diego kernel: Starting kswapd
Dec 16 16:54:41 diego kernel: pty: 256 Unix98 ptys configured
Dec 16 16:54:41 diego kernel: block: 64 slots per queue, batch=16
Dec 16 16:54:41 diego kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
Dec 16 16:54:41 diego kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Dec 16 16:54:41 diego kernel: SIS5513: IDE controller on PCI bus 00 dev 09
Dec 16 16:54:41 diego kernel: SIS5513: chipset revision 193
Dec 16 16:54:41 diego kernel: SIS5513: not 100%% native mode: will probe
irqs later
Dec 16 16:54:41 diego kernel:     ide0: BM-DMA at 0x1000-0x1007, BIOS
settings: hda:pio, hdb:pio
Dec 16 16:54:41 diego kernel:     ide1: BM-DMA at 0x1008-0x100f, BIOS
settings: hdc:pio, hdd:pio
Dec 16 16:54:41 diego kernel: hda: ST32122A, ATA DISK drive
Dec 16 16:54:41 diego kernel: hdb: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM
drive
Dec 16 16:54:41 diego kernel: hdc: ST340016A, ATA DISK drive
Dec 16 16:54:41 diego kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 16 16:54:41 diego kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 16 16:54:41 diego kernel: hda: 4124736 sectors (2112 MB) w/128KiB
Cache, CHS=1023/64/63
Dec 16 16:54:41 diego kernel: hdc: 78165360 sectors (40021 MB) w/2048KiB
Cache, CHS=77545/16/63
Dec 16 16:54:41 diego kernel: Partition check:
Dec 16 16:54:41 diego kernel:  hda: hda1 hda2
Dec 16 16:54:41 diego kernel:  hdc: [DM6:DDO] [remap +63] [4865/255/63]
hdc1 < hdc5 hdc6 > hdc2
Dec 16 16:54:41 diego kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 16 16:54:41 diego kernel: IP Protocols: ICMP, UDP, TCP
Dec 16 16:54:41 diego kernel: IP: routing cache hash table of 512 buckets,
4Kbytes
Dec 16 16:54:41 diego kernel: TCP: Hash tables configured (established 2048
bind 2048)
Dec 16 16:54:41 diego kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Dec 16 16:54:41 diego kernel: reiserfs: checking transaction log (device
16:05) ...
Dec 16 16:54:41 diego kernel: Using r5 hash to sort names
Dec 16 16:54:41 diego kernel: ReiserFS version 3.6.25
Dec 16 16:54:41 diego kernel: VFS: Mounted root (reiserfs filesystem)
readonly.
Dec 16 16:54:41 diego kernel: Freeing unused kernel memory: 180k freed
Dec 16 16:54:41 diego kernel: Adding Swap: 96352k swap-space (priority -1)
Dec 16 16:54:41 diego kernel: Real Time Clock Driver v1.10e
Dec 16 16:54:41 diego kernel: Serial driver version 5.05c (2001-07-08) with
MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Dec 16 16:54:41 diego kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec 16 16:54:41 diego kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Dec 16 16:54:41 diego kernel: ttyS03 at 0x02e8 (irq = 3) is a 16550A
Dec 16 16:54:45 diego kernel: parport0: PC-style at 0x378 [PCSPP]
Dec 16 16:54:45 diego kernel: lp0: using parport0 (polling).
Dec 16 16:54:45 diego kernel: lp0: compatibility mode
Dec 16 16:54:45 diego last message repeated 2 times
Dec 16 16:54:59 diego kernel: CSLIP: code copyright 1989 Regents of the
University of California
Dec 16 16:54:59 diego kernel: PPP generic driver version 2.4.1
Dec 16 16:55:19 diego kernel: [drm] Initialized tdfx 1.0.0 20010216 on
minor 0
Dec 16 16:54:59 diego pppd[259]: pppd 2.4.1 started by root, uid 0
<pppd dialing>
Dec 16 17:14:40 diego -- MARK --
Dec 16 17:34:40 diego -- MARK --
Dec 16 17:40:40 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:40:40 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:40:40 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68669 0x0 SD]
Dec 16 17:40:40 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:40:40 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:40:40 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68669 0x0 SD]
Dec 16 17:40:41 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:40:41 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:40:41 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68669 0x0 SD]
Dec 16 17:40:45 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:40:45 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:40:45 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68669 0x0 SD]
Dec 16 17:40:47 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:40:47 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:40:47 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68669 0x0 SD]
Dec 16 17:40:55 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:40:55 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:40:55 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68669 0x0 SD]
Dec 16 17:41:28 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:41:28 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:41:28 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68722 0x0 SD]
Dec 16 17:41:28 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:41:28 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:41:28 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 64508 0x0 SD]
Dec 16 17:41:28 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:41:28 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:41:28 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 63049 0x0 SD]
Dec 16 17:41:28 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:41:28 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:41:28 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68673 0x0 SD]
Dec 16 17:41:28 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:41:28 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:41:28 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68377 0x0 SD]
Dec 16 17:41:36 diego kernel: SysRq : Emergency Sync
Dec 16 17:41:36 diego kernel: Syncing device 16:05 ... OK
Dec 16 17:41:36 diego kernel: Done.
Dec 16 17:41:45 diego kernel: SysRq : HELP : loglevel0-8 reBoot tErm kIll
saK killalL showMem showPc unRaw Sync showTasks Unmount 
Dec 16 17:42:43 diego syslogd 1.4.1#8: restart.
Dec 16 17:42:43 diego kernel: klogd 1.4.1#8, log source = /proc/kmsg
started.
Dec 16 17:42:43 diego kernel: Cannot find map file. 
Dec 16 17:42:43 diego kernel: Loaded 5 symbols from 1 module.
Dec 16 17:42:43 diego kernel: Linux version 2.5.1-pre10 (root@diego) (gcc
version 2.95.4 20011006 (Debian prerelease)) #1 Tue Dec 11 21:20:18 CET
2001
Dec 16 17:42:43 diego kernel: BIOS-provided physical RAM map:
Dec 16 17:42:43 diego kernel:  BIOS-e820: 0000000000000000 -
00000000000a0000 (usable)
Dec 16 17:42:43 diego kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Dec 16 17:42:43 diego kernel:  BIOS-e820: 0000000000100000 -
0000000002000000 (usable)
Dec 16 17:42:43 diego kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Dec 16 17:42:43 diego kernel: On node 0 totalpages: 8192
Dec 16 17:42:43 diego kernel: zone(0): 4096 pages.
Dec 16 17:42:43 diego kernel: zone(1): 4096 pages.
Dec 16 17:42:43 diego kernel: zone(2): 0 pages.
Dec 16 17:42:43 diego kernel: Initializing CPU#0
Dec 16 17:42:43 diego kernel: Detected 200.457 MHz processor.
Dec 16 17:42:43 diego kernel: Console: colour VGA+ 132x43
Dec 16 17:42:43 diego kernel: Calibrating delay loop... 399.76 BogoMIPS
Dec 16 17:42:43 diego kernel: Memory: 30440k/32768k available (801k kernel
code, 1944k reserved, 192k data, 180k init, 0k highmem)
Dec 16 17:42:43 diego kernel: Checking if this processor honours the WP bit
even in supervisor mode... Ok.
Dec 16 17:42:43 diego kernel: Dentry-cache hash table entries: 4096 (order:
3, 32768 bytes)
Dec 16 17:42:43 diego kernel: Inode-cache hash table entries: 2048 (order:
2, 16384 bytes)
Dec 16 17:42:43 diego kernel: Mount-cache hash table entries: 512 (order:
0, 4096 bytes)
Dec 16 17:42:43 diego kernel: Buffer-cache hash table entries: 1024 (order:
0, 4096 bytes)
Dec 16 17:42:43 diego kernel: Page-cache hash table entries: 8192 (order:
3, 32768 bytes)
Dec 16 17:42:43 diego kernel: CPU: Cyrix 6x86MX 3x Core/Bus Clock stepping
07
Dec 16 17:42:43 diego kernel: Checking 'hlt' instruction... OK.
Dec 16 17:42:43 diego kernel: POSIX conformance testing by UNIFIX
Dec 16 17:42:43 diego kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Dec 16 17:42:43 diego kernel: mtrr: detected mtrr type: Cyrix ARR
Dec 16 17:42:43 diego kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb3b0,
last bus=0
Dec 16 17:42:43 diego kernel: PCI: Using configuration type 1
Dec 16 17:42:43 diego kernel: PCI: Probing PCI hardware
Dec 16 17:42:43 diego kernel: Linux NET4.0 for Linux 2.4
Dec 16 17:42:43 diego kernel: Based upon Swansea University Computer
Society NET3.039
Dec 16 17:42:43 diego kernel: Starting kswapd
Dec 16 17:42:43 diego kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Dec 16 17:42:43 diego kernel: biovec: init pool 0, 1 entries, 12 bytes
Dec 16 17:42:43 diego kernel: biovec: init pool 1, 4 entries, 48 bytes
Dec 16 17:42:43 diego kernel: biovec: init pool 2, 16 entries, 192 bytes
Dec 16 17:42:43 diego kernel: biovec: init pool 3, 64 entries, 768 bytes
Dec 16 17:42:43 diego kernel: biovec: init pool 4, 128 entries, 1536 bytes
Dec 16 17:42:43 diego kernel: biovec: init pool 5, 256 entries, 3072 bytes
Dec 16 17:42:43 diego kernel: pty: 256 Unix98 ptys configured
Dec 16 17:42:43 diego kernel: block: 64 slots per queue, batch=16
Dec 16 17:42:43 diego kernel: Uniform Multi-Platform E-IDE driver Revision:
6.32
Dec 16 16:54:41 diego kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Dec 16 17:42:43 diego kernel: SIS5513: IDE controller on PCI slot 00:01.1
Dec 16 17:42:43 diego kernel: SIS5513: chipset revision 193
Dec 16 17:42:43 diego kernel: SIS5513: not 100%% native mode: will probe
irqs later
Dec 16 17:42:43 diego kernel:     ide0: BM-DMA at 0x1000-0x1007, BIOS
settings: hda:pio, hdb:pio
Dec 16 17:42:43 diego kernel:     ide1: BM-DMA at 0x1008-0x100f, BIOS
settings: hdc:pio, hdd:pio
Dec 16 17:42:43 diego kernel: hda: ST32122A, ATA DISK drive
Dec 16 17:42:43 diego kernel: hdb: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM
drive
Dec 16 17:42:43 diego kernel: hdc: ST340016A, ATA DISK drive
Dec 16 17:42:43 diego kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 16 17:42:43 diego kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 16 17:42:43 diego kernel: hda: 4124736 sectors (2112 MB) w/128KiB
Cache, CHS=1023/64/63
Dec 16 17:42:43 diego kernel: hdc: 78165360 sectors (40021 MB) w/2048KiB
Cache, CHS=77545/16/63
Dec 16 17:42:43 diego kernel: Partition check:
Dec 16 17:42:43 diego kernel:  hda: hda1 hda2
Dec 16 17:42:43 diego kernel:  hdc: [DM6:DDO] [remap +63] [4865/255/63]
hdc1 < hdc5 hdc6 > hdc2
Dec 16 17:42:43 diego kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 16 17:42:43 diego kernel: IP Protocols: ICMP, UDP, TCP
Dec 16 17:42:43 diego kernel: IP: routing cache hash table of 512 buckets,
4Kbytes
Dec 16 17:42:43 diego kernel: TCP: Hash tables configured (established 2048
bind 2048)
Dec 16 17:42:43 diego kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Dec 16 17:42:43 diego kernel: reiserfs: checking transaction log (device
16:05) ...
Dec 16 17:42:43 diego kernel: Using r5 hash to sort names
Dec 16 17:42:43 diego kernel: ReiserFS version 3.6.25
Dec 16 17:42:43 diego kernel: VFS: Mounted root (reiserfs filesystem)
readonly.
Dec 16 17:42:43 diego kernel: Freeing unused kernel memory: 180k freed
Dec 16 17:42:43 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:42:43 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:42:43 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68669 0x0 SD]
Dec 16 17:42:43 diego kernel: Adding Swap: 96352k swap-space (priority -1)
Dec 16 17:42:43 diego kernel: Real Time Clock Driver v1.10e
Dec 16 17:42:43 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:42:43 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:42:43 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68673 0x0 SD]
Dec 16 17:42:47 diego /usr/sbin/gpm[247]: Removing stale pid file
/var/run/gpm.pid
Dec 16 17:42:48 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 16 17:42:48 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 16 17:42:48 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 63049 0x0 SD]
Dec 16 17:42:48 diego kernel: Kernel logging (proc) stopped.

I did a Sysrq + sync and sysrq + reboot, I've tried to 
do fsck, but:


<-------------reiserfsck, 2001------------->
reiserfsprogs 3.x.0j

Will read-only check consistency of the partition
Will put log info to 'stderr'
Do you want to run this program?[N/Yes] (note you need to type Yes):Yes
Analyzing journal..nothing to replay (no transactions older than last
flushed one found)
Fetching on-disc bitmap..done
Checking S+tree../ 1 (of    2)/  3 (of 110)/ 15 (of 149)node (10667) with
wrong level (18771) found in the tree (should be 1)
Segmentation fault.

Last version of reiserfsprogs fix this?

Now, I see that when I run ls /mnt/etc as root I get several file
permissions error:
ls: /mnt/etc/rpc: Permission denied
ls: /mnt/etc/mtab: Permission denied
ls: /mnt/etc/t1lib: Permission denied
ls: /mnt/etc/hotplug: Permission denied
ls: /mnt/etc/serial.conf: Permission denied
ls: /mnt/etc/sprucesig: Permission denied

and kernel:

is_tree_node: node level 18771 does not match to the expected one 1
vs-5150: search_by_key: invalid format found in block 10667. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
data of [4160 68722 0x0 SD]
is_tree_node: node level 18771 does not match to the expected one 1
vs-5150: search_by_key: invalid format found in block 10667. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
data of [4160 68669 0x0 SD]
is_tree_node: node level 18771 does not match to the expected one 1
vs-5150: search_by_key: invalid format found in block 10667. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
data of [4160 64508 0x0 SD]
is_tree_node: node level 18771 does not match to the expected one 1
vs-5150: search_by_key: invalid format found in block 10667. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
data of [4160 63049 0x0 SD]
is_tree_node: node level 18771 does not match to the expected one 1
vs-5150: search_by_key: invalid format found in block 10667. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
data of [4160 68673 0x0 SD]
is_tree_node: node level 18771 does not match to the expected one 1
vs-5150: search_by_key: invalid format found in block 10667. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
data of [4160 68377 0x0 SD]


Perhaps this can be fixed with reiserfsprogs last version, but I think that
this should never happen
in journaling filesystem (or it should be very difficult, it shouldn't
happen in a normal 200mhz box)

I'll send any information about my computer, if you need. 


