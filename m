Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263712AbTCVQtt>; Sat, 22 Mar 2003 11:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263710AbTCVQts>; Sat, 22 Mar 2003 11:49:48 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:34373
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263712AbTCVQtm>; Sat, 22 Mar 2003 11:49:42 -0500
Date: Sat, 22 Mar 2003 11:57:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Manfred Spraul <manfred@colorfullife.com>
Subject: BUG: Use after free in detach_pid
Message-ID: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred, much quicker turnover if i leave it to you. kernel/box is SMP 
i triggered it whilst doing a find in a large NFS directory and writing 
out 512M to that same directory.

187     }
188
189     static inline int __detach_pid(task_t *task, enum pid_type type)
190     {
191             struct pid_link *link = task->pids + type;
192             struct pid *pid = link->pidptr;
193             int nr;
194
195             list_del(&link->pid_chain); <==
196             if (!atomic_dec_and_test(&pid->count))

Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c013479c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c013479c>]    Not tainted
EFLAGS: 00010046
EIP is at detach_pid+0x1c/0xf0
eax: 6b6b6b6b   ebx: 6b6b6b6b   ecx: 6b6b6b6b   edx: c1bb93d0
esi: 00000000   edi: bfffef74   ebp: 00000000   esp: caaa3f08
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 1292, threadinfo=caaa2000 task=cbb02560)
Stack: c1bb9380 00000000 bfffef74 00000000 c01232ec c1bb9380 c01233dc c1bb9380 
       c1bb9380 c1bb9944 c1bb9380 00000526 c01251cb c1bb9380 bfffef74 bfffef74 
       c1bb9424 c1bb9380 cbb02560 cbb025fc c0125681 c1bb9380 bfffef74 00000000 
Call Trace:
 [<c01232ec>] __unhash_process+0x10c/0x170
 [<c01233dc>] release_task+0x8c/0x200
 [<c01251cb>] wait_task_zombie+0x15b/0x1c0
 [<c0125681>] sys_wait4+0x241/0x290
 [<c011cb10>] default_wake_function+0x0/0x20
 [<c011cb10>] default_wake_function+0x0/0x20
 [<c0109477>] syscall_call+0x7/0xb

Code: 89 01 89 48 04 f0 ff 4b 04 0f 94 c0 31 f6 84 c0 74 1f 8b 43 

-- 
function.linuxpower.ca
