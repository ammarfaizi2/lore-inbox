Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSJIOBn>; Wed, 9 Oct 2002 10:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbSJIOBn>; Wed, 9 Oct 2002 10:01:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:49031 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261723AbSJIOBl>; Wed, 9 Oct 2002 10:01:41 -0400
Subject: [BUG] NULL pointer dereference
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Oct 2002 09:01:47 -0500
Message-Id: <1034172108.29084.96.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During some testing I was doing on linux-2.5.41-mm1 I came across the
NULL pointer dereference below.  I suspect it is also in 2.5.41 vanilla,
but I have not been able to reproduce it so far.  It was on an 8-way
PIII-700, 16 GB ram.  I had been running ltp at the time and it had
completed.  I was hitting tab at the time it happened to get a command
line completion in bash.

Unable to handle kernel NULL pointer dereference at virtual address
0000002c
 printing eip:
c01525b5
*pde = 00104001
Oops: 0000

CPU:    0
EIP:    0060:[<c01525b5>]    Not tainted
EFLAGS: 00010046
EIP is at fasync_helper+0x75/0xf0
eax: c0359198   ebx: 00000000   ecx: 0000002c   edx: 0000007e
esi: 0000002c   edi: 00000000   ebp: cc2682c0   esp: f637bec4
ds: 0068   es: 0068   ss: 0068
Process python (pid: 1253, threadinfo=f637a000 task=f6c8f1a0)
Stack: 00000000 f7c0c9bc f7c0c960 ffffffff 00000000 c014dc45 ffffffff
cc2682c0
       00000000 0000002c f7c0c960 f7ff5620 f7c0c960 f63b8ca0 c014dd83
ffffffff
       cc2682c0 00000000 cc2682c0 c014453b f7c0c960 cc2682c0 f7ff5760
00000286
Call Trace:
 [<c014dc45>] pipe_read_fasync+0x45/0x70
 [<c014dd83>] pipe_read_release+0x13/0x30
 [<c014453b>] __fput+0x2b/0xd0
 [<c0142cd9>] filp_close+0x99/0xb0
 [<c011c3eb>] put_files_struct+0x4b/0xd0
 [<c011cd69>] do_exit+0x109/0x2e0
 [<c011e16b>] do_softirq+0x5b/0xc0
 [<c01111df>] smp_apic_timer_interrupt+0x10f/0x120
 [<c01071d3>] syscall_call+0x7/0xb

Code: 8b 16 85 d2 74 36 90 8d 74 26 00 39 6a 0c 75 22 85 ff 75 ba

Thanks,
Paul Larson

