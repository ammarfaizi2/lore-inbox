Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbTBTSVT>; Thu, 20 Feb 2003 13:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbTBTSVT>; Thu, 20 Feb 2003 13:21:19 -0500
Received: from tang.qis.net ([209.150.98.149]:48390 "EHLO lamut.jtang.org")
	by vger.kernel.org with ESMTP id <S266765AbTBTSUF>;
	Thu, 20 Feb 2003 13:20:05 -0500
To: linux-kernel@vger.kernel.org
Subject: Oops: nfsd/reiserfs, 2.4.20 with preemption
Message-Id: <20030220182949.557DC3E62@cavall.jtang.org>
Date: Thu, 20 Feb 2003 13:29:49 -0500 (EST)
From: tang@jtang.org (J. Tang)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there.

I have been experiencing some very odd nfs problems lately; eventually I
was able to get this output:

------------------------------------------------------------

nfsd/reiserfs, fhtype=0, len=-603226364 - odd
Unable to handle kernel paging request at virtual address 9110d6ff
 printing eip:
d6bec2b0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d6bec2b0>]    Not tainted
EFLAGS: 00010282
eax: d6bec200   ebx: dc0b6084   ecx: 00000000   edx: dc0b7e9c
esi: bec2a8d6   edi: d6f27880   ebp: c15c06f8   esp: dc0b7e3c
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 229, stackpage=dc0b7000)
Stack: c0145b01 d6f27880 dc0b7e9c dc0b6000 00000000 c15c06f8 00000000 c0145dde
       d6bec280 00000000 c15c06f8 c0175574 dc0b7e9c 00000005 dc0b7ebc 00000000
       d6bec280 c01755b3 d6bec280 00000000 c0175574 dc0b7e9c 00000005 dc0b14a4
Call Trace:    [<c0145b01>] [<c0145dde>] [<c0175574>] [<c01755b3>] [<c0175574>]
  [<c01756bc>] [<c013bc10>] [<e29cec35>] [<e29cf54d>] [<e29b4be4>] [<e29d4d28>]
  [<e29dbaac>] [<e29dbaac>] [<e29cc5c3>] [<e29b482f>] [<e29db3f8>] [<e29cc3a0>]
  [<c01055dc>]

Code: 10 91 ff d6 10 91 ff d6 00 00 00 00 dc c2 be d6 03 00 00 00
 <6>note: nfsd[229] exited with preempt_count 1

------------------------------------------------------------

Specifics of my system:

Pentium III, Debian Woody, kernel 2.4.20 with prempt patches:

ext3-scheduling-storm.patch        sync_fs-fix-2.patch
ext3-use-after-free.patch          sync_fs-fix.patch
preempt-kernel-rml-2.4.20-1.patch  sync_fs.patch

running knfsd and reiserfs.  I have not seen this error reported within
the lkml archives.  Let me know if additional information is needed to
track down this problem.

As that I am not subscribed to this list, please CC all replies to the
address below.  Thanks.

-- 
Jason Tang  /  tang@jtang.org  /  http://www.jtang.org/~tang
