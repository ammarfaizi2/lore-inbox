Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269148AbUINChj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269148AbUINChj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269142AbUINCe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:34:57 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63182 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269135AbUINCdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:33:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: BUG at inode.c:1024
Date: Mon, 13 Sep 2004 19:33:46 -0700
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409131933.47047.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I think this backtrace is actually legitimate (different, working hardware 
I hope) :)  I hit this while running aim7, about 20 min. into the run or so, 
probably at a few thousand users.  It was a 64p machine.  The machine stayed 
up and continued running aim7 until it was rebooted by the next user who had 
it reserved.

Thanks,
Jesse

kernel BUG at fs/inode.c:1025!
multitask[32163]: bugcheck! 0 [1]
Modules linked in:

Pid: 32163, CPU 8, comm:            multitask
psr : 0000101008026018 ifs : 800000000000038a ip  : [<a0000001001a9850>]    
Nottainted
ip is at generic_delete_inode+0x310/0x400
unat: 0000000000000000 pfs : 000000000000038a rsc : 0000000000000003
rnat: 00000000f880f5b7 bsps: 000000000001003e pr  : 0000000005aaa959
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001001a9850 b6  : a000000100104cc0 b7  : a0000001004b0d60
f6  : 0ffec89813003a028040c f7  : 0ffe0afb0d00000000000
f8  : 1001be93fe00000000000 f9  : 10011ee4e000000000000
f10 : 10008fa91c79e4f580355 f11 : 1003e00000000000003ea
r1  : a000000100ba6ba0 r2  : 0000000000000000 r3  : 0000000000000001
r8  : 000000000000001f r9  : 0000000000004000 r10 : e0000a3004a4427a
r11 : e0000a3004a44260 r12 : e000083c6c5e7e30 r13 : e000083c6c5e0000
r14 : 0000000000000000 r15 : e000083c6c5e0e70 r16 : e000083c6c5e0e80
r17 : e00008b4789f7de8 r18 : 0000000000020220 r19 : 0fd0000000000000
r20 : 0000088000000000 r21 : 8000000910000380 r22 : 0000000000020220
r23 : 0000000000000000 r24 : 0000000000000000 r25 : 0000000000000004
r26 : e000083c67f98e70 r27 : e000083c6c5e0e74 r28 : e000083c67f98e74
r29 : e000083c67f9802c r30 : e00008b4789f002c r31 : e00008b004a24968

Call Trace:
 [<a000000100017380>] show_stack+0x80/0xa0
                                sp=e000083c6c5e79c0 bsp=e000083c6c5e1110
 [<a00000010003d4b0>] die+0x150/0x200
                                sp=e000083c6c5e7b90 bsp=e000083c6c5e10d0
 [<a00000010003d9f0>] ia64_bad_break+0x430/0x4c0
                                sp=e000083c6c5e7b90 bsp=e000083c6c5e10a8
 [<a00000010000f660>] ia64_leave_kernel+0x0/0x270
                                sp=e000083c6c5e7c60 bsp=e000083c6c5e10a8
 [<a0000001001a9850>] generic_delete_inode+0x310/0x400
                                sp=e000083c6c5e7e30 bsp=e000083c6c5e1058
 [<a0000001001a72a0>] iput+0x140/0x1e0
                                sp=e000083c6c5e7e30 bsp=e000083c6c5e1030
 [<a0000001001a0570>] dput+0x370/0x660
                                sp=e000083c6c5e7e30 bsp=e000083c6c5e0ff0
 [<a000000100168360>] __fput+0x280/0x320
                                sp=e000083c6c5e7e30 bsp=e000083c6c5e0fa0
 [<a000000100164f40>] filp_close+0xc0/0x1a0
                                sp=e000083c6c5e7e30 bsp=e000083c6c5e0f70
 [<a000000100165170>] sys_close+0x150/0x1a0
                                sp=e000083c6c5e7e30 bsp=e000083c6c5e0ef8
 [<a00000010000f4c0>] ia64_ret_from_syscall+0x0/0x20
                                sp=e000083c6c5e7e30 bsp=e000083c6c5e0ef8
