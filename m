Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131213AbQKUUWh>; Tue, 21 Nov 2000 15:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131017AbQKUUW0>; Tue, 21 Nov 2000 15:22:26 -0500
Received: from net128-053.mclink.it ([195.110.128.53]:26561 "EHLO
	mail.mclink.it") by vger.kernel.org with ESMTP id <S131213AbQKUUWN>;
	Tue, 21 Nov 2000 15:22:13 -0500
From: "CMA" <cma@mclink.it>
To: <tytso@mit.edu>, <card@masi.ibp.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: e2fs performance as function of block size
Date: Tue, 21 Nov 2000 20:46:21 +0100
Message-ID: <000001c053f4$7e7fbc40$65000a0a@cma.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sirs,
performing extensive tests on linux platform performance, optimized as
database server, I got IMHO confusing results:
in particular e2fs initialized to use 1024 block/fragment size showed
significant I/O gains over 4096 block/fragment size, while I expected the
opposite. I would appreciate some hints to understand this.
The test performed was a c-isam index rebuild for a large table (more than
300000 tuples, over 80 megs for data and 90 megs for indexes).
Disk configurations were just cloned (no fragmentation).
Optimal (for the specific purpose) hdparm and bdflush tuning were applied
and tests run in single user mode.
This behaviour was consistent through a broad range of kernel releases (up
to 2.2.17) and h/w configurations.
Please find attached info and test results for a reference platform.
BTW, similar tests running interbase 4.0 DB load showed > 4x performance
over a fully tuned Win NT 4 config (same platform) ;-)
Regards

Dr. Eng. Mauro Tassinari
Rome, Italy
mtassinari@libero.it




dmesg

Linux version 2.2.6 (root@zap) (gcc version 2.7.2.3) #20 Tue Apr 27 15:23:25
CDT 1999
Detected 736483166 Hz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 734.00 BogoMIPS
Memory: 127708k/130944k available (1204k kernel code, 408k reserved, 1568k
data, 56k init)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Intel 00/08 stepping 03
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.26 (19981001) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xf08f0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
Initializing RT netlink socket
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
Serial driver version 4.27 with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:DMA
hda: QUANTUM FIREBALLlct15 20, ATA DISK drive
hdd: ATAPI-CD ROM-DRIVE-50MAX, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: QUANTUM FIREBALLlct15 20, 19470MB w/418kB Cache, CHS=2482/255/63
hdd: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CDROM driver Revision: 2.54
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
linear personality registered
raid0 personality registered
scsi : 0 hosts.
scsi : detected total.
Partition check:
 hda: hda1 hda2 hda3
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 56k freed
Adding Swap: 136516k swap-space (priority -1)
parport0: PC-style at 0x378 [SPP,PS2,EPP]
lp0: using parport0 (polling).
CSLIP: code copyright 1989 Regents of the University of California
SLIP: version 0.8.4-NET3.019-NEWTTY-MODULAR (dynamic channels, max=256).
SLIP linefill/keepalive option.
PPP: version 2.3.3 (demand dialling)
PPP line discipline registered.
es1371: version v0.11 time 23:59:18 Apr 28 1999
es1371: found adapter at io 0xa800 irq 5
es1371: features: joystick 0x0
es1371: codec vendor ƒ„v revision 9
es1371: codec features 18bit DAC 18bit ADC
es1371: stereo enhancement: unknown
rtl8139.c:v1.07 5/6/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/rtl8139.html
eth0: RealTek RTL8139 Fast Ethernet at 0xa400, IRQ 10, 00:60:52:0b:ce:a4.
st: bufsize 32768, wrt 30720, max buffers 4, s/g segs 16.
scsi : 0 hosts.
Linux PCMCIA Card Services 3.0.9
  kernel build: 2.2.6 #20 Sat Apr 17 23:17:12 CDT 1999
  options:  [pci] [cardbus]
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
ds: no socket drivers loaded!






rc.local

#!/bin/sh
#
# /etc/rc.d/rc.local:  Local system initialization script.
 (...skipped...)
hdparm -a16A1c1d1k1K1m16u1W1 /dev/hda
# tune buffer cache parameters
bdflush -0 100 -1 5000 -2 2000 -3 32 -5 12000 -d
# start xdm daemon
 (...skipped...)






test 1024 block/fragment size

BCHECK  C-ISAM B-tree Checker version 1.07
Copyright (C) 1981-1989 Informix Software, Inc.


C-ISAM Files: prod

Checking dictionary and file sizes.
index file node size = 1024
current C-ISAM index node size = 1024
Checking data file records.
Checking indexes and key descriptions.
 (...skipped...)
Recreating data record free list.
Recreating index 10.
Recreating index 9.
Recreating index 8.
Recreating index 7.
Recreating index 6.
Recreating index 5.
Recreating index 4.
Recreating index 3.
Recreating index 2.
Recreating index 1.
12 index node(s) used, 0 free --349724 data record(s) used, 4 free


        Command being timed: "bcheck -y prod"
        User time (seconds): 69.32
        System time (seconds): 25.15
        Percent of CPU this job got: 54%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 2:54.14
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 43861
        Minor (reclaiming a frame) page faults: 207
        Voluntary context switches: 0
        Involuntary context switches: 0
        Swaps: 95
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0





test 4096 block/fragment size

BCHECK  C-ISAM B-tree Checker version 1.07
Copyright (C) 1981-1989 Informix Software, Inc.


C-ISAM Files: prod

Checking dictionary and file sizes.
index file node size = 1024
current C-ISAM index node size = 1024
Checking data file records.
Checking indexes and key descriptions.
 (...skipped...)
Recreating data record free list.
Recreating index 10.
Recreating index 9.
Recreating index 8.
Recreating index 7.
Recreating index 6.
Recreating index 5.
Recreating index 4.
Recreating index 3.
Recreating index 2.
Recreating index 1.
12 index node(s) used, 0 free --349724 data record(s) used, 4 free


        Command being timed: "bcheck -y prod"
        User time (seconds): 68.43
        System time (seconds): 24.79
        Percent of CPU this job got: 39%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 3:54.87
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 41944
        Minor (reclaiming a frame) page faults: 239
        Voluntary context switches: 0
        Involuntary context switches: 0
        Swaps: 32
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
