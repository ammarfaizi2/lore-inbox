Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264592AbRFPIQ5>; Sat, 16 Jun 2001 04:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264593AbRFPIQs>; Sat, 16 Jun 2001 04:16:48 -0400
Received: from beethoven.singa.pore.net ([202.156.1.28]:12818 "EHLO
	beethoven.singa.pore.net") by vger.kernel.org with ESMTP
	id <S264592AbRFPIQj>; Sat, 16 Jun 2001 04:16:39 -0400
Date: Sat, 16 Jun 2001 16:18:01 +0800
From: Richard Chan <cshihpin@dso.org.sg>
To: linux-kernel@vger.kernel.org
Subject: [Oops] 2.4.5-ac14/2.4.6-pre3+Athlon+gcc3-prerelease+VIAKT133A
Message-ID: <20010616161801.A1821@caesar>
Reply-To: cshihpin@dso.org.sg
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an oops from

1. Athlon kernel, gcc3 prerelease 14 June compiled
2. Kernel version 2.4.5-ac14
3. Mobo: Soltek 75KAV (VT133A disaster??) with Athlon 1.2G C

Any ideas? Bad compiler or bad kernel?
The problems occur in kmem_cache_????.

On this mobo and chipset I have had no luck with locally compiled
Athlon kernels at all (whether stock or -ac, RedHat gcc or gcc3-prerelease).
Me thinks something is seriously wrong with this mobo/chipset or is it
the Athlon code in gcc?

Thanks
ksymoops 2.4.0 on i686 2.4.5-ac14.  Options used
     -v /usr/src/linux-ac/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac14/ (default)
     -m /usr/src/linux-ac/System.map (specified)

CPU:    0
EIP:    0010:[<c0128246>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010012
eax: 400a0006   ebx: 004da9ba   ecx: cff3f000   edx: 00000180
esi: c1407ae0   edi: 00000286   ebp: 00000020   esp: cfd3ff18
ds: 0018   es: 0018   ss: 0018
Process minilogd (pid: 22, stackpage=cfd3f000)
Stack: cfd2e0c0 00000000 cff3f740 00000001 c01167f7 c1407ae0 cff3f740 c14d8340 
       cfd3e000 00000500 bffffd28 c0116d71 cff3f740 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 cf000000 c01399ff 00000286 
Call Trace: [<c01167f7>] [<c0116d71>] [<c01399ff>] [<c01d0cbd>] [<c0116ece>] 
   [<c0106edb>] 
Code: 89 44 99 18 8b 41 10 89 59 14 8d 50 ff 89 51 10 3b 46 14 74 

>>EIP; c0128246 <kmem_cache_free+36/b0>   <=====
Trace; c01167f7 <put_files_struct+b7/c0>
Trace; c0116d71 <do_exit+91/1c0>
Trace; c01399ff <path_release+f/30>
Trace; c01d0cbd <sys_socketcall+6d/1d0>
Trace; c0116ece <sys_exit+e/10>
Trace; c0106edb <system_call+33/38>
Code;  c0128246 <kmem_cache_free+36/b0>
00000000 <_EIP>:
Code;  c0128246 <kmem_cache_free+36/b0>   <=====
   0:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)   <=====
Code;  c012824a <kmem_cache_free+3a/b0>
   4:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  c012824d <kmem_cache_free+3d/b0>
   7:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  c0128250 <kmem_cache_free+40/b0>
   a:   8d 50 ff                  lea    0xffffffff(%eax),%edx
Code;  c0128253 <kmem_cache_free+43/b0>
   d:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  c0128256 <kmem_cache_free+46/b0>
  10:   3b 46 14                  cmp    0x14(%esi),%eax
Code;  c0128259 <kmem_cache_free+49/b0>
  13:   74 00                     je     15 <_EIP+0x15> c012825b <kmem_cache_free+4b/b0>

 guring kernel pa<1>Unable to handle kernel paging request at virtual address d12a9704
c0128246
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0128246>]
EFLAGS: 00010012
eax: 400a0006   ebx: 004da9bb   ecx: cff3f000   edx: 00000180
esi: c1407ae0   edi: 00000286   ebp: 00000020   esp: cfd4df18
ds: 0018   es: 0018   ss: 0018
Process sysctl (pid: 23, stackpage=cfd4d000)
Stack: cff24bc0 00000000 cff3f900 00000001 c01167f7 c1407ae0 cff3f900 c14d83c0 
       cfd4c000 00000000 bffffd68 c0116d71 cff3f900 40019000 00001000 00000000 
       00000000 40019000 00001000 c1407ba0 c0122795 c14d83c0 cfd644c0 40019000 
