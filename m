Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133037AbRAVSfd>; Mon, 22 Jan 2001 13:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132981AbRAVSfW>; Mon, 22 Jan 2001 13:35:22 -0500
Received: from datafoundation.com ([209.150.125.194]:29194 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S132966AbRAVSfQ>; Mon, 22 Jan 2001 13:35:16 -0500
Date: Mon, 22 Jan 2001 13:35:15 -0500 (EST)
From: John Jasen <jjasen@datafoundation.com>
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org
Subject: PROBLEM: raid assembly on 2.4.0-2.4.1-pre9 fails
Message-ID: <Pine.LNX.4.21.0101221257350.6716-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:    

cannot assemble md devices under 2.4.x, x=0,1-pre7,1-pre9

[2.] Full description of the problem/report:

System: API UP2000 motherboard, running generic 2.4.0 to 2.4.1-pre9
kernel.

kernel .config file can be
found: http://userpages.umbc.edu/~jjasen1/config.241-p7.txt

error messages: <summarised> can be found:

http://userpages.umbc.edu/~jjasen1/boot-2.4.0-errs.txt and
boot-2.4.1-p7-errs.txt

[3.] Keywords:
kernel, filesystem, raid, alpha

[4.] Kernel version:

2.4.0, 2.4.1-pre7, 2.4.1-pre9

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
No Oops

[6.] A small shell script or example program which triggers the
     problem (if possible)
none

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)

version of kernel is incorrect to report problem. System cannot mount
drives under 2.4.0

Linux sneaky 2.2.17-RAID-IDE-NFS #5 Tue Nov 7 18:18:22 EST 2000 alpha
unknown
Kernel modules         2.3.19
Gnu C                  egcs-2.91.66
Gnu Make               3.78.1
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         lockd sunrpc de4x5 st

[7.2] CPU Info:
[root@sneaky /root]# more /proc/cpuinfo 
cpu                     : Alpha
cpu model               : EV67
cpu variation           : 7
cpu revision            : 0
cpu serial number       : 
system type             : Nautilus
system variation        : 0
system revision         : 0
system serial number    : 
cycle frequency [Hz]    : 598802395 
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 1191.18
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : SEC UP1100 598 MHz
cpus detected           : 1

[7.5]

[root@sneaky /root]# more /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5] 
read_ahead 1024 sectors
md0 : active raid5 hdd1[2] hdc1[1] hdb1[0] hda1[3] 1060096 blocks level 5,
32k c
hunk, algorithm 2 [3/3] [UUU]
md1 : active raid5 hdd3[2] hdc3[1] hdb3[0] hda3[3] 4208896 blocks level 5,
32k c
hunk, algorithm 2 [3/3] [UUU]
md2 : active raid5 hdd5[2] hdc5[1] hdb5[0] hda5[3] 4208768 blocks level 5,
32k c
hunk, algorithm 2 [3/3] [UUU]
md3 : active raid5 hdd6[2] hdc6[1] hdb6[0] hda6[3] 4208768 blocks level 5,
32k c
hunk, algorithm 2 [3/3] [UUU]
md4 : active raid5 hdd7[2] hdc7[1] hdb7[0] hda7[3] 1060096 blocks level 5,
32k c
hunk, algorithm 2 [3/3] [UUU]
unused devices: <none>

cat /etc/raidtab:

[root@sneaky /root]# more /etc/raidtab 
raiddev /dev/md0
        raid-level      5
        nr-raid-disks   3
        nr-spare-disks  1
        persistent-superblock   1
        parity-algorithm        left-symmetric
        chunk-size      32

        device  /dev/hdb1
        raid-disk       0
        device  /dev/hdc1
        raid-disk       1
        device  /dev/hdd1
        raid-disk       2
        device  /dev/hda1
        spare-disk      0

raiddev /dev/md1
        raid-level      5
        nr-raid-disks   3
        nr-spare-disks  1
        persistent-superblock   1
        parity-algorithm        left-symmetric
        chunk-size      32

        device  /dev/hdb3
        raid-disk       0
        device  /dev/hdc3
        raid-disk       1
        device  /dev/hdd3
        raid-disk       2
        device  /dev/hda3
        spare-disk      0

... and so forth.

[8.]

I seem to recall seeing an error just like this in the archives, under
-test5 or somesuch, but of course, can't find it now.

-- John Jasen




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
