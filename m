Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263394AbSJFL6U>; Sun, 6 Oct 2002 07:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbSJFL6U>; Sun, 6 Oct 2002 07:58:20 -0400
Received: from maila.telia.com ([194.22.194.231]:24553 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S263394AbSJFL6T>;
	Sun, 6 Oct 2002 07:58:19 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net
Subject: 2.5.40 panic in uhci-hcd
From: Peter Osterlund <petero2@telia.com>
Date: 06 Oct 2002 14:03:49 +0200
Message-ID: <m24rbz4vve.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes when booting 2.5.40 and my Freecom USB-IDE controller (CDRW)
is connected, the kernel panics when trying to initialize the usb
subsystem. It happens right after the RH73 boot scripts print out:

        Initializing USB controller (uhci-hcd):  [  OK  ]

In 2.5.39, this happened every time I tried to boot, but in 2.5.40 it
seems to happen about 20% of the time.


Unable to handle kernel NULL pointer dereference at virtual address 00000014
*pde = 00000000
Oops: 0000
usb-storage uhci-hcd usbcore  
CPU:    0
EIP:    0060:[<c482e4a7>]    Not tainted
EFLAGS: 00010006
EIP is at uhci_result_control+0x17/0x210 [uhci-hcd]
eax: 00000000   ebx: c3b47300   ecx: 00010003   edx: ffffffea
esi: 00000014   edi: 00010003   ebp: c3b47300   esp: c3bbde00
ds: 0068   es: 0068   ss: 0068
Process usb.agent (pid: 198, threadinfo=c3bbc000 task=c3c2e0c0)
Stack: c3c90120 c3c90134 00000000 c3b47300 00000000 00010003 c1151600 c482f327 
       c1151600 c3b47300 00000202 c1151740 c1151740 c1151600 c1151600 c482fd23 
       c1151600 c3b47300 c1151600 00000003 0000000a c3bbdeb0 c4818de7 c1151600 
Call Trace:
 [<c482f327>] uhci_transfer_result+0x67/0x1a0 [uhci-hcd]
 [<c482fd23>] uhci_irq+0xf3/0x130 [uhci-hcd]
 [<c4818de7>] usb_hcd_irq+0x17/0x30 [usbcore]
 [<c01087bd>] E dump_stack+0x100d/0x1d090
 [<c010899d>] E enable_irq+0x15d/0xffffffa0
 [<c0107478>] E __up_wakeup+0x118c/0x8de6c
 [<c0125920>] E pm_find+0xdf0/0x20e890
 [<c0111311>] E default_wake_function+0x21/0x90
 [<c0125a16>] E pm_find+0xee6/0x20e890
 [<c0125a70>] E pm_find+0xf40/0x20e890
 [<c0128cb3>] E do_brk+0x323/0xfffef120
 [<c0112aa2>] E autoremove_wake_function+0x232/0xffffebc0
 [<c0118067>] E exit_mm+0x5b7/0x190f0
 [<c011979b>] E __tasklet_hi_schedule+0xfb/0x199320
 [<c0119581>] E do_softirq+0x51/0xb0
 [<c0107287>] E __up_wakeup+0xf9b/0x8de6c

Code: 8b 40 14 39 f0 75 0a b8 ea ff ff ff e9 d4 01 00 00 8b 54 24 
 <0>Kernel panic: Aiee, killing interrupt handler!

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
