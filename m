Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265239AbRGEOlr>; Thu, 5 Jul 2001 10:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbRGEOl2>; Thu, 5 Jul 2001 10:41:28 -0400
Received: from borg.metroweb.co.za ([196.23.181.81]:3590 "EHLO
	borg.metroweb.co.za") by vger.kernel.org with ESMTP
	id <S265239AbRGEOlV>; Thu, 5 Jul 2001 10:41:21 -0400
From: Henry <henry@borg.metroweb.co.za>
To: linux-kernel@vger.kernel.org
Subject: OOPS (kswapd) in 2.4.5 and 2.4.6
Date: Thu, 5 Jul 2001 16:03:00 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01070516412506.06182@borg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Presumably this has already been mentioned, but since it seems like an ongoing
thing (I've seen a similar topic discussed at
http://kt.zork.net/kernel-traffic/) I thought it wouldn't hurt to provide
more info.

We've noticed the following kernel error since 2.4 (2.4.1-2.4.6).  It appears to
be swap (kswapd thread specific?) related.  The same error is reported on
several SMP machines after only a short period (an hour or less).  The problem
has only started since we upgraded to 2.4.

Here's two ksymoops outputs from different machines (on 2.4.5 the first server
would eventually fail with memory errors (sorry, don't have the specific
error, but it involved 'semget' and (eg) apache would refuse to launch) and
require a reboot; the second server would not require a reboot).  With 2.4.6
the error still appears, but the servers *seem* more stable (ie, not requiring
a reboot).

Please advise if more detail is required or if anything else will help.

regards
Henry

Hardware:
-------
Our test servers are:
Dual-cpu pentium 233 (intel) with 128MB RAM and more than double that swap.

Software:
-------
Kernel: 2.4.6
gcc: egcs-2.91.66 19990314/Linux (egcs-1.1.2 release) and gcc version 2.95.2
19991024 (as I type this I realise the diff with compilers - surely that's not
the cause though, since compiling 2.2 with both was not a problem)

Distribution:  slackware 7 with the latest e2fsprogs/modutils/util-linux. 

Server1: ------
cpu: 0, clocks: 668166, slice: 222722
cpu: 1, clocks: 668166, slice: 222722
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c01b4227
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b4227>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 00000001   ebx: 00000000   ecx: 000000c0   edx: c12c49c0
esi: c12d3f4c   edi: 00000001   ebp: c0d0f2a0   esp: c12d3ee0
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c12d3000)
Stack: 00000000 c12d3f4c c12d3f4c c01330cb 00000001 00000000 001c4300 c1203048 
       00000000 00000028 c0129752 00000001 c1203048 00000305 c12d3f48 00001000 
       001c4300 c1203048 00000000 00000028 c12d3f48 00000000 00001000 00001c43 
Call Trace: [<c01330cb>] [<c0129752>] [<c0106cec>] [<c012981f>] [<c012a4e8>] [<c
0128b1d>] [<c01293f5>] 
       [<c0129486>] [<c01054cc>] 
Code: 0f b7 43 08 66 c1 e8 09 0f b7 f0 8b 43 18 a8 04 75 19 68 a7 

>>EIP; c01b4227 <submit_bh+b/74>   <=====
Trace; c01330cb <brw_page+8f/a0>
Trace; c0129752 <rw_swap_page_base+152/1b0>
Trace; c0106cec <ret_from_intr+0/7>
Trace; c012981f <rw_swap_page+6f/b8>
Trace; c012a4e8 <swap_writepage+78/80>
Trace; c0128b1d <page_launder+285/874>
Trace; c01293f5 <do_try_to_free_pages+1d/58>
Trace; c0129486 <kswapd+56/e8>
Trace; c01054cc <kernel_thread+28/38>
Code;  c01b4227 <submit_bh+b/74>
00000000 <_EIP>:
Code;  c01b4227 <submit_bh+b/74>   <=====
   0:   0f b7 43 08               movzwl 0x8(%ebx),%eax   <=====
Code;  c01b422b <submit_bh+f/74>
   4:   66 c1 e8 09               shrw   $0x9,%ax
Code;  c01b422f <submit_bh+13/74>
   8:   0f b7 f0                  movzwl %ax,%esi
Code;  c01b4232 <submit_bh+16/74>
   b:   8b 43 18                  movl   0x18(%ebx),%eax
Code;  c01b4235 <submit_bh+19/74>
   e:   a8 04                     testb  $0x4,%al
Code;  c01b4237 <submit_bh+1b/74>
  10:   75 19                     jne    2b <_EIP+0x2b> c01b4252 <submit_bh+36/74>
Code;  c01b4239 <submit_bh+1d/74>
  12:   68 a7 00 00 00            pushl  $0xa7


Server2:
------
cpu: 0, clocks: 668219, slice: 222739
cpu: 1, clocks: 668219, slice: 222739
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c01bd75b
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01bd75b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: 00000000
esi: 00000002   edi: 00000001   ebp: c12d5f4c   esp: c12d5ee4
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c12d5000)
Stack: 00000000 00000002 c0948d40 c01345bf 00000001 00000000 0020b000 c1192208 
       00000008 00001000 c012a7c7 00000001 c1192208 00000302 c12d5f48 00001000 
       0020b000 c1192208 00000008 00000030 c12d5f48 00000000 000020b0 030200c0 
Call Trace: [<c01345bf>] [<c012a7c7>] [<c012a89c>] [<c012b56c>] [<c0129a44>] [<c
012a445>] [<c012a4d6>] 
       [<c0105000>] [<c010550b>] 
Code: 0f b7 43 08 66 c1 e8 09 0f b7 f0 8b 43 18 a8 04 75 1b 68 a7 

>>EIP; c01bd75b <submit_bh+b/78>   <=====
Trace; c01345bf <brw_page+93/a4>
Trace; c012a7c7 <rw_swap_page_base+14f/1b0>
Trace; c012a89c <rw_swap_page+74/bc>
Trace; c012b56c <swap_writepage+78/80>
Trace; c0129a44 <page_launder+294/918>
Trace; c012a445 <do_try_to_free_pages+1d/58>
Trace; c012a4d6 <kswapd+56/e4>
Trace; c0105000 <_stext+0/0>
Trace; c010550b <kernel_thread+23/30>
Code;  c01bd75b <submit_bh+b/78>
00000000 <_EIP>:
Code;  c01bd75b <submit_bh+b/78>   <=====
   0:   0f b7 43 08               movzwl 0x8(%ebx),%eax   <=====
Code;  c01bd75f <submit_bh+f/78>
   4:   66 c1 e8 09               shrw   $0x9,%ax
Code;  c01bd763 <submit_bh+13/78>
   8:   0f b7 f0                  movzwl %ax,%esi
Code;  c01bd766 <submit_bh+16/78>
   b:   8b 43 18                  movl   0x18(%ebx),%eax
Code;  c01bd769 <submit_bh+19/78>
   e:   a8 04                     testb  $0x4,%al
Code;  c01bd76b <submit_bh+1b/78>
  10:   75 1b                     jne    2d <_EIP+0x2d> c01bd788 <submit_bh+38/78>
Code;  c01bd76d <submit_bh+1d/78>
  12:   68 a7 00 00 00            pushl  $0xa7