Call Trace: [<c01167f7>] [<c0116d71>] [<c0122795>] [<c012f91e>] [<c0116ece>] 
   [<c0106edb>] 
Code: 89 44 99 18 8b 41 10 89 59 14 8d 50 ff 89 51 10 3b 46 14 74 

>>EIP; c0128246 <kmem_cache_free+36/b0>   <=====
Trace; c01167f7 <put_files_struct+b7/c0>
Trace; c0116d71 <do_exit+91/1c0>
Trace; c0122795 <do_munmap+235/250>
Trace; c012f91e <filp_close+3e/60>
Trace; c0116ece <sys_exit+e/10>
Trace; c0106edb <system_call+33/38>
Code;  c0128246 <kmem_cache_free+36/b0>
00000000 <_EIP>:
Code;  c0128246 <kmem_cache_free+36/b0>   <=====
   0:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)   <=====
Code;  c012824a <kmem_cache_free+3a/b0>
   4:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  c012824d <kmem_cache_free+3d/b0>
   7:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  c0128250 <kmem_cache_free+40/b0>
   a:   8d 50 ff                  lea    0xffffffff(%eax),%edx
Code;  c0128253 <kmem_cache_free+43/b0>
   d:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  c0128256 <kmem_cache_free+46/b0>
  10:   3b 46 14                  cmp    0x14(%esi),%eax
Code;  c0128259 <kmem_cache_free+49/b0>
  13:   74 00                     je     15 <_EIP+0x15> c012825b <kmem_cache_free+4b/b0>

 rameters:  <1>Unable to handle kernel paging request at virtual address d12a96fc
c0128246
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0128246>]
EFLAGS: 00010012
eax: 400a0006   ebx: 004da9b9   ecx: cff3f000   edx: 00000180
esi: c1407ae0   edi: 00000286   ebp: 00000100   esp: cfd49f18
ds: 0018   es: 0018   ss: 0018
Process initlog (pid: 21, stackpage=cfd49000)
Stack: cff3f580 00000000 cff3f580 cfd96000 c01167f7 c1407ae0 cff3f580 c14d82c0 
       cfd48000 00000b00 bffffd48 c0116d71 cff3f580 bffff710 cfd49f70 cfd49fa4 
       c011d105 cff240c0 ffffffea 00000000 00000049 cff240c0 00000049 00000000 
Call Trace: [<c01167f7>] [<c0116d71>] [<c011d105>] [<c012fd93>] [<c0116ece>] 
   [<c0106edb>] 
Code: 89 44 99 18 8b 41 10 89 59 14 8d 50 ff 89 51 10 3b 46 14 74 

>>EIP; c0128246 <kmem_cache_free+36/b0>   <=====
Trace; c01167f7 <put_files_struct+b7/c0>
Trace; c0116d71 <do_exit+91/1c0>
Trace; c011d105 <sys_rt_sigaction+95/110>
Trace; c012fd93 <sys_write+83/d0>
Trace; c0116ece <sys_exit+e/10>
Trace; c0106edb <system_call+33/38>
Code;  c0128246 <kmem_cache_free+36/b0>
00000000 <_EIP>:
Code;  c0128246 <kmem_cache_free+36/b0>   <=====
   0:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)   <=====
