Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUIXQgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUIXQgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUIXQga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:36:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50365 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268886AbUIXQQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:16:40 -0400
Date: Fri, 24 Sep 2004 12:16:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.9-rc2-mm3
In-Reply-To: <Xine.LNX.4.44.0409241127220.7816-300000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, James Morris wrote:

> I'm getting what looks like a deadlock during boot with this kernel, 
> .config, bootlog and sysrq output attached.  Looks like it may be related 
> to the serial/tty code?

Backing these out lets me boot again:

+tty-driver-take-4-try-2.patch
+tty-locking-build-fix.patch

Also, here's what the NMI oopser says:

NMI Watchdog detected LOCKUP on CPU1, eip c03516ab, registers:
Modules linked in:
CPU:    1
EIP:    0060:[<c03516ab>]    Not tainted VLI
EFLAGS: 00000006   (2.6.9-rc2-mm3) 
EIP is at _spin_lock_irqsave+0x1e/0x53
eax: 00000000   ebx: 00000000   ecx: c1950ee0   edx: 00000006
esi: c03eaec8   edi: c1950000   ebp: c1950e30   esp: c1950e24
ds: 007b   es: 007b   ss: 0068
Process init (pid: 1, threadinfo=c1950000 task=c194f9d0)
Stack: f7bb537c f7bb537c 00000000 c1950e40 c026b3a4 f7bb537c c1950ee0 
c1950e58 
       c027f485 00009600 c049fd40 f7bb537c 00000013 c1950e94 c0283af1 00000000 
       0001c200 00000000 00000202 c1950ec0 c014af00 00000000 0001c200 00000000 
Call Trace:
 [<c0106ba1>] show_stack+0x7a/0x90
 [<c0106d22>] show_registers+0x152/0x1ca
 [<c010797c>] die_nmi+0x50/0x83
 [<c0112cdf>] nmi_watchdog_tick+0x9a/0xb6
 [<c0107a0a>] default_do_nmi+0x5b/0xe7
 [<c0107add>] do_nmi+0x40/0x4a
 [<c01068d5>] nmi_stack_correct+0x1e/0x2e
 [<c026b3a4>] tty_termios_baud_rate+0x11/0x67
 [<c027f485>] uart_get_baud_rate+0x53/0xd4
 [<c0283af1>] serial8250_set_termios+0x8d/0x348
 [<c027f580>] uart_change_speed+0x4a/0x64
 [<c0280664>] uart_set_termios+0x4f/0x162
 [<c026e94f>] change_termios+0x1b3/0x21a
 [<c026ea40>] set_termios+0x8a/0xf9
 [<c026ad15>] tty_ioctl+0x152/0x44f
 [<c0169687>] sys_ioctl+0x231/0x282
 [<c0105d09>] sysenter_past_esp+0x52/0x71
Code: 83 47 14 01 eb d2 e8 53 f3 ff ff eb e3 55 89 e5 57 56 89 c6 b8 00 f0 
ff ff 53 21 e0 83 40 14 01 31 db 89 c7 9c 5a 
fa 89 d8 86 06 <84> c0 7e 07 5b 89 d0 5e 5f 5d c3 52 9d 8b 47 08 83 6f 14 
01 a8 
console shuts up ...


Looks like tty_termios_lock.


-- 
James Morris
<jmorris@redhat.com>



