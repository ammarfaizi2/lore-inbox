Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317418AbSGJNzd>; Wed, 10 Jul 2002 09:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSGJNzc>; Wed, 10 Jul 2002 09:55:32 -0400
Received: from p508EF2F6.dip.t-dialin.net ([80.142.242.246]:22403 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id <S317418AbSGJNz2>;
	Wed, 10 Jul 2002 09:55:28 -0400
Date: Wed, 10 Jul 2002 15:58:11 +0200
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.20 kernel BUG at dcache.c:352
Message-ID: <20020710135811.GA10894@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo List,

I got the appended two oopses with 2.5.20
Some similar oops happend with 2.5.25 but
I don't have them anymore ...

Some guy with an Nvidia card had the same problem
with a tainted kernel. Please note that I have no
modules loaded and no binary only stuff.

System Info:

Asus P5A (some VIA chipset?)
AMD 350Mhz
384 MB
40GB Seagate
60GB IBM
ATI Mach64 PCI card
EEPRO 100 Ethernet

No Sound, no CD, no X Server.
Here comes the ksymoops output:

ksymoops 2.4.5 on i586 2.5.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.20/ (default)
     -m /boot/System.map-2.5.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
kernel BUG at dcache.c:352!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013d8ed>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: ffffffff   ebx: ca27f7b8   ecx: c1593040   edx: c15933f8
esi: ca27f7a0   edi: cb84f440   ebp: 000036fe   esp: d00e5dec
ds: 0018   es: 0018   ss: 0018
Stack: 00000011 00000005 000001d2 00000018 c013dcbf 00004263 c0126036 00000005
000001d2 00000005 000001d2 c0262194 c0262194 c0262194 000003b6 00000000
00010e32 0000a045 000075ac c012606d 00000018 d00e4000 00000000 00000000
Call Trace: [<c013dcbf>] [<c0126036>] [<c012606d>] [<c0126990>] [<c0126c2a>]
[<c0126936>] [<c011e770>] [<c011e884>] [<c011ea6b>] [<c010e46f>] [<c010e2f4>]
[<c0126e7b>] [<c011fbe5>] [<c011ed22>] [<c0106c44>]
Code: 0f 0b 60 01 46 59 22 c0 8d 46 10 8b 48 04 8b 53 f8 89 4a 04


>>EIP; c013d8ed <prune_dcache+61/14c>   <=====

>>eax; ffffffff <END_OF_CODE+3fd445df/????>
>>ebx; ca27f7b8 <END_OF_CODE+9fc3d98/????>
>>ecx; c1593040 <END_OF_CODE+12d7620/????>
>>edx; c15933f8 <END_OF_CODE+12d79d8/????>
>>esi; ca27f7a0 <END_OF_CODE+9fc3d80/????>
>>edi; cb84f440 <END_OF_CODE+b593a20/????>
>>ebp; 000036fe Before first symbol
>>esp; d00e5dec <END_OF_CODE+fe2a3cc/????>

Trace; c013dcbf <shrink_dcache_memory+1b/30>
Trace; c0126036 <shrink_caches+7e/98>
Trace; c012606d <try_to_free_pages+1d/3c>
Trace; c0126990 <balance_classzone+58/1c0>
Trace; c0126c2a <__alloc_pages+132/190>
Trace; c0126936 <_alloc_pages+16/18>
Trace; c011e770 <do_anonymous_page+38/114>
Trace; c011e884 <do_no_page+38/1c0>
Trace; c011ea6b <handle_mm_fault+5f/d0>
Trace; c010e46f <do_page_fault+17b/464>
Trace; c010e2f4 <do_page_fault+0/464>
Trace; c0126e7b <get_page_cache_size+b/18>
Trace; c011fbe5 <do_brk+119/1fc>
Trace; c011ed22 <sys_brk+c2/ec>
Trace; c0106c44 <error_code+34/40>

Code;  c013d8ed <prune_dcache+61/14c>
00000000 <_EIP>:
Code;  c013d8ed <prune_dcache+61/14c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013d8ef <prune_dcache+63/14c>
   2:   60                        pusha  
Code;  c013d8f0 <prune_dcache+64/14c>
   3:   01 46 59                  add    %eax,0x59(%esi)
Code;  c013d8f3 <prune_dcache+67/14c>
   6:   22 c0                     and    %al,%al
Code;  c013d8f5 <prune_dcache+69/14c>
   8:   8d 46 10                  lea    0x10(%esi),%eax
Code;  c013d8f8 <prune_dcache+6c/14c>
   b:   8b 48 04                  mov    0x4(%eax),%ecx
Code;  c013d8fb <prune_dcache+6f/14c>
   e:   8b 53 f8                  mov    0xfffffff8(%ebx),%edx
Code;  c013d8fe <prune_dcache+72/14c>
  11:   89 4a 04                  mov    %ecx,0x4(%edx)

kernel BUG at dcache.c:352!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013d8ed>]    Not tainted
EFLAGS: 00010286
eax: ffffffff   ebx: cfe54658   ecx: cfe54020   edx: cfe54d58
esi: cfe54640   edi: cbd130c0   ebp: 00003564   esp: d40a7d40
ds: 0018   es: 0018   ss: 0018
Stack: 0000001a 00000006 000001d2 00000020 c013dcbf 0000358b c0126036 00000006
000001d2 00000006 000001d2 c0262194 c0262194 c0262194 00000345 00000000
00011548 00009fe8 00007bec c012606d 00000020 d40a6000 00000000 00000000
Call Trace: [<c013dcbf>] [<c0126036>] [<c012606d>] [<c0126990>] [<c0126c2a>]
[<c0126936>] [<c0122542>] [<c01799ac>] [<c014dea4>] [<c0179e2d>] [<c017ee32>]
[<c0176e52>] [<c0211e75>] [<c0176c44>] [<c0105520>]
Code: 0f 0b 60 01 46 59 22 c0 8d 46 10 8b 48 04 8b 53 f8 89 4a 04


