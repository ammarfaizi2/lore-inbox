Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319422AbSILDS1>; Wed, 11 Sep 2002 23:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319423AbSILDS1>; Wed, 11 Sep 2002 23:18:27 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:65428 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S319422AbSILDS0>; Wed, 11 Sep 2002 23:18:26 -0400
Date: Wed, 11 Sep 2002 20:23:09 -0700 (PDT)
From: Syam Sundar V Appala <syam@cisco.com>
To: linux-kernel@vger.kernel.org
cc: syam@cisco.com
Subject: Kernel 2.4.19 Oops error
Message-ID: <Pine.GSO.4.44.0209112015100.17831-100000@msabu-view1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am relatively new to linux and I am facing the following problem. Can
someone explain what is going on?

Oops:
---
EXT2-fs error (device ide0(3,1)): ext2_check_page: bad entry in directory
#21179
6: unaligned directory entry - offset=0, inode=4294967295, rec_len=65535,
name_l
en=255
Unable to handle kernel NULL pointer dereference at virtual address
00000003
 printing eip:
c0112b23
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0112b23>]    Not tainted
EFLAGS: 00010286
eax: c0fe2000   ebx: cfc66000   ecx: 00000000   edx: ffffffff
esi: cfc665a0   edi: c0fe25a0   ebp: c0fe2000   esp: cfc67f78
ds: 0018   es: 0018   ss: 0018
Process rpm (pid: 47, stackpage=cfc67000)
Stack: fffffff5 cfffcba0 bfffe1d8 c013b723 c013b73f 00000013 cfffcba0
cfff03a0
       00000206 cfc66000 08532ed8 00000001 bfffe1e8 c01073e5 00000011
bfffe1dc
       cfc67fc4 00000000 c01087eb 00000000 00000001 00000001 08532ed8
00000001
Call Trace:    [<c013b723>] [<c013b73f>] [<c01073e5>] [<c01087eb>]

Code: 8b 42 04 3b 85 18 02 00 00 72 52 f6 83 d6 01 00 00 20 74 0e


Ksymoops output:
---------------
bash-2.05a# ksymoops -v vmlinux -k /proc/ksyms -m System.map crash
ksymoops 2.4.5 on i686 2.4.19.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Unable to handle kernel NULL pointer dereference at virtual address
00000003
c0112b23
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0112b23>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c0fe2000   ebx: cfc66000   ecx: 00000000   edx: ffffffff
esi: cfc665a0   edi: c0fe25a0   ebp: c0fe2000   esp: cfc67f78
ds: 0018   es: 0018   ss: 0018
Process rpm (pid: 47, stackpage=cfc67000)
Stack: fffffff5 cfffcba0 bfffe1d8 c013b723 c013b73f 00000013 cfffcba0
cfff03a0
       00000206 cfc66000 08532ed8 00000001 bfffe1e8 c01073e5 00000011
bfffe1dc
       cfc67fc4 00000000 c01087eb 00000000 00000001 00000001 08532ed8
00000001
Call Trace:    [<c013b723>] [<c013b73f>] [<c01073e5>] [<c01087eb>]
Code: 8b 42 04 3b 85 18 02 00 00 72 52 f6 83 d6 01 00 00 20 74 0e


>>EIP; c0112b23 <do_fork+83/730>   <=====

>>eax; c0fe2000 <END_OF_CODE+d810e4/????>
>>ebx; cfc66000 <END_OF_CODE+fa050e4/????>
>>edx; ffffffff <END_OF_CODE+3fd9f0e3/????>
>>esi; cfc665a0 <END_OF_CODE+fa05684/????>
>>edi; c0fe25a0 <END_OF_CODE+d81684/????>
>>ebp; c0fe2000 <END_OF_CODE+d810e4/????>
>>esp; cfc67f78 <END_OF_CODE+fa0705c/????>

Trace; c013b723 <dupfd+23/60>
Trace; c013b73f <dupfd+3f/60>
Trace; c01073e5 <sys_fork+15/20>
Trace; c01087eb <system_call+33/38>

Code;  c0112b23 <do_fork+83/730>
00000000 <_EIP>:
Code;  c0112b23 <do_fork+83/730>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  c0112b26 <do_fork+86/730>
   3:   3b 85 18 02 00 00         cmp    0x218(%ebp),%eax
Code;  c0112b2c <do_fork+8c/730>
   9:   72 52                     jb     5d <_EIP+0x5d> c0112b80
<do_fork+e0/730>
Code;  c0112b2e <do_fork+8e/730>
   b:   f6 83 d6 01 00 00 20      testb  $0x20,0x1d6(%ebx)
Code;  c0112b35 <do_fork+95/730>
  12:   74 0e                     je     22 <_EIP+0x22> c0112b45
<do_fork+a5/730>


1 warning issued.  Results may not be reliable.


Objdump  -d kernel/fork.o:
-------------------------
     998:       c7 04 24 ff ff ff ff    movl   $0xffffffff,(%esp,1)
     99f:       74 12                   je     9b3 <do_fork+0x43>
     9a1:       b8 00 e0 ff ff          mov    $0xffffe000,%eax
     9a6:       21 e0                   and    %esp,%eax
     9a8:       8b 58 7c                mov    0x7c(%eax),%ebx
     9ab:       85 db                   test   %ebx,%ebx
     9ad:       0f 85 0c 06 00 00       jne    fbf <do_fork+0x64f>
     9b3:       c7 04 24 f4 ff ff ff    movl   $0xfffffff4,(%esp,1)
     9ba:       ba 01 00 00 00          mov    $0x1,%edx
     9bf:       b8 f0 01 00 00          mov    $0x1f0,%eax
     9c4:       e8 fc ff ff ff          call   9c5 <do_fork+0x55>
     9c9:       89 c5                   mov    %eax,%ebp
     9cb:       85 ed                   test   %ebp,%ebp
     9cd:       0f 84 ec 05 00 00       je     fbf <do_fork+0x64f>
     9d3:       bb 00 e0 ff ff          mov    $0xffffe000,%ebx
     9d8:       21 e3                   and    %esp,%ebx
     9da:       fc                      cld
     9db:       b9 68 01 00 00          mov    $0x168,%ecx
     9e0:       89 ef                   mov    %ebp,%edi
     9e2:       89 de                   mov    %ebx,%esi
     9e4:       f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
     9e6:       c7 04 24 f5 ff ff ff    movl   $0xfffffff5,(%esp,1)
     9ed:       8b 95 e4 01 00 00       mov    0x1e4(%ebp),%edx
=>   9f3:       8b 42 04                mov    0x4(%edx),%eax



Thanks,
Syam
----

