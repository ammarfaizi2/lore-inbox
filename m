Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRJJUoy>; Wed, 10 Oct 2001 16:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRJJUoo>; Wed, 10 Oct 2001 16:44:44 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:65086 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272074AbRJJUoa>; Wed, 10 Oct 2001 16:44:30 -0400
Message-ID: <3BC4B34C.BB45D829@redhat.com>
Date: Wed, 10 Oct 2001 16:45:00 -0400
From: Bob Matthews <bmatthews@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: 2.4.11 oops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I've received an oops while booting 2.4.11 on two different SMP
machines.  The kernel was SMP, HIGHMEM=64G with sym53c8xx, 3c59x,
eepro100, aic7xx and megaraid drivers statically linked.

Oops follows.  (Note: copied by hand, use with caution.)

ksymoops 2.4.0 on i686 2.4.2-2smp.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (specified)

CPU:    1
EIP:    0010: [<c013d941>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 37e8ace4   ebx: 00000001     ecx: 00000001       edx: c02e1990
esi: f7dc6f44   edi: c02e1960     ebp: c2014000       esp: c2015c74
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 1, stackpage=c2015000)
Stack: 00000000 c02e1440 c02e1944 f7e7eaa4 c2014000 c013dab9 00000000
00000000
       f7e8ad0c e2015d5c c209ea0d 00000000 c014f3fc c2015e3c 00000124
00000202
       00000001 00000001 00000000 00000000 00000000 ffffffff 00000bb8
00000001
Call Trace: [<c013dab9>] [<c014f3fc>] [<c0111fe7>] [<c011965d>]
[<c014efd0>] [<c013e1ac>] [<c013e45d>] [<c013f3fe>] [<c0105ab0>]
[<c0106f6b>] [<c0110018>] [<c0105184>] [<c0105000>] [<c0105656>]
[<c0105070>]
Code: 0f 22 d8 eb 7d 8d 04 dd 00 00 00 00 ba 01 00 00 00 39 b8 40

>>EIP; c013d941 <exec_mmap+111/1f0>   <=====
Trace; c013dab9 <flush_old_exec+99/2f0>
Trace; c014f3fc <load_elf_binary+42c/a60>
Trace; c0111fe7 <schedule+407/630>
Trace; c011965d <__run_task_queue+5d/70>
Trace; c014efd0 <load_elf_binary+0/a60>
Trace; c013e1ac <search_binary_handler+8c/1c0>
Trace; c013e45d <do_execve+17d/1e0>
Trace; c013f3fe <getname+5e/a0>
Trace; c0105ab0 <sys_execve+30/60>
Trace; c0106f6b <system_call+33/38>
Trace; c0110018 <pin_2_irq+8/d0>
Trace; c0105184 <init+114/190>
Trace; c0105000 <_stext+0/0>
Trace; c0105656 <kernel_thread+26/30>
Trace; c0105070 <init+0/190>
Code;  c013d941 <exec_mmap+111/1f0>
00000000 <_EIP>:
Code;  c013d941 <exec_mmap+111/1f0>   <=====
   0:   0f 22 d8                  mov    %eax,%cr3   <=====
Code;  c013d944 <exec_mmap+114/1f0>
   3:   eb 7d                     jmp    82 <_EIP+0x82> c013d9c3
<exec_mmap+193/1f0>
Code;  c013d946 <exec_mmap+116/1f0>
   5:   8d 04 dd 00 00 00 00      lea    0x0(,%ebx,8),%eax
Code;  c013d94d <exec_mmap+11d/1f0>
   c:   ba 01 00 00 00            mov    $0x1,%edx
Code;  c013d952 <exec_mmap+122/1f0>
  11:   39 b8 40 00 00 00         cmp    %edi,0x40(%eax)

-- 
Bob Matthews
Red Hat, Inc.