>>EIP; c013d8ed <prune_dcache+61/14c>   <=====

>>eax; ffffffff <END_OF_CODE+3fd445df/????>
>>ebx; cfe54658 <END_OF_CODE+fb98c38/????>
>>ecx; cfe54020 <END_OF_CODE+fb98600/????>
>>edx; cfe54d58 <END_OF_CODE+fb99338/????>
>>esi; cfe54640 <END_OF_CODE+fb98c20/????>
>>edi; cbd130c0 <END_OF_CODE+ba576a0/????>
>>ebp; 00003564 Before first symbol
>>esp; d40a7d40 <END_OF_CODE+13dec320/????>

Trace; c013dcbf <shrink_dcache_memory+1b/30>
Trace; c0126036 <shrink_caches+7e/98>
Trace; c012606d <try_to_free_pages+1d/3c>
Trace; c0126990 <balance_classzone+58/1c0>
Trace; c0126c2a <__alloc_pages+132/190>
Trace; c0126936 <_alloc_pages+16/18>
Trace; c0122542 <generic_file_write+48a/6bc>
Trace; c01799ac <nfsd_open+f0/138>
Trace; c014dea4 <ext3_file_write+40/4c>
Trace; c0179e2d <nfsd_write+121/2b8>
Trace; c017ee32 <nfsd3_proc_write+ee/10c>
Trace; c0176e52 <nfsd_dispatch+ca/198>
Trace; c0211e75 <svc_process+28d/4d8>
Trace; c0176c44 <nfsd+1c8/30c>
Trace; c0105520 <kernel_thread+28/38>

Code;  c013d8ed <prune_dcache+61/14c>
00000000 <_EIP>:
Code;  c013d8ed <prune_dcache+61/14c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013d8ef <prune_dcache+63/14c>
   2:   60                        pusha  
Code;  c013d8f0 <prune_dcache+64/14c>
   3:   01 46 59                  add    %eax,0x59(%esi)
Code;  c013d8f3 <prune_dcache+67/14c>
   6:   22 c0                     and    %al,%al
Code;  c013d8f5 <prune_dcache+69/14c>
   8:   8d 46 10                  lea    0x10(%esi),%eax
Code;  c013d8f8 <prune_dcache+6c/14c>
   b:   8b 48 04                  mov    0x4(%eax),%ecx
Code;  c013d8fb <prune_dcache+6f/14c>
   e:   8b 53 f8                  mov    0xfffffff8(%ebx),%edx
Code;  c013d8fe <prune_dcache+72/14c>
  11:   89 4a 04                  mov    %ecx,0x4(%edx)


2 warnings issued.  Results may not be reliable.