Code;  c012824a <kmem_cache_free+3a/b0>
   4:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  c012824d <kmem_cache_free+3d/b0>
   7:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  c0128250 <kmem_cache_free+40/b0>
   a:   8d 50 ff                  lea    0xffffffff(%eax),%edx
Code;  c0128253 <kmem_cache_free+43/b0>
   d:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  c0128256 <kmem_cache_free+46/b0>
  10:   3b 46 14                  cmp    0x14(%esi),%eax
Code;  c0128259 <kmem_cache_free+49/b0>
  13:   74 00                     je     15 <_EIP+0x15> c012825b <kmem_cache_free+4b/b0>

 net.ipv4.ip_forw<1>Unable to handle kernel paging request at virtual address d01bf030
c012815c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012815c>]
EFLAGS: 00010803
eax: 400a0006   ebx: 11800a80   ecx: 00000286   edx: cff3f000
esi: c1407ae0   edi: fffffff4   ebp: 00000011   esp: c15b9ec0
ds: 0018   es: 0018   ss: 0018
Process initlog (pid: 11, stackpage=c15b9000)
Stack: 40153600 cfdbe54c 015be065 00000000 cfd48000 fffffff4 c01131f4 c1407ae0 
       00000007 c0123d71 c15b9f50 c10569c0 c0123dbe cfdc43c0 00000292 cff3f3c0 
       c14d67c0 40153600 c15b8000 c01114d9 c14d8240 00000286 0000ed48 00000286 
Call Trace: [<c01131f4>] [<c0123d71>] [<c0123dbe>] [<c01114d9>] [<c012a8f7>] 
   [<c01136ae>] [<c013a86e>] [<c0105a84>] [<c0106edb>] 
Code: 8b 44 82 18 89 42 14 03 5a 0c 40 74 07 51 9d 89 d8 eb d9 90 

>>EIP; c012815c <kmem_cache_alloc+3c/60>   <=====
Trace; c01131f4 <copy_files+54/290>
Trace; c0123d71 <do_generic_file_read+1d1/4a0>
Trace; c0123dbe <do_generic_file_read+21e/4a0>
Trace; c01114d9 <do_page_fault+2c9/470>
Trace; c012a8f7 <__alloc_pages+57/260>
Trace; c01136ae <do_fork+27e/640>
Trace; c013a86e <__user_walk+4e/60>
Trace; c0105a84 <sys_fork+14/20>
Trace; c0106edb <system_call+33/38>
Code;  c012815c <kmem_cache_alloc+3c/60>
00000000 <_EIP>:
Code;  c012815c <kmem_cache_alloc+3c/60>   <=====
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax   <=====
Code;  c0128160 <kmem_cache_alloc+40/60>
   4:   89 42 14                  mov    %eax,0x14(%edx)
Code;  c0128163 <kmem_cache_alloc+43/60>
   7:   03 5a 0c                  add    0xc(%edx),%ebx
Code;  c0128166 <kmem_cache_alloc+46/60>
   a:   40                        inc    %eax
Code;  c0128167 <kmem_cache_alloc+47/60>
   b:   74 07                     je     14 <_EIP+0x14> c0128170 <kmem_cache_alloc+50/60>
Code;  c0128169 <kmem_cache_alloc+49/60>
   d:   51                        push   %ecx
Code;  c012816a <kmem_cache_alloc+4a/60>
   e:   9d                        popf   
Code;  c012816b <kmem_cache_alloc+4b/60>
   f:   89 d8                     mov    %ebx,%eax
Code;  c012816d <kmem_cache_alloc+4d/60>
  11:   eb d9                     jmp    ffffffec <_EIP+0xffffffec> c0128148 <kmem_cache_alloc+28/60>
Code;  c012816f <kmem_cache_alloc+4f/60>
  13:   90                        nop    

