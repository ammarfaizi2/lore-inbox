Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265933AbUAULlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 06:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbUAULlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 06:41:31 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:21441 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S265933AbUAULl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 06:41:26 -0500
Date: Wed, 21 Jan 2004 11:41:22 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: [2.6.2-rc1] Oops while rmmod'ing parport_pc (PnP related?)
Message-ID: <Pine.LNX.4.58.0401211140310.13077@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I got this Oops while rmmod'ing parport_pc. Acording to
/sys/bus/pnp/devices/00:01/resources, PnP device 00:01 is my parallel port.
I'm using "options parport_pc dma=3 io=0x378 irq=7" in /etc/modprobe.conf.
After this I was unable do read /proc/modules or run any process that uses
it, as it has stale in D state... I could only reboot with SysRq+B.
	If you need more info, just ask.

	Regards,
		Rui Saraiva

---[ dmesg output ]-------------------------------------------------------

PnPBIOS: set_dev_node: invalid parameters were passed
pnp: Failed to disable device 00:01.
Unable to handle kernel paging request at virtual address d1bc1e44
 printing eip:
c0228ebf
*pde = 0f75a067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0228ebf>]    Not tainted
EFLAGS: 00010246
EIP is at unlink+0x5f/0x90
eax: d1a8b060   ebx: c03e7d84   ecx: c03e8140   edx: d1bc1e40
esi: c03e7dcc   edi: d1a8b044   ebp: c59c9f04   esp: c59c9ef0
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 16117, threadinfo=c59c8000 task=cebee960)
Stack: c035504b 00000042 d1a8b044 c03e7d80 d1a8b014 c59c9f14 c02291b4 d1a8b044
       c03e7d80 c59c9f30 c027ae86 d1a8b044 00000042 d1a8b01c d1a8b014 00000000
       c59c9f48 c027b2ca d1a8b014 c4249df8 00000000 00000000 c59c9f5c d1a8674b
Call Trace:
 [<c02291b4>] kobject_unregister+0x14/0x20
 [<c027ae86>] bus_remove_driver+0x76/0x90
 [<c027b2ca>] driver_unregister+0x1a/0x42
 [<d1a8674b>] cleanup_module+0x3b/0x5c [parport_pc]
 [<c014510f>] sys_delete_module+0x13f/0x160
 [<c0166307>] sys_munmap+0x57/0x80
 [<c010a14f>] syscall_call+0x7/0xb

Code: 89 4a 04 89 11 89 40 04 89 47 1c 8b 47 28 8b 18 8d 4b 48 89
