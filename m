Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267473AbUBRUQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUBRUQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:16:31 -0500
Received: from palrel12.hp.com ([156.153.255.237]:49557 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S267473AbUBRUQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:16:28 -0500
Date: Wed, 18 Feb 2004 12:15:59 -0800
To: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.6.3 + hp100 -> Oops
Message-ID: <20040218201559.GA31872@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Maybe it would be a good idea to fix or revert the hp100 patch
that went into 2.6.3 :

----------------------------------------------------------
# modprobe hp100
FATAL: Error inserting hp100 (/lib/modules/2.6.3/kernel/drivers/net/hp100.ko): No such device
# dmesg
[...]
hp100: Busmaster mode enabled.
hp100: at 0xf400, IRQ 16, PCI bus, 32k SRAM (rx/tx 75%).
hp100: Adapter is attached to 100Mb/s Voice Grade AnyLAN network.
# cat /proc/net/dev
Segmentation fault
# dmesg
[...]
hp100: Busmaster mode enabled.
hp100: at 0xf400, IRQ 16, PCI bus, 32k SRAM (rx/tx 75%).
hp100: Adapter is attached to 100Mb/s Voice Grade AnyLAN network.
Unable to handle kernel paging request at virtual address d086648c
 printing eip:
d086648c
*pde = 0fda1067
*pte = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<d086648c>]    Not tainted
EFLAGS: 00010282
EIP is at 0xd086648c
eax: d086648c   ebx: ccf6b000   ecx: fffffffd   edx: cfb99000
esi: c139cca0   edi: ccf6b000   ebp: 000001be   esp: c90b5f20
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 511, threadinfo=c90b4000 task=c9080670)
Stack: c01ee394 ccf6b000 c139cca0 00000000 c01ee46d c139cca0 ccf6b000 c139cca0 
       00000000 ccf6b000 c0167d60 c139cca0 ccf6b000 00000000 c55888e0 c5588900 
       00000400 c139ccb8 00000000 00000003 00000000 00000002 00000000 c014cf1c 
Call Trace:
 [<c01ee394>] dev_seq_printf_stats+0x14/0x94
 [<c01ee46d>] dev_seq_show+0x59/0x64
 [<c0167d60>] seq_read+0x1bc/0x2fc
 [<c014cf1c>] vfs_read+0x9c/0xcc
 [<c014d0fd>] sys_read+0x31/0x4c
 [<c0108c33>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 
---------------------------------------------------------------

	After that, the whole system is mostly unusable and doesn't
reboot cleanly.
	This is with a PCI card. Looking at the changes, they would
also require testing with a ISA card (which I don't have in my box at
the moment).

	2.6.2 works perfectly. This is what 2.6.2 looks like :
---------------------------------------------
hp100: eth1: Busmaster mode enabled.
hp100: eth1: HP J2585B at 0xf400, IRQ 16, PCI bus, 32k SRAM (rx/tx 75%).
hp100: eth1: Adapter is attached to 100Mb/s Voice Grade AnyLAN network.
---------------------------------------------
	Also :
-----------------------------------
00:12.0 Ethernet controller: Hewlett-Packard Company J2585B
        Subsystem: Hewlett-Packard Company J2585B DeskDirect 10/100VG NIC
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at f400 [size=256]
        Memory at fedfc000 (32-bit, non-prefetchable) [disabled] [size=8K]
-----------------------------------

	Have fun...

	Jean

