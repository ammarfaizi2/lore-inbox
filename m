Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbUK3PDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbUK3PDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbUK3PDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:03:34 -0500
Received: from egg.hpc2n.umu.se ([130.239.45.244]:3996 "EHLO egg.hpc2n.umu.se")
	by vger.kernel.org with ESMTP id S262094AbUK3PD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:03:27 -0500
Date: Tue, 30 Nov 2004 16:03:24 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2 - kernel BUG at mm/page_alloc.c:575
Message-ID: <20041130150324.GN4329@hpc2n.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Ake.Sandgren@hpc2n.umu.se (Ake)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing dd to xfs filesystem produced the following.
Rebuilding with debug pagealloc and a few more in case it will help
tracking it down.

The kernel also has the udm2 patches applied and the xfs filesystem is
on a dm_multipath:ed disk.

It so far looks repeatable.

Please CC me.

------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:575!
invalid operand: 0000 [#1]
SMP 
Modules linked in: xfs dm_round_robin md5 ipv6 uhci_hcd ohci_hcd ehci_hcd usbcore qla2300 qla2xxx scsi_transport_fc e1000 i2c_i801 i2c_core hw_random floppy rtc dm_multipath dm_mod autofs4 sg ext3 jbd sd_mod aic79xx scsi_mod
CPU:    15
EIP:    0060:[<c0138d63>]    Not tainted VLI
EFLAGS: 00010002   (2.6.10-rc2-udm2-hpc2n-p4-smp) 
EIP is at buffered_rmqueue+0x175/0x1f4
eax: 00000001   ebx: c029f480   ecx: 00001000   edx: 00049878
esi: c1930f00   edi: 00000000   ebp: f2568f04   esp: f2568ee0
ds: 007b   es: 007b   ss: 0068
Process  (pid: 0, threadinfo=f2568000 task=ec889000)
Stack: c029ed00 c1930f00 00000000 00000000 c029f500 c1930f00 c029ed00 baadf00d 
       00000000 f2568f54 c01390f4 c029ed00 00000000 00000200 f256a000 f256a012 
       f256a012 00000001 00000001 00000001 ec889000 00000000 c029f600 00000000 
Call Trace:
 [<c0103437>] show_stack+0x80/0x96
 [<c01035ce>] show_registers+0x15f/0x1c3
 [<c01037c5>] die+0xfa/0x180
 [<c0103ccf>] do_invalid_op+0x102/0x104
 [<c01030cb>] error_code+0x2b/0x30
 [<c01390f4>] __alloc_pages+0x312/0x333
 [<c013913c>] __get_free_pages+0x27/0x40
 [<c013c2f5>] kmem_getpages+0x20/0xce
 [<c013cf9a>] cache_grow+0xab/0x14a
 [<c013d1a7>] cache_alloc_refill+0x16e/0x20f
 [<c013d411>] kmem_cache_alloc+0x4a/0x4c
 =======================
Unable to handle kernel paging request at virtual address 00060030
 printing eip:
c0103388
*pde = 00000000
Oops: 0000 [#2]
SMP 
Modules linked in: xfs dm_round_robin md5 ipv6 uhci_hcd ohci_hcd ehci_hcd usbcore qla2300 qla2xxx scsi_transport_fc e1000 i2c_i801 i2c_core hw_random floppy rtc dm_multipath dm_mod autofs4 sg ext3 jbd sd_mod aic79xx scsi_mod
CPU:    15
EIP:    0060:[<c0103388>]    Not tainted VLI
EFLAGS: 00010096   (2.6.10-rc2-udm2-hpc2n-p4-smp) 
EIP is at show_trace+0x7b/0xaa
eax: 00060ffd   ebx: f2569000   ecx: 00000000   edx: 00000086
esi: f2569000   edi: 00060000   ebp: f2568d50   esp: f2568d38
ds: 007b   es: 007b   ss: 0068
Process  (pid: 0, threadinfo=f2568000 task=ec889000)
Stack: c0270c6f c013d411 00060ffd f2568f40 00000018 00000000 f2568d6c c0103437 
       00000000 f2568ee0 f2568000 f2568eac 00000000 f2568da4 c01035ce 00000000 
       f2568ee0 00000000 f2568000 ec889000 00010002 c029a242 00680d68 00000001 
Call Trace:
 [<c0103437>] show_stack+0x80/0x96
 [<c01035ce>] show_registers+0x15f/0x1c3
 [<c01037c5>] die+0xfa/0x180
 [<c01115ba>] do_page_fault+0x316/0x63f
 [<c01030cb>] error_code+0x2b/0x30
 [<c0103437>] show_stack+0x80/0x96
 [<c01035ce>] show_registers+0x15f/0x1c3
 [<c01037c5>] die+0xfa/0x180
 [<c0103ccf>] do_invalid_op+0x102/0x104
 [<c01030cb>] error_code+0x2b/0x30
 [<c01390f4>] __alloc_pages+0x312/0x333
 [<c013913c>] __get_free_pages+0x27/0x40
 [<c013c2f5>] kmem_getpages+0x20/0xce
 [<c013cf9a>] cache_grow+0xab/0x14a
 [<c013d1a7>] cache_alloc_refill+0x16e/0x20f
 [<c013d411>] kmem_cache_alloc+0x4a/0x4c
 =======================
Unable to handle kernel paging request at virtual address 00060030
 printing eip:
c0103388
*pde = 00000000
Recursive die() failure, output suppressed
 <1>Unable to handle kernel paging request at virtual address 21a9214f
 printing eip:
c0113226
*pde = 00000000
Recursive die() failure, output suppressed


-- 
Ake Sandgren, HPC2N, Umea University, S-90187 Umea, Sweden
Internet: ake@hpc2n.umu.se	Phone: +46 90 7866134 Fax: +46 90 7866126
Mobile: +46 70 7716134 WWW: http://www.hpc2n.umu.se