net.ipv<1>Unable to handle kernel paging request at virtual address d12a96f8
c0128246
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0128246>]
EFLAGS: 00010012
eax: 400a0006   ebx: 004da9b8   ecx: cff3f000   edx: 00000180
esi: c1407ae0   edi: 00000286   ebp: 00000020   esp: c15b9d30
ds: 0018   es: 0018   ss: 0018
Process initlog (pid: 11, stackpage=c15b9000)
Stack: cff24540 00000000 cff3f3c0 00000001 c01167f7 c1407ae0 cff3f3c0 c14d8240 
       c15b8000 0000000b c15b8000 c0116d71 cff3f3c0 00000000 00000001 c02991c0 
       0000000e c0117fcb c02991c0 c15b9da0 00000000 c0295900 c01083cf 00000000 
Call Trace: [<c01167f7>] [<c0116d71>] [<c0117fcb>] [<c01083cf>] [<c012815c>] 
   [<c010a67e>] [<c012815c>] [<c012815c>] [<c010743a>] [<c0111351>] [<c01083bc>] 
   [<e017822f>] [<c012a8f7>] [<c020f85a>] [<c01215bb>] [<c0111210>] [<c0107008>] 
   [<c012815c>] [<c01131f4>] [<c0123d71>] [<c0123dbe>] [<c01114d9>] [<c012a8f7>] 
   [<c01136ae>] [<c013a86e>] [<c0105a84>] [<c0106edb>] 
Code: 89 44 99 18 8b 41 10 89 59 14 8d 50 ff 89 51 10 3b 46 14 74 

>>EIP; c0128246 <kmem_cache_free+36/b0>   <=====
Trace; c01167f7 <put_files_struct+b7/c0>
Trace; c0116d71 <do_exit+91/1c0>
Trace; c0117fcb <do_softirq+5b/80>
Trace; c01083cf <do_IRQ+8f/b0>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c010a67e <call_do_IRQ+5/b>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c010743a <die+4a/50>
Trace; c0111351 <do_page_fault+141/470>
Trace; c01083bc <do_IRQ+7c/b0>
Trace; e017822f <END_OF_CODE+cdd1ab0/????>
Trace; c012a8f7 <__alloc_pages+57/260>
Trace; c020f85a <fast_clear_page+a/60>
Trace; c01215bb <do_anonymous_page+6b/a0>
Trace; c0111210 <do_page_fault+0/470>
Trace; c0107008 <error_code+38/40>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c01131f4 <copy_files+54/290>
Trace; c0123d71 <do_generic_file_read+1d1/4a0>
Trace; c0123dbe <do_generic_file_read+21e/4a0>
Trace; c01114d9 <do_page_fault+2c9/470>
Trace; c012a8f7 <__alloc_pages+57/260>
Trace; c01136ae <do_fork+27e/640>
Trace; c013a86e <__user_walk+4e/60>
Trace; c0105a84 <sys_fork+14/20>
Trace; c0106edb <system_call+33/38>
Code;  c0128246 <kmem_cache_free+36/b0>
00000000 <_EIP>:
Code;  c0128246 <kmem_cache_free+36/b0>   <=====
   0:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)   <=====
Code;  c012824a <kmem_cache_free+3a/b0>
   4:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  c012824d <kmem_cache_free+3d/b0>
   7:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  c0128250 <kmem_cache_free+40/b0>
   a:   8d 50 ff                  lea    0xffffffff(%eax),%edx
Code;  c0128253 <kmem_cache_free+43/b0>
   d:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  c0128256 <kmem_cache_free+46/b0>
  10:   3b 46 14                  cmp    0x14(%esi),%eax
Code;  c0128259 <kmem_cache_free+49/b0>
  13:   74 00                     je     15 <_EIP+0x15> c012825b <kmem_cache_free+4b/b0>

 4.conf.all.rp_fi<1>Unable to handle kernel paging request at virtual address d01bf030
c012815c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012815c>]
EFLAGS: 00010803
eax: 400a0006   ebx: 11800a80   ecx: 00000286   edx: cff3f000
esi: c1407ae0   edi: fffffff4   ebp: 00000011   esp: cfe07ec0
ds: 0018   es: 0018   ss: 0018
Process rc.sysinit (pid: 10, stackpage=cfe07000)
Stack: 080a8050 00000000 cfdbc2a0 bffff650 c15b8000 fffffff4 c01131f4 c1407ae0 
       00000007 cfe1d6c4 00000011 cfe0654c cfe07fc4 c0106b1e 00000011 cff3f200 
       c14d6900 080a8050 cfe06000 c01114d9 c14d81c0 00000286 000005b8 00000286 
