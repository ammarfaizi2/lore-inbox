Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266453AbUF3EWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUF3EWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 00:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUF3EWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 00:22:36 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:53895 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S266453AbUF3EWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 00:22:32 -0400
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 30 Jun 2004 04:21:09 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: twl@mail.com
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Jun 2004 23:22:28 -0500
Subject: 2.6.7 oops in psmouse/serio while booting
X-Originating-Ip: 170.215.214.139
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20040630042228.7FC414BDAE@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The panic happens in psmouse_interrupt.  It doesn't happen every time I boot, 
but it happens about half of the time.  It doesn't happen with 2.6.6. 
 
I have a USB mouse, but the input driver initially seems to think it has found 
a serial PS/2 mouse. 
 
When it boots ok, I see this: 
 
mice: PS/2 mouse device common for all mice 
serio: i8042 AUX port at 0x60,0x64 irq 12 
input: PS/2 Generic Mouse on isa0060/serio1 
<snip> 
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.0-1 
 
When it panics, I see this: 
 
mice: PS/2 mouse device common for all mice 
serio: i8042 AUX port at 0x60,0x64 irq 12 
Unable to handle kernel NULL pointer dereference at virtual address 00000000 
 printing eip: 
00000000 
*pde = 00000000 
Oops: 0000 [#1] 
PREEMPT SMP 
Modules linked in: 
CPU:    1 
EIP:    0060:[<00000000>]    Not tainted 
EFLAGS: 00010206   (2.6.7) 
EIP is at 0x0 
eax: 00000001   ebx: c15d3000   ecx: 00000000   edx: 000000fa 
esi: 000000fa   edi: c035b4a0   ebp: 00000001   esp: c15fde4c 
ds: 007b   es: 007b   ss: 0068 
Process swapper (pid: 1, threadinfo=c15fc000 task=c15ff670) 
Stack: c025593c c15d3000 00000000 00000000 00000000 fffb91fa 00000000 c0257db6 
       c035b4a0 000000fa 00000000 00000000 fa00003d 0000003d c02584d6 c035b4a0 
       000000fa 00000000 00000000 ffffff3d 00000000 00000246 c0258203 00000000 
Call Trace: 
 [<c025593c>] psmouse_interrupt+0x88/0x298 
 [<c0257db6>] serio_interrupt+0x66/0x6c 
 [<c02584d6>] i8042_interrupt+0xba/0x148 
 [<c0258203>] i8042_command+0xbf/0xc8 
 [<c02582a2>] i8042_aux_write+0x3a/0x4c 
 [<c0255bce>] psmouse_sendbyte+0x82/0x88 
 [<c0255d3f>] psmouse_command+0x16b/0x188 
 [<c0256991>] ps2pp_init+0x25/0x238 
 [<c0256012>] psmouse_extensions+0xde/0x188 
 [<c02563f1>] psmouse_connect+0xe9/0x224 
 [<c0257a4c>] serio_find_dev+0x4c/0x50 
 [<c0257dda>] serio_register_port+0x1e/0x30 
 [<c03bfa49>] i8042_port_register+0x45/0x64 
 [<c03bfc5b>] i8042_init+0x15f/0x168 
 [<c03a484b>] do_initcalls+0x27/0xa4 
 [<c01004dc>] init+0xe8/0x234 
 [<c01003f4>] init+0x0/0x234 
 [<c0104221>] kernel_thread_helper+0x5/0xc 
 
Code: Bad EIP value. 
 <0>Kernel panic: Attempted to kill init! 
 
 
 
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

