Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262900AbSJBART>; Tue, 1 Oct 2002 20:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSJBART>; Tue, 1 Oct 2002 20:17:19 -0400
Received: from tantale.fifi.org ([216.27.190.146]:64657 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S262900AbSJBARR>;
	Tue, 1 Oct 2002 20:17:17 -0400
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.22
References: <200210020007.g9207su26324@devserv.devel.redhat.com>
From: Philippe Troin <phil@fifi.org>
Date: 01 Oct 2002 17:22:40 -0700
In-Reply-To: <200210020007.g9207su26324@devserv.devel.redhat.com>
Message-ID: <877kh1adv3.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> 2.2.2 doesnt support gcc 3

There also is something else broken about it ;-)

It's been crashing repeatedly on one of my boxes with the following
oops:

----------------------------------------------------------------------
Unable to handle kernel paging request at virtual address 000ed0ac
current->tss.cr3 = 031ff000, %cr3 = 031ff000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c018464e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000ed0a4   ebx: 00000000   ecx: 00000807   edx: cae8be00
esi: c1c63e24   edi: 00000004   ebp: 00000008   esp: c1c63dcc
ds: 0018   es: 0018   ss: 0018
Process tripwire (pid: 4524, process nr: 108, stackpage=c1c63000)
Stack: 00000000 00000100 c8384620 c8384620 00076855 00000400 c8384620 00000807 
       00076855 c012e640 00000000 00000004 c1c63e24 cfbcd880 00000374 cfbcd880 
       00000000 c1c63ea4 00000807 00000004 cae8be00 00000000 cae8be00 c8795d20 
Call Trace: [<c012e640>] [<c012e81c>] [<c0122f0e>] [<c0122e4b>] [<c012330c>] [<c01bd025>] [<c01236b3>] 
       [<c0123600>] [<c0112217>] [<c0111b8a>] [<c012be3e>] [<c010c7ad>] [<c010a7d0>] 
Code: 28 8b 14 9e 8b 42 08 c1 e8 09 50 8d 42 10 50 8d 42 0e 50 31 

>>EIP; c018464e <ll_rw_block+ce/228>   <=====
Trace; c012e640 <brw_page+26c/368>
Trace; c012e81c <generic_readpage+8c/9c>
Trace; c0122f0e <try_to_read_ahead+f2/10c>
Trace; c0122e4b <try_to_read_ahead+2f/10c>
Trace; c012330c <do_generic_file_read+294/588>
Trace; c01bd025 <do_aic7xxx_isr+79/98>
Trace; c01236b3 <generic_file_read+63/7c>
Trace; c0123600 <file_read_actor+0/50>
Trace; c0112217 <do_level_ioapic_IRQ+9b/b0>
Trace; c0111b8a <smp_apic_timer_interrupt+16/20>
Trace; c012be3e <sys_read+c6/f8>
Trace; c010c7ad <apic_timer_interrupt+1d/28>
Trace; c010a7d0 <system_call+34/38>
Code;  c018464e <ll_rw_block+ce/228>
00000000 <_EIP>:
Code;  c018464e <ll_rw_block+ce/228>   <=====
   0:   28 8b 14 9e 8b 42         sub    %cl,0x428b9e14(%ebx)   <=====
Code;  c0184654 <ll_rw_block+d4/228>
   6:   08 c1                     or     %al,%cl
Code;  c0184656 <ll_rw_block+d6/228>
   8:   e8 09 50 8d 42            call   428d5016 <_EIP+0x428d5016> 02a59664 Before first symbol
Code;  c018465b <ll_rw_block+db/228>
   d:   10 50 8d                  adc    %dl,0xffffff8d(%eax)
Code;  c018465e <ll_rw_block+de/228>
  10:   42                        inc    %edx
Code;  c018465f <ll_rw_block+df/228>
  11:   0e                        push   %cs
Code;  c0184660 <ll_rw_block+e0/228>
  12:   50                        push   %eax
Code;  c0184661 <ll_rw_block+e1/228>
  13:   31 00                     xor    %eax,(%eax)
----------------------------------------------------------------------

See <873crzmb6b.fsf@ceramic.fifi.org> for more details.

2.2.21 has ran with more than 6 months uptime and the same workload.
2.2.22 crashes with the above oops every couple of days.

Phil.