Call Trace: [<c01131f4>] [<c0106b1e>] [<c01114d9>] [<c012a8f7>] [<c01136ae>] 
   [<c01308b4>] [<c0105a84>] [<c0106edb>] 
Code: 8b 44 82 18 89 42 14 03 5a 0c 40 74 07 51 9d 89 d8 eb d9 90 

>>EIP; c012815c <kmem_cache_alloc+3c/60>   <=====
Trace; c01131f4 <copy_files+54/290>
Trace; c0106b1e <handle_signal+ce/100>
Trace; c01114d9 <do_page_fault+2c9/470>
Trace; c012a8f7 <__alloc_pages+57/260>
Trace; c01136ae <do_fork+27e/640>
Trace; c01308b4 <fput+74/c0>
Trace; c0105a84 <sys_fork+14/20>
Trace; c0106edb <system_call+33/38>
Code;  c012815c <kmem_cache_alloc+3c/60>
00000000 <_EIP>:
Code;  c012815c <kmem_cache_alloc+3c/60>   <=====
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax   <=====
Code;  c0128160 <kmem_cache_alloc+40/60>
   4:   89 42 14                  mov    %eax,0x14(%edx)
Code;  c0128163 <kmem_cache_alloc+43/60>
   7:   03 5a 0c                  add    0xc(%edx),%ebx
Code;  c0128166 <kmem_cache_alloc+46/60>
   a:   40                        inc    %eax
Code;  c0128167 <kmem_cache_alloc+47/60>
   b:   74 07                     je     14 <_EIP+0x14> c0128170 <kmem_cache_alloc+50/60>
Code;  c0128169 <kmem_cache_alloc+49/60>
   d:   51                        push   %ecx
Code;  c012816a <kmem_cache_alloc+4a/60>
   e:   9d                        popf   
Code;  c012816b <kmem_cache_alloc+4b/60>
   f:   89 d8                     mov    %ebx,%eax
Code;  c012816d <kmem_cache_alloc+4d/60>
  11:   eb d9                     jmp    ffffffec <_EIP+0xffffffec> c0128148 <kmem_cache_alloc+28/60>
Code;  c012816f <kmem_cache_alloc+4f/60>
  13:   90                        nop    

kernel<1>Unable to handle kernel paging request at virtual address d12a96f4
c0128246
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0128246>]
EFLAGS: 00010012
eax: 400a0006   ebx: 004da9b7   ecx: cff3f000   edx: 00000180
esi: c1407ae0   edi: 00000286   ebp: 00000100   esp: cfe07d30
ds: 0018   es: 0018   ss: 0018
Process rc.sysinit (pid: 10, stackpage=cfe07000)
Stack: cff3f200 00000000 cff3f200 c1438c00 c01167f7 c1407ae0 cff3f200 c14d81c0 
       cfe06000 0000000b cfe06000 c0116d71 cff3f200 00000000 00000001 c02991c0 
       0000000e c0117fcb c02991c0 cfe07da0 00000000 c0295900 c01083cf 00000000 
Call Trace: [<c01167f7>] [<c0116d71>] [<c0117fcb>] [<c01083cf>] [<c012815c>] 
   [<c010a67e>] [<c012815c>] [<c012815c>] [<c010743a>] [<c0111351>] [<c01ac17a>] 
   [<c0124593>] [<c01ac67f>] [<c0111210>] [<c0107008>] [<c012815c>] [<c01131f4>] 
   [<c0106b1e>] [<c01114d9>] [<c012a8f7>] [<c01136ae>] [<c01308b4>] [<c0105a84>] 
   [<c0106edb>] 
