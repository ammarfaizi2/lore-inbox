Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263628AbUEGPtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbUEGPtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUEGPtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:49:17 -0400
Received: from 12-222-129-149.client.insightBB.com ([12.222.129.149]:33927
	"EHLO comet") by vger.kernel.org with ESMTP id S263628AbUEGPtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:49:15 -0400
From: Patrick Finnegan <pat@computer-refuge.org>
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.6.6-rc3 on SMP/SPARC64 (Sun E3000)? & MD
Date: Fri, 7 May 2004 10:49:14 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405071049.14725.pat@computer-refuge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to get 2.6.6-rc3 to work in SMP mode on my E3000 without
much success yet.  It boots fine with a uniprocessor kernel, but trying
to enable SMP gives me this as the last few lines of the kernel messages
(booted with -p early printk option):

----------------------------------------------------------------
CENTRAL: Detected 4 slot Enterprise system. cfreg[aa] cver[fc]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 7): Version[1] PartID[fa0] Manuf[3e]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e]
FHC(board 3): Version[1] PartID[fa0] Manuf[3e]
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro -p
PID hash table entries: 2048 (order 11: 32768 bytes)
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff8000040f000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000009980f01603 TPC: 000000000044b704 TNPC: 000000000044b708 Y: 000000d
TPC: <wake_up_forked_process+0x1e4/0x280>
g0: 00000000006c5c00 g1: 00000000000007f0 g2: 0000000000000000 g3: 0000000000628
g4: 0000000000622000 g5: 0000000000000000 g6: 000000000061e000 g7: 0000000000000
o0: 000000000000007d o1: 0000000000008000 o2: fffff8000005c440 o3: 00000000006a0
o4: 0000000000621d98 o5: 0000000000000008 sp: 00000000006214e1 ret_pc: 00000000c
RPC: <wake_up_forked_process+0x15c/0x280>
l0: 00000000006a11b8 l1: 00000000006c7400 l2: 00000000006c5c00 l3: 0000000000620
l4: 000000000000fe83 l5: 0000000000000003 l6: 0000000000000000 l7: 0000000000620
i0: 0000000000622000 i1: 0000000000000002 i2: 00000000006a11b8 i3: fffff80000030
i4: 0000000000000001 i5: fffff8000003de98 i6: 00000000006215b1 i7: 000000000068c
I7: <sched_init+0x12c/0x1a0>
Instruction DUMP: 9a01e008  82006020  c2762038 <c4586008> c6706008  82102001  c
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Press L1-A to return to the boot prom
---------------------------

I've posted my .config, System.map, (uniproc) dmesg (from klogd), and 
(2.4.26) /proc/cpuinfo files to:
http://x-ray.rcs.purdue.edu/linux-2.6.6-rc3-e3000.config
http://x-ray.rcs.purdue.edu/linux-2.6.6-rc3-e3000.System.map
http://x-ray.rcs.purdue.edu/linux-2.6.6-rc3-e3000.dmesg
http://x-ray.rcs.purdue.edu/linux-2.4.26-e3000.cpuinfo

I have not yet tested any other versions on it.

Also, I've noticed the md driver seems to have problems with data corruption 
(it overwrites other partitions on the same disk, or the disklabel even).  I've
noticed this problem under 2.6.5 on my Sun Ultra 60, as well.  Is it an
UltrSparc issue, or is it more general?

Pat
-- 
Purdue University ITAP/RCS        --- http://www.itap.purdue.edu/rcs/
The Computer Refuge               --- http://computer-refuge.org
