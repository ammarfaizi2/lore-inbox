Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263954AbSJTSkG>; Sun, 20 Oct 2002 14:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263966AbSJTSkG>; Sun, 20 Oct 2002 14:40:06 -0400
Received: from ns0.cobite.com ([208.222.80.10]:49423 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S263954AbSJTSkF>;
	Sun, 20 Oct 2002 14:40:05 -0400
Date: Sun, 20 Oct 2002 14:46:05 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Keith Owens <kaos@sgi.com>, <linux-kernel@vger.kernel.org>
Subject: [OOPS] in kdb v2.3 on top of 2.5.44
Message-ID: <Pine.LNX.4.44.0210201440150.30018-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Keith, list,

I tried patching the 2.5.44 vanilla kernel with the 2.3 you released for
2.5.43.  The patching had only a few rejects, which were completely
trivial, but perhaps this mis-match of kernel to patch version caused the
oops, but here it is (starting from me successfully executing a few
commands inside the debugger):

[ snip kernel boot and beginning of kdb session ]

[1]kdb> bt
EBP        EIP        Function (args)
0xc0106ee0 0xc0106f0a default_idle+0x2a (0x0, 0x0, 0x0)
                               kernel .text 0xc0100000 0xc0106ee0 
0xc0106f20
           0xc0106fb2 cpu_idle+0x52
                               kernel .text 0xc0100000 0xc0106f60 
0xc0106fd0
           0xc0452dfd start_secondary+0x6d
                               kernel .init.text 0xc044c000 0xc0452d90 
0xc0452e00
[1]kdb> go

[ time passes here while I use the system a bit - then I do ctrl-a again ]

Entering kdb (current=0xc0420e20, pid 0) on processor 0 due to Keyboard 
Entry
Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
c02b77c4
*pde = 00000000
Oops: 0002
 
CPU:    0
EIP:    0060:[<c02b77c4>]    Not tainted
EFLAGS: 00010006
EIP is at kdba_setjmp+0x4/0x50
eax: 00000000   ebx: c044a000   ecx: 00000001   edx: 00000000
esi: 00000004   edi: c034409f   ebp: c044a000   esp: c044be1c
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=c044a000 task=c0420e20)
Stack: c02084ec c04d4c40 00000000 00000000 00000000 00000000 00000000 
00000002 
       ae50ded0 1750ded0 00000000 00000000 c036952e ffffffff c0369532 
00000000 
       c02b7229 c036952e c036952e c044a000 c044a000 00000008 00000000 
c020872c 
Call Trace:
 [<c02084ec>] kdb_local+0x2cc/0x3e0
 [<c02b7229>] kdba_getregcontents+0x119/0x280
 [<c020872c>] kdb_main_loop+0xbc/0x220
 [<c02b76e4>] kdba_main_loop+0x54/0x60
 [<c0208e49>] kdb+0x5b9/0x7e0
 [<c0233c4c>] receive_chars+0x9c/0x290
 [<c0234098>] serial8250_interrupt+0x88/0x120
 [<c010ae9a>] handle_IRQ_event+0x3a/0x60
 [<c010b0e6>] do_IRQ+0xc6/0x160
 [<c0106ee0>] default_idle+0x0/0x40
 [<c0106ee0>] default_idle+0x0/0x40
 [<c01098d4>] common_interrupt+0x18/0x20
 [<c0106ee0>] default_idle+0x0/0x40
 [<c0106ee0>] default_idle+0x0/0x40
 [<c0106f0a>] default_idle+0x2a/0x40
 [<c0106fb2>] cpu_idle+0x52/0x70
 [<c0105000>] stext+0x0/0x60
 [<c0105051>] stext+0x51/0x60

Code: 89 58 00 89 70 04 89 78 08 8b 0c 24 89 48 0c 8d 4c 24 08 89 
 kdb: Debugger re-entered on cpu 0, new reason = 5
     Not executing a kdb command
     No longjmp available for recovery
     Cannot recover, allowing event to proceed
<0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 
My system is a dual PII-450 with 1GB ram (highmem 4g) running all SCSI
with an adaptec aic7xxx.  System is redhat 7.3 based with official
updates.

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