Code: 89 44 99 18 8b 41 10 89 59 14 8d 50 ff 89 51 10 3b 46 14 74 

>>EIP; c0128246 <kmem_cache_free+36/b0>   <=====
Trace; c01167f7 <put_files_struct+b7/c0>
Trace; c0116d71 <do_exit+91/1c0>
Trace; c0117fcb <do_softirq+5b/80>
Trace; c01083cf <do_IRQ+8f/b0>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c010a67e <call_do_IRQ+5/b>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c010743a <die+4a/50>
Trace; c0111351 <do_page_fault+141/470>
Trace; c01ac17a <ide_wait_stat+ca/120>
Trace; c0124593 <filemap_nopage+a3/370>
Trace; c01ac67f <ide_do_request+10f/340>
Trace; c0111210 <do_page_fault+0/470>
Trace; c0107008 <error_code+38/40>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c01131f4 <copy_files+54/290>
Trace; c0106b1e <handle_signal+ce/100>
Trace; c01114d9 <do_page_fault+2c9/470>
Trace; c012a8f7 <__alloc_pages+57/260>
Trace; c01136ae <do_fork+27e/640>
Trace; c01308b4 <fput+74/c0>
Trace; c0105a84 <sys_fork+14/20>
Trace; c0106edb <system_call+33/38>
Code;  c0128246 <kmem_cache_free+36/b0>
00000000 <_EIP>:
Code;  c0128246 <kmem_cache_free+36/b0>   <=====
   0:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)   <=====
Code;  c012824a <kmem_cache_free+3a/b0>
   4:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  c012824d <kmem_cache_free+3d/b0>
   7:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  c0128250 <kmem_cache_free+40/b0>
   a:   8d 50 ff                  lea    0xffffffff(%eax),%edx
Code;  c0128253 <kmem_cache_free+43/b0>
   d:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  c0128256 <kmem_cache_free+46/b0>
  10:   3b 46 14                  cmp    0x14(%esi),%eax
Code;  c0128259 <kmem_cache_free+49/b0>
  13:   74 00                     je     15 <_EIP+0x15> c012825b <kmem_cache_free+4b/b0>

/etc<1>Unable to handle kernel paging request at virtual address d01bf030
c012815c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012815c>]
EFLAGS: 00010807
eax: 400a0006   ebx: 11800a80   ecx: 00000286   edx: cff3f000
esi: c1407ae0   edi: fffffff4   ebp: 00000011   esp: cfe19ec0
ds: 0018   es: 0018   ss: 0018
Process init (pid: 9, stackpage=cfe19000)
Stack: 0804f2a4 cfe1713c 014b9065 c0120254 cfe06000 fffffff4 c01131f4 c1407ae0 
       00000007 cfe08c00 c020f7af cfe062a0 cfe06000 cfe18000 cfe08000 cff3f040 
       c14d6400 0804f2a4 cfe18000 c01114d9 c14d8140 00000286 0000ee06 00000286 
Call Trace: [<c0120254>] [<c01131f4>] [<c020f7af>] [<c01114d9>] [<c012a8f7>] 
   [<c01136ae>] [<c0188008>] [<c0105a84>] [<c0106edb>] 
Code: 8b 44 82 18 89 42 14 03 5a 0c 40 74 07 51 9d 89 d8 eb d9 90 

>>EIP; c012815c <kmem_cache_alloc+3c/60>   <=====
Trace; c0120254 <copy_page_range+f4/1a0>
Trace; c01131f4 <copy_files+54/290>
Trace; c020f7af <_mmx_memcpy+4f/f0>
Trace; c01114d9 <do_page_fault+2c9/470>
Trace; c012a8f7 <__alloc_pages+57/260>
Trace; c01136ae <do_fork+27e/640>
Trace; c0188008 <tty_ioctl+148/3c0>
Trace; c0105a84 <sys_fork+14/20>
Trace; c0106edb <system_call+33/38>
Code;  c012815c <kmem_cache_alloc+3c/60>
00000000 <_EIP>:
Code;  c012815c <kmem_cache_alloc+3c/60>   <=====
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax   <=====
Code;  c0128160 <kmem_cache_alloc+40/60>
   4:   89 42 14                  mov    %eax,0x14(%edx)
