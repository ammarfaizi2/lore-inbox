Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbQLGJqe>; Thu, 7 Dec 2000 04:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLGJqY>; Thu, 7 Dec 2000 04:46:24 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:10747 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129345AbQLGJqJ>;
	Thu, 7 Dec 2000 04:46:09 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: linux-kernel@vger.kernel.org
Subject: USB-related lockup in test12-pre5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Dec 2000 09:15:40 +0000
Message-ID: <11659.976180540@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Haven't tried test12-pre7 yet. Is enabling bus mastering likely to make 
this magically go away? I doubt it.

This happened when trying to run excel under wine. Dual Celeron with 
CONFIG_USB_UHCI.

NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c0270c21>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00200086
eax: c12c9600   ebx: c7a383c0   ecx: c7a383c0   edx: c12c9600
esi: 00000001   edi: 00000001   ebp: c7f068a0   esp: c123dea8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c123d000)
Stack: 00200006 00000001 c7a38398 c7a383c0 00000001 c7a38000 c01f488e c7a383c0
       ca8578be c7a383c0 00200246 00000000 c7a383c0 00000000 c7f068a0 c01ffc3e
       c7a383c0 00000000 00000000 c12c9600 00000000 c7a3846c c7f068a0 c7f068bc
Call Trace: [<c01f488e>] [<ca8578be>] [<c01ffc3e>] [<c01ffd49>] [<c010c800>] [<c010ca01>] [<c0108f50>]
       [<c010af88>] [<c0108f50>] [<c0100018>] [<c0108f7c>] [<c0109002>] [<c011f47d>] [<c010ca47>]
Code: f3 90 7e f8 e9 42 dc f8 ff 80 7e 24 00 f3 90 7e f8 e9 89 e7

>>EIP; c0270c21 <stext_lock+4e6d/8f50>   <=====
Trace; c01f488e <usb_submit_urb+1e/30>
Trace; ca8578be <[audio]usbout_completed+7e/c0>
Trace; c01ffc3e <process_urb+1de/230>
Trace; c01ffd49 <uhci_interrupt+b9/120>
Trace; c010c800 <handle_IRQ_event+60/90>
Trace; c010ca01 <do_IRQ+a1/100>
Trace; c0108f50 <default_idle+0/40>
Trace; c010af88 <ret_from_intr+0/20>
Trace; c0108f50 <default_idle+0/40>
Trace; c0100018 <startup_32+18/cb>
Trace; c0108f7c <default_idle+2c/40>
Trace; c0109002 <cpu_idle+52/70>
Trace; c011f47d <do_softirq+6d/a0>
Trace; c010ca47 <do_IRQ+e7/100>
Code;  c0270c21 <stext_lock+4e6d/8f50>
00000000 <_EIP>:
Code;  c0270c21 <stext_lock+4e6d/8f50>   <=====
   0:   f3 90                     repz nop    <=====
Code;  c0270c23 <stext_lock+4e6f/8f50>
   2:   7e f8                     jle    fffffffc <_EIP+0xfffffffc> c0270c1d <stext_lock+4e69/8f50>
Code;  c0270c25 <stext_lock+4e71/8f50>
   4:   e9 42 dc f8 ff            jmp    fff8dc4b <_EIP+0xfff8dc4b> c01fe86c <uhci_submit_urb+6c/2d0>
Code;  c0270c2a <stext_lock+4e76/8f50>
   9:   80 7e 24 00               cmpb   $0x0,0x24(%esi)
Code;  c0270c2e <stext_lock+4e7a/8f50>
   d:   f3 90                     repz nop 
Code;  c0270c30 <stext_lock+4e7c/8f50>
   f:   7e f8                     jle    9 <_EIP+0x9> c0270c2a <stext_lock+4e76/8f50>
Code;  c0270c32 <stext_lock+4e7e/8f50>
  11:   e9 89 e7 00 00            jmp    e79f <_EIP+0xe79f> c027f3c0 <tvecs+1678/e4f8>



--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
