Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVCAL2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVCAL2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVCAL2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:28:45 -0500
Received: from ns2.protei.ru ([195.239.28.26]:17865 "EHLO mail.protei.ru")
	by vger.kernel.org with ESMTP id S261877AbVCAL2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:28:38 -0500
Message-ID: <422451DA.3040802@protei.ru>
Date: Tue, 01 Mar 2005 14:28:26 +0300
From: Nickolay <nickolay@protei.ru>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: coywolf@gmail.com
Subject: Kernel Oopses, can anyone fix it?
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.610842, version=0.92.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guys!

I has some shit happens after 2-3 days system working.
After 2-3 days in kernel.debug i has many oopses.
Stock 2.4.27 kernel.
At time oopses started, system can't fork no one process.
Below first two:


OOPS No 1
-----------
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

KSYMOOPS Output for OOPS No 1
----------------------------------
 >>EIP; c0128e3c <kmem_cache_alloc+84/dc>   <=====

 >>ecx; dcbdd040 <_end+1c8bba6c/1f4e0a8c>
 >>edx; dc99b640 <_end+1c67a06c/1f4e0a8c>
 >>esi; c15dfc00 <_end+12be62c/1f4e0a8c>
 >>esp; db78bf64 <_end+1b46a990/1f4e0a8c>

Trace; c0113917 <do_fork+3ff/740>
Trace; c01177f4 <sys_time+14/54>
Trace; c0107398 <sys_fork+14/1c>
Trace; c01086d3 <system_call+33/40>

Code;  c0128e3c <kmem_cache_alloc+84/dc>
00000000 <_EIP>:
Code;  c0128e3c <kmem_cache_alloc+84/dc>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c0128e40 <kmem_cache_alloc+88/dc>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0128e43 <kmem_cache_alloc+8b/dc>
   7:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0128e46 <kmem_cache_alloc+8e/dc>
   a:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0128e49 <kmem_cache_alloc+91/dc>
   d:   75 25                     jne    34 <_EIP+0x34>
Code;  c0128e4b <kmem_cache_alloc+93/dc>
   f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c0128e4e <kmem_cache_alloc+96/dc>
  12:   8b 11                     mov    (%ecx),%edx



OOPS No 2
-----------
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


KSYMOOPS Output for OOPS No 2
----------------------------------
 >>EIP; c0128e3c <kmem_cache_alloc+84/dc>   <=====

 >>ecx; dcbdd040 <_end+1c8bba6c/1f4e0a8c>
 >>edx; db69a3a0 <_end+1b378dcc/1f4e0a8c>
 >>esi; c15dfc00 <_end+12be62c/1f4e0a8c>
 >>esp; db78bf64 <_end+1b46a990/1f4e0a8c>

Trace; c0113917 <do_fork+3ff/740>
Trace; c01304e3 <sys_llseek+cf/dc>
Trace; c0107398 <sys_fork+14/1c>
Trace; c01086d3 <system_call+33/40>

Code;  c0128e3c <kmem_cache_alloc+84/dc>
00000000 <_EIP>:
Code;  c0128e3c <kmem_cache_alloc+84/dc>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c0128e40 <kmem_cache_alloc+88/dc>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0128e43 <kmem_cache_alloc+8b/dc>
   7:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0128e46 <kmem_cache_alloc+8e/dc>
   a:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0128e49 <kmem_cache_alloc+91/dc>
   d:   75 25                     jne    34 <_EIP+0x34>
Code;  c0128e4b <kmem_cache_alloc+93/dc>
   f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c0128e4e <kmem_cache_alloc+96/dc>
  12:   8b 11                     mov    (%ecx),%edx