Code;  c0128163 <kmem_cache_alloc+43/60>
   7:   03 5a 0c                  add    0xc(%edx),%ebx
Code;  c0128166 <kmem_cache_alloc+46/60>
   a:   40                        inc    %eax
Code;  c0128167 <kmem_cache_alloc+47/60>
   b:   74 07                     je     14 <_EIP+0x14> c0128170 <kmem_cache_alloc+50/60>
Code;  c0128169 <kmem_cache_alloc+49/60>
   d:   51                        push   %ecx
Code;  c012816a <kmem_cache_alloc+4a/60>
   e:   9d                        popf   
Code;  c012816b <kmem_cache_alloc+4b/60>
   f:   89 d8                     mov    %ebx,%eax
Code;  c012816d <kmem_cache_alloc+4d/60>
  11:   eb d9                     jmp    ffffffec <_EIP+0xffffffec> c0128148 <kmem_cache_alloc+28/60>
Code;  c012816f <kmem_cache_alloc+4f/60>
  13:   90                        nop    

<1>Unable to handle kernel paging request at virtual address d12a96f0
c0128246
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0128246>]
EFLAGS: 00010012
eax: 400a0006   ebx: 004da9b6   ecx: cff3f000   edx: 00000180
esi: c1407ae0   edi: 00000286   ebp: 00000020   esp: cfe19d30
ds: 0018   es: 0018   ss: 0018
Process init (pid: 9, stackpage=cfe19000)
Stack: cff240c0 00000000 cff3f040 00000001 c01167f7 c1407ae0 cff3f040 c14d8140 
       cfe18000 0000000b cfe18000 c0116d71 cff3f040 00000000 00000001 c02991c0 
       0000000e c0117fcb c02991c0 cfe19da0 00000000 c0295900 c01083cf 00000000 
Call Trace: [<c01167f7>] [<c0116d71>] [<c0117fcb>] [<c01083cf>] [<c012815c>] 
   [<c010a67e>] [<c012815c>] [<c012815c>] [<c010743a>] [<c0111351>] [<c0153c80>] 
   [<c012a8f7>] [<c020f8bf>] [<c0120fb5>] [<c0120f75>] [<c0111210>] [<c0107008>] 
   [<c012815c>] [<c0120254>] [<c01131f4>] [<c020f7af>] [<c01114d9>] [<c012a8f7>] 
   [<c01136ae>] [<c0188008>] [<c0105a84>] [<c0106edb>] 
Code: 89 44 99 18 8b 41 10 89 59 14 8d 50 ff 89 51 10 3b 46 14 74 

>>EIP; c0128246 <kmem_cache_free+36/b0>   <=====
Trace; c01167f7 <put_files_struct+b7/c0>
Trace; c0116d71 <do_exit+91/1c0>
Trace; c0117fcb <do_softirq+5b/80>
Trace; c01083cf <do_IRQ+8f/b0>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c010a67e <call_do_IRQ+5/b>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c010743a <die+4a/50>
Trace; c0111351 <do_page_fault+141/470>
Trace; c0153c80 <ext2_lookup+0/80>
Trace; c012a8f7 <__alloc_pages+57/260>
Trace; c020f8bf <fast_copy_page+f/f0>
Trace; c0120fb5 <do_wp_page+c5/230>
Trace; c0120f75 <do_wp_page+85/230>
Trace; c0111210 <do_page_fault+0/470>
Trace; c0107008 <error_code+38/40>
Trace; c012815c <kmem_cache_alloc+3c/60>
Trace; c0120254 <copy_page_range+f4/1a0>
Trace; c01131f4 <copy_files+54/290>
Trace; c020f7af <_mmx_memcpy+4f/f0>
Trace; c01114d9 <do_page_fault+2c9/470>
Trace; c012a8f7 <__alloc_pages+57/260>
Trace; c01136ae <do_fork+27e/640>
Trace; c0188008 <tty_ioctl+148/3c0>
Trace; c0105a84 <sys_fork+14/20>
Trace; c0106edb <system_call+33/38>
Code;  c0128246 <kmem_cache_free+36/b0>
00000000 <_EIP>:
Code;  c0128246 <kmem_cache_free+36/b0>   <=====
   0:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)   <=====
