Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbRFGOKM>; Thu, 7 Jun 2001 10:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbRFGOKC>; Thu, 7 Jun 2001 10:10:02 -0400
Received: from ns.suse.de ([213.95.15.193]:58384 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262651AbRFGOJy>;
	Thu, 7 Jun 2001 10:09:54 -0400
Date: Thu, 7 Jun 2001 15:40:54 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac9 console NULL pointer pointer dereference
Message-ID: <20010607154054.A23442@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this happend with 2.4.5-ac9 with serial console on i386.

Full boot log and config can be found here:
http://www.penguinppc.org/~olaf/bugs/245-ac9/


ksymoops 2.4.1 on i686 2.4.6-pre1.  Options used
     -v /usr/src/OLAF/linux-2.4.5-ac9/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/OLAF/linux-2.4.5-ac9/System.map (specified)

 WARNING: unexpectC, please mail
cpu: 0, clocks: 1001790, slice: 500895
ttyS1 at Unable to handle kernel NULL pointer dereference0x02f8 (irq = 3) at virtual address 00000004
Oops: 0000
CPU:    0
EIP:    0010:[<c01967c7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: c1231fa4   ecx: 00000202   edx: 00000000
esi: c1231fa4   edi: c1230332   ebp: c1230000   esp: c1231f8c
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=c1231000)
Stack: c0195a67 c1231fa4 c0119a5c 00000000 c1230650 c1231fe0 c025a5c4 c025a5c4 
       c0120f97 c0252d20 00000700 c123ffc4 00000000 0008e000 c1230650 c1230640 
       00000001 00000000 00000000 00010000 00000000 00000000 c1230000 c0252d2c 
Call Trace: [<c0195a67>] [<c0119a5c>] [<c0120f97>] [<c01056cc>] 
Code: 80 78 04 01 74 39 83 3d 00 43 2d c0 00 74 11 a1 88 52 2c c0 

>>EIP; c01967c7 <poke_blanked_console+1b/5c>   <=====
Trace; c0195a67 <console_callback+5f/b0>
Trace; c0119a5c <__run_task_queue+60/74>
Trace; c0120f97 <context_thread+127/1c4>
Trace; c01056cc <kernel_thread+28/38>
Code;  c01967c7 <poke_blanked_console+1b/5c>
00000000 <_EIP>:
Code;  c01967c7 <poke_blanked_console+1b/5c>   <=====
   0:   80 78 04 01               cmpb   $0x1,0x4(%eax)   <=====
Code;  c01967cb <poke_blanked_console+1f/5c>
   4:   74 39                     je     3f <_EIP+0x3f> c0196806 <poke_blanked_console+5a/5c>
Code;  c01967cd <poke_blanked_console+21/5c>
   6:   83 3d 00 43 2d c0 00      cmpl   $0x0,0xc02d4300
Code;  c01967d4 <poke_blanked_console+28/5c>
   d:   74 11                     je     20 <_EIP+0x20> c01967e7 <poke_blanked_console+3b/5c>
Code;  c01967d6 <poke_blanked_console+2a/5c>
   f:   a1 88 52 2c c0            mov    0xc02c5288,%eax




Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
