Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318864AbSHLXZJ>; Mon, 12 Aug 2002 19:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318866AbSHLXZJ>; Mon, 12 Aug 2002 19:25:09 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:12786 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318864AbSHLXZI>; Mon, 12 Aug 2002 19:25:08 -0400
Date: Mon, 12 Aug 2002 19:28:58 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: v2.5.31 handle_scancode oops
Message-ID: <20020812192858.S1781@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with only the serial console enabled, pressing Ctrl-Scroll 
Lock kills the system with the following oops.  Whoever has been working 
on the console code might be interested in fixing this.

		-ben

ksymoops 2.4.4 on i686 2.4.18-5smp.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

Unable to handle kernel paging request at virtual address 646d203c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01bc05d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 646d2030   ebx: c7b74000   ecx: 00000000   edx: c035d5a0
esi: 0000001d   edi: 00000001   ebp: c11610e0   esp: c77f5f2c
ds: 0018   es: 0018   ss: 0018
Stack: c035d5a0 611d0000 00000000 0000001d 0000270f c77f5fc4 c01bc4e7 0000001d 
       00000001 3d52d215 00000000 0001041e 00000000 c77f5f7c 40012020 bffff550 
       bffff5c8 c1166580 00000001 00000001 c01bc54f c0108a8a 00000001 00000000 
Call Trace: [<c01bc4e7>] [<c01bc54f>] [<c0108a8a>] [<c0108be8>] [<c0107754>] 
Code: f6 40 0c 08 75 15 53 ff 53 7c 5a 85 c0 0f 85 bf 00 00 00 a1 

>>EIP; c01bc05d <handle_scancode+15d/250>   <=====
Trace; c01bc4e7 <handle_kbd_event+137/190>
Trace; c01bc54f <keyboard_interrupt+f/20>
Trace; c0108a8a <handle_IRQ_event+3a/60>
Trace; c0108be8 <do_IRQ+78/e0>
Trace; c0107754 <common_interrupt+18/20>
Code;  c01bc05d <handle_scancode+15d/250>
00000000 <_EIP>:
Code;  c01bc05d <handle_scancode+15d/250>   <=====
   0:   f6 40 0c 08               testb  $0x8,0xc(%eax)   <=====
Code;  c01bc061 <handle_scancode+161/250>
   4:   75 15                     jne    1b <_EIP+0x1b> c01bc078 <handle_scancode+178/250>
Code;  c01bc063 <handle_scancode+163/250>
   6:   53                        push   %ebx
Code;  c01bc064 <handle_scancode+164/250>
   7:   ff 53 7c                  call   *0x7c(%ebx)
Code;  c01bc067 <handle_scancode+167/250>
   a:   5a                        pop    %edx
Code;  c01bc068 <handle_scancode+168/250>
   b:   85 c0                     test   %eax,%eax
Code;  c01bc06a <handle_scancode+16a/250>
   d:   0f 85 bf 00 00 00         jne    d2 <_EIP+0xd2> c01bc12f <handle_scancode+22f/250>
Code;  c01bc070 <handle_scancode+170/250>
  13:   a1 00 00 00 00            mov    0x0,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

-- 
"You will be reincarnated as a toad; and you will be much happier."
