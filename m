Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbTHXU5w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 16:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbTHXU5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 16:57:52 -0400
Received: from mail1-106.ewetel.de ([212.6.122.106]:56806 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S261307AbTHXU5s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 16:57:48 -0400
Date: Sun, 24 Aug 2003 22:57:30 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: linux-kernel@vger.kernel.org
cc: sct@redhat.com, <akpm@osdl.org>
Subject: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164 
Message-ID: <Pine.LNX.4.44.0308242250100.1411-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I was running fsx to test a userspace NFSv3 server. The underlying 
filesystem was ext3. After about 10 seconds into the fsx run, I hit the 
following BUG() in transaction.c. data=journal was used. I could not start 
any new processes after the incident and had to press the reset button.

Is this a known problem?

Assertion failure in journal_dirty_metadata() at transaction.c:1164: 
"jh->b_frozen_data == 0"

ksymoops 2.4.4 on i686 2.4.22-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc1/ (default)
     -m /boot/System.map-2.4.22-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at transaction.c:1164!
invalid operand: 0000
CPU:    0
EIP:    0010:[journal_dirty_metadata+359/416]    Not tainted
EIP:    0010:[<c015dcc7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000061   ebx: e6044f30   ecx: 00000005   edx: e77a9f44
esi: e77a67c0   edi: e7c447c0   ebp: e655c940   esp: d1459dcc
ds: 0018   es: 0018   ss: 0018
Process fsx (pid: 4689, stackpage=d1459000)
Stack: c02d8fa0 c02d4126 c02d49b8 0000048c c02d4bd1 d0785640 e655c940 00000000 
       00001000 c015581a e655c940 d0785640 00000246 00000000 00000246 00000000 
       d0785640 d07d7000 00001000 0000001e 00001000 d0785640 0000001c c01637f7 
Call Trace:    [commit_write_fn+26/96] [__jbd_kmalloc+39/160] [walk_page_buffers+93/128] [ext3_commit_write+166/448] [commit_write_fn+0/96]
Call Trace:    [<c015581a>] [<c01637f7>] [<c015557d>] [<c0155906>] [<c0155800>]
  [<c01276cd>] [<c0127ad0>] [<c01531ff>] [<c0132245>] [<c0131e20>] [<c0131fce>]
  [<c01088a3>]
Code: 0f 0b 8c 04 b8 49 2d c0 83 c4 14 6a 03 ff 75 00 53 e8 43 0a 

>>EIP; c015dcc7 <journal_dirty_metadata+167/1a0>   <=====
Trace; c015581a <commit_write_fn+1a/60>
Trace; c01637f7 <__jbd_kmalloc+27/a0>
Trace; c015557d <walk_page_buffers+5d/80>
Trace; c0155906 <ext3_commit_write+a6/1c0>
Trace; c0155800 <commit_write_fn+0/60>
Trace; c01276cd <do_generic_file_write+29d/3e0>
Trace; c0127ad0 <generic_file_write+f0/110>
Trace; c01531ff <ext3_file_write+1f/b0>
Trace; c0132245 <sys_write+95/f0>
Trace; c0131e20 <generic_file_llseek+0/b0>
Trace; c0131fce <sys_lseek+6e/80>
Trace; c01088a3 <system_call+33/38>
Code;  c015dcc7 <journal_dirty_metadata+167/1a0>
00000000 <_EIP>:
Code;  c015dcc7 <journal_dirty_metadata+167/1a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015dcc9 <journal_dirty_metadata+169/1a0>
   2:   8c 04 b8                  movl   %es,(%eax,%edi,4)
Code;  c015dccc <journal_dirty_metadata+16c/1a0>
   5:   49                        dec    %ecx
Code;  c015dccd <journal_dirty_metadata+16d/1a0>
   6:   2d c0 83 c4 14            sub    $0x14c483c0,%eax
Code;  c015dcd2 <journal_dirty_metadata+172/1a0>
   b:   6a 03                     push   $0x3
Code;  c015dcd4 <journal_dirty_metadata+174/1a0>
   d:   ff 75 00                  pushl  0x0(%ebp)
Code;  c015dcd7 <journal_dirty_metadata+177/1a0>
  10:   53                        push   %ebx
Code;  c015dcd8 <journal_dirty_metadata+178/1a0>
  11:   e8 43 0a 00 00            call   a59 <_EIP+0xa59> c015e720 <__journal_file_buffer+0/1e0>


1 warning and 1 error issued.  Results may not be reliable.


-- 
Ciao,
Pascal

