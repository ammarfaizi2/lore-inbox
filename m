Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSHBBH6>; Thu, 1 Aug 2002 21:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSHBBH6>; Thu, 1 Aug 2002 21:07:58 -0400
Received: from mail305.mail.bellsouth.net ([205.152.58.165]:24613 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S317385AbSHBBH5>; Thu, 1 Aug 2002 21:07:57 -0400
Date: Thu, 1 Aug 2002 21:11:20 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@elte.hu>, george anzinger <george@mvista.com>,
       <rml@tech9.net>
Subject: 2.5.30: LTP process_stress causes oops with DEBUG_SLAB and PREEMPT
Message-ID: <Pine.LNX.4.43.0208012053100.409-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Text Project's process stress test
(ltp-20020709/testcases/kernel/sched/process_stress/process.c) causes a
reproducable oops on 2.5.30 (and .29, and .28) if DEBUG_SLAB and PREEMPT
are enabled (tested with two different x86 machines).

Run the process program as './process -b 2 -d 2', and watch an oops a
second later on your serial console

The LTP can be downloaded from
http://prdownloads.sourceforge.net/ltp/ltp-20020709.tgz?download

Unable to handle kernel paging request at virtual address 5a5a5ace
c011230f
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011230f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010813
eax: d29c4000   ebx: d3c00040   ecx: d3d80b68   edx: 5a5a5a5a
esi: 000415f4   edi: d29c6040   ebp: d29c5f18   esp: d29c5f00
ds: 0018   es: 0018   ss: 0018
Stack: d29c5f2c 000415f4 00000104 d29c6040 d3d9bb7c 00000212 d29c5f70 c011cab7
       d29c5f2c 00000000 d295c664 c0302724 c0302724 000415f4 d29c6040 c011ca2c
       c0143431 00000001 00000004 d3b44414 00000000 00000100 d29c4000 0000000a
Call Trace: [<c011cab7>] [<c011ca2c>] [<c0143431>] [<c01437cc>] [<c01087a7>]
Code: 0f ba 6a 74 00 8b 42 0c 05 00 00 00 40 0f 22 d8 8b 82 98 00


>>EIP; c011230f <schedule+18f/2a4>   <=====

>>eax; d29c4000 <END_OF_CODE+1269b3bc/????>
>>ebx; d3c00040 <END_OF_CODE+138d73fc/????>
>>ecx; d3d80b68 <END_OF_CODE+13a57f24/????>
>>edx; 5a5a5a5a Before first symbol
>>esi; 000415f4 Before first symbol
>>edi; d29c6040 <END_OF_CODE+1269d3fc/????>
>>ebp; d29c5f18 <END_OF_CODE+1269d2d4/????>
>>esp; d29c5f00 <END_OF_CODE+1269d2bc/????>

Trace; c011cab7 <schedule_timeout+7f/a0>
Trace; c011ca2c <process_timeout+0/c>
Trace; c0143431 <do_select+1cd/210>
Trace; c01437cc <sys_select+330/480>
Trace; c01087a7 <syscall_call+7/b>

Code;  c011230f <schedule+18f/2a4>
00000000 <_EIP>:
Code;  c011230f <schedule+18f/2a4>   <=====
   0:   0f ba 6a 74 00            btsl   $0x0,0x74(%edx)   <=====
Code;  c0112314 <schedule+194/2a4>
   5:   8b 42 0c                  mov    0xc(%edx),%eax
Code;  c0112317 <schedule+197/2a4>
   8:   05 00 00 00 40            add    $0x40000000,%eax
Code;  c011231c <schedule+19c/2a4>
   d:   0f 22 d8                  mov    %eax,%cr3
Code;  c011231f <schedule+19f/2a4>
  10:   8b 82 98 00 00 00         mov    0x98(%edx),%eax

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461




