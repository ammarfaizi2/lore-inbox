Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbUAQVHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 16:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUAQVHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 16:07:22 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:12684 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S266150AbUAQVHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 16:07:16 -0500
Date: Sat, 17 Jan 2004 22:07:15 +0100
From: Sander <sander@humilis.net>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Sander <sander@humilis.net>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: several oopses during boot (was: Re: [PATCH] Add CONFIG for -mregparm=3)
Message-ID: <20040117210715.GA15172@favonius>
Reply-To: sander@humilis.net
References: <20040114090603.GA1935@averell> <20040117201639.GA16420@favonius> <20040117205302.GA16658@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117205302.GA16658@colin2.muc.de>
X-Uptime: 20:45:26 up 31 days, 10:34, 39 users,  load average: 1.09, 1.08, 1.02
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote (ao):
> > 2.6.1-mm4
> 
> Note that this kernel is broken on gcc 3.4 and on 3.3-hammer. If
> you're using that disable the -funit-at-a-time setting in the main
> Makefile.

> > VIA C3 Ezra
> > 
> > It mounts its root filesystem over nfs and has netconsole compiled
> > in.
> > 
> > Without the REGPARM option the system boots and runs fine.
> > 
> > Should I post the oopses, the result of ksymoops, a dmesg and kernel
> > config or is this an already known issue?
> 
> Not known. Please post the decoded oopses.  Also give your compiler
> version.

Hope this helps. The system runs fine with the option disabled.

gcc (GCC) 3.3.3 20040110 (prerelease) (Debian)

I ran ksymoops on another system, but used the vmlinux and System.map
from the mentioned oopsing system.

The full output is very long (3657 lines), so I only post the fist 100
or so lines. Do you need them all?


ksymoops 2.4.9 on i686 2.6.0-test11.  Options used
     -v /tmp/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /tmp/System.map (specified)

Unable to handle kernel paging request at virtual address 249579f8
c012c19d
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 0000000d   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 00002323 23232323 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000202 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb
Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8'
  Garbage: 'Unable to handle kernel paging request at virtual address 249579f8'
Error (Oops_code_values): invalid value 0x1 in Code line, must be 2, 4, 8 or 16 digits, value ignored


>>EIP; c012c19d <sys_setsid+7d/a0>   <=====

>>eax; c1557940 <_end+119d158/3fc42818>
>>ebx; c1554000 <_end+1199818/3fc42818>
>>ecx; c1557a4c <_end+119d264/3fc42818>
>>edx; c1557990 <_end+119d1a8/3fc42818>
>>ebp; c1554000 <_end+1199818/3fc42818>
>>esp; c1555fb8 <_end+119b7d0/3fc42818>

Trace; c02a01d7 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c012c18a <sys_setsid+6a/a0>
00000000 <_EIP>:
Code;  c012c18a <sys_setsid+6a/a0>
   0:   00 00                     add    %al,(%eax)
Code;  c012c18c <sys_setsid+6c/a0>
   2:   52                        push   %edx
Code;  c012c18d <sys_setsid+6d/a0>
   3:   8b 80 88 00 00 00         mov    0x88(%eax),%eax
Code;  c012c193 <sys_setsid+73/a0>
   9:   50                        push   %eax
Code;  c012c194 <sys_setsid+74/a0>
   a:   e8 0f 49 ff ff            call   ffff491e <_EIP+0xffff491e>
Code;  c012c199 <sys_setsid+79/a0>
   f:   5e                        pop    %esi
Code;  c012c19a <sys_setsid+7a/a0>
  10:   58                        pop    %eax
Code;  c012c19b <sys_setsid+7b/a0>
  11:   8b 03                     mov    (%ebx),%eax

This decode from eip onwards should be reliable

Code;  c012c19d <sys_setsid+7d/a0>
00000000 <_EIP>:

c012c19d
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 0000000e   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 61630053 32323232 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000246 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb
Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8'
  Garbage: 'Unable to handle kernel paging request at virtual address 249579f8'
Error (Oops_code_values): invalid value 0x1 in Code line, must be 2, 4, 8 or 16 digits, value ignored


>>EIP; c012c19d <sys_setsid+7d/a0>   <=====

