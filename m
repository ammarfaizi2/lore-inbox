Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312750AbSDFTPz>; Sat, 6 Apr 2002 14:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312748AbSDFTPy>; Sat, 6 Apr 2002 14:15:54 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:36037 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S312750AbSDFTPs>; Sat, 6 Apr 2002 14:15:48 -0500
Subject: 2.4.19-pre5-ac3 swsusp panic
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: linux-kernel@vger.kernel.org
Cc: swsusp@lister.fornax.hu, Alan Cox <alan@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 Apr 2002 14:15:39 -0500
Message-Id: <1018120544.4270.25.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran ksymoops 2.4.5 on the kernel. Here is the output. Hope this helps
shed some light onto things.   

ksymoops 2.4.5 on i686 2.4.19-pre5-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5-ac3/ (default)
     -m /boot/System.map-2.4.19-pre5-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

c0140b3b
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c0140b3b>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010293
eax: ffffffff   ebx: cf3c1c00     ecx: 00000000       edx: c1313c90
esi: 00000000   edi: 00001000     ebp: 00000001       esp: cff5de04
ds: 0018        es: 0018       ss: 0018
Process bdflush (pid: 6, stackpage=cff5d000)
stack:  cf3c1c00 c0140bc6 cf3c1c00 c1313c90 00000000 37363534 62614938 66656463
        6a696867 c1313c90 cf265000 cff5dea4 00001000 c0140dd8 c1313c90 00001000
        00000001 c1313c90 cf265000 c014259c c1313c90 00000303 00001000 0000850f
Call Trace: [<c0140bc6>] [<c0140dd8>] [<c014259c>] [<c0137b73>] [<c011aad6>] [<c0137cd3>] [<c0128a44>] [<c012892c>] [<c0129448>] [<c011ae10>] [<c012969e>] [<c0129bd7>] [<c011f72c>] [<c0142e9a>] [<c0142dc0>] [<c0105000>] [<c0105000>] [<c01071d6>] [<c0142dc0>]
Code: 2b 90 c4 00 00 00 c1 fa 02 69 d2 c5 4e ec c4 c1 e2 0c 03 90


>>EIP; c0140b3b <set_bh_page+2b/50>   <=====

>>eax; ffffffff <END_OF_CODE+2f7a7f20/????>
>>ebx; cf3c1c00 <_end+f11d68c/105a7a8c>
>>edx; c1313c90 <_end+106f71c/105a7a8c>
>>edi; 00001000 Before first symbol
>>esp; cff5de04 <_end+fcb9890/105a7a8c>

Trace; c0140bc6 <create_buffers+66/100>
Trace; c0140dd8 <create_empty_buffers+18/60>
Trace; c014259c <brw_page+bc/e0>
Trace; c0137b73 <rw_swap_page_base+73/110>
Trace; c011aad6 <__call_console_drivers+46/60>
Trace; c0137cd3 <rw_swap_page_nolock+53/a0>
Trace; c0128a44 <write_suspend_image+104/380>
Trace; c012892c <lock_swapdevices+6c/80>
Trace; c0129448 <suspend_save_image+198/1f0>
Trace; c011ae10 <printk+120/170>
Trace; c012969e <do_magic_suspend_2+e/e0>
Trace; c0129bd7 <do_software_suspend+b7/d0>
Trace; c011f72c <__run_task_queue+5c/70>
Trace; c0142e9a <bdflush+da/f0>
Trace; c0142dc0 <bdflush+0/f0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c01071d6 <kernel_thread+26/30>
Trace; c0142dc0 <bdflush+0/f0>

Code;  c0140b3b <set_bh_page+2b/50>
00000000 <_EIP>:
Code;  c0140b3b <set_bh_page+2b/50>   <=====
   0:   2b 90 c4 00 00 00         sub    0xc4(%eax),%edx   <=====
Code;  c0140b41 <set_bh_page+31/50>
   6:   c1 fa 02                  sar    $0x2,%edx
Code;  c0140b44 <set_bh_page+34/50>
   9:   69 d2 c5 4e ec c4         imul   $0xc4ec4ec5,%edx,%edx
Code;  c0140b4a <set_bh_page+3a/50>
   f:   c1 e2 0c                  shl    $0xc,%edx
Code;  c0140b4d <set_bh_page+3d/50>
  12:   03 90 00 00 00 00         add    0x0(%eax),%edx


1 warning issued.  Results may not be reliable.



