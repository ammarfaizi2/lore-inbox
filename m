Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVKGV2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVKGV2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVKGV2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:28:32 -0500
Received: from pop.gmx.net ([213.165.64.20]:48574 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965107AbVKGV2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:28:31 -0500
X-Authenticated: #20450766
Date: Mon, 7 Nov 2005 22:28:36 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic zd1211-driver-r38 2.6.14-rc5, SMP (fwd)
Message-ID: <Pine.LNX.4.60.0511072224110.4791@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Got a kernel panic in subject. The message below was sent to the zd1211 
ml, but I just wanted to ask here too - how a network usb driver could 
cause such a race? Looks like a missing spin_lock*(&base->t_base.lock); 
somewhere, but I couldn't easily find a place in the driver, where this 
could happen. Maybe some lockless ("__<function>") version called instead 
of the locking one?...

Thanks
Guennadi
---
Guennadi Liakhovetski

---------- Forwarded message ----------
Date: Mon, 7 Nov 2005 21:43:46 +0100 (CET)
From: Guennadi Liakhovetski <lyakh@poirot.grange>
To: Zd1211-devs@lists.sourceforge.net
Subject: Kernel panic zd1211-driver-r38 2.6.14-rc5, SMP

Hi all

Got the Kernel Panic (Oops below) while testing with a WL-410U (1211 
chipset) on a SMP. I just have done "ifconfig wlan0 up", was able to press 
a couple of keys, and then kernel paniced.

The actual Oops is in

__list_del
detach_timer
__run_timers
run_timer_softirq

where timer->entry->next == NULL, if I decoded it right. Any ideas?

Thanks
Guennadi
---
Guennadi Liakhovetski

usb 1-5.1: reset high speed USB device using ehci_hcd and address 3

 _____     ____    _    ____
|__  /   _|  _ \  / \  / ___|
  / / | | | | | |/ _ \ \___ \
 / /| |_| | |_| / ___ \ ___) |
/____\__, |____/_/   \_\____/
     |___/
zd1211 - version 2.0.0.0
Release Ver = 4330
EEPORM Ver = 4330
PA type: 0
AllowedChannel = 000107ff
Region:48
usbcore: registered new driver zd1211
******* Schedule task fail *********
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0129af1
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
Modules linked in: zd1211 ehci_hcd usbcore eepro100 mii
CPU:    1
EIP:    0060:[<c0129af1>]    Not tainted VLI
EFLAGS: 00010086   (2.6.14-rc5) 
EIP is at run_timer_softirq+0xd1/0x1f0
eax: 00000000   ebx: c5bc3800   ecx: c5970e48   edx: c11cfee8
esi: c110d020   edi: c110cf60   ebp: c11cff00   esp: c11cfecc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c11ce000 task=c11a9550)
Stack: 00000000 00011537 c11a9550 1075d800 c11cfee8 c11ce000 c90e6900 c5970e48 
       c11f9dd0 00000082 00000001 c03dd308 c04320c0 c11cff20 c0125745 c03dd308 
       00000001 0000000a 00000046 00000001 c11cff5c c11cff2c c0125798 c042f98c 
Call Trace:
 [<c0103f3f>] show_stack+0x7f/0xa0
 [<c01040f2>] show_registers+0x162/0x1d0
 [<c0104310>] die+0x100/0x180
 [<c032b77e>] do_page_fault+0x2de/0x60f
 [<c0103beb>] error_code+0x4f/0x54
 [<c0125745>] __do_softirq+0xd5/0xf0
 [<c0125798>] do_softirq+0x38/0x40
 [<c0125885>] irq_exit+0x45/0x50
 [<c01151ec>] smp_apic_timer_interrupt+0x6c/0x100
 [<c0103b44>] apic_timer_interrupt+0x1c/0x24
 [<c0100eab>] cpu_idle+0x7b/0x80
 [<c011413c>] start_secondary+0x12c/0x1c0
 [<00000000>] _stext+0x3feffd68/0x8
 [<c11cffb4>] 0xc11cffb4
Code: 00 00 00 b8 00 e0 ff ff 21 e0 89 45 e0 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 51 10 89 55 e4 8b 59 14 89 4f 08 8b 51 04 8b 01 <89> 50 04 89 02 89 f8 c7 01 00 00 00 00 c7 41 04 00 02 20 00 e8 
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 
