Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSGWQxo>; Tue, 23 Jul 2002 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318147AbSGWQxo>; Tue, 23 Jul 2002 12:53:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58039 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318145AbSGWQxl>; Tue, 23 Jul 2002 12:53:41 -0400
Subject: kernel BUG at page_alloc.c:92! & page allocation failure. order:0, mode:0x0
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6F39340B.FF1F1097-ON85256BFF.005C6460@pok.ibm.com>
From: "David F Barrera" <dbarrera@us.ibm.com>
Date: Tue, 23 Jul 2002 11:56:46 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 07/23/2002 12:56:49 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have experienced the following errors while running a test suite (LTP
test suite)  on the 2.4.26 kernel.  Has anybody seen this problem, and, if
so, is there a patch for it?  Thanks.


kernel BUG at page_alloc.c:92!
invalid operand: 0000
CPU:    7
EIP:    0010:[<c0132fae>]    Not tainted
EFLAGS: 00010202
eax: 00000020   ebx: 00000009   ecx: c7fd0208   edx: c7fd0208
esi: fe0029fa   edi: 00000000   ebp: ddeff009   esp: f6793eb4
ds: 0018   es: 0018   ss: 0018
Process top (pid: 4648, threadinfo=f6792000 task=f7320ce0)
Stack: c7fd0208 00000000 00000009 ddeff000 ddeff000 c011e137 f7320ce0
f5f4d8a0
       bffff9f1 00000009 fe0029fa 00000000 ddeff009 c011e0fe f6792000
ddeff000
       f5f4d8a0 c7fd0208 f5ba83c0 00000000 f5f4d8a0 ddeff000 ddeff000
c015cca3
Call Trace: [<c011e137>] [<c011e0fe>] [<c015cca3>] [<c015d016>]
[<c013c9e8>]
   [<c013cb9a>] [<c010700b>]

Code: 0f 0b 5c 00 99 49 2d c0 8b 14 24 8b 42 14 83 e0 40 74 08 0f

mremap01: page allocation failure. order:0, mode:0x0
pdflush: page allocation failure. order:0, mode:0x0
mremap01: page allocation failure. order:0, mode:0x0
mremap01: page allocation failure. order:0, mode:0x0
pdflush: page allocation failure. order:0, mode:0x0
pdflush: page allocation failure. order:0, mode:0x0
mremap01: page allocation failure. order:0, mode:0x0
pdflush: page allocation failure. order:0, mode:0x0
pdflush: page allocation failure. order:0, mode:0x0
pdflush: page allocation failure. order:0, mode:0x0
pdflush: page allocation failure. order:0, mode:0x0
pdflush: page allocation failure. order:0, mode:0x0
----------------------------------------------------------------------------------------------------------------------------
Ksymoops output:

ksymoops 2.4.1 on i686 2.5.26.  Options used
     -v /boot/vmlinux-2.5.26 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.26/ (default)
     -m /boot/System.map-2.5.26 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Warning (compare_maps): ksyms_base symbol
__wake_up_sync_R__ver___wake_up_sync not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not
found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
set_cpus_allowed_R__ver_set_cpus_allowed not found in vmlinux.  Ignoring
ksyms_base entry
kernel BUG at page_alloc.c:92!
invalid operand: 0000
CPU:    7
EIP:    0010:[<c0132fae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000020   ebx: 00000009   ecx: c7fd0208   edx: c7fd0208
esi: fe0029fa   edi: 00000000   ebp: ddeff009   esp: f6793eb4
ds: 0018   es: 0018   ss: 0018
Stack: c7fd0208 00000000 00000009 ddeff000 ddeff000 c011e137 f7320ce0
f5f4d8a0
       bffff9f1 00000009 fe0029fa 00000000 ddeff009 c011e0fe f6792000
ddeff000
       f5f4d8a0 c7fd0208 f5ba83c0 00000000 f5f4d8a0 ddeff000 ddeff000
c015cca3
Call Trace: [<c011e137>] [<c011e0fe>] [<c015cca3>] [<c015d016>]
[<c013c9e8>]
   [<c013cb9a>] [<c010700b>]
Code: 0f 0b 5c 00 99 49 2d c0 8b 14 24 8b 42 14 83 e0 40 74 08 0f

>>EIP; c0132fae <__free_pages_ok+4e/2e0>   <=====
Trace; c011e137 <access_process_vm+177/1c0>
Trace; c011e0fe <access_process_vm+13e/1c0>
Trace; c015cca3 <proc_pid_cmdline+63/f0>
Trace; c015d016 <proc_info_read+46/100>
Trace; c013c9e8 <vfs_read+98/110>
Trace; c013cb9a <sys_read+2a/40>
Trace; c010700b <syscall_call+7/b>
Code;  c0132fae <__free_pages_ok+4e/2e0>
00000000 <_EIP>:
Code;  c0132fae <__free_pages_ok+4e/2e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0132fb0 <__free_pages_ok+50/2e0>
   2:   5c                        pop    %esp
Code;  c0132fb1 <__free_pages_ok+51/2e0>
   3:   00 99 49 2d c0 8b         add    %bl,0x8bc02d49(%ecx)
Code;  c0132fb7 <__free_pages_ok+57/2e0>
   9:   14 24                     adc    $0x24,%al
Code;  c0132fb9 <__free_pages_ok+59/2e0>
   b:   8b 42 14                  mov    0x14(%edx),%eax
Code;  c0132fbc <__free_pages_ok+5c/2e0>
   e:   83 e0 40                  and    $0x40,%eax
Code;  c0132fbf <__free_pages_ok+5f/2e0>
  11:   74 08                     je     1b <_EIP+0x1b> c0132fc9
<__free_pages_ok+69/2e0>
Code;  c0132fc1 <__free_pages_ok+61/2e0>
  13:   0f 00 00                  sldtl  (%eax)


4 warnings issued.  Results may not be reliable.


David F Barrera
dbarrera@us.ibm.com


