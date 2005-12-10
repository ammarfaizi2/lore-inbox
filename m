Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVLJWZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVLJWZx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 17:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVLJWZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 17:25:53 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:16303 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S1750738AbVLJWZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 17:25:52 -0500
Date: Sat, 10 Dec 2005 23:25:36 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel maillist <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-Reply-To: <20051207.133236.97581111.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0512102314530.4626@lai.local.lan>
References: <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
 <20051207.123458.26771065.davem@davemloft.net> <Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
 <20051207.133236.97581111.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got today a mail from Mr Miller with the subject "Need for VM_INCOMPLETE 
on I/O mappings" and a patch made by Mr Dickins. Did apply it to my 
2.6.15-rc5 and recompiled the whole kernel and all the drivers.

Sadly this didn't affect the problem I have when starting X. The 
Xorg.0.log looks still the same as before and I do have the '_' cursor
in the right left corner of the screen.
The only error in dmesg output is the following:

kernel BUG at arch/sparc64/mm/generic.c:77!
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
X(6762): Kernel bad sw trap 5 [#1]
TSTATE: 0000000011009603 TPC: 0000000000434d60 TNPC: 0000000000434d64 Y: 
00000000    Not tainted
TPC: <io_remap_pfn_range+0x3c0/0x3e0>
g0: fffff800007ee080 g1: 0000000000669400 g2: 0000000000000001 g3: 
0000000000001df8
g4: fffff80001f30160 g5: 0000000000000010 g6: fffff80005c70000 g7: 
0000000000000000
o0: 000000000000002f o1: 000000000061f118 o2: 000000000000004d o3: 
0000000011812000
o4: 000001fc00610000 o5: fffff80001318c00 sp: fffff80005c7f271 ret_pc: 
0000000000434d58
RPC: <io_remap_pfn_range+0x3b8/0x3e0>
l0: 0000000071804000 l1: 000001fb8edfe000 l2: 0000000071804000 l3: 
000001fb8edfe000
l4: 000001fb8edfe000 l5: e000000000000f8a l6: a000000000000f8a l7: 
c000000000000f8a
i0: 0000000071802000 i1: 0000000071802000 i2: fffff80000b90000 i3: 
0000000071802000
i4: 80000000000006b0 i5: fffff80001db000c i6: fffff80005c7f361 i7: 
000000000053b1e4
I7: <sbusfb_mmap_helper+0x104/0x160>
Caller[000000000053b1e4]: sbusfb_mmap_helper+0x104/0x160
Caller[0000000000533574]: fb_mmap+0x134/0x160
Caller[0000000000478708]: do_mmap_pgoff+0x368/0x720
Caller[00000000004161d8]: sys_mmap+0xf8/0x160
Caller[0000000000406c94]: linux_sparc_syscall32+0x34/0x40
Caller[0000000000286378]: 0x286378
Instruction DUMP: 9210204d  7fff6e12  90122118 <91d02005> 7ffff77f 
b13e2000  81cfe008  01000000  30680003


I have to say I don't have much knowledge about the kernel code, but in 
arch/sparc64/mm/generic.c it looks for me that no matter what if 
io_remap_pte_range() is called it will result in a bug output, is this 
supposed to happen? Looking at arch/sparc/mm/generic.c I can't find any 
similar functionality.


-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
