Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262713AbSJCBHs>; Wed, 2 Oct 2002 21:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbSJCBHs>; Wed, 2 Oct 2002 21:07:48 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:28572
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262713AbSJCBHs>; Wed, 2 Oct 2002 21:07:48 -0400
Date: Wed, 2 Oct 2002 20:12:11 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: zwane@linuxpower.ca
Subject: Oops on 2.5.40, flush_tlb_mm
Message-ID: <Pine.LNX.4.44.0210021957140.14293-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Please keep my CC on any replies (i'm currently experiencing 
DNS problems and hence do not get lkml)

Dorking around in mozilla did this, the machine had completely locked up 
so this was from the serial;

Unable to handle kernel paging request at virtual address 5a5a5ad6
 printing eip:
c0115f2f
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<c0115f2f>]    Not tainted
EFLAGS: 00010202
EIP is at flush_tlb_mm+0x1f/0x90
eax: c1ce01a0   ebx: 5a5a5a5a   ecx: 00000000   edx: fffffffe
esi: 00400000   edi: c759d418   ebp: 00100000   esp: c2749f04
ds: 0068   es: 0068   ss: 0068
Process mozilla-bin (pid: 1396, threadinfo=c2748000 task=c1ce01a0)
Stack: c759d418 c01418ab 5a5a5a5a c759d418 c142d810 c0141a1a c142d810 c195263c 
       c012c577 00000001 00000000 c1ce01a0 41500000 00100073 00000002 c195263c 
       c0141c62 c195263c 41800000 41500000 00000025 00000025 c2fda834 00000073 
Call Trace:
 [<c01418ab>]change_protection+0x1bb/0x210
 [<c0141a1a>]mprotect_attempt_merge+0x11a/0x1d0
 [<c012c577>]update_process_times+0x27/0x30
 [<c0141c62>]mprotect_fixup+0x192/0x1b0
 [<c0141de7>]sys_mprotect+0x167/0x2f0
 [<c010bd67>]do_IRQ+0x1e7/0x200
 [<c0109477>]syscall_call+0x7/0xb

Code: 23 53 7c 39 58 60 75 38 8b 40 5c 85 c0 74 08 0f 20 d8 0f 22 

(gdb) list *flush_tlb_mm+0x1f
0xc0115f2f is in flush_tlb_mm (smp.c:451).
446     void flush_tlb_mm (struct mm_struct * mm)
447     {
448             unsigned long cpu_mask;
449
450             preempt_disable();
451             cpu_mask = mm->cpu_vm_mask & ~(1UL << smp_processor_id());
452
453             if (current->active_mm == mm) {
454                     if (current->mm)
455                             local_flush_tlb();

-- 
function.linuxpower.ca