Code;  c012824a <kmem_cache_free+3a/b0>
   4:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  c012824d <kmem_cache_free+3d/b0>
   7:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  c0128250 <kmem_cache_free+40/b0>
   a:   8d 50 ff                  lea    0xffffffff(%eax),%edx
Code;  c0128253 <kmem_cache_free+43/b0>
   d:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  c0128256 <kmem_cache_free+46/b0>
  10:   3b 46 14                  cmp    0x14(%esi),%eax
Code;  c0128259 <kmem_cache_free+49/b0>
  13:   74 00                     je     15 <_EIP+0x15> c012825b <kmem_cache_free+4b/b0>

 <1>Unable to handle kernel paging request at virtual address d01bf030
c012815c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012815c>]
EFLAGS: 00010807
eax: 400a0006   ebx: 11800a80   ecx: 00000286   edx: cff3f000
esi: c1407ae0   edi: fffffff4   ebp: 00000011   esp: c140bec0
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, stackpage=c140b000)
Stack: 00000000 00000000 cff23000 c02c0840 cfe18000 fffffff4 c01131f4 c1407ae0 
       00000007 00000000 cff32005 00000003 0026c8ca c15f8b40 cff32000 c0243b40 
       0804dd5f bffffaa8 c013af36 cff32000 c140bf84 00000286 0000ee18 00000286 
Call Trace: [<c01131f4>] [<c013af36>] [<c012a8f7>] [<c01136ae>] [<c013a86e>] 
   [<c0105a84>] [<c0106edb>] 
Code: 8b 44 82 18 89 42 14 03 5a 0c 40 74 07 51 9d 89 d8 eb d9 90 

>>EIP; c012815c <kmem_cache_alloc+3c/60>   <=====
Trace; c01131f4 <copy_files+54/290>
Trace; c013af36 <open_namei+5c6/5f0>
Trace; c012a8f7 <__alloc_pages+57/260>
Trace; c01136ae <do_fork+27e/640>
Trace; c013a86e <__user_walk+4e/60>
Trace; c0105a84 <sys_fork+14/20>
Trace; c0106edb <system_call+33/38>
Code;  c012815c <kmem_cache_alloc+3c/60>
00000000 <_EIP>:
Code;  c012815c <kmem_cache_alloc+3c/60>   <=====
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax   <=====
Code;  c0128160 <kmem_cache_alloc+40/60>
   4:   89 42 14                  mov    %eax,0x14(%edx)
Code;  c0128163 <kmem_cache_alloc+43/60>
   7:   03 5a 0c                  add    0xc(%edx),%ebx
Code;  c0128166 <kmem_cache_alloc+46/60>
   a:   40                        inc    %eax
Code;  c0128167 <kmem_cache_alloc+47/60>
   b:   74 07                     je     14 <_EIP+0x14> c0128170 <kmem_cache_alloc+50/60>
Code;  c0128169 <kmem_cache_alloc+49/60>
   d:   51                        push   %ecx
Code;  c012816a <kmem_cache_alloc+4a/60>
   e:   9d                        popf   
Code;  c012816b <kmem_cache_alloc+4b/60>
   f:   89 d8                     mov    %ebx,%eax
Code;  c012816d <kmem_cache_alloc+4d/60>
  11:   eb d9                     jmp    ffffffec <_EIP+0xffffffec> c0128148 <kmem_cache_alloc+28/60>
Code;  c012816f <kmem_cache_alloc+4f/60>
  13:   90                        nop    

 <0>Kernel panic: Attempted to kill init!

1002 warnings issued.  Results may not be reliable.
