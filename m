Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVHYNs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVHYNs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVHYNs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:48:26 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47754 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964985AbVHYNsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:48:22 -0400
Date: Thu, 25 Aug 2005 04:52:30 -0500
From: serue@us.ibm.com
To: Chris Wright <chrisw@osdl.org>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>
Subject: Re: [PATCH 0/5] LSM hook updates
Message-ID: <20050825095230.GA6938@sergelap.austin.ibm.com>
References: <20050825012028.720597000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825012028.720597000@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, haven't yet figured out why, but something in this patchset
doesn't work for power5.  Oops attached, as well as the assembly
for selinux_task_create (which I'm weeding through right now).

thanks,
-serge

Oops output from console:

Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA PSERIES LPAR
Modules linked in:
NIP: C00000000016BCCC XER: 20000005 LR: C00000000004FA38 CTR: C00000000016BCA8
REGS: c000000000403590 TRAP: 0300   Not tainted  (2.6.13-rc7-git1)
MSR: 8000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 42000028
DAR: 0000000000000000 DSISR: 0000000040000000
TASK: c000000000468ea0[0] 'swapper' THREAD: c000000000400000 CPU: 0
GPR00: C00000000004FA38 C000000000403810 C00000000054BA70 0000000000800B00
GPR04: C000000000403DE0 C000000000403B60 0000000000000000 0000000000000000
GPR08: 0000000000000000 C00000000049C450 0000000000000000 C0000000005F3298
GPR12: 0000000042000022 C000000000423C00 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 C000000000403B60
GPR20: C000000000403DE0 0000000000000000 0000000000000001 0000000000000000
GPR24: 0000000000000000 0000000000800B00 C000000000403DE0 0000000000000000
GPR28: 0000000000000001 0000000000000001 C0000000004A4AC8 0000000000800B00
NIP [c00000000016bccc] .selinux_task_create+0x24/0x84
LR [c00000000004fa38] .copy_process+0xc28/0x163c
Call Trace:
[c000000000403810] [00000000000000d0] 0xd0 (unreliable)
[c000000000403890] [c00000000004fa38] .copy_process+0xc28/0x163c
[c0000000004039a0] [c00000000005059c] .do_fork+0x94/0x240
[c000000000403a80] [c000000000011c80] .sys_clone+0x60/0x78
[c000000000403af0] [c00000000000d814] .ppc_clone+0x8/0xc
--- Exception: c00 at .kernel_thread+0x28/0x68
    LR = .rest_init+0x24/0x5c
[c000000000403de0] [0000000001ff1b88] 0x1ff1b88 (unreliable)
[c000000000403e50] [c0000000003e3004] .proc_root_init+0x164/0x184
[c000000000403ed0] [c0000000003c98a0] .start_kernel+0x2ac/0x328
[c000000000403f90] [c00000000000bfb4] .__setup_cpu_power3+0x0/0x4
Instruction dump:
4e800020 63ff0004 4bffff44 7c0802a6 fbc1fff0 ebc2c9d0 fbe1fff8 f8010010
f821ff81 e97e8100 e92b0000 e9490258 <e80a0000> f8410028 e96a0010 e84a0008
 <0>Kernel panic - not syncing: Attempted to kill the idle task!

Taken from hooks.S:

0000000000005494 <.selinux_task_create>:
    5494:       7c 08 02 a6     mflr    r0
    5498:       fb c1 ff f0     std     r30,-16(r1)
    549c:       eb c2 00 00     ld      r30,0(r2)
    54a0:       fb e1 ff f8     std     r31,-8(r1)
    54a4:       f8 01 00 10     std     r0,16(r1)
    54a8:       f8 21 ff 81     stdu    r1,-128(r1)
    54ac:       e9 7e 81 00     ld      r11,-32512(r30)
    54b0:       e9 2b 00 00     ld      r9,0(r11)
    54b4:       e9 49 02 58     ld      r10,600(r9)
    54b8:       e8 0a 00 00     ld      r0,0(r10)
    54bc:       f8 41 00 28     std     r2,40(r1)
    54c0:       e9 6a 00 10     ld      r11,16(r10)
    54c4:       e8 4a 00 08     ld      r2,8(r10)
    54c8:       7c 09 03 a6     mtctr   r0
    54cc:       4e 80 04 21     bctrl   
    54d0:       e8 41 00 28     ld      r2,40(r1)
    54d4:       38 a0 00 01     li      r5,1
    54d8:       2f a3 00 00     cmpdi   cr7,r3,0
    54dc:       41 9e 00 1c     beq-    cr7,54f8 <.selinux_task_create+0x64>
    54e0:       38 21 00 80     addi    r1,r1,128
    54e4:       e8 01 00 10     ld      r0,16(r1)
    54e8:       eb c1 ff f0     ld      r30,-16(r1)
    54ec:       eb e1 ff f8     ld      r31,-8(r1)
    54f0:       7c 08 03 a6     mtlr    r0
    54f4:       4e 80 00 20     blr     
    54f8:       38 21 00 80     addi    r1,r1,128
    54fc:       e8 6d 01 70     ld      r3,368(r13)
    5500:       e8 01 00 10     ld      r0,16(r1)
    5504:       eb c1 ff f0     ld      r30,-16(r1)
    5508:       eb e1 ff f8     ld      r31,-8(r1)
    550c:       7c 64 1b 78     mr      r4,r3
    5510:       7c 08 03 a6     mtlr    r0
    5514:       4b ff ba 68     b       f7c <.task_has_perm>