>>eax; c1557940 <_end+119d158/3fc42818>
>>ebx; c1554000 <_end+1199818/3fc42818>
>>ecx; c1557a4c <_end+119d264/3fc42818>
>>edx; c1557990 <_end+119d1a8/3fc42818>
>>ebp; c1554000 <_end+1199818/3fc42818>
>>esp; c1555fb8 <_end+119b7d0/3fc42818>

Trace; c02a01d7 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c012c18a <sys_setsid+6a/a0>
00000000 <_EIP>:
Code;  c012c18a <sys_setsid+6a/a0>
   0:   00 00                     add    %al,(%eax)
Code;  c012c18c <sys_setsid+6c/a0>
   2:   52                        push   %edx
Code;  c012c18d <sys_setsid+6d/a0>
   3:   8b 80 88 00 00 00         mov    0x88(%eax),%eax
Code;  c012c193 <sys_setsid+73/a0>
   9:   50                        push   %eax
Code;  c012c194 <sys_setsid+74/a0>
   a:   e8 0f 49 ff ff            call   ffff491e <_EIP+0xffff491e>
Code;  c012c199 <sys_setsid+79/a0>
   f:   5e                        pop    %esi
Code;  c012c19a <sys_setsid+7a/a0>
  10:   58                        pop    %eax
Code;  c012c19b <sys_setsid+7b/a0>
  11:   8b 03                     mov    (%ebx),%eax

This decode from eip onwards should be reliable

Code;  c012c19d <sys_setsid+7d/a0>
00000000 <_EIP>:

c012c19d
*pde = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c012c19d>]    Not tainted VLI
EFLAGS: 00010046
eax: c1557940   ebx: c1554000   ecx: c1557a4c   edx: c1557990
esi: 0000000f   edi: bffffaa0   ebp: c1554000   esp: c1555fb8
ds: 007b   es: 007b   ss: 0068
Stack: bffffba0 bffffb20 c02a01d7 bffffba0 61630053 32323232 bffffb20 bffffaa0 
       bffffcc8 00000042 0000007b 0000007b 00000042 400c8b17 00000073 00000246 
       bffff9fc 0000007b 
Call Trace:
 [<c02a01d7>] syscall_call+0x7/0xb
Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: 00 00 52 8b 80 88 00 00 00 50 e8 0f 49 ff ff 5e 58 8b 03 <1>Unable to handle kernel paging request at virtual address 249579f8'
  Garbage: 'Unable to handle kernel paging request at virtual address 249579f8'
Error (Oops_code_values): invalid value 0x1 in Code line, must be 2, 4, 8 or 16 digits, value ignored


>>EIP; c012c19d <sys_setsid+7d/a0>   <=====

>>eax; c1557940 <_end+119d158/3fc42818>
>>ebx; c1554000 <_end+1199818/3fc42818>
>>ecx; c1557a4c <_end+119d264/3fc42818>
>>edx; c1557990 <_end+119d1a8/3fc42818>
>>ebp; c1554000 <_end+1199818/3fc42818>
>>esp; c1555fb8 <_end+119b7d0/3fc42818>

Trace; c02a01d7 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c012c18a <sys_setsid+6a/a0>
00000000 <_EIP>:
Code;  c012c18a <sys_setsid+6a/a0>
   0:   00 00                     add    %al,(%eax)
Code;  c012c18c <sys_setsid+6c/a0>
   2:   52                        push   %edx
Code;  c012c18d <sys_setsid+6d/a0>
   3:   8b 80 88 00 00 00         mov    0x88(%eax),%eax
Code;  c012c193 <sys_setsid+73/a0>
   9:   50                        push   %eax
Code;  c012c194 <sys_setsid+74/a0>
   a:   e8 0f 49 ff ff            call   ffff491e <_EIP+0xffff491e>
Code;  c012c199 <sys_setsid+79/a0>
   f:   5e                        pop    %esi
Code;  c012c19a <sys_setsid+7a/a0>
  10:   58                        pop    %eax
Code;  c012c19b <sys_setsid+7b/a0>
  11:   8b 03                     mov    (%ebx),%eax


-- 
Humilis IT Services and Solutions
http://www.humilis.net
