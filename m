Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263458AbTC2Udz>; Sat, 29 Mar 2003 15:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263459AbTC2Udz>; Sat, 29 Mar 2003 15:33:55 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:260
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S263458AbTC2Udx>; Sat, 29 Mar 2003 15:33:53 -0500
Message-ID: <001c01c2f634$2e517da0$030aa8c0@unknown>
From: "Shawn Starr" <spstarr@sh0n.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PANIC][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings
Date: Sat, 29 Mar 2003 15:45:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panic from 2.5.66-bk3 w/ ksymoops dump:

In both panics below c012e9b4 does not exist as a kernel symbol in
System.map:
=======================================================

Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c012e9b4
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c012e9b4>]    Not tainted
EFLAGS: 00010012
EIP is at run_timer_softirq+0xe4/0x3f0
eax: 6b6b6b6b   ebx: 6b6b6b6b   ecx: c2e7e150   edx: 6b6b6b6b
esi: 6b6b6b6b   edi: c114a000   ebp: c0419860   esp: c114bf0c
ds: 007b   es: 007b   ss: 0068
Process init (pid: 1, threadinfo=c114a000 task=c114e000)
Stack: c041a8b0 c011282e c114bf94 c114bf24 c114e5d4 c114bfc4 00000011
c114a000
       000000e7 00000092 00000001 c04c9c48 fffffffd 00000046 c012963a
c04c9c48
       c114a000 c114a000 00000000 c04183a0 c010cd75 00000000 c114bf94
c04183a0
Call Trace:
 [<c011282e>] timer_interrupt+0x19e/0x3f0
 [<c012963a>] do_softirq+0x9a/0xa0
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c017a557>] sys_stat64+0x37/0x40
 [<c010ac18>] common_interrupt+0x18/0x20
 [<c010a2bb>] restore_all+0x1/0xe

Code: 89 50 04 89 02 c7 41 30 00 00 00 00 81 3d 60 98 41 c0 3c 4b
 kernel/timer.c:258: spin_lock(kernel/timer.c:c0419860) already locked by
kernel/timer.c/398
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


ksymoops dump:

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 02                     mov    %eax,(%edx)
Code;  00000005 Before first symbol
   5:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
Code;  0000000c Before first symbol
   c:   81 3d 60 98 41 c0 3c      cmpl   $0x4b3c,0xc0419860
Code;  00000013 Before first symbol
  13:   4b 00 00


We know this is poisioned ('6b') EIP c012e9b4 is not present in System.map.
The machine was on for several hours 8+


----------------------------------------------------------------------------
--------------------------------------

Panic #2 (older) from 2.5.65:

Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c012e920
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c012e920>]    Not tainted
EFLAGS: 00010016
EIP is at run_timer_softirq+0xd0/0x3f0
eax: 6b6b6b6b   ebx: c7de5150   ecx: 000000ee   edx: 6b6b6b6b
esi: 6b6b6b6b   edi: 6b6b6b6b   ebp: c0418bc0   esp: c117fe80
ds: 007b   es: 007b   ss: 0068
Process init (pid: 1, threadinfo=c117e000 task=c117c000)
Stack: c01127ae c117ff04 c117ff44 c0130249 c128423c c7fc2ac0 c117e000
c117e000
       c117e000 00000001 c04c5c48 fffffffd 00000046 c012960a c04c5c48
c117e000
       c117e000 00000000 c0417700 c010cd05 00000000 c117ff04 c0417700
fffffffe
Call Trace:
 [<c01127ae>] timer_interrupt+0x19e/0x3f0
 [<c0130249>] __dequeue_signal+0xc9/0x180
 [<c012960a>] do_softirq+0x9a/0xa0
 [<c010cd05>] do_IRQ+0x235/0x370
 [<c0180e37>] link_path_walk+0x247/0xdc0
 [<c010abf8>] common_interrupt+0x18/0x20
 [<c014007b>] sys_timer_delete+0x1db/0x210
 [<c014d756>] fprob+0x26/0x40
 [<c014d7ab>] check_poison_obj+0x3b/0x1b0
 [<c0181e6c>] __user_walk+0x5c/0x60
 [<c014f71c>] kmem_cache_alloc+0x12c/0x170
 [<c017f9c1>] getname+0x31/0xd0
 [<c017f9c1>] getname+0x31/0xd0
 [<c016b83b>] sys_open+0x1b/0x90
 [<c010a28b>] syscall_call+0x7/0xb

Code: 89 50 04 89 02 c7 43 30 00 00 00 00 81 3d c0 8b 41 c0 3c 4b
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 kernel/timer.c:251: spin_lock(kernel/timer.c:c0418bc0) already locked by
kernel/timer.
c/389

ksymoops zwane debugged showed garbage, also poisioned ('6b').

I can say none of these irq mishaps have happened in 2.4.xx so some driver
or resource is trying to reuse a timer that doesn't exist anymore (if thats
the case).

Shawn.

