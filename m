Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSJQPMI>; Thu, 17 Oct 2002 11:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbSJQPMI>; Thu, 17 Oct 2002 11:12:08 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:9694 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261506AbSJQPMD> convert rfc822-to-8bit; Thu, 17 Oct 2002 11:12:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Keith Owens <kaos@ocs.com.au>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20pre11aa1
Date: Fri, 18 Oct 2002 01:26:36 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <15355.1034859667@ocs3.intra.ocs.com.au>
In-Reply-To: <15355.1034859667@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210180126.37013.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Keith,

> You don't need that, just mkdir /var/log/ksymoops.  modprobe/insmod
> will create a daily log file and snapshot a copy of lsmod and
> /proc/ksyms for every module loaded or unloaded.  All with sync in the
> right places.

Thanks, and that works fine.

Hello Andrea,

1. To simplify and to prove that the crashes are associated with agpgart 
and/or radeon I have compiled kernel with _only_ agpgart and radeon as 
modules and nothing else.

$ cat /lib/modules/2.4.20-pre10aa1/modules.dep
/lib/modules/2.4.20-pre11aa1/kernel/drivers/char/agp/agpgart.o:

/lib/modules/2.4.20-pre11aa1/kernel/drivers/char/drm/radeon.o:

These are some decoded output of oops appeared in the system logs:
------------------------------------------------------------------------------------------------------
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

