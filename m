Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbTGEXMT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 19:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbTGEXMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 19:12:19 -0400
Received: from [65.37.126.18] ([65.37.126.18]:16283 "EHLO the-penguin.otak.com")
	by vger.kernel.org with ESMTP id S266547AbTGEXMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 19:12:15 -0400
Date: Sat, 5 Jul 2003 16:26:47 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel oops, netstat -a
Message-ID: <20030705232647.GA22714@the-penguin.otak.com>
Mail-Followup-To: Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.5.74 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I got a oops from netstat -a today, seems innocuous, and repeatable.
Happens on both stock 2.5.74, 2.5.74-mm1. 

ksymoops 2.4.8 on i686 2.5.74.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.74/ (default)
     -m /boot/System.map-2.5.74 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 3ddcd9ae
c0138480
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0138480>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010016
eax: 00140000   ebx: e9b9cd00   ecx: e7b23cc0   edx: 3ddcd9ae
esi: 00000100   edi: 00000206   ebp: da345600   esp: cc91bf50
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000001 e9b9cd00 e7b23cc0 c952cdd0 c01651b5 00000100 e7b23cc0 
       e7b23cc0 efff0740 c952cdd0 c014b2d9 c952cdd0 e7b23cc0 e7b23cc0 e69b8c80 
       00000000 cc91a000 c0149acd e7b23cc0 e69b8c80 e7b23cc0 08060130 08060130 
Call Trace:
 [<c01651b5>] seq_release_private+0x25/0x48
 [<c014b2d9>] __fput+0xd9/0xe0
 [<c0149acd>] filp_close+0x4d/0x80
 [<c0149b50>] sys_close+0x50/0x60
 [<c010a88b>] syscall_call+0x7/0xb
Code: 8b 1a 8b 03 3b 43 04 73 18 89 74 83 10 ff 03 57 9d 8b 5c 24 


>>EIP; c0138480 <kfree+30/70>   <=====

>>ebx; e9b9cd00 <acqseq_lock.5+29823e38/3fc85138>
>>ecx; e7b23cc0 <acqseq_lock.5+277aadf8/3fc85138>
>>ebp; da345600 <acqseq_lock.5+19fcc738/3fc85138>
>>esp; cc91bf50 <acqseq_lock.5+c5a3088/3fc85138>

Trace; c01651b5 <seq_release_private+25/48>
Trace; c014b2d9 <__fput+d9/e0>
Trace; c0149acd <filp_close+4d/80>
Trace; c0149b50 <sys_close+50/60>
Trace; c010a88b <syscall_call+7/b>

Code;  c0138480 <kfree+30/70>
00000000 <_EIP>:
Code;  c0138480 <kfree+30/70>   <=====
   0:   8b 1a                     mov    (%edx),%ebx   <=====
Code;  c0138482 <kfree+32/70>
   2:   8b 03                     mov    (%ebx),%eax
Code;  c0138484 <kfree+34/70>
   4:   3b 43 04                  cmp    0x4(%ebx),%eax
Code;  c0138487 <kfree+37/70>
   7:   73 18                     jae    21 <_EIP+0x21>
Code;  c0138489 <kfree+39/70>
   9:   89 74 83 10               mov    %esi,0x10(%ebx,%eax,4)
Code;  c013848d <kfree+3d/70>
   d:   ff 03                     incl   (%ebx)
Code;  c013848f <kfree+3f/70>
   f:   57                        push   %edi
Code;  c0138490 <kfree+40/70>
  10:   9d                        popf   
Code;  c0138491 <kfree+41/70>
  11:   8b 5c 24 00               mov    0x0(%esp,1),%ebx


1 warning and 1 error issued.  Results may not be reliable.


-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


