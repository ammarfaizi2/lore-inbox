Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262047AbTCZTkz>; Wed, 26 Mar 2003 14:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262051AbTCZTkl>; Wed, 26 Mar 2003 14:40:41 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:10760 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S262047AbTCZTiv>;
	Wed, 26 Mar 2003 14:38:51 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.66] slab corruption
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Wed, 26 Mar 2003 20:11:32 +0100
Message-ID: <871y0uhriz.fsf@echidna.jochen.org>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is when shutting down.  I have the two patches from Jack Simmons
for the illegal context and the broken cursor applied and nothing
else.

uhci-hcd 00:07.2: remove, state 3
usb usb1: USB disconnect, address 1
Slab corruption: start=c5e0b21c, expend=c5e0b2db, problemat=c5e0b224
Last user: [<c0166732>](load_elf_binary+0x86e/0xb0c)
Data: ********00 **************************************************************************************************************************************************************************************A5 
Next: 71 F0 2C .32 67 16 C0 A5 C2 0F 17 E0 5F 3B C0 48 E2 E0 C5 34 E9 D2 C3 00 00 00 00 00 00 00 00 
slab error in check_poison_obj(): cache `size-192': object was modified after freeing
Call Trace:
 [<c01308dd>] __slab_error+0x21/0x28
 [<c0130ccc>] check_poison_obj+0x174/0x180
 [<c0131f8a>] kmalloc+0xc6/0x174
 [<c0165fd5>] load_elf_binary+0x111/0xb0c
 [<c0165fd5>] load_elf_binary+0x111/0xb0c
 [<c012ea2f>] buffered_rmqueue+0xff/0x110
 [<c012eace>] __alloc_pages+0x8e/0x274
 [<c014c9ad>] search_binary_handler+0xcd/0x260
 [<c0165ec4>] load_elf_binary+0x0/0xb0c
 [<c014cca8>] do_execve+0x168/0x1f0
 [<c0107873>] sys_execve+0x2f/0x68
 [<c0108d4b>] syscall_call+0x7/0xb

uhci-hcd 00:07.2: USB bus 1 deregistered
uhci-hcd 00:07.2: dangling refs (1) to bus 1!
Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c011ef6f
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c011ef6f>]    Not tainted
EFLAGS: 00010012
EIP is at run_timer_softirq+0xd7/0x138
eax: 6b6b6b6b   ebx: c2f64000   ecx: c5e24254   edx: 6b6b6b6b
esi: c03775c0   edi: 6b6b6b6b   ebp: c2f65f84   esp: c2f65f70
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1391, threadinfo=c2f64000 task=c36aa140)
Stack: 00000011 c0412868 ffffffdd 00000150 6b6b6b6b c2f65fa0 c011b981 c0412868 
       c2f64000 c2f64000 c03eba00 00000046 c2f65fbc c010a360 400114ac 080486e0 
       400116d8 c037650c 00000000 bffff838 c0108eb8 400114ac 0804aa70 00000007 
Call Trace:
 [<c011b981>] do_softirq+0x51/0xb0
 [<c010a360>] <1>Unable to handle kernel paging request at virtual address c6c0e000
 printing eip:
c0261229
*pde = 05ea4067
*pte = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c0261229>]    Not tainted
EFLAGS: 00010012
EIP is at bitfill32+0x99/0x1e0
eax: c6c0e000   ebx: c6c0e000   ecx: 00000000   edx: 00002000
esi: 00000000   edi: 00002000   ebp: c2f65af0   esp: c2f65ac0
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1391, threadinfo=c2f64000 task=c36aa140)
Stack: c6c0e000 c034f5a0 00000092 c6c0e000 c034f5a0 00000092 00000000 c0261190 
       00000000 c6c0e000 00000000 ffffffff c2f65b44 c0261bd0 c6c0e000 00000000 
       00000000 00002000 00000000 00000400 00000800 00000010 00000010 00000008 
Call Trace:
 [<c0261190>] bitfill32+0x0/0x1e0
 [<c0261bd0>] cfb_fillrect+0x180/0x290
 [<c02608e9>] neofb_fillrect+0x29/0x30
 [<c0259376>] accel_clear+0x7a/0x84
 [<c025a130>] fbcon_clear+0x114/0x120
 [<c025b224>] fbcon_scroll+0x754/0x994
 [<c021efa5>] scrup+0x71/0x108
 [<c02204cf>] lf+0x33/0x64
 [<c0222da4>] vt_console_print+0x198/0x2c4
 [<c0118b37>] __call_console_drivers+0x3b/0x50
 [<c0118b9c>] _call_console_drivers+0x50/0x58
 [<c0118c5c>] call_console_drivers+0xb8/0xe8
 [<c0118ef7>] release_console_sem+0x5b/0xd0
 [<c0118e1f>] printk+0x127/0x158
 [<c012ae5a>] __print_symbol+0x106/0x11c
 [<c010a360>] do_IRQ+0x114/0x130
 [<c010a360>] do_IRQ+0x114/0x130
 [<c010910c>] show_trace+0x6c/0x8c
 [<c010a360>] do_IRQ+0x114/0x130
 [<c01091b8>] show_stack+0x68/0x74
 [<c01092d3>] show_registers+0xfb/0x164
 [<c0109424>] die+0x60/0x84
 [<c011400c>] do_page_fault+0x2dc/0x40e
 [<c0113d30>] do_page_fault+0x0/0x40e
 [<c013b7d7>] pte_chain_alloc+0x1b/0x84
 [<c0137884>] do_no_page+0x2b0/0x2bc
 [<c01379bb>] handle_mm_fault+0x6b/0x120
 [<c0126564>] rcu_check_callbacks+0x54/0x58
 [<c0114fcb>] scheduler_tick+0x63/0x2e4
 [<c011ee70>] update_process_times+0x2c/0x38
 [<c0108ef5>] error_code+0x2d/0x38
 [<c011ef6f>] run_timer_softirq+0xd7/0x138
 [<c011b981>] do_softirq+0x51/0xb0
 [<c010a360>] do_IRQ+0x114/0x130
 [<c0108eb8>] common_interrupt+0x18/0x20

Code: 8b 10 89 f0 31 d0 23 45 fc 31 d0 8b 55 f4 89 02 8b 4d 0c 83 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 
-- 
#include <~/.signature>: permission denied
