Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTJXWFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTJXWFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:05:50 -0400
Received: from home.nightdaughter.de ([194.95.224.141]:64008 "EHLO
	a141.shuttle.de") by vger.kernel.org with ESMTP id S262669AbTJXWFj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:05:39 -0400
Date: Sat, 25 Oct 2003 00:06:15 +0200
From: Joerg Hoh <joerg@devone.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.22: md on Alpha, RAID1
Message-ID: <20031024220615.GB3573@hydra.joerghoh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have a Alpha EV56 System (Noritake-Primo), running a raid1 on 2
scsi-harddrives:

Oct 24 23:43:01 zyklop kernel:   Vendor: DEC       Model: RZ1CB-CS (C) DEC  Rev: 0656
Oct 24 23:43:01 zyklop kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Oct 24 23:43:01 zyklop kernel:   Vendor: DEC       Model: RZ1CB-CS (C) DEC  Rev: 0844
Oct 24 23:43:01 zyklop kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02

The md-drivers comes up well

Oct 24 23:43:01 zyklop kernel: md: raid1 personality registered as nr 3
Oct 24 23:43:01 zyklop kernel: md: raid5 personality registered as nr 4
Oct 24 23:43:01 zyklop kernel: raid5: measuring checksumming speed
Oct 24 23:43:01 zyklop kernel:    8regs     :   376.832 MB/sec
Oct 24 23:43:01 zyklop kernel:    32regs    :   638.976 MB/sec
Oct 24 23:43:01 zyklop kernel:    alpha     :   688.128 MB/sec
Oct 24 23:43:01 zyklop kernel:    alpha prefetch:   598.016 MB/sec
Oct 24 23:43:01 zyklop kernel: raid5: using function: alpha (688.128 MB/sec)
Oct 24 23:43:01 zyklop kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Oct 24 23:43:01 zyklop kernel: md: Autodetecting RAID arrays.
Oct 24 23:43:01 zyklop kernel: md: autorun ...
Oct 24 23:43:01 zyklop kernel: md: ... autorun DONE.

but it then begins to complain (I've made a hard shutdown without first
umounting the partitions):

Oct 24 23:43:01 zyklop kernel:  [events: 00000021]
Oct 24 23:43:01 zyklop kernel:  [events: 00000022]
Oct 24 23:43:01 zyklop kernel: md: autorun ...
Oct 24 23:43:01 zyklop kernel: md: considering sdc1 ...
Oct 24 23:43:01 zyklop kernel: md:  adding sdc1 ...
Oct 24 23:43:01 zyklop kernel: md:  adding sdb1 ...
Oct 24 23:43:01 zyklop kernel: md: created md0
Oct 24 23:43:01 zyklop kernel: md: bind<sdb1,1>
Oct 24 23:43:01 zyklop kernel: md: bind<sdc1,2>
Oct 24 23:43:01 zyklop kernel: md: running: <sdc1><sdb1>
Oct 24 23:43:01 zyklop kernel: md: sdc1's event counter: 00000022
Oct 24 23:43:01 zyklop kernel: md: sdb1's event counter: 00000021
Oct 24 23:43:01 zyklop kernel: md: freshest: sdc1
Oct 24 23:43:01 zyklop kernel: md0: removing former faulty sdb1!
Oct 24 23:43:01 zyklop kernel: md: RAID level 1 does not need chunksize! Continuing anyway.
Oct 24 23:43:01 zyklop kernel: md0: max total readahead window set to 248k
Oct 24 23:43:01 zyklop kernel: md0: 1 data-disks, max readahead per data-disk: 248k
Oct 24 23:43:01 zyklop kernel: raid1: device sdc1 operational as mirror 1
Oct 24 23:43:01 zyklop kernel: raid1: spare disk sdb1
Oct 24 23:43:01 zyklop kernel: raid1: raid set md0 active with 1 out of 2 mirrors
Oct 24 23:43:01 zyklop kernel: md: bug in file md.c, line 986
Oct 24 23:43:01 zyklop kernel:
Oct 24 23:43:01 zyklop kernel: md:^I**********************************
Oct 24 23:43:01 zyklop kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
Oct 24 23:43:01 zyklop kernel: md:^I**********************************
Oct 24 23:43:01 zyklop kernel: md0: <sdc1><sdb1> array superblock:
Oct 24 23:43:01 zyklop kernel: md:  SB: (V:0.90.0) ID:<f90cc42f.ece4fdac.fb1c4bae.6739380d> CT:3ee8ce2d
Oct 24 23:43:01 zyklop kernel: md:     L1 S04184832 ND:1 RD:2 md0 LO:0 CS:4096
Oct 24 23:43:01 zyklop kernel: md:     UT:3f999ce0 ST:0 AD:1 WD:1 FD:0 SD:0 CSUM:00005a08 E:00000023
Oct 24 23:43:01 zyklop kernel:      D  0:  DISK<N:0,[dev 00:00](0,0),R:0,S:8>
Oct 24 23:43:01 zyklop kernel:      D  1:  DISK<N:1,sdc1(8,33),R:1,S:6>
Oct 24 23:43:01 zyklop kernel:      D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
Oct 24 23:43:01 zyklop kernel: md:     THIS:  DISK<N:1,sdc1(8,33),R:1,S:6>
Oct 24 23:43:01 zyklop kernel: md: rdev sdc1: O:sdc1, SZ:04184832 F:0 DN:1 <6>md: rdev superblock:
Oct 24 23:43:01 zyklop kernel: md:  SB: (V:0.90.0) ID:<f90cc42f.ece4fdac.fb1c4bae.6739380d> CT:3ee8ce2d
Oct 24 23:43:01 zyklop kernel: md:     L1 S04184832 ND:1 RD:2 md0 LO:0 CS:4096
Oct 24 23:43:01 zyklop kernel: md:     UT:3f999ce0 ST:0 AD:1 WD:1 FD:0 SD:0 CSUM:00005bf4 E:00000023
Oct 24 23:43:01 zyklop kernel:      D  0:  DISK<N:0,[dev 00:00](0,0),R:0,S:8>
Oct 24 23:43:01 zyklop kernel:      D  1:  DISK<N:1,sdc1(8,33),R:1,S:6>
Oct 24 23:43:01 zyklop kernel:      D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
Oct 24 23:43:01 zyklop kernel: md:     THIS:  DISK<N:1,sdc1(8,33),R:1,S:6>
Oct 24 23:43:01 zyklop kernel: md: rdev sdb1: O:sdb1, SZ:04184832 F:0 DN:0 <6>md: rdev superblock:
Oct 24 23:43:01 zyklop kernel: md:  SB: (V:0.90.0) ID:<f90cc42f.ece4fdac.fb1c4bae.6739380d> CT:3ee8ce2d
Oct 24 23:43:01 zyklop kernel: md:     L1 S04184832 ND:1 RD:2 md0 LO:0 CS:4096
Oct 24 23:43:01 zyklop kernel: md:     UT:3f999ce0 ST:0 AD:1 WD:1 FD:0 SD:0 CSUM:00005a08 E:00000023
Oct 24 23:43:01 zyklop kernel:      D  0:  DISK<N:0,[dev 00:00](0,0),R:0,S:8>
Oct 24 23:43:01 zyklop kernel:      D  1:  DISK<N:1,sdc1(8,33),R:1,S:6>
Oct 24 23:43:01 zyklop kernel:      D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:9>
Oct 24 23:43:01 zyklop kernel: md:     THIS:  DISK<N:1,sdc1(8,33),R:1,S:6>
Oct 24 23:43:01 zyklop kernel: md:^I**********************************
Oct 24 23:43:01 zyklop kernel:
Oct 24 23:43:01 zyklop kernel: md: updating md0 RAID superblock on device
Oct 24 23:43:01 zyklop kernel: md: sdc1 [events: 00000023]<6>(write) sdc1's sb offset: 4184832
Oct 24 23:43:01 zyklop kernel: md: recovery thread got woken up ...
Oct 24 23:43:01 zyklop kernel: md: recovery thread finished ...
Oct 24 23:43:01 zyklop kernel: md: sdb1 [events: 00000023]<6>(write) sdb1's sb offset: 4184832
Oct 24 23:43:01 zyklop kernel: md: ... autorun DONE.
Oct 24 23:43:01 zyklop kernel: mount(89): Oops 0
Oct 24 23:43:01 zyklop kernel: pc = [raid1_read_balance+384/512]  ra = [raid1_make_request+484/1248]  ps = 0000    Not tainted
Oct 24 23:43:01 zyklop kernel: v0 = 0000000000000002  t0 = 0000000000000000  t1 = 000000000000000e
Oct 24 23:43:01 zyklop kernel: t2 = ffff6c0489ad501c  t3 = 0000000000000001  t4 = ffff6c0489ad4ffc
Oct 24 23:43:01 zyklop kernel: t5 = ffff6c0489ad4ff4  t6 = 0000000000000002  t7 = fffffc001f100000
Oct 24 23:43:01 zyklop kernel: s0 = fffffc001f0aa940  s1 = 0000000000000900  s2 = fffffc001f825000
Oct 24 23:43:01 zyklop kernel: s3 = fffffc001f0aa940  s4 = fffffc001f10f5c0  s5 = fffffc00008f3a08
Oct 24 23:43:01 zyklop kernel: s6 = 0000000000000000
Oct 24 23:43:01 zyklop kernel: a0 = fffffc001f825000  a1 = fffffc001f0aa940  a2 = fffffc001f0aa940
Oct 24 23:43:01 zyklop kernel: a3 = 0000000000000400  a4 = 0000000000000002  a5 = fffffc001f825018
Oct 24 23:43:01 zyklop kernel: t8 = 0000000000000024  t9 = ffff70046a2b0000  t10= 000000000000000e
Oct 24 23:43:01 zyklop kernel: t11= fffffc001f825020  pv = fffffc00004cf220  at = fffffc001f82501c
Oct 24 23:43:01 zyklop kernel: gp = fffffc00008f7160  sp = fffffc001f103bb8
Oct 24 23:43:01 zyklop kernel: Trace:fffffc00004d8d10 fffffc0000365a3c fffffc0000407374 fffffc000040746c fffffc000040773c fffffc0000365674 fffffc00003bb774 fffffc000036adcc fffffc000036b18c fffffc000036b15c fffffc0000385408 fffffc000038585c fffffc0000385e78 fffffc0000385e54 fffffc0000310ca0
Oct 24 23:43:01 zyklop kernel: Code: 42fc0403  2ffe0000  42f90405  a0f003d8  40a49525  40c49526 <a0250000> 40649523


The raid recovers, and then all works without problems. Can someone help me
with this flaw? Please cc me since I'm not constantly reading on the lkml.

Joerg


-- 
...Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org
