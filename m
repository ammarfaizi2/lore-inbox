Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWCARhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWCARhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWCARgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:36:49 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55252 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932409AbWCARgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:36:43 -0500
Date: Wed, 1 Mar 2006 11:36:36 -0600
From: Dean Roe <roe@sgi.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at mm/slab.c:2564 - 2.6.16-rc5-g7b14e3b5
Message-ID: <20060301173636.GA20861@sgi.com>
References: <20060301160656.370e1ee0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301160656.370e1ee0@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 04:06:56PM +0100, Paolo Ornati wrote:
> It's the first time I see this, I don't think it is reproducible...
> 
> Kernel BUG at mm/slab.c:2564
> invalid opcode: 0000 [1] 
> CPU 0 
> Modules linked in: xt_state ip_queue ip_conntrack iptable_filter
> ip_tables Pid: 21232, comm: as Not tainted 2.6.16-rc5-g7b14e3b5 #7
> RIP: 0010:[<ffffffff80156c5e>] <ffffffff80156c5e>{check_slabp+188}
> RSP: 0018:ffff81000a2cbdc8  EFLAGS: 00010096
> RAX: 0000000000000001 RBX: 0000000000000178 RCX: 0000000000003ee7
> RDX: 00000000ffffff01 RSI: 0000000000003ee7 RDI: ffffffff803f24c0
> RBP: ffff810000a07000 R08: 00000000fffffffe R09: ffff810000a07000
> R10: 0000000000000046 R11: 0000000000000000 R12: ffff81001ff2cec0
> R13: ffff810000a071a0 R14: 0000000000000000 R15: ffff81000a2cbee0
> FS:  00002af4db709dc0(0000) GS:ffffffff804cb000(0000)
> knlGS:00000000f6cd7bb0 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000003cf698c600 CR3: 000000000c1a3000 CR4: 00000000000006e0
> Process as (pid: 21232, threadinfo ffff81000a2ca000, task
> ffff810017e7a100) Stack: ffff810000a07000 ffff81001ff2bf20
> ffff81001ff2cec0 ffffffff80157763 ffff81001ff280a8 ffff810005f24000
> 0000000000000010 0000000000000010 ffff81001ff28098 ffff81001ff2bf20 
> Call Trace: <ffffffff80157763>{free_block+154}
> <ffffffff8015796c>{cache_flusharray+111}
> <ffffffff80157585>{kmem_cache_free+78}
> <ffffffff80148cac>{free_pgtables+45} <ffffffff8014e1fc>{exit_mmap+119}
> <ffffffff8012210c>{mmput+27} <ffffffff801263d6>{do_exit+519}
> <ffffffff801269d7>{sys_exit_group+0} <ffffffff8010a5b2>{system_call+126}
> 
> Code: 0f 0b 68 4f e6 38 80 c2 04 0a 5b 5d 41 5c c3 41 55 31 c0 48 
> RIP <ffffffff80156c5e>{check_slabp+188} RSP <ffff81000a2cbdc8>
>  <1>Fixing recursive fault but reboot is needed!

I might have hit something similar about a month ago running 2.6.16-rc1.
At the time I had written this off as a hardware problem since I was using
a questionable system, but maybe there is a hard-to-hit bug in the anon_vma
or slab code?


Pid: 10865, CPU 3, comm:                sleep
psr : 00001010081a2018 ifs : 800000000000058d ip  : [<a00000010012f7c0>]    Tainted: G     U
ip is at free_block+0x1c0/0x280
unat: 0000000000000000 pfs : 000000000000058d rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 0000000001aa9555
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8270033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010012f700 b6  : a000000100010640 b7  : a000000100010610
f6  : 0fffaaaaaaaaaaa000000 f7  : 0ffe4b040000000000000
f8  : 1000cb040000000000000 f9  : 10003c000000000000000
f10 : 10007eaffffffff150000 f11 : 1003e00000000000001d6
r1  : a000000100f81b50 r2  : e002806003045ea0 r3  : e002806077210020
r8  : 0000000000000000 r9  : 0000000000000246 r10 : 0000000000000247
r11 : 0000000000002814 r12 : e00280606e9c7d40 r13 : e00280606e9c0000
r14 : 0000000a0181dc84 r15 : 0000000000000001 r16 : e00280607a7ab594
r17 : 00000000ffffffff r18 : e002806003045eb0 r19 : e002806003045e88
r20 : 0000000000000000 r21 : 0000000000000758 r22 : e00280607a7aad8c
r23 : 0000000000200200 r24 : 0000000000100100 r25 : e00280600c0b0008
r26 : e002806072b8c000 r27 : e00280600c0b0000 r28 : a0007ffffffbbd10
r29 : a0007ffffffbbce0 r30 : 000000460a8d079c r31 : a0007dcfab938000

Call Trace:
 [<a000000100014c20>] show_stack+0x40/0xa0
                                sp=e00280606e9c78d0 bsp=e00280606e9c14f8
 [<a000000100015450>] show_regs+0x7d0/0x800
                                sp=e00280606e9c7aa0 bsp=e00280606e9c14b0
 [<a000000100037560>] die+0x1c0/0x2a0
                                sp=e00280606e9c7aa0 bsp=e00280606e9c1468
 [<a0000001008b5d50>] ia64_do_page_fault+0x890/0x9e0
                                sp=e00280606e9c7ac0 bsp=e00280606e9c1410
 [<a00000010000cae0>] ia64_leave_kernel+0x0/0x280
                                sp=e00280606e9c7b70 bsp=e00280606e9c1410
 [<a00000010012f7c0>] free_block+0x1c0/0x280
                                sp=e00280606e9c7d40 bsp=e00280606e9c13a0
 [<a00000010012eb00>] cache_flusharray+0x140/0x1a0
                                sp=e00280606e9c7d40 bsp=e00280606e9c1358
 [<a00000010012f350>] kmem_cache_free+0x310/0x3a0
                                sp=e00280606e9c7d40 bsp=e00280606e9c1310
 [<a0000001001157a0>] anon_vma_unlink+0xe0/0x100
                                sp=e00280606e9c7d50 bsp=e00280606e9c12e8
 [<a000000100109de0>] free_pgtables+0x160/0x2a0
                                sp=e00280606e9c7d50 bsp=e00280606e9c12a0
 [<a00000010010c1b0>] exit_mmap+0x130/0x440
                                sp=e00280606e9c7d50 bsp=e00280606e9c1250
 [<a0000001000830d0>] mmput+0x50/0x180
                                sp=e00280606e9c7e20 bsp=e00280606e9c1220
 [<a00000010008cb90>] exit_mm+0x330/0x360
                                sp=e00280606e9c7e20 bsp=e00280606e9c11d8
 [<a000000100090880>] do_exit+0x400/0x1340
                                sp=e00280606e9c7e20 bsp=e00280606e9c1178
 [<a000000100091940>] do_group_exit+0x180/0x1a0
                                sp=e00280606e9c7e30 bsp=e00280606e9c1140
 [<a000000100091980>] sys_exit_group+0x20/0x40
                                sp=e00280606e9c7e30 bsp=e00280606e9c10e8
 [<a00000010000c940>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00280606e9c7e30 bsp=e00280606e9c10e8
 [<a000000000010640>] __kernel_syscall_via_break+0x0/0x20
                                sp=e00280606e9c8000 bsp=e00280606e9c10e8
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000768)
sleep[10865]: Oops 11012296146944 [2]


Dean

-- 
Dean Roe
Silicon Graphics, Inc.
roe@sgi.com
