Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273323AbTHFCOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273288AbTHFCOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:14:10 -0400
Received: from CPE-144-132-162-109.nsw.bigpond.net.au ([144.132.162.109]:59132
	"EHLO tigers-lfs.local") by vger.kernel.org with ESMTP
	id S273323AbTHFCNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:13:54 -0400
Date: Wed, 6 Aug 2003 12:13:16 +1000
From: Greg Schafer <gschafer@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 oops - NPTL triggered
Message-ID: <20030806021316.GA408@tigers-lfs.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

An otherwise fine running kernel-2.6.0-test2 repeatably gives this when
running the NPTL testsuite.

ksymoops output attached.

 - kernel compiled with gcc-2.95.4 (s'pose I should try 3.2.3)
 - recent binutils
 - board is Tyan S2466N-4M with pair of Athlon 2200's

This is a UP kernel (trying to narrow down the cause).

Thanks
Greg
(not subscribed)

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.4.9 on i686 2.6.0-test2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test2/ (default)
     -m /boot/System.map-2.6.0-test2 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace:
 [<c0115093>] __might_sleep+0x53/0x60
 [<c01129b5>] do_page_fault+0x65/0x3fa
 [<c0112950>] do_page_fault+0x0/0x3fa
 [<c014ebdc>] vfs_follow_link+0xcc/0x140
 [<c0108e95>] error_code+0x2d/0x38
 [<c012384c>] _detach_pid+0x1c/0x80
 [<c0123a03>] switch_exec_pids+0x13/0x100
 [<c0149fa8>] flush_old_exec+0x2c8/0x660
 [<c0163639>] load_elf_binary+0x479/0xb00
 [<c012d44c>] buffered_rmqueue+0xbc/0xd0
 [<c014a5f5>] search_binary_handler+0x75/0x1b0
 [<c014a86a>] do_execve+0x13a/0x190
 [<c010789f>] sys_execve+0x2f/0x70
 [<c0108c99>] sysenter_past_esp+0x52/0x71
Unable to handle kernel paging request at virtual address 00100104
c012384c
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c012384c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: f77f2db0   ebx: f77f2dbc   ecx: 00200200   edx: 00100100
esi: f77f2d00   edi: f77f2d00   ebp: f0e99cc0   esp: f0e99cbc
ds: 007b   es: 007b   ss: 0068
Stack: f0f2a6e0 f0e99cd8 c0123a03 f77f2d00 00000000 f77f2da4 00000002 f0e99d20 
       c0149fa8 f77f2d00 f0f2a6e0 f0e98000 00000002 c0292d37 f0e99e60 f0e98000 
       f176a6a0 00000000 00000000 00000000 f0e98000 f7feaf40 f7311580 f661eac0 
Call Trace:
 [<c0123a03>] switch_exec_pids+0x13/0x100
 [<c0149fa8>] flush_old_exec+0x2c8/0x660
 [<c0163639>] load_elf_binary+0x479/0xb00
 [<c012d44c>] buffered_rmqueue+0xbc/0xd0
 [<c014a5f5>] search_binary_handler+0x75/0x1b0
 [<c014a86a>] do_execve+0x13a/0x190
 [<c010789f>] sys_execve+0x2f/0x70
 [<c0108c99>] sysenter_past_esp+0x52/0x71
Code: 89 4a 04 89 11 c7 00 00 01 10 00 c7 40 04 00 02 20 00 ff 4b 


Trace; c0115093 <__might_sleep+53/60>
Trace; c01129b5 <do_page_fault+65/3fa>
Trace; c0112950 <do_page_fault+0/3fa>
Trace; c014ebdc <vfs_follow_link+cc/140>
Trace; c0108e95 <error_code+2d/38>
Trace; c012384c <_detach_pid+1c/80>
Trace; c0123a03 <switch_exec_pids+13/100>
Trace; c0149fa8 <flush_old_exec+2c8/660>
Trace; c0163639 <load_elf_binary+479/b00>
Trace; c012d44c <buffered_rmqueue+bc/d0>
Trace; c014a5f5 <search_binary_handler+75/1b0>
Trace; c014a86a <do_execve+13a/190>
Trace; c010789f <sys_execve+2f/70>
Trace; c0108c99 <sysenter_past_esp+52/71>

>>EIP; c012384c <_detach_pid+1c/80>   <=====

>>eax; f77f2db0 <_end+374676ac/3fc728fc>
>>ebx; f77f2dbc <_end+374676b8/3fc728fc>
>>esi; f77f2d00 <_end+374675fc/3fc728fc>
>>edi; f77f2d00 <_end+374675fc/3fc728fc>
>>ebp; f0e99cc0 <_end+30b0e5bc/3fc728fc>
>>esp; f0e99cbc <_end+30b0e5b8/3fc728fc>

Trace; c0123a03 <switch_exec_pids+13/100>
Trace; c0149fa8 <flush_old_exec+2c8/660>
Trace; c0163639 <load_elf_binary+479/b00>
Trace; c012d44c <buffered_rmqueue+bc/d0>
Trace; c014a5f5 <search_binary_handler+75/1b0>
Trace; c014a86a <do_execve+13a/190>
Trace; c010789f <sys_execve+2f/70>
Trace; c0108c99 <sysenter_past_esp+52/71>

Code;  c012384c <_detach_pid+1c/80>
00000000 <_EIP>:
Code;  c012384c <_detach_pid+1c/80>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c012384f <_detach_pid+1f/80>
   3:   89 11                     mov    %edx,(%ecx)
Code;  c0123851 <_detach_pid+21/80>
   5:   c7 00 00 01 10 00         movl   $0x100100,(%eax)
Code;  c0123857 <_detach_pid+27/80>
   b:   c7 40 04 00 02 20 00      movl   $0x200200,0x4(%eax)
Code;  c012385e <_detach_pid+2e/80>
  12:   ff 4b 00                  decl   0x0(%ebx)

 <1>Unable to handle kernel paging request at virtual address 00100104
c012384c
*pde = 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c012384c>]    Not tainted
EFLAGS: 00010082
eax: f009a710   ebx: f009a71c   ecx: 00200200   edx: 00100100
esi: f009a660   edi: f009a660   ebp: f0e99cc0   esp: f0e99cbc
ds: 007b   es: 007b   ss: 0068
Stack: f0f2a6e0 f0e99cd8 c0123a03 f009a660 00000000 f009a704 00000002 f0e99d20 
       c0149fa8 f009a660 f0f2a6e0 f0e98000 f0e99e60 f7a98240 f7a981c0 f0e98000 
       f176a6a0 00000000 00000000 00000000 f0e98000 f7feaac0 f661eac0 efbfb040 
