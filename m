Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTJEWVo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 18:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTJEWVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 18:21:44 -0400
Received: from lewis.CNS.CWRU.Edu ([129.22.104.62]:42529 "EHLO
	lewis.CNS.CWRU.Edu") by vger.kernel.org with ESMTP id S263990AbTJEWVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 18:21:31 -0400
Date: Sun, 05 Oct 2003 18:15:39 -0400
From: Justin Hibbits <jrh29@po.cwru.edu>
Subject: Re: BUG in 2.4.xx
In-reply-to: <20031005214833.GD1205@matchmail.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <7372DCC0-F781-11D7-86F4-000A95841F44@po.cwru.edu>
MIME-version: 1.0
X-Mailer: Apple Mail (2.552)
Content-type: text/plain; format=flowed; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, Oct 5, 2003, at 17:48 America/New_York, Mike Fedyk wrote:

> On Sun, Oct 05, 2003 at 02:48:31PM -0400, Justin Hibbits wrote:
>> (panic from 2.4.22, but panics also in 2.4.21)
>>
>> This is what I get when I have high memory support and preempt enabled
>> in any 2.4 kernel.  High mem set to 4GB.  If I disable preempt, all
>> works just fine.  If you need more help, I'll keep this kernel around.
>
> What exact kernel versions, with what prempt patch versions, and you 
> didn't
> run it through ksymoops, also mention those exact versions that this 
> oops is
> from.

That oops came from kernel 2.4.22, using Con Kolivas' patchset.  the 
output of ksymoops is at the end of this.  Not sure of the exact 
versions (can't find them in the patch file), but the patch is 
2.4.22-ck2.  (ksymoops 2.4.9)  If I screwed up on the ksymoops, it's 
probably because I can't boot that kernel enough to get even klogd 
running.

-Justin

No modules in ksyms, skipping objects
   /dev/ide/host0/bus0/target0/lun0:kernel BUG at sched.c:1263!
  CPU: 0
  EIP: 0010:[<c01aac85>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
  EFLAGS: 00010213
  eax: ffffffff ebx: c0148000 ecx: c01614e0 edx: c01614e0
  esi: 00000001 edi: 00000000 ebp: c0149f24 esp: c0149f0c
  ds: 0018 es: 0018
  Process swapper (pid: 0, stackpage=c01490000)
  Stack: c0149000 00000001 0000000 c0148000 00000001 00000000 c0149f30  
c01ab122
  c0148000 c0145d40 c01b3428 c0145d00 c01b3326 00000001 00000001
  c0145d40 fffffffe c01b310a c0145d40 c0148000 00000000 c0144f40 c0449f88
  Call Trace: [<c01ab122>] [<c01b3428>] [<c01b3326>] [<c01b310a>]  
[<c019e81a>]
          [<c019b4f0>] [<c01a0d33>] [<c019b4f0>] [<c019b513>] 
[<c019b569>]
          [<c019b25d>]
  Code: 0f 0b ef 04 58 9c 38 c0 b8 00 e0 ff ff 21 e0 ff 40 04 89 45


 >>EIP; c01aac85 <copy_mm+45/2b0>   <=====

 >>ebx; c0148000 <init_task_union+0/2000>
 >>ecx; c01614e0 <batch_tqueue+0/14>
 >>edx; c01614e0 <batch_tqueue+0/14>
 >>ebp; c0149f24 <init_task_union+1f24/2000>
 >>esp; c0149f0c <init_task_union+1f0c/2000>

Trace; c01ab122 <copy_files+132/290>
Trace; c01b3428 <access_process_vm+138/1c0>
Trace; c01b3326 <access_process_vm+36/1c0>
Trace; c01b310a <ptrace_attach+11a/210>
Trace; c019e81a <handle_vm86_fault+42a/9d0>
Trace; c019b4f0 <sys_rt_sigreturn+80/110>
Trace; c01a0d33 <sys_ipc+e3/270>
Trace; c019b4f0 <sys_rt_sigreturn+80/110>
Trace; c019b513 <sys_rt_sigreturn+a3/110>
Trace; c019b569 <sys_rt_sigreturn+f9/110>
Trace; c019b25d <restore_sigcontext+1d/140>

Code;  c01aac85 <copy_mm+45/2b0>
00000000 <_EIP>:
Code;  c01aac85 <copy_mm+45/2b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c01aac87 <copy_mm+47/2b0>
    2:   ef                        out    %eax,(%dx)
Code;  c01aac88 <copy_mm+48/2b0>
    3:   04 58                     add    $0x58,%al
Code;  c01aac8a <copy_mm+4a/2b0>
    5:   9c                        pushf
Code;  c01aac8b <copy_mm+4b/2b0>
    6:   38 c0                     cmp    %al,%al
Code;  c01aac8d <copy_mm+4d/2b0>
    8:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c01aac92 <copy_mm+52/2b0>
    d:   21 e0                     and    %esp,%eax
Code;  c01aac94 <copy_mm+54/2b0>
    f:   ff 40 04                  incl   0x4(%eax)
Code;  c01aac97 <copy_mm+57/2b0>
   12:   89 45 00                  mov    %eax,0x0(%ebp)

   <0>Kernel panic: Aiee, killing interrupt handler!

