Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVBPBIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVBPBIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVBPBIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:08:34 -0500
Received: from dsl-210-15-250-66.NSW.netspace.net.au ([210.15.250.66]:27637
	"EHLO ptraci.internal.sensorynetworks.com") by vger.kernel.org
	with ESMTP id S261962AbVBPBIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:08:17 -0500
Date: Wed, 16 Feb 2005 12:07:52 +1100
From: Erik de Castro Lopo <erik.de.castro.lopo@sensorynetworks.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 : kernel BUG at mm/rmap.c:483!
Message-Id: <20050216120752.4da9c36b.erik.de.castro.lopo@sensorynetworks.com>
Organization: Sensory Networks
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm running a kernel compiled from pristine 2.6.10 sources
downloaded from kernel.org on a P4 with HT. I was originally
working on an SMP/CONFIG_PREEMPT kernel when I first hit this
problem. I downgraded to an SMP kernel without CONFIG_PREEMPT 
the problem remained. Same problem on a kernel compiled for a 
single CPU. The dmesg output below is for the single CPU, no 
CONFIG_PREEMPT case.

The problem is triggered by a user space application which 
mmaps memory space on a custom PCI card via /dev/mem, reads 
some data and munmaps it. The program works perfectly on a 
2.4.26 kernel. On 2.6.10 I get this on the console:

------------[ cut here ]------------
kernel BUG at mm/rmap.c:483!
invalid operand: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c013b5b6>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10) 
EIP is at page_remove_rmap+0x26/0x40
eax: ffffffff   ebx: 00003000   ecx: b5e86000   edx: c1000060
esi: dabd9a24   edi: c1000060   ebp: 0017a000   esp: da40febc
ds: 007b   es: 007b   ss: 0068
Process counters-erikd (pid: 1622, threadinfo=da40e000 task=da9d6a60)
Stack: c0135a38 dfd0f878 00000002 f277a8c0 00000000 00003027 b5e86000 c049e480 
       b6286000 da43eb60 b6000000 c049e480 c0135b9b 0017a000 00000000 de16f030 
       dfc82000 b5e86000 da43eb60 b6286000 c049e480 c0135bfd 00400000 00000000 
Call Trace:
 [<c0135a38>] zap_pte_range+0x138/0x250
 [<c0135b9b>] zap_pmd_range+0x4b/0x70
 [<c0135bfd>] unmap_page_range+0x3d/0x70
 [<c0135d2e>] unmap_vmas+0xfe/0x1b0
 [<c013955a>] unmap_region+0x6a/0xd0
 [<c01397f4>] do_munmap+0xf4/0x130
 [<c0139870>] sys_munmap+0x40/0x70
 [<c01022f3>] syscall_call+0x7/0xb
Code: 90 8d 74 26 00 89 c2 8b 00 f6 c4 08 75 27 83 42 08 ff 0f 98 c0 84 c0 74 11 8b 42 08 40 78 0c 9c 58 fa ff 0d 50 65 4a c0 50 9d c3 <0f> 0b e3 01 41 2c 38 c0 eb ea 0f 0b e0 01 41 2c 38 c0 eb cf 8d 
 
Is there anything I have missed? Does /dev/mem on a 2.6
kerel behave the same way as on a 2.4 kernel?

I can supply more info if needed.

Regards,
Erik
-- 
-------------------------------------------------------
[N] Erik de Castro Lopo, Senior Computer Engineer
[E] erik.de.castro.lopo@sensorynetworks.com
[W] http://www.sensorynetworks.com
[T] +61 2 83022726
[F] +61 2 94750316
[A] L6/140 William St, East Sydney NSW 2011, Australia
-------------------------------------------------------
A good debugger is no substitute for a good test suite.
