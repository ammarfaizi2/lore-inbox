Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbTDHIm6 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 04:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTDHIm6 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 04:42:58 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:50398 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261530AbTDHImt (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 04:42:49 -0400
Message-ID: <035401c2fdac$6e6aa400$5600a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
Subject: Kernel BUG linux-2.5.67
Date: Tue, 8 Apr 2003 10:54:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I tried linux-2.5.67 this morning...

instant oops with a small multi-threaded program using futex()

---------------------------------
var/log/messages  ------------------------------------------------------
Apr  8 07:40:12 test1 kernel: ------------[ cut here ]------------
Apr  8 07:40:12 test1 kernel: kernel BUG at include/linux/mm.h:234!
Apr  8 07:40:12 test1 kernel: invalid operand: 0000 [#1]
Apr  8 07:40:12 test1 kernel: CPU:    0
Apr  8 07:40:12 test1 kernel: EIP:    0060:[<c012d0d5>]    Not tainted
Apr  8 07:40:12 test1 kernel: EFLAGS: 00010246
Apr  8 07:40:12 test1 kernel: EIP is at futex_wake+0xeb/0x1ae
Apr  8 07:40:12 test1 kernel: eax: 00000000   ebx: e2701eec   ecx: e35e1940
edx: 00000001
Apr  8 07:40:12 test1 kernel: esi: c03bb410   edi: c15fed08   ebp: c03bb410
esp: e2ab9f5c
Apr  8 07:40:12 test1 kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 07:40:12 test1 kernel: Process tstfutex (pid: 1266,
threadinfo=e2ab8000 task=e2abcca0)
Apr  8 07:40:12 test1 kernel: Stack: e2701f08 00000000 b08fea20 00000001
00000ab4 00000001 089edaa0 e2ab8000
Apr  8 07:40:12 test1 kernel:        c012d984 089edab4 00000ab4 00000001
7fffffff 00000000 00000001 c012da25
Apr  8 07:40:12 test1 kernel:        089edab4 00000001 00000001 7fffffff
01f78a40 00000003 089edab4 00000000
Apr  8 07:40:12 test1 kernel: Call Trace:
Apr  8 07:40:12 test1 kernel:  [<c012d984>] do_futex+0x8c/0x8e
Apr  8 07:40:12 test1 kernel:  [<c012da25>] sys_futex+0x9f/0xce
Apr  8 07:40:12 test1 kernel:  [<c010aa07>] syscall_call+0x7/0xb
Apr  8 07:40:12 test1 kernel:
Apr  8 07:40:12 test1 kernel: Code: 0f 0b ea 00 ea 08 2d c0 eb c8 8b 07 a9
00 08 00 00 75 da 8b
Apr  8 07:40:12 test1 kernel:  ------------[ cut here ]------------
Apr  8 07:40:12 test1 kernel: kernel BUG at include/linux/mm.h:234!
Apr  8 07:40:12 test1 kernel: invalid operand: 0000 [#2]
Apr  8 07:40:12 test1 kernel: CPU:    1
Apr  8 07:40:12 test1 kernel: EIP:    0060:[<c012d3f6>]    Not tainted
Apr  8 07:40:12 test1 kernel: EFLAGS: 00010246
Apr  8 07:40:12 test1 kernel: EIP is at futex_wait+0x1f4/0x2ec
Apr  8 07:40:12 test1 kernel: eax: 00000000   ebx: c15fed08   ecx: e2701eec
edx: e2701eec
Apr  8 07:40:12 test1 kernel: esi: 7fffffff   edi: e2700000   ebp: e2701f08
esp: e2701ed8
Apr  8 07:40:12 test1 kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 07:40:12 test1 kernel: Process tstfutex (pid: 1256,
threadinfo=e2700000 task=e2714ca0)
Apr  8 07:40:12 test1 kernel: Stack: e2701f08 089edab4 f6314800 c012d198
00000000 e2701eec e2701eec 00000001
Apr  8 07:40:12 test1 kernel:        e2701f58 e2701f58 c15fed08 00000ab4
089ed000 f6314800 e2701f10 e2701f10
Apr  8 07:40:12 test1 kernel:        c012d198 ffffffff 00000000 e35e3ef8
00000282 00000000 e2714ca0 c011afd6
Apr  8 07:40:12 test1 kernel: Call Trace:
Apr  8 07:40:12 test1 kernel:  [<c012d198>] futex_vcache_callback+0x0/0x6a
Apr  8 07:40:12 test1 kernel:  [<c012d198>] futex_vcache_callback+0x0/0x6a
Apr  8 07:40:12 test1 kernel:  [<c011afd6>] default_wake_function+0x0/0x12
Apr  8 07:40:12 test1 kernel:  [<c011afd6>] default_wake_function+0x0/0x12
Apr  8 07:40:12 test1 kernel:  [<c012d972>] do_futex+0x7a/0x8e
Apr  8 07:40:12 test1 kernel:  [<c012da25>] sys_futex+0x9f/0xce
Apr  8 07:40:12 test1 kernel:  [<c010aa07>] syscall_call+0x7/0xb
Apr  8 07:40:12 test1 kernel:
Apr  8 07:40:12 test1 kernel: Code: 0f 0b ea 00 ea 08 2d c0 eb c5 8b 03 a9
00 08 00 00 75 d7 8b
Apr  8 07:40:12 test1 kernel:  ------------[ cut here ]------------
Apr  8 07:40:12 test1 kernel: kernel BUG at include/linux/mm.h:234!
Apr  8 07:40:12 test1 kernel: invalid operand: 0000 [#3]
Apr  8 07:40:12 test1 kernel: CPU:    0
Apr  8 07:40:12 test1 kernel: EIP:    0060:[<c017797c>]    Not tainted
Apr  8 07:40:12 test1 kernel: EFLAGS: 00010246
Apr  8 07:40:12 test1 kernel: EIP is at elf_core_dump+0x88a/0x9b0
Apr  8 07:40:12 test1 kernel: eax: 00000000   ebx: 08801000   ecx: 00001000
edx: c15fa028
Apr  8 07:40:12 test1 kernel: esi: e3e2a5c0   edi: e2aa6000   ebp: f79aee80
esp: e2aa7db4
Apr  8 07:40:12 test1 kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 07:40:12 test1 kernel: Process tstfutex (pid: 1267,
threadinfo=e2aa6000 task=e2abc690)
Apr  8 07:40:12 test1 kernel: Stack: c15fa028 e6401000 00001000 00000000
00000000 00000001 e2aa7e14 e2aa7e10
Apr  8 07:40:12 test1 kernel:        000028a0 000307b8 e3764c00 e36e1100
e36e1180 f78bed80 e36e1280 00000005
Apr  8 07:40:12 test1 kernel:        b71b0000 00034000 01025000 00026f74
00001f20 c0000000 00000001 e3e2a5c0
Apr  8 07:40:12 test1 kernel: Call Trace:
Apr  8 07:40:12 test1 kernel:  [<c015a13a>] do_coredump+0x1da/0x1ed
Apr  8 07:40:12 test1 kernel:  [<c0126cb5>] __dequeue_signal+0xbb/0x164
Apr  8 07:40:12 test1 kernel:  [<c0126de8>] dequeue_signal+0x8a/0x92
Apr  8 07:40:12 test1 kernel:  [<c0128ad9>]
get_signal_to_deliver+0x227/0x346
Apr  8 07:40:12 test1 kernel:  [<c010a7d8>] do_signal+0xd6/0x106
Apr  8 07:40:12 test1 kernel:  [<c01210a6>] sys_wait4+0x1f6/0x27a
Apr  8 07:40:12 test1 kernel:  [<c011afd6>] default_wake_function+0x0/0x12
Apr  8 07:40:12 test1 kernel:  [<c0129c83>] sys_rt_sigaction+0xe5/0x10e
Apr  8 07:40:12 test1 kernel:  [<c0130242>] nanosleep_wake_up+0x0/0xa
Apr  8 07:40:12 test1 kernel:  [<c0130328>] sys_nanosleep+0xca/0xf0
Apr  8 07:40:12 test1 kernel:  [<c010a860>] do_notify_resume+0x58/0x5a
Apr  8 07:40:12 test1 kernel:  [<c010aa52>] work_notifysig+0x13/0x15
Apr  8 07:40:12 test1 kernel:
Apr  8 07:40:12 test1 kernel: Code: 0f 0b ea 00 ea 08 2d c0 eb 87 8b 02 a9
00 08 00 00 75 99 8b


-------------------------------------------------------------- ksymoops
result :

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr  8 07:40:12 test1 kernel: kernel BUG at include/linux/mm.h:234!
Apr  8 07:40:12 test1 kernel: invalid operand: 0000 [#1]
Apr  8 07:40:12 test1 kernel: CPU:    0
Apr  8 07:40:12 test1 kernel: EIP:    0060:[<c012d0d5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr  8 07:40:12 test1 kernel: EFLAGS: 00010246
Apr  8 07:40:12 test1 kernel: eax: 00000000   ebx: e2701eec   ecx: e35e1940
edx: 00000001
Apr  8 07:40:12 test1 kernel: esi: c03bb410   edi: c15fed08   ebp: c03bb410
esp: e2ab9f5c
Apr  8 07:40:12 test1 kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 07:40:12 test1 kernel: Stack: e2701f08 00000000 b08fea20 00000001
00000ab4 00000001 089edaa0 e2ab8000
Apr  8 07:40:12 test1 kernel:        c012d984 089edab4 00000ab4 00000001
7fffffff 00000000 00000001 c012da25
Apr  8 07:40:12 test1 kernel:        089edab4 00000001 00000001 7fffffff
01f78a40 00000003 089edab4 00000000
Apr  8 07:40:12 test1 kernel:  [<c012d984>] do_futex+0x8c/0x8e
Apr  8 07:40:12 test1 kernel:  [<c012da25>] sys_futex+0x9f/0xce
Apr  8 07:40:12 test1 kernel:  [<c010aa07>] syscall_call+0x7/0xb
Apr  8 07:40:12 test1 kernel: Code: 0f 0b ea 00 ea 08 2d c0 eb c8 8b 07 a9
00 08 00 00 75 da 8b


>>EIP; c012d0d5 <futex_wake+eb/1ae>   <=====

>>ebx; e2701eec <__crc_cap_syslog+92cb84/e7433c>
>>ecx; e35e1940 <__crc_poll_freewait+d1139/1f9356>
>>esi; c03bb410 <futex_queues+10/800>
>>edi; c15fed08 <__crc_global_cache_flush+7b8a2/18ed99>
>>ebp; c03bb410 <futex_queues+10/800>
>>esp; e2ab9f5c <__crc_cap_syslog+ce4bf4/e7433c>

Code;  c012d0d5 <futex_wake+eb/1ae>
00000000 <_EIP>:
Code;  c012d0d5 <futex_wake+eb/1ae>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d0d7 <futex_wake+ed/1ae>
   2:   ea 00 ea 08 2d c0 eb      ljmp   $0xebc0,$0x2d08ea00
Code;  c012d0de <futex_wake+f4/1ae>
   9:   c8 8b 07 a9               enter  $0x78b,$0xa9
Code;  c012d0e2 <futex_wake+f8/1ae>
   d:   00 08                     add    %cl,(%eax)
Code;  c012d0e4 <futex_wake+fa/1ae>
   f:   00 00                     add    %al,(%eax)
Code;  c012d0e6 <futex_wake+fc/1ae>
  11:   75 da                     jne    ffffffed <_EIP+0xffffffed>
Code;  c012d0e8 <futex_wake+fe/1ae>
  13:   8b 00                     mov    (%eax),%eax

Apr  8 07:40:12 test1 kernel: kernel BUG at include/linux/mm.h:234!
Apr  8 07:40:12 test1 kernel: invalid operand: 0000 [#2]
Apr  8 07:40:12 test1 kernel: CPU:    1
Apr  8 07:40:12 test1 kernel: EIP:    0060:[<c012d3f6>]    Not tainted
Apr  8 07:40:12 test1 kernel: EFLAGS: 00010246
Apr  8 07:40:12 test1 kernel: eax: 00000000   ebx: c15fed08   ecx: e2701eec
edx: e2701eec
Apr  8 07:40:12 test1 kernel: esi: 7fffffff   edi: e2700000   ebp: e2701f08
esp: e2701ed8
Apr  8 07:40:12 test1 kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 07:40:12 test1 kernel: Stack: e2701f08 089edab4 f6314800 c012d198
00000000 e2701eec e2701eec 00000001
Apr  8 07:40:12 test1 kernel:        e2701f58 e2701f58 c15fed08 00000ab4
089ed000 f6314800 e2701f10 e2701f10
Apr  8 07:40:12 test1 kernel:        c012d198 ffffffff 00000000 e35e3ef8
00000282 00000000 e2714ca0 c011afd6
Apr  8 07:40:12 test1 kernel:  [<c012d198>] futex_vcache_callback+0x0/0x6a
Apr  8 07:40:12 test1 kernel:  [<c012d198>] futex_vcache_callback+0x0/0x6a
Apr  8 07:40:12 test1 kernel:  [<c011afd6>] default_wake_function+0x0/0x12
Apr  8 07:40:12 test1 kernel:  [<c011afd6>] default_wake_function+0x0/0x12
Apr  8 07:40:12 test1 kernel:  [<c012d972>] do_futex+0x7a/0x8e
Apr  8 07:40:12 test1 kernel:  [<c012da25>] sys_futex+0x9f/0xce
Apr  8 07:40:12 test1 kernel:  [<c010aa07>] syscall_call+0x7/0xb
Apr  8 07:40:12 test1 kernel: Code: 0f 0b ea 00 ea 08 2d c0 eb c5 8b 03 a9
00 08 00 00 75 d7 8b


>>EIP; c012d3f6 <futex_wait+1f4/2ec>   <=====

>>ebx; c15fed08 <__crc_global_cache_flush+7b8a2/18ed99>
>>ecx; e2701eec <__crc_cap_syslog+92cb84/e7433c>
>>edx; e2701eec <__crc_cap_syslog+92cb84/e7433c>
>>esi; 7fffffff <__crc_ide_setting_sem+a3f87/d805c>
>>edi; e2700000 <__crc_cap_syslog+92ac98/e7433c>
>>ebp; e2701f08 <__crc_cap_syslog+92cba0/e7433c>
>>esp; e2701ed8 <__crc_cap_syslog+92cb70/e7433c>

Code;  c012d3f6 <futex_wait+1f4/2ec>
00000000 <_EIP>:
Code;  c012d3f6 <futex_wait+1f4/2ec>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d3f8 <futex_wait+1f6/2ec>
   2:   ea 00 ea 08 2d c0 eb      ljmp   $0xebc0,$0x2d08ea00
Code;  c012d3ff <futex_wait+1fd/2ec>
   9:   c5 8b 03 a9 00 08         lds    0x800a903(%ebx),%ecx
Code;  c012d405 <futex_wait+203/2ec>
   f:   00 00                     add    %al,(%eax)
Code;  c012d407 <futex_wait+205/2ec>
  11:   75 d7                     jne    ffffffea <_EIP+0xffffffea>
Code;  c012d409 <futex_wait+207/2ec>
  13:   8b 00                     mov    (%eax),%eax

Apr  8 07:40:12 test1 kernel: kernel BUG at include/linux/mm.h:234!
Apr  8 07:40:12 test1 kernel: invalid operand: 0000 [#3]
Apr  8 07:40:12 test1 kernel: CPU:    0
Apr  8 07:40:12 test1 kernel: EIP:    0060:[<c017797c>]    Not tainted
Apr  8 07:40:12 test1 kernel: EFLAGS: 00010246
Apr  8 07:40:12 test1 kernel: eax: 00000000   ebx: 08801000   ecx: 00001000
edx: c15fa028
Apr  8 07:40:12 test1 kernel: esi: e3e2a5c0   edi: e2aa6000   ebp: f79aee80
esp: e2aa7db4
Apr  8 07:40:12 test1 kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 07:40:12 test1 kernel: Stack: c15fa028 e6401000 00001000 00000000
00000000 00000001 e2aa7e14 e2aa7e10
Apr  8 07:40:12 test1 kernel:        000028a0 000307b8 e3764c00 e36e1100
e36e1180 f78bed80 e36e1280 00000005
Apr  8 07:40:12 test1 kernel:        b71b0000 00034000 01025000 00026f74
00001f20 c0000000 00000001 e3e2a5c0
Apr  8 07:40:12 test1 kernel:  [<c015a13a>] do_coredump+0x1da/0x1ed
Apr  8 07:40:12 test1 kernel:  [<c0126cb5>] __dequeue_signal+0xbb/0x164
Apr  8 07:40:12 test1 kernel:  [<c0126de8>] dequeue_signal+0x8a/0x92
Apr  8 07:40:12 test1 kernel:  [<c0128ad9>]
get_signal_to_deliver+0x227/0x346
Apr  8 07:40:12 test1 kernel:  [<c010a7d8>] do_signal+0xd6/0x106
Apr  8 07:40:12 test1 kernel:  [<c01210a6>] sys_wait4+0x1f6/0x27a
Apr  8 07:40:12 test1 kernel:  [<c011afd6>] default_wake_function+0x0/0x12
Apr  8 07:40:12 test1 kernel:  [<c0129c83>] sys_rt_sigaction+0xe5/0x10e
Apr  8 07:40:12 test1 kernel:  [<c0130242>] nanosleep_wake_up+0x0/0xa
Apr  8 07:40:12 test1 kernel:  [<c0130328>] sys_nanosleep+0xca/0xf0
Apr  8 07:40:12 test1 kernel:  [<c010a860>] do_notify_resume+0x58/0x5a
Apr  8 07:40:12 test1 kernel:  [<c010aa52>] work_notifysig+0x13/0x15
Apr  8 07:40:12 test1 kernel: Code: 0f 0b ea 00 ea 08 2d c0 eb 87 8b 02 a9
00 08 00 00 75 99 8b


>>EIP; c017797c <elf_core_dump+88a/9b0>   <=====

>>ebx; 08801000 <__crc_pci_root_buses+53dded/6bc856>
>>ecx; 00001000 Before first symbol
>>edx; c15fa028 <__crc_global_cache_flush+76bc2/18ed99>
>>esi; e3e2a5c0 <__crc_inode_sub_bytes+1cc6d9/23c490>
>>edi; e2aa6000 <__crc_cap_syslog+cd0c98/e7433c>
>>ebp; f79aee80 <__crc_path_release+666db/2ea4fc>
>>esp; e2aa7db4 <__crc_cap_syslog+cd2a4c/e7433c>

Code;  c017797c <elf_core_dump+88a/9b0>
00000000 <_EIP>:
Code;  c017797c <elf_core_dump+88a/9b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c017797e <elf_core_dump+88c/9b0>
   2:   ea 00 ea 08 2d c0 eb      ljmp   $0xebc0,$0x2d08ea00
Code;  c0177985 <elf_core_dump+893/9b0>
   9:   87 8b 02 a9 00 08         xchg   %ecx,0x800a902(%ebx)
Code;  c017798b <elf_core_dump+899/9b0>
   f:   00 00                     add    %al,(%eax)
Code;  c017798d <elf_core_dump+89b/9b0>
  11:   75 99                     jne    ffffffac <_EIP+0xffffffac>
Code;  c017798f <elf_core_dump+89d/9b0>
  13:   8b 00                     mov    (%eax),%eax


I'm setting an other test machine to try isolate the problem.
Thanks

Eric Dumazet

