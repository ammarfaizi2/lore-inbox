Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSJQMEm>; Thu, 17 Oct 2002 08:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSJQMDy>; Thu, 17 Oct 2002 08:03:54 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:10468 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261364AbSJQLuV> convert rfc822-to-8bit; Thu, 17 Oct 2002 07:50:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20pre11aa1
Date: Thu, 17 Oct 2002 22:04:50 +1000
User-Agent: KMail/1.4.3
References: <20021016165155.GE30254@dualathlon.random>
In-Reply-To: <20021016165155.GE30254@dualathlon.random>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210172204.50297.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

> Srihari, I would like if you could try to reproduce with this new one
> with CONFIG_SOUND=n.  Thanks!

No worries!

I tried it without sound and unfortunately it crashed few times. The good news 
is that it is very stable without agpgart and radeon (module or not) support.

These are the three oops with agpgart and radeon as modules:
------------------------------------------------------------------------------------------
ksymoops 2.4.5 on i686 2.4.20-pre11aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre11aa1/ (default)
     -m /boot/System.map-2.4.20-pre11aa1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 17 20:27:24 localhost kernel: Unable to handle kernel paging request at 
virtual address c68b8008
Oct 17 20:27:24 localhost kernel: c01180ae
Oct 17 20:27:24 localhost kernel: *pde = 068001e3
Oct 17 20:27:24 localhost kernel: Oops: 0000 2.4.20-pre11aa1 #3 Thu Oct 17 
20:18:58 EST 2002
Oct 17 20:27:24 localhost kernel: CPU:    0
Oct 17 20:27:24 localhost kernel: EIP:    0010:[<c01180ae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 17 20:27:24 localhost kernel: EFLAGS: 00013206
Oct 17 20:27:24 localhost kernel: eax: bfffec7c   ebx: c68b8000   ecx: 
c020de0c   edx: 00000018
Oct 17 20:27:24 localhost kernel: esi: 00000100   edi: bfffec7c   ebp: 
ffffffff   esp: c58f5f78
Oct 17 20:27:24 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 17 20:27:24 localhost kernel: Process modprobe (pid: 888, 
stackpage=c58f5000)
Oct 17 20:27:24 localhost kernel: Stack: dff82e04 00000000 00001000 00000000 
00000000 ffffffea c020dda0 bfffec7c 
Oct 17 20:27:24 localhost kernel:        080640e8 c01188a4 080640e8 00000100 
bfffec7c 00000004 c58f4000 00000100 
Oct 17 20:27:24 localhost kernel:        bfffec7c bfffeca8 c01074ff 00000000 
00000001 080640e8 00000100 bfffec7c 
Oct 17 20:27:24 localhost kernel: Call Trace:    [<c01188a4>] [<c01074ff>]
Oct 17 20:27:24 localhost kernel: Code: 8b 7b 08 89 e9 31 c0 f2 ae f7 d1 49 8d 
79 01 39 f7 77 7f 8b 


>>EIP; c01180ae <qm_modules+2e/140>   <=====

>>eax; bfffec7c Before first symbol
>>ebx; c68b8000 <[agpgart].bss.end+2c031e5/1c0a3265>
>>ecx; c020de0c <modlist_lock+0/0>
>>edi; bfffec7c Before first symbol
>>ebp; ffffffff <END_OF_CODE+202a3a58/????>
>>esp; c58f5f78 <[agpgart].bss.end+1c4115d/1c0a3265>

Trace; c01188a4 <sys_query_module+d4/1b0>
Trace; c01074ff <system_call+33/38>

Code;  c01180ae <qm_modules+2e/140>
00000000 <_EIP>:
Code;  c01180ae <qm_modules+2e/140>   <=====
   0:   8b 7b 08                  mov    0x8(%ebx),%edi   <=====
Code;  c01180b1 <qm_modules+31/140>
   3:   89 e9                     mov    %ebp,%ecx
Code;  c01180b3 <qm_modules+33/140>
   5:   31 c0                     xor    %eax,%eax
Code;  c01180b5 <qm_modules+35/140>
   7:   f2 ae                     repnz scas %es:(%edi),%al
Code;  c01180b7 <qm_modules+37/140>
   9:   f7 d1                     not    %ecx
Code;  c01180b9 <qm_modules+39/140>
   b:   49                        dec    %ecx
Code;  c01180ba <qm_modules+3a/140>
   c:   8d 79 01                  lea    0x1(%ecx),%edi
Code;  c01180bd <qm_modules+3d/140>
   f:   39 f7                     cmp    %esi,%edi
Code;  c01180bf <qm_modules+3f/140>
  11:   77 7f                     ja     92 <_EIP+0x92>
Code;  c01180c1 <qm_modules+41/140>
  13:   8b 00                     mov    (%eax),%eax

Oct 17 20:27:24 localhost kernel:  <1>Unable to handle kernel paging request 
at virtual address c56ac098
Oct 17 20:27:24 localhost kernel: c0119dd0
Oct 17 20:27:24 localhost kernel: *pde = 054001e3
Oct 17 20:27:24 localhost kernel: Oops: 0000 2.4.20-pre11aa1 #3 Thu Oct 17 
20:18:58 EST 2002
Oct 17 20:27:24 localhost kernel: CPU:    0
Oct 17 20:27:24 localhost kernel: EIP:    0010:[<c0119dd0>]    Not tainted
Oct 17 20:27:24 localhost kernel: EFLAGS: 00013206
Oct 17 20:27:24 localhost kernel: eax: 00000000   ebx: c56ac000   ecx: 
c4ad9000   edx: 00000000
Oct 17 20:27:24 localhost kernel: esi: c58f4000   edi: 000000b8   ebp: 
0000000b   esp: c58f5e2c
Oct 17 20:27:24 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 17 20:27:24 localhost kernel: Process modprobe (pid: 888, 
stackpage=c58f5000)
Oct 17 20:27:24 localhost kernel: Stack: c1587bb8 c4ad9ac0 c58f4000 00000000 
c58f4000 000000b8 0000000b c011a2c0 
Oct 17 20:27:24 localhost kernel:        c58f4000 c16f1880 c58f5f44 00000000 
000000b8 c58f4000 c0107bef 0000000b 
Oct 17 20:27:24 localhost kernel:        c01f1e2a 00000000 00000000 c01125a4 
c01f1e2a c58f5f44 00000000 dff82e00 
Oct 17 20:27:24 localhost kernel: Call Trace:    [<c011a2c0>] [<c0107bef>] 
[<c01125a4>] [<c0126aaa>] [<c01314e5>]
Oct 17 20:27:24 localhost kernel:   [<c0126dde>] [<c011244a>] [<c01276dc>] 
[<c01122a0>] [<c01075f0>] [<c01180ae>]
Oct 17 20:27:24 localhost kernel:   [<c01188a4>] [<c01074ff>]
Oct 17 20:27:24 localhost kernel: Code: 39 b3 98 00 00 00 0f 84 85 02 00 00 8b 
5b 50 81 fb 00 a0 21 


>>EIP; c0119dd0 <exit_notify+20/300>   <=====

>>ebx; c56ac000 <[agpgart].bss.end+19f71e5/1c0a3265>
>>ecx; c4ad9000 <[agpgart].bss.end+e241e5/1c0a3265>
>>esi; c58f4000 <[agpgart].bss.end+1c3f1e5/1c0a3265>
>>esp; c58f5e2c <[agpgart].bss.end+1c41011/1c0a3265>

Trace; c011a2c0 <do_exit+210/260>
Trace; c0107bef <die+7f/80>
Trace; c01125a4 <do_page_fault+304/5a0>
Trace; c0126aaa <do_no_page+8a/1c0>
Trace; c01314e5 <lru_cache_add+65/70>
Trace; c0126dde <handle_mm_fault+8e/160>
Trace; c011244a <do_page_fault+1aa/5a0>
Trace; c01276dc <zap_pmd_range+7c/80>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>
Trace; c01180ae <qm_modules+2e/140>
Trace; c01188a4 <sys_query_module+d4/1b0>
Trace; c01074ff <system_call+33/38>

Code;  c0119dd0 <exit_notify+20/300>
00000000 <_EIP>:
Code;  c0119dd0 <exit_notify+20/300>   <=====
   0:   39 b3 98 00 00 00         cmp    %esi,0x98(%ebx)   <=====
Code;  c0119dd6 <exit_notify+26/300>
   6:   0f 84 85 02 00 00         je     291 <_EIP+0x291>
Code;  c0119ddc <exit_notify+2c/300>
   c:   8b 5b 50                  mov    0x50(%ebx),%ebx
Code;  c0119ddf <exit_notify+2f/300>
   f:   81 fb 00 a0 21 00         cmp    $0x21a000,%ebx

Oct 17 20:27:24 localhost kernel:  <1>Unable to handle kernel paging request 
at virtual address c4db8098
Oct 17 20:27:24 localhost kernel: c0119dd0
Oct 17 20:27:24 localhost kernel: *pde = 04c001e3
Oct 17 20:27:24 localhost kernel: Oops: 0000 2.4.20-pre11aa1 #3 Thu Oct 17 
20:18:58 EST 2002
Oct 17 20:27:24 localhost kernel: CPU:    0
Oct 17 20:27:24 localhost kernel: EIP:    0010:[<c0119dd0>]    Not tainted
Oct 17 20:27:24 localhost kernel: EFLAGS: 00013206
Oct 17 20:27:24 localhost kernel: eax: 00000000   ebx: c4db8000   ecx: 
00000000   edx: 00000000
Oct 17 20:27:24 localhost kernel: esi: c58f4000   edi: 000002ac   ebp: 
0000000b   esp: c58f5ce0
Oct 17 20:27:24 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 17 20:27:24 localhost kernel: Process modprobe (pid: 888, 
stackpage=c58f5000)
Oct 17 20:27:24 localhost kernel: Stack: 00000020 00000400 c58f4000 00000000 
c58f4000 000002ac 0000000b c011a2c0 
Oct 17 20:27:24 localhost kernel:        c58f4000 00000000 c58f5df8 00000000 
000002ac c58f4000 c0107bef 0000000b 
Oct 17 20:27:24 localhost kernel:        c01f1e2a 00000000 00000000 c01125a4 
c01f1e2a c58f5df8 00000000 33323130 
Oct 17 20:27:24 localhost kernel: Call Trace:    [<c011a2c0>] [<c0107bef>] 
[<c01125a4>] [<c0131577>] [<c01278e8>]
Oct 17 20:27:24 localhost kernel:   [<c01122a0>] [<c01276dc>] [<c01122a0>] 
[<c01075f0>] [<c0119dd0>] [<c011a2c0>]
Oct 17 20:27:24 localhost kernel:   [<c0107bef>] [<c01125a4>] [<c0126aaa>] 
[<c01314e5>] [<c0126dde>] [<c011244a>]
Oct 17 20:27:24 localhost kernel:   [<c01276dc>] [<c01122a0>] [<c01075f0>] 
[<c01180ae>] [<c01188a4>] [<c01074ff>]
Oct 17 20:27:24 localhost kernel: Code: 39 b3 98 00 00 00 0f 84 85 02 00 00 8b 
5b 50 81 fb 00 a0 21 


>>EIP; c0119dd0 <exit_notify+20/300>   <=====

>>ebx; c4db8000 <[agpgart].bss.end+11031e5/1c0a3265>
>>esi; c58f4000 <[agpgart].bss.end+1c3f1e5/1c0a3265>
>>esp; c58f5ce0 <[agpgart].bss.end+1c40ec5/1c0a3265>

Trace; c011a2c0 <do_exit+210/260>
Trace; c0107bef <die+7f/80>
Trace; c01125a4 <do_page_fault+304/5a0>
Trace; c0131577 <__lru_cache_del+87/90>
Trace; c01278e8 <zap_pte_range+f8/150>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01276dc <zap_pmd_range+7c/80>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>
Trace; c0119dd0 <exit_notify+20/300>
Trace; c011a2c0 <do_exit+210/260>
Trace; c0107bef <die+7f/80>
Trace; c01125a4 <do_page_fault+304/5a0>
Trace; c0126aaa <do_no_page+8a/1c0>
Trace; c01314e5 <lru_cache_add+65/70>
Trace; c0126dde <handle_mm_fault+8e/160>
Trace; c011244a <do_page_fault+1aa/5a0>
Trace; c01276dc <zap_pmd_range+7c/80>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>
Trace; c01180ae <qm_modules+2e/140>
Trace; c01188a4 <sys_query_module+d4/1b0>
Trace; c01074ff <system_call+33/38>

Code;  c0119dd0 <exit_notify+20/300>
00000000 <_EIP>:
Code;  c0119dd0 <exit_notify+20/300>   <=====
   0:   39 b3 98 00 00 00         cmp    %esi,0x98(%ebx)   <=====
Code;  c0119dd6 <exit_notify+26/300>
   6:   0f 84 85 02 00 00         je     291 <_EIP+0x291>
Code;  c0119ddc <exit_notify+2c/300>
   c:   8b 5b 50                  mov    0x50(%ebx),%ebx
Code;  c0119ddf <exit_notify+2f/300>
   f:   81 fb 00 a0 21 00         cmp    $0x21a000,%ebx


1 warning issued.  Results may not be reliable.

These are the two oops with agpgart and radeon built-in the kernel:
------------------------------------------------------------------------------------------------
ksymoops 2.4.5 on i686 2.4.20-pre11aa1-agpdrm.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre11aa1-agpdrm/ (default)
     -m /boot/System.map-2.4.20-pre11aa1-agpdrm (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 17 21:22:29 localhost kernel: Unable to handle kernel paging request at 
virtual address c72b4034
Oct 17 21:22:29 localhost kernel: c0112b57
Oct 17 21:22:29 localhost kernel: *pde = 070001e3
Oct 17 21:22:29 localhost kernel: Oops: 0000 2.4.20-pre11aa1-agpdrm #6 Thu Oct 
17 21:11:50 EST 2002
Oct 17 21:22:29 localhost kernel: CPU:    0
Oct 17 21:22:29 localhost kernel: EIP:    0010:[<c0112b57>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 17 21:22:29 localhost kernel: EFLAGS: 00013086
Oct 17 21:22:29 localhost kernel: eax: 00000000   ebx: c8aaa000   ecx: 
c72b4000   edx: c8aabe78
Oct 17 21:22:29 localhost kernel: esi: 00000002   edi: c01f5f22   ebp: 
00003246   esp: c8aabd9c
Oct 17 21:22:29 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 17 21:22:29 localhost kernel: Process modprobe (pid: 1036, 
stackpage=c8aab000)
Oct 17 21:22:29 localhost kernel: Stack: c8aaa000 00000002 c6e3c000 c8aaa000 
c01124c2 c01f5f22 c8aaa000 00000000 
Oct 17 21:22:29 localhost kernel:        c6270f8e c110eb5c c8aaa000 c8aabfc4 
0001ff9d c022326f c6270000 c110eb5c 
Oct 17 21:22:29 localhost kernel:        c2d94000 00000000 c0223360 c8aabfc8 
c0141c50 c8aabdfc c8aabf6c c8aabdfc 
Oct 17 21:22:29 localhost kernel: Call Trace:    [<c01124c2>] [<c01f5f22>] 
[<c0141c50>] [<c01122a0>] [<c01075f0>]
Oct 17 21:22:29 localhost kernel:   [<c01f5f22>] [<c01269b2>] [<c0126dde>] 
[<c011244a>] [<c01286df>] [<c0128a37>]
Oct 17 21:22:29 localhost kernel:   [<c0128ab4>] [<c01122a0>] [<c01075f0>]
Oct 17 21:22:29 localhost kernel: Code: 8b 51 34 85 d2 74 3f f7 41 14 41 00 00 
00 74 36 8b 71 38 89 


>>EIP; c0112b57 <search_exception_table+17/80>   <=====

>>ebx; c8aaa000 <[sr_mod].bss.end+1da61a9/1902c229>
>>ecx; c72b4000 <[sr_mod].bss.end+5b01a9/1902c229>
>>edx; c8aabe78 <[sr_mod].bss.end+1da8021/1902c229>
>>edi; c01f5f22 <fast_clear_page+12/50>
>>ebp; 00003246 Before first symbol
>>esp; c8aabd9c <[sr_mod].bss.end+1da7f45/1902c229>

Trace; c01124c2 <do_page_fault+222/5a0>
Trace; c01f5f22 <fast_clear_page+12/50>
Trace; c0141c50 <do_execve+180/220>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>
Trace; c01f5f22 <fast_clear_page+12/50>
Trace; c01269b2 <do_anonymous_page+a2/110>
Trace; c0126dde <handle_mm_fault+8e/160>
Trace; c011244a <do_page_fault+1aa/5a0>
Trace; c01286df <unmap_fixup+12f/140>
Trace; c0128a37 <do_munmap+297/2d0>
Trace; c0128ab4 <sys_munmap+44/80>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>

Code;  c0112b57 <search_exception_table+17/80>
00000000 <_EIP>:
Code;  c0112b57 <search_exception_table+17/80>   <=====
   0:   8b 51 34                  mov    0x34(%ecx),%edx   <=====
Code;  c0112b5a <search_exception_table+1a/80>
   3:   85 d2                     test   %edx,%edx
Code;  c0112b5c <search_exception_table+1c/80>
   5:   74 3f                     je     46 <_EIP+0x46>
Code;  c0112b5e <search_exception_table+1e/80>
   7:   f7 41 14 41 00 00 00      testl  $0x41,0x14(%ecx)
Code;  c0112b65 <search_exception_table+25/80>
   e:   74 36                     je     46 <_EIP+0x46>
Code;  c0112b67 <search_exception_table+27/80>
  10:   8b 71 38                  mov    0x38(%ecx),%esi
Code;  c0112b6a <search_exception_table+2a/80>
  13:   89 00                     mov    %eax,(%eax)

Oct 17 21:22:29 localhost kernel:  <1>Unable to handle kernel paging request 
at virtual address c77340c4
Oct 17 21:22:29 localhost kernel: c0139b5e
Oct 17 21:22:29 localhost kernel: *pde = 07769163
Oct 17 21:22:29 localhost kernel: Oops: 0003 2.4.20-pre11aa1-agpdrm #6 Thu Oct 
17 21:11:50 EST 2002
Oct 17 21:22:29 localhost kernel: CPU:    0
Oct 17 21:22:29 localhost kernel: EIP:    0010:[<c0139b5e>]    Not tainted
Oct 17 21:22:29 localhost kernel: EFLAGS: 00013246
Oct 17 21:22:29 localhost kernel: eax: c27e7340   ebx: c779cdc0   ecx: 
00000000   edx: c77340c0
Oct 17 21:22:29 localhost kernel: esi: c158e380   edi: c1689dc0   ebp: 
c1ac8540   esp: c8aabc20
Oct 17 21:22:29 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 17 21:22:29 localhost kernel: Process modprobe (pid: 1036, 
stackpage=c8aab000)
Oct 17 21:22:29 localhost kernel: Stack: c1689dc0 c779cdc0 c1c338c0 00001000 
dfe572c0 08060000 c0128e85 dfe572c0 
Oct 17 21:22:29 localhost kernel:        08060000 00001000 c1c33940 dfe572c0 
c8aaa000 000002b4 0000000b c0115076 
Oct 17 21:22:29 localhost kernel:        dfe572c0 00003202 dfe572c0 c011a137 
dfe572c0 00000000 c8aabd68 00000000 
Oct 17 21:22:29 localhost kernel: Call Trace:    [<c0128e85>] [<c0115076>] 
[<c011a137>] [<c0107bef>] [<c01125a4>]
Oct 17 21:22:29 localhost kernel:   [<c014322b>] [<c01122a0>] [<c01075f0>] 
[<c01f5f22>] [<c0112b57>] [<c01124c2>]
Oct 17 21:22:29 localhost kernel:   [<c01f5f22>] [<c0141c50>] [<c01122a0>] 
[<c01075f0>] [<c01f5f22>] [<c01269b2>]
Oct 17 21:22:29 localhost kernel:   [<c0126dde>] [<c011244a>] [<c01286df>] 
[<c0128a37>] [<c0128ab4>] [<c01122a0>]
Oct 17 21:22:29 localhost kernel:   [<c01075f0>]
Oct 17 21:22:29 localhost kernel: Code: 89 42 04 c7 03 00 00 00 00 a1 b4 3e 22 
c0 89 58 04 89 03 89 


>>EIP; c0139b5e <fput+9e/120>   <=====

>>eax; c27e7340 <[floppy].bss.end+599905/4ab2645>
>>ebx; c779cdc0 <[sr_mod].bss.end+a98f69/1902c229>
>>edx; c77340c0 <[sr_mod].bss.end+a30269/1902c229>
>>esi; c158e380 <_end+12f1d10/15aaa10>
>>edi; c1689dc0 <_end+13ed750/15aaa10>
>>ebp; c1ac8540 <[md].bss.end+25a861/3123a1>
>>esp; c8aabc20 <[sr_mod].bss.end+1da7dc9/1902c229>

Trace; c0128e85 <exit_mmap+125/140>
Trace; c0115076 <mmput+56/d0>
Trace; c011a137 <do_exit+87/260>
Trace; c0107bef <die+7f/80>
Trace; c01125a4 <do_page_fault+304/5a0>
Trace; c014322b <cached_lookup+1b/70>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>
Trace; c01f5f22 <fast_clear_page+12/50>
Trace; c0112b57 <search_exception_table+17/80>
Trace; c01124c2 <do_page_fault+222/5a0>
Trace; c01f5f22 <fast_clear_page+12/50>
Trace; c0141c50 <do_execve+180/220>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>
Trace; c01f5f22 <fast_clear_page+12/50>
Trace; c01269b2 <do_anonymous_page+a2/110>
Trace; c0126dde <handle_mm_fault+8e/160>
Trace; c011244a <do_page_fault+1aa/5a0>
Trace; c01286df <unmap_fixup+12f/140>
Trace; c0128a37 <do_munmap+297/2d0>
Trace; c0128ab4 <sys_munmap+44/80>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>

Code;  c0139b5e <fput+9e/120>
00000000 <_EIP>:
Code;  c0139b5e <fput+9e/120>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c0139b61 <fput+a1/120>
   3:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c0139b67 <fput+a7/120>
   9:   a1 b4 3e 22 c0            mov    0xc0223eb4,%eax
Code;  c0139b6c <fput+ac/120>
   e:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c0139b6f <fput+af/120>
  11:   89 03                     mov    %eax,(%ebx)
Code;  c0139b71 <fput+b1/120>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.

The mainline (2.4.20-pre11) is fine with agpgart and radeon as modules. I 
haven't tested it with agpgart and radeon built-in the kernel.

I am trying to find if any of my friends have a different Radeon card (mine is 
Radeon VE QY) or any video card that has DRM support on the official kernel 
tree. If I find one I will try and see if --aa works fine with that.

Thanks for your help. 
-- 
Hari
harisri@bigpond.com