Oct 18 00:29:02 localhost kernel: Unable to handle kernel paging request at 
virtual address c73ae000
Oct 18 00:29:02 localhost kernel: c0210ee2
Oct 18 00:29:02 localhost kernel: *pde = 070001e3
Oct 18 00:29:02 localhost kernel: Oops: 0002 2.4.20-pre11aa1 #9 Fri Oct 18 
00:06:42 EST 2002
Oct 18 00:29:02 localhost kernel: CPU:    0
Oct 18 00:29:02 localhost kernel: EIP:    0010:[<c0210ee2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 18 00:29:02 localhost kernel: EFLAGS: 00013246
Oct 18 00:29:02 localhost kernel: eax: 0000003f   ebx: c73ae000   ecx: 
c7c8c000   edx: 00000000
Oct 18 00:29:02 localhost kernel: esi: c2daffe0   edi: 00000fe0   ebp: 
c113e204   esp: c7c8deac
Oct 18 00:29:02 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 18 00:29:02 localhost kernel: Process modprobe (pid: 944, 
stackpage=c7c8d000)
Oct 18 00:29:03 localhost kernel: Stack: 00104025 c01269b2 c73ae000 c7534bfc 
bfff8e50 c2d9f480 c4e97a40 c0126dde 
Oct 18 00:29:03 localhost kernel:        c2d9f480 c4e97a40 c2daffe0 c7534bfc 
00000001 bfff8e50 c7c8df24 c2d9f480 
Oct 18 00:29:03 localhost kernel:        c4e97a40 bfff8e50 c7c8c000 c011244a 
c2d9f480 c4e97a40 bfff8e50 00000001 
Oct 18 00:29:03 localhost kernel: Call Trace:    [<c01269b2>] [<c0126dde>] 
[<c011244a>] [<c0127bb6>] [<c0128cc7>]
Oct 18 00:29:03 localhost kernel:   [<c0127ab1>] [<c01122a0>] [<c01075f0>]
Oct 18 00:29:03 localhost kernel: Code: 0f e7 03 0f e7 43 08 0f e7 43 10 0f e7 
43 18 0f e7 43 20 0f 


>>EIP; c0210ee2 <fast_clear_page+12/50>   <=====

>>ebx; c73ae000 <END_OF_CODE+35e90a5/????>
>>ecx; c7c8c000 <END_OF_CODE+3ec70a5/????>
>>esi; c2daffe0 <_end+2ad7c48/3a47ce8>
>>edi; 00000fe0 Before first symbol
>>ebp; c113e204 <_end+e65e6c/3a47ce8>
>>esp; c7c8deac <END_OF_CODE+3ec8f51/????>

Trace; c01269b2 <do_anonymous_page+a2/110>
Trace; c0126dde <handle_mm_fault+8e/160>
Trace; c011244a <do_page_fault+1aa/5a0>
Trace; c0127bb6 <__vma_link+56/d0>
Trace; c0128cc7 <do_brk+1d7/210>
Trace; c0127ab1 <sys_brk+f1/130>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>

Code;  c0210ee2 <fast_clear_page+12/50>
00000000 <_EIP>:
Code;  c0210ee2 <fast_clear_page+12/50>   <=====
   0:   0f e7 03                  movntq %mm0,(%ebx)   <=====
Code;  c0210ee5 <fast_clear_page+15/50>
   3:   0f e7 43 08               movntq %mm0,0x8(%ebx)
Code;  c0210ee9 <fast_clear_page+19/50>
   7:   0f e7 43 10               movntq %mm0,0x10(%ebx)
Code;  c0210eed <fast_clear_page+1d/50>
   b:   0f e7 43 18               movntq %mm0,0x18(%ebx)
Code;  c0210ef1 <fast_clear_page+21/50>
   f:   0f e7 43 20               movntq %mm0,0x20(%ebx)
Code;  c0210ef5 <fast_clear_page+25/50>
  13:   0f 00 00                  sldtl  (%eax)

Oct 18 00:29:03 localhost kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000044
Oct 18 00:29:03 localhost kernel: c014ca41
Oct 18 00:29:03 localhost kernel: *pde = 0752b067
Oct 18 00:29:03 localhost kernel: Oops: 0000 2.4.20-pre11aa1 #9 Fri Oct 18 
00:06:42 EST 2002
Oct 18 00:29:03 localhost kernel: CPU:    0
Oct 18 00:29:03 localhost kernel: EIP:    0010:[<c014ca41>]    Not tainted
Oct 18 00:29:03 localhost kernel: EFLAGS: 00013217
Oct 18 00:29:03 localhost kernel: eax: dff32cf8   ebx: 00000010   ecx: 
00000010   edx: dff00000
Oct 18 00:29:03 localhost kernel: esi: 00000000   edi: 00000000   ebp: 
0003b0c1   esp: c64d9d74
Oct 18 00:29:03 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 18 00:29:03 localhost kernel: Process X (pid: 945, stackpage=c64d9000)
Oct 18 00:29:03 localhost kernel: Stack: 00000000 00000000 00000000 00000000 
00000000 dff32cf8 dfe66005 00000002 
Oct 18 00:29:03 localhost kernel:        dfe66005 dfe66007 00000000 c64d9e14 
c014322b c16d7540 c64d9dd4 dfe66005 
Oct 18 00:29:03 localhost kernel:        c0143854 c16d7540 c64d9dd4 00000000 
00000009 00000000 c16c29c0 00000000 
Oct 18 00:29:03 localhost kernel: Call Trace:    [<c014322b>] [<c0143854>] 
[<c0143d37>] [<c0141187>] [<c0141af7>]
Oct 18 00:29:03 localhost kernel:   [<c0132ecf>] [<c01314e5>] [<c0126510>] 
[<c0126e69>] [<c011244a>] [<c0142fd7>]
Oct 18 00:29:03 localhost kernel:   [<c0105c90>] [<c01074ff>]
Oct 18 00:29:03 localhost kernel: Code: 39 6e 44 8b 1b 75 e8 8b 7c 24 34 39 7e 
0c 75 df 8b 57 4c 85 


>>EIP; c014ca41 <d_lookup+61/110>   <=====

>>eax; dff32cf8 <END_OF_CODE+1c16dd9d/????>
>>edx; dff00000 <END_OF_CODE+1c13b0a5/????>
>>ebp; 0003b0c1 Before first symbol
>>esp; c64d9d74 <END_OF_CODE+2714e19/????>

Trace; c014322b <cached_lookup+1b/70>
Trace; c0143854 <link_path_walk+3c4/6f0>
Trace; c0143d37 <path_lookup+37/40>
Trace; c0141187 <open_exec+27/e0>
Trace; c0141af7 <do_execve+27/220>
Trace; c0132ecf <__alloc_pages+5f/280>
Trace; c01314e5 <lru_cache_add+65/70>
Trace; c0126510 <do_wp_page+140/1f0>
Trace; c0126e69 <handle_mm_fault+119/160>
Trace; c011244a <do_page_fault+1aa/5a0>
Trace; c0142fd7 <getname+97/d0>
Trace; c0105c90 <sys_execve+50/80>
Trace; c01074ff <system_call+33/38>

Code;  c014ca41 <d_lookup+61/110>
00000000 <_EIP>:
Code;  c014ca41 <d_lookup+61/110>   <=====
   0:   39 6e 44                  cmp    %ebp,0x44(%esi)   <=====
Code;  c014ca44 <d_lookup+64/110>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c014ca46 <d_lookup+66/110>
   5:   75 e8                     jne    ffffffef <_EIP+0xffffffef>
Code;  c014ca48 <d_lookup+68/110>
   7:   8b 7c 24 34               mov    0x34(%esp,1),%edi
Code;  c014ca4c <d_lookup+6c/110>
   b:   39 7e 0c                  cmp    %edi,0xc(%esi)
Code;  c014ca4f <d_lookup+6f/110>
   e:   75 df                     jne    ffffffef <_EIP+0xffffffef>
Code;  c014ca51 <d_lookup+71/110>
  10:   8b 57 4c                  mov    0x4c(%edi),%edx
Code;  c014ca54 <d_lookup+74/110>
  13:   85 00                     test   %eax,(%eax)

Oct 18 00:29:04 localhost kernel:  <1>Unable to handle kernel paging request 
at virtual address c6b917c4
Oct 18 00:29:04 localhost kernel: c0139920
Oct 18 00:29:04 localhost kernel: *pde = 0748a163
Oct 18 00:29:04 localhost kernel: Oops: 0003 2.4.20-pre11aa1 #9 Fri Oct 18 
00:06:42 EST 2002
Oct 18 00:29:04 localhost kernel: CPU:    0
Oct 18 00:29:04 localhost kernel: EIP:    0010:[<c0139920>]    Not tainted
Oct 18 00:29:04 localhost kernel: EFLAGS: 00010216
Oct 18 00:29:04 localhost kernel: eax: c6b917c0   ebx: c4a132c0   ecx: 
00000004   edx: c0251474
Oct 18 00:29:04 localhost kernel: esi: 00000000   edi: ffffffe9   ebp: 
c158e380   esp: c8bb7f44
Oct 18 00:29:04 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 18 00:29:04 localhost kernel: Process sh (pid: 950, stackpage=c8bb7000)
Oct 18 00:29:04 localhost kernel: Stack: c167e440 00000004 c57acbe4 00000000 
c0137e29 00000004 c16d77c0 00000000 
Oct 18 00:29:04 localhost kernel:        c1be5000 4001edcd bfffeb68 c0137e07 
c16d77c0 c158e380 00000000 c8bb7f84 
Oct 18 00:29:04 localhost kernel:        c16d77c0 c158e380 c1be5000 c2dbc61c 
00000003 00000001 00000001 4001edcd 
Oct 18 00:29:04 localhost kernel: Call Trace:    [<c0137e29>] [<c0137e07>] 
[<c01381e3>] [<c01074ff>]
Oct 18 00:29:04 localhost kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 
03 00 00 00 00 ff 0d 


>>EIP; c0139920 <get_empty_filp+20/130>   <=====

>>eax; c6b917c0 <END_OF_CODE+2dcc865/????>
>>ebx; c4a132c0 <END_OF_CODE+c4e365/????>
>>edx; c0251474 <free_list+0/8>
>>edi; ffffffe9 <END_OF_CODE+3c23b08e/????>
>>ebp; c158e380 <_end+12b5fe8/3a47ce8>
>>esp; c8bb7f44 <END_OF_CODE+4df2fe9/????>

Trace; c0137e29 <dentry_open+19/210>
Trace; c0137e07 <filp_open+67/70>
Trace; c01381e3 <sys_open+53/a0>
Trace; c01074ff <system_call+33/38>

Code;  c0139920 <get_empty_filp+20/130>
00000000 <_EIP>:
Code;  c0139920 <get_empty_filp+20/130>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0139923 <get_empty_filp+23/130>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0139925 <get_empty_filp+25/130>
   5:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c013992c <get_empty_filp+2c/130>
   c:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c0139932 <get_empty_filp+32/130>
  12:   ff 0d 00 00 00 00         decl   0x0

Oct 18 00:29:10 localhost kernel:  <1>Unable to handle kernel paging request 
at virtual address c6895b44
Oct 18 00:29:10 localhost kernel: c0139920
Oct 18 00:29:10 localhost kernel: *pde = 0748a163
Oct 18 00:29:10 localhost kernel: Oops: 0003 2.4.20-pre11aa1 #9 Fri Oct 18 
00:06:42 EST 2002
Oct 18 00:29:10 localhost kernel: CPU:    0
Oct 18 00:29:10 localhost kernel: EIP:    0010:[<c0139920>]    Not tainted
Oct 18 00:29:10 localhost kernel: EFLAGS: 00010216
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c0139920 <get_empty_filp+20/130>   <=====


2 warnings issued.  Results may not be reliable.

2. Then I compiled the kernel with one and only module ie, radeon, and nothing 
else.
$ cat /lib/modules/2.4.20-pre11aa1/modules.dep
/lib/modules/2.4.20-pre11aa1/kernel/drivers/char/drm/radeon.o:

Here is the decoded output of the oops appeared on the system logs:
----------------------------------------------------------------------------------------------------
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

Oct 18 01:00:26 localhost kernel: Unable to handle kernel paging request at 
virtual address c3d50000
Oct 18 01:00:26 localhost kernel: c021389a
Oct 18 01:00:26 localhost kernel: *pde = 03c001e3
Oct 18 01:00:26 localhost kernel: Oops: 0002 2.4.20-pre11aa1 #10 Fri Oct 18 
00:39:27 EST 2002
Oct 18 01:00:26 localhost kernel: CPU:    0
Oct 18 01:00:26 localhost kernel: EIP:    0010:[<c021389a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 18 01:00:26 localhost kernel: EFLAGS: 00013246
Oct 18 01:00:26 localhost kernel: eax: 0000003a   ebx: c1730000   ecx: 
c3df4000   edx: 00000000
Oct 18 01:00:26 localhost kernel: esi: c3d50000   edi: 01730025   ebp: 
c10a89dc   esp: c3df5e9c
Oct 18 01:00:26 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 18 01:00:26 localhost kernel: Process modprobe (pid: 712, 
stackpage=c3df5000)
Oct 18 01:00:26 localhost kernel: Stack: c103fc5c c3fad498 c01264ce c3d50000 
c1730000 dfe1ce00 c10a89dc c4c99420 
Oct 18 01:00:26 localhost kernel:        42126000 dfe1ce00 c164ed40 c0126e69 
dfe1ce00 c164ed40 42126000 c3fad498 
Oct 18 01:00:26 localhost kernel:        c4c99420 01730025 c164e5c0 dfe1ce00 
c164ed40 42126000 c3df4000 c011244a 
Oct 18 01:00:26 localhost kernel: Call Trace:    [<c01264ce>] [<c0126e69>] 
[<c011244a>] [<c01276dc>] [<c0139b8c>]
Oct 18 01:00:26 localhost kernel:   [<c01286df>] [<c0128a37>] [<c0128ab4>] 
[<c01122a0>] [<c01075f0>]
Oct 18 01:00:26 localhost kernel: Code: 0f e7 06 0f 6f 4b 08 0f e7 4e 08 0f 6f 
53 10 0f e7 56 10 0f 


>>EIP; c021389a <fast_copy_page+3a/e0>   <=====

>>ebx; c1730000 <_end+1455ba8/3a85c28>
>>ecx; c3df4000 <END_OF_CODE+7ea89/????>
>>esi; c3d50000 <_end+3a75ba8/3a85c28>
>>edi; 01730025 Before first symbol
>>ebp; c10a89dc <_end+dce584/3a85c28>
>>esp; c3df5e9c <END_OF_CODE+80925/????>

Trace; c01264ce <do_wp_page+fe/1f0>
Trace; c0126e69 <handle_mm_fault+119/160>
Trace; c011244a <do_page_fault+1aa/5a0>
Trace; c01276dc <zap_pmd_range+7c/80>
Trace; c0139b8c <fput+cc/120>
Trace; c01286df <unmap_fixup+12f/140>
Trace; c0128a37 <do_munmap+297/2d0>
Trace; c0128ab4 <sys_munmap+44/80>
Trace; c01122a0 <do_page_fault+0/5a0>
Trace; c01075f0 <error_code+34/3c>

Code;  c021389a <fast_copy_page+3a/e0>
00000000 <_EIP>:
Code;  c021389a <fast_copy_page+3a/e0>   <=====
   0:   0f e7 06                  movntq %mm0,(%esi)   <=====
Code;  c021389d <fast_copy_page+3d/e0>
   3:   0f 6f 4b 08               movq   0x8(%ebx),%mm1
Code;  c02138a1 <fast_copy_page+41/e0>
   7:   0f e7 4e 08               movntq %mm1,0x8(%esi)
Code;  c02138a5 <fast_copy_page+45/e0>
   b:   0f 6f 53 10               movq   0x10(%ebx),%mm2
Code;  c02138a9 <fast_copy_page+49/e0>
   f:   0f e7 56 10               movntq %mm2,0x10(%esi)
Code;  c02138ad <fast_copy_page+4d/e0>
  13:   0f 00 00                  sldtl  (%eax)


1 warning issued.  Results may not be reliable.

I can provide .config upon request, but it is basically the same as the 
previous one except I have deselected the whole Netfilter stuff.

Thanks.
-- 
Hari
harisri@bigpond.com