Call Trace:
 [<c0123a03>] switch_exec_pids+0x13/0x100
 [<c0149fa8>] flush_old_exec+0x2c8/0x660
 [<c0163639>] load_elf_binary+0x479/0xb00
 [<c012d44c>] buffered_rmqueue+0xbc/0xd0
 [<c012d44c>] buffered_rmqueue+0xbc/0xd0
 [<c012d4ee>] __alloc_pages+0x8e/0x2d0
 [<c014a5f5>] search_binary_handler+0x75/0x1b0
 [<c014a86a>] do_execve+0x13a/0x190
 [<c010789f>] sys_execve+0x2f/0x70
 [<c0108c99>] sysenter_past_esp+0x52/0x71
Code: 89 4a 04 89 11 c7 00 00 01 10 00 c7 40 04 00 02 20 00 ff 4b 


>>EIP; c012384c <_detach_pid+1c/80>   <=====

>>eax; f009a710 <_end+2fd0f00c/3fc728fc>
>>ebx; f009a71c <_end+2fd0f018/3fc728fc>
>>esi; f009a660 <_end+2fd0ef5c/3fc728fc>
>>edi; f009a660 <_end+2fd0ef5c/3fc728fc>
>>ebp; f0e99cc0 <_end+30b0e5bc/3fc728fc>
>>esp; f0e99cbc <_end+30b0e5b8/3fc728fc>

Trace; c0123a03 <switch_exec_pids+13/100>
Trace; c0149fa8 <flush_old_exec+2c8/660>
Trace; c0163639 <load_elf_binary+479/b00>
Trace; c012d44c <buffered_rmqueue+bc/d0>
Trace; c012d44c <buffered_rmqueue+bc/d0>
Trace; c012d4ee <__alloc_pages+8e/2d0>
Trace; c014a5f5 <search_binary_handler+75/1b0>
Trace; c014a86a <do_execve+13a/190>
Trace; c010789f <sys_execve+2f/70>
Trace; c0108c99 <sysenter_past_esp+52/71>

Code;  c012384c <_detach_pid+1c/80>
00000000 <_EIP>:
Code;  c012384c <_detach_pid+1c/80>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c012384f <_detach_pid+1f/80>
   3:   89 11                     mov    %edx,(%ecx)
Code;  c0123851 <_detach_pid+21/80>
   5:   c7 00 00 01 10 00         movl   $0x100100,(%eax)
Code;  c0123857 <_detach_pid+27/80>
   b:   c7 40 04 00 02 20 00      movl   $0x200200,0x4(%eax)
Code;  c012385e <_detach_pid+2e/80>
  12:   ff 4b 00                  decl   0x0(%ebx)


1 error issued.  Results may not be reliable.

--3MwIy2ne0vdjdPXF--
