Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRHRXX4>; Sat, 18 Aug 2001 19:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269391AbRHRXXq>; Sat, 18 Aug 2001 19:23:46 -0400
Received: from Expansa.sns.it ([192.167.206.189]:21510 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S269326AbRHRXXd>;
	Sat, 18 Aug 2001 19:23:33 -0400
Date: Sun, 19 Aug 2001 01:23:47 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <linux-kernel@vger.kernel.org>
Subject: disk I/O slower with kernel 2.4.9 
Message-ID: <Pine.LNX.4.33.0108190037070.1823-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
I was just starting to test eavily linux 2.4.9 if i can use it in a
production environment.
The platform target i am considering is the x86 family processor (Mostly
AMD Athlon), with no more than 512 MByte RAM and scsi disks.

The first thing i noticed is that, while  context switch performances
has improoved a lot, disk I/O is mutch slower. This is true for both ext2
and reiserFS, but maybe reiserFS is suffering the effects a little more
than ext2.
That can be even felt by a normal user, just doing a cp of a directory
containing a lot of small files.

That also has big impacts with normal compilations.
just making time make -j 2 bzImage with kernel source 2.4.9
gives me:

real    3m36.041s
user    2m2.950s
sys     0m9.740s

while compiling the same sources running kernel 2.4.7 gives:

real    2m28.350s
user    1m56.150s
sys     0m5.262s

Every single operation that has to do with read and write activities
on disks is simply slower.

That has big repercussion with uses like NFS server, and web server
with khttpd as primary server and apache as the secondary one.

Even more affected are mysql performances and everything relates to FS
speed.

The test machine is a AMD Athlon 1300 Mhz, 200 FSB, with 256 Mbyte RAM
133 Mhz and an adaptec 2940 UW2 with two seagate scsi 3 disks. Mother
board is an abit KT7A-RAID (KT133 VT82C686 chipsets) but i am not using
any ATA disk.

kernel is compiled for athlon, gcc 2.95.3, binutils 2.11.90.0.27

This should not be a problem related to a via since the server has always
been stable with all 2.4.X kernels compiled for athlon, with mtrr and
3dnow enabled, and all bios settings setted to maximize performances.
The AIC7XXX adaptec driver i compied statically inside of the kernel is
the new one, with firware rebuild enabled,
253 tag queues, and 5000m sec for reset.

To be sure i made some tests also on a k6 II, and on a PIII 450 with the
same adaptec, the same memory amount (just dimm are 100 Mhz instead of 133
Mhz), and same kernel configuration just using respectivelly k6 and PIII
optimizzations. Results are the same.

I know i should make some comparative test beetwen 2.4.7 and 2.4.9 using
another scsi card (like a symbios or busloginc) or with some EIDE and ATA
disks, but actually i do not have a server available for those tests with
different HW. SO i made my tests also on a SUN ULTRA5, with one ultrasparc
processor running at 400 Mhz, and 512 MByte of RAM. The ultra5 disk is
simply an ATA66, but it runs as a standard EIDE at 33 Mhz. I could just
test ext2, because i have never been able to run an mkreiserFS on
this platform. DISK I/O is slower with 2.4.9 also with ultrasparc
processor, but I have to admitt that the difference is not so niticeable,
49 minutes to compile the kernel in front of 43...

I read many posts about 2.4.8 slowdown as NFS server, and i think this
could be a case of what i noticed.

Hope this helps
Luigi


