Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTE1DwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 23:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTE1DwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 23:52:04 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:45697
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264493AbTE1DwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 23:52:03 -0400
Date: Tue, 27 May 2003 23:55:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: John Appleby <john@dnsworld.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 Oops in scheduler
In-Reply-To: <434747C01D5AC443809D5FC5405011315693@bobcat.unickz.com>
Message-ID: <Pine.LNX.4.50.0305272338070.15323-100000@montezuma.mastecende.com>
References: <434747C01D5AC443809D5FC5405011315693@bobcat.unickz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, John Appleby wrote:

> <6>ksoftirqd/0 (0): address exception: pc=020ab494
> Code: eb001b23 ebffb8b5 e5846030 e5950004 (e5971004)
> kernel/sched.c: 245: spin_lock(kernel/sched.c:021a8000) already locked
> by kernel/sched.c/1271
> 
> I won't go any further because I've done some debugging and next is set
> to 0 in all the schedule() calls. prev looks about right...

next = NULL at context switch? Something like... Cool beans, it even got 
kblockhead.

Unable to handle kernel NULL pointer dereference at virtual address 0000003c
 printing eip:
c011f5b3
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c011f5b3>]    Not tainted VLI
EFLAGS: 00000007
EIP is at schedule+0x1a3/0x690
eax: 00000009   ebx: c1490000   ecx: c0570fc0   edx: 0000000d
esi: ffffffe0   edi: c0570fc0   ebp: c1485f74   esp: c1485f40
ds: 007b   es: 007b   ss: 0068
Process kblockd/0 (pid: 5, threadinfo=c1484000 task=c1490000)
Stack: c0570fc0 00010000 c148f158 00000010 00000292 00000292 c0570fc0 00000246
       c1491004 c1491004 c1484000 c1490000 c1490000 c1491004 c0136595 00000000
       c149101c 00000000 00000000 00000000 c1491014 00000000 00000000 00000000
Call Trace:
 [<c0136595>] worker_thread+0x3b5/0x3e0
 [<c011faf0>] default_wake_function+0x0/0x20
 [<c0109486>] ret_from_fork+0x6/0x20
 [<c011faf0>] default_wake_function+0x0/0x20
 [<c01361e0>] worker_thread+0x0/0x3e0
 [<c0107125>] kernel_thread_helper+0x5/0x10

Code: b8 60 0c 5c c0 8b 52 10 8b 0c 95 00 10 5c c0 01 c8 8b 10 42 39 f3 89 
10 0f 84 42 03 00 00 8b 4d cc 8b 41 0c 89 71 18 4
0 89 41 0c <8b> 56 5c 8b 7b 60 89 7d e4 85 d2 0f 84 f4 02 00 00 b8 00 e0 
ff
 <6>note: kblockd/0[5] exited with preempt_count 2

-- 
function.linuxpower.ca
