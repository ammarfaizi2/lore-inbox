Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291144AbSAaQiR>; Thu, 31 Jan 2002 11:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291143AbSAaQiI>; Thu, 31 Jan 2002 11:38:08 -0500
Received: from mail.spylog.com ([194.67.35.220]:46816 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S291145AbSAaQhv>;
	Thu, 31 Jan 2002 11:37:51 -0500
Date: Thu, 31 Jan 2002 19:37:44 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: drbd-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: (BUG): drbd 0.6.1-pre9 + 2.4.17
Message-ID: <20020131163744.GA3054@an.local>
Mail-Followup-To: drbd-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

1. drbd module 2.4.17
2. kernel 2.4.17 (1CPU/no highmem)
3. 

...
EXT3-fs: mounted filesystem with ordered data mode.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
kernel BUG at slab.c:1200!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0126c71>]    Not tainted
EFLAGS: 00010082
eax: 0000001b   ebx: c180f2e0   ecx: c02ab200   edx: 00002df3
esi: 00000000   edi: de775974   ebp: de2f700d   esp: ddc49ee8
ds: 0018   es: 0018   ss: 0018
Process exportfs (pid: 978, stackpage=ddc49000)
Stack: c0255c0c 000004b0 de775974 de2f700d de2f700d c180f2e0 c0127240 c180f2e0 
       de775974 de2f700d ddc49f8c ffffffd8 ddbec9d4 ddc49f84 de8da824 00001000 
       de2f700d 00000246 c0137973 c180f2e0 de2f700d ddc49f8c ddbec9d4 40139944 
Call Trace: [<c0127240>] [<c0137973>] [<c012dc37>] [<c012df7c>] [<c0106d4b>] 

Code: 0f 0b 83 c4 08 8b 5f 14 83 fb ff 74 23 89 f6 39 f3 75 14 68 
 <6>drbd0: Connection established. size=4194688 KB / blksize=4096 B
drbd0: predetermined states are in contradiction to GC's
drbd0: Synchronisation started blks=15 int=1 
drbd1: Connection established. size=7034688 KB / blksize=4096 B
drbd1: predetermined states are in contradiction to GC's
drbd1: Synchronisation started blks=15 int=1 
...

4. ksymoops:
... 

kernel BUG at slab.c:1200!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0126c71>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001b   ebx: c180f2e0   ecx: c02ab200   edx: 00002df3
esi: 00000000   edi: de775974   ebp: de2f700d   esp: ddc49ee8
ds: 0018   es: 0018   ss: 0018
Process exportfs (pid: 978, stackpage=ddc49000)
Stack: c0255c0c 000004b0 de775974 de2f700d de2f700d c180f2e0 c0127240 c180f2e0 
       de775974 de2f700d ddc49f8c ffffffd8 ddbec9d4 ddc49f84 de8da824 00001000 
       de2f700d 00000246 c0137973 c180f2e0 de2f700d ddc49f8c ddbec9d4 40139944 
Call Trace: [<c0127240>] [<c0137973>] [<c012dc37>] [<c012df7c>] [<c0106d4b>] 
Code: 0f 0b 83 c4 08 8b 5f 14 83 fb ff 74 23 89 f6 39 f3 75 14 68 

>>EIP; c0126c70 <kmem_extra_free_checks+50/88>   <=====
Trace; c0127240 <kmem_cache_free+1d8/258>
Trace; c0137972 <open_namei+5b6/5cc>
Trace; c012dc36 <filp_open+3a/5c>
Trace; c012df7c <sys_open+38/b4>
Trace; c0106d4a <system_call+32/38>
Code;  c0126c70 <kmem_extra_free_checks+50/88>
00000000 <_EIP>:
Code;  c0126c70 <kmem_extra_free_checks+50/88>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0126c72 <kmem_extra_free_checks+52/88>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0126c74 <kmem_extra_free_checks+54/88>
   5:   8b 5f 14                  mov    0x14(%edi),%ebx
Code;  c0126c78 <kmem_extra_free_checks+58/88>
   8:   83 fb ff                  cmp    $0xffffffff,%ebx
Code;  c0126c7a <kmem_extra_free_checks+5a/88>
   b:   74 23                     je     30 <_EIP+0x30> c0126ca0 <kmem_extra_free_checks+80/88>
Code;  c0126c7c <kmem_extra_free_checks+5c/88>
   d:   89 f6                     mov    %esi,%esi
Code;  c0126c7e <kmem_extra_free_checks+5e/88>
   f:   39 f3                     cmp    %esi,%ebx
Code;  c0126c80 <kmem_extra_free_checks+60/88>
  11:   75 14                     jne    27 <_EIP+0x27> c0126c96 <kmem_extra_free_checks+76/88>
Code;  c0126c82 <kmem_extra_free_checks+62/88>
  13:   68 00 00 00 00            push   $0x0

-- 
bye.
Andrey Nekrasov, SpyLOG.
