Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTDHCXA (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 22:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTDHCXA (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 22:23:00 -0400
Received: from franka.aracnet.com ([216.99.193.44]:22425 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263761AbTDHCW6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 22:22:58 -0400
Date: Mon, 07 Apr 2003 19:33:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 550] New: reading /proc/bus/pnp/escd results in oops
Message-ID: <7590000.1049769199@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=550

           Summary: reading /proc/bus/pnp/escd results in oops
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: ambx1@neo.rr.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: Compaq Armada 1650DMT Laptop
Software Environment:
Problem Description: 
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x2621, dseg 0xf0000
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found

(cat /proc/bus/pnp/escd here)
Unable to handle kernel paging request at virtual address 000ea002
 printing eip:
0000100c
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0098:[<0000100c>]    Not tainted
EFLAGS: 00010012
EIP is at 0x100c
eax: 80000100   ebx: 00000411   ecx: 00008000   edx: 00000000
esi: 000e0000   edi: 00000000   ebp: c3b97ea8   esp: c3b97e7c
ds: 00a0   es: 00a8   ss: 0068
Process cat (pid: 301, threadinfo=c3b96000 task=c4d4e660)
Stack: 04118000 00120100 267a0fcb 00000006 007b007b 00000202 000e0000 00000000
       000000a0 00000042 00b000a8 c3b97efc 0090000b 00000042 00b000a8 000000a0
       00000000 c020502f 00000060 00000046 00000000 00000000 0000007b 0000007b
Call Trace:
 [<c020502f>] __pnp_bios_read_escd+0x1a7/0x2a0
 [<c0205139>] pnp_bios_read_escd+0x11/0x34
 [<c02059b2>] proc_read_escd+0x66/0xfc
 [<c018c477>] proc_file_read+0xb7/0x1fc
 [<c0155cae>] vfs_read+0xa2/0xd4
 [<c0155e8a>] sys_read+0x2a/0x40
 [<c0109c37>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <6>note: cat[301] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c0115634>] schedule+0x40/0x5d4
 [<c0143221>] unmap_vmas+0xfd/0x2e0
 [<c01175d3>] __cond_resched+0x17/0x1c
 [<c01432f8>] unmap_vmas+0x1d4/0x2e0
 [<c0148281>] exit_mmap+0xdd/0x24c
 [<c01185d2>] mmput+0xc6/0xe4
 [<c011d506>] do_exit+0x28a/0x900
 [<c010a547>] die+0x18f/0x190
 [<c0113dab>] do_page_fault+0x30b/0x449
 [<c0113aa0>] do_page_fault+0x0/0x449
 [<c011f3a2>] do_softirq+0x52/0xb0
 [<c010b924>] do_IRQ+0x2e4/0x300
 [<c0109e58>] common_interrupt+0x18/0x20
 [<c013b559>] poison_obj+0x35/0x44
 [<c013c180>] cache_init_objs+0x44/0x104
 [<c0109e9d>] error_code+0x2d/0x40
 [<c020502f>] __pnp_bios_read_escd+0x1a7/0x2a0
 [<c0205139>] pnp_bios_read_escd+0x11/0x34
 [<c02059b2>] proc_read_escd+0x66/0xfc
 [<c018c477>] proc_file_read+0xb7/0x1fc
 [<c0155cae>] vfs_read+0xa2/0xd4
 [<c0155e8a>] sys_read+0x2a/0x40
 [<c0109c37>] syscall_call+0x7/0xb

drivers/pnp/pnpbios/core.c:191: spin_lock(drivers/pnp/pnpbios/core.c:c03e7260) a
lready locked by drivers/pnp/pnpbios/core.c/191

