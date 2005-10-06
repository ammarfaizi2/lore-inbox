Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVJFP0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVJFP0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVJFP0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:26:14 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:18133 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751090AbVJFP0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:26:14 -0400
Date: Thu, 6 Oct 2005 11:26:04 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051006084920.GB22397@elte.hu>
Message-ID: <Pine.LNX.4.58.0510061122530.418@localhost.localdomain>
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
 <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
 <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu>
 <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain> <20051006084920.GB22397@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo, the following bug popped up.

BUG: scheduling while atomic: modprobe/0x00000001/3083
caller is schedule+0x84/0x111
 [<c0103fe2>] dump_stack+0x1e/0x20 (20)
 [<c0323402>] __schedule+0x742/0xa94 (84)
 [<c03237d8>] schedule+0x84/0x111 (28)
 [<c0324a7b>] __down_mutex+0x56b/0x83a (116)
 [<c0326bcf>] _spin_lock+0x1f/0x44 (28)
 [<c0155070>] __kmalloc+0x6c/0x11d (36)
 [<c021e989>] soft_cursor+0x61/0x1a8 (76)
 [<c02175c4>] bit_cursor+0x2d3/0x588 (164)
 [<c0212b4e>] fbcon_cursor+0x1be/0x307 (76)
 [<c0213529>] fbcon_scroll+0x84/0xf5d (80)
 [<c026bafd>] scrup+0xce/0xd8 (40)
 [<c026d1a5>] lf+0x50/0x5d (28)
 [<c026f3ad>] vt_console_print+0x116/0x2bb (56)
 [<c011e9c4>] __call_console_drivers+0x47/0x56 (32)
 [<c011ea4a>] _call_console_drivers+0x77/0x7e (24)
 [<c011eaf6>] call_console_drivers+0xa5/0x183 (44)
 [<c011f0af>] release_console_sem+0x2e/0xeb (32)
 [<c011ef85>] vprintk+0x2aa/0x312 (108)
 [<c011ecd9>] printk+0x1b/0x1d (20)
 [<f8c2f04a>] usb_register_bus+0xf1/0x137 [usbcore] (36)
 [<f8c2feb2>] usb_add_hcd+0x7c/0x3b3 [usbcore] (64)
 [<f8c3730b>] usb_hcd_pci_probe+0x1cb/0x2f9 [usbcore] (52)
 [<c020b929>] pci_call_probe+0x19/0x1b (16)
 [<c020b977>] __pci_device_probe+0x4c/0x57 (28)
 [<c020b9ad>] pci_device_probe+0x2b/0x42 (24)
 [<c027dfc7>] driver_probe_device+0x3e/0xab (36)
 [<c027e102>] __driver_attach+0x41/0x51 (24)
 [<c027d61b>] bus_for_each_dev+0x57/0x77 (44)
 [<c027e13a>] driver_attach+0x28/0x2a (24)
 [<c027dad2>] bus_add_driver+0x7a/0xdb (36)
 [<c027e4d5>] driver_register+0x64/0x6b (32)
 [<c020bbec>] pci_register_driver+0x8b/0xa9 (28)
 [<f881d024>] init+0x24/0x2a [ehci_hcd] (12)
 [<c0146780>] sys_init_module+0xb9/0x22e (28)
 [<c01030ed>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0140530>] .... add_preempt_count+0x1c/0x1e
.....[<c011ecf0>] ..   ( <= vprintk+0x15/0x312)

------------------------------
| showing all locks held by: |  (modprobe/3083 [f747f7d0, 118]):
------------------------------

#001:             [cf480218] {(struct semaphore *)(&dev->sem)}
... acquired at:               __driver_attach+0x18/0x51


I didn't know that down_mutex could cause the scheduling while atomic.  It
seems that the driver inside the vt_console failed to grab a lock, and
this will output, since printk does a raw_spin_lock_irqsave that seems to
also do a preempt_disable. (the kmallocs are GFP_ATOMIC).

-- Steve


