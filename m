Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVB1Ra2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVB1Ra2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 12:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVB1Ra2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 12:30:28 -0500
Received: from 87.202.leased.lanck.net ([62.152.87.202]:22440 "EHLO
	mail.protei.ru") by vger.kernel.org with ESMTP id S261702AbVB1RaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 12:30:06 -0500
Message-ID: <42235512.7040507@protei.ru>
Date: Mon, 28 Feb 2005 20:29:54 +0300
From: Nickolay <nickolay@protei.ru>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops after 2-3 days working...
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.752237, version=0.92.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guys!

I has host, running my applications.
After 2-3 days, i can't logon to system via network, and can't login 
from console.
In kernel.debug many oopses for processes telnetd, sshd, crond, bash and 
other...
Kernel - stock 2.4.27.
After oopsing started, system working 5-6 hours and hanged.
I try move my applications to other host, and has same trouble :(

Here is first oops:

Jan  2 16:43:00 localhost kernel: Unable to handle kernel paging request 
at virtual address b0bdd054
Jan  2 16:43:00 localhost kernel:  printing eip:
Jan  2 16:43:00 localhost kernel: c0128e3c
Jan  2 16:43:00 localhost kernel: *pde = 00000000
Jan  2 16:43:00 localhost kernel: Oops: 0000
Jan  2 16:43:00 localhost kernel: CPU:    0
Jan  2 16:43:00 localhost kernel: EIP:    0010:[<c0128e3c>]    Not tainted
Jan  2 16:43:00 localhost kernel: EFLAGS: 00010883
Jan  2 16:43:00 localhost kernel: eax: 34ffffff   ebx: 9ffffae0   ecx: 
dcbdd040   edx: dc99b640
Jan  2 16:43:00 localhost kernel: esi: c15dfc00   edi: 00000246   ebp: 
000001f0   esp: db78bf64
Jan  2 16:43:00 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 16:43:00 localhost kernel: Process crond (pid: 445, 
stackpage=db78b000)
Jan  2 16:43:00 localhost kernel: Stack: d1724000 ded07280 d17245a0 
00000011 c0113917 c15dfc00 000001f0 db78a000
Jan  2 16:43:00 localhost kernel:        0804ea20 00000001 db78bfbc 
00000000 fffffff4 00000296 db78a000 00000000
Jan  2 16:43:00 localhost kernel:        c01177f4 c0107398 00000011 
bffffccc db78bfc4 00000000 bffffcd8 c01086d3
Jan  2 16:43:00 localhost kernel: Call Trace:    [<c0113917>] 
[<c01177f4>] [<c0107398>] [<c01086d3>]
Jan  2 16:43:00 localhost kernel:
Jan  2 16:43:00 localhost kernel: Code: 8b 44 81 18 89 41 14 03 59 0c 83 
f8 ff 75 25 8b 41 04 8b 11

Here is ksymoops output for first oops:
 >>EIP; c0128e3c <filemap_sync+5c/230>   <=====

 >>ecx; dcbdd040 <_end+1c884bc8/205d2be8>
 >>edx; dc99b640 <_end+1c6431c8/205d2be8>
 >>esi; c15dfc00 <_end+1287788/205d2be8>
 >>esp; db78bf64 <_end+1b433aec/205d2be8>

Trace; c0113917 <sleep_on_timeout+1c7/490>
Trace; c01177f4 <try_inc_mod_count+674/15e0>
Trace; c0107398 <__up_wakeup+1628/1650>
Trace; c01086d3 <dump_stack+1313/1610>

Code;  c0128e3c <filemap_sync+5c/230>
00000000 <_EIP>:
Code;  c0128e3c <filemap_sync+5c/230>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c0128e40 <filemap_sync+60/230>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0128e43 <filemap_sync+63/230>
   7:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0128e46 <filemap_sync+66/230>
   a:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0128e49 <filemap_sync+69/230>
   d:   75 25                     jne    34 <_EIP+0x34>
Code;  c0128e4b <filemap_sync+6b/230>
   f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c0128e4e <filemap_sync+6e/230>
  12:   8b 11                     mov    (%ecx),%edx

#################################################
This is oops number 2:

Jan  2 16:43:01 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address b0bdd054
Jan  2 16:43:01 localhost kernel:  printing eip:
Jan  2 16:43:01 localhost kernel: c0128e3c
Jan  2 16:43:01 localhost kernel: *pde = 00000000
Jan  2 16:43:01 localhost kernel: Oops: 0000
Jan  2 16:43:01 localhost kernel: CPU:    0
Jan  2 16:43:01 localhost kernel: EIP:    0010:[<c0128e3c>]    Not tainted
Jan  2 16:43:01 localhost kernel: EFLAGS: 00010883
Jan  2 16:43:01 localhost kernel: eax: 34ffffff   ebx: 9ffffae0   ecx: 
dcbdd040   edx: db69a3a0
Jan  2 16:43:01 localhost kernel: esi: c15dfc00   edi: 00000246   ebp: 
000001f0   esp: db78bf64
Jan  2 16:43:01 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 16:43:01 localhost kernel: Process log_script.sh (pid: 9286, 
stackpage=db78b000)
Jan  2 16:43:01 localhost kernel: Stack: dc56e000 ded07280 dc56e5a0 
00000011 c0113917 c15dfc00 000001f0 db78a000
Jan  2 16:43:01 localhost kernel:        bffff7d0 00000000 db78bfbc 
00000000 fffffff4 bffff708 dc9845c0 c01304e3
Jan  2 16:43:01 localhost kernel:        db78a000 c0107398 00000011 
bffff74c db78bfc4 00000000 bffff868 c01086d3
Jan  2 16:43:01 localhost kernel: Call Trace:    [<c0113917>] 
[<c01304e3>] [<c0107398>] [<c01086d3>]
Jan  2 16:43:01 localhost kernel:
Jan  2 16:43:01 localhost kernel: Code: 8b 44 81 18 89 41 14 03 59 0c 83 
f8 ff 75 25 8b 41 04 8b 11

This is ksymoops output for oops number 2:

 >>EIP; c0128e3c <filemap_sync+5c/230>   <=====

 >>ecx; dcbdd040 <_end+1c884bc8/205d2be8>
 >>edx; db69a3a0 <_end+1b341f28/205d2be8>
 >>esi; c15dfc00 <_end+1287788/205d2be8>
 >>esp; db78bf64 <_end+1b433aec/205d2be8>

Trace; c0113917 <sleep_on_timeout+1c7/490>
Trace; c01304e3 <free_pages+683/20b0>
Trace; c0107398 <__up_wakeup+1628/1650>
Trace; c01086d3 <dump_stack+1313/1610>

Code;  c0128e3c <filemap_sync+5c/230>
00000000 <_EIP>:
Code;  c0128e3c <filemap_sync+5c/230>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c0128e40 <filemap_sync+60/230>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0128e43 <filemap_sync+63/230>
   7:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0128e46 <filemap_sync+66/230>
   a:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0128e49 <filemap_sync+69/230>
   d:   75 25                     jne    34 <_EIP+0x34>
Code;  c0128e4b <filemap_sync+6b/230>
   f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c0128e4e <filemap_sync+6e/230>
  12:   8b 11                     mov    (%ecx),%edx


