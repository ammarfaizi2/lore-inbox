Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbTJFRVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTJFRVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:21:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36804 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262418AbTJFRVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:21:14 -0400
Date: Mon, 06 Oct 2003 10:21:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1329] New: atp870u driver oops
Message-ID: <240700000.1065460892@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1329

           Summary: atp870u driver oops
    Kernel Version: 2.6.0-test6-mm4 (>=2.5.74 in general)
            Status: NEW
          Severity: blocking
             Owner: andmike@us.ibm.com
         Submitter: afw2000@hotmail.com


Distribution: Gentoo Linux
Hardware Environment: P4 2.2ghz, 384MB RDRAM
Software Environment: gcc-3.3.1.20030916, glibc-2.3.2.20030919 + nptl 0.60
Problem Description: modprobing the driver just oops (and some times locks up
the computer)

Steps to reproduce:
1. make menuconfug
2. compile atp870u as a module
3. modprobe/insmod it

results : 
aec671x_detect:
   ACARD AEC-671X PCI Ultra/W SCSI-3 Host Adapter: 0    IO:df00, IRQ:23.
         ID:  6  MATSHITACD-R   CW-7503  1.09
         ID:  7  Host Adapter
Unable to handle kernel NULL pointer dereference at virtual address 000004ac
 printing eip:
d9b7e022
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<d9b7e022>]    Not tainted VLI
EFLAGS: 00010202
EIP is at atp870u_detect+0x13f/0x91e [atp870u]
eax: 00000001   ebx: ffffffff   ecx: 00000001   edx: 00000398
esi: 0000df3b   edi: 00000033   ebp: d6444000   esp: d5975bfc
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4968, threadinfo=d5974000 task=d65c86a0)
Stack: c032b220 0000df00 00000040 d9b7ed7a d6444000 c013c1ea 00000001 00000000
       d64441bc 0000df3a c032c954 d5974000 00000001 0000df00 00000282 07170154
       0000df00 00000000 0000df20 00000000 002000a0 c032c907 00000010 c032cb9c
Call Trace:
 [<c013c1ea>] buffered_rmqueue+0xd6/0x182
 [<c0145aa9>] do_anonymous_page+0x133/0x224
 [<c0146100>] handle_mm_fault+0xd6/0x166
 [<c011c1f7>] do_page_fault+0x31a/0x4ff
 [<c017a8ec>] load_elf_binary+0x5c9/0xb51
 [<c01381e6>] find_get_page+0x2d/0x56
 [<c01393e4>] filemap_nopage+0x273/0x301
 [<c0145d7f>] do_no_page+0x1e5/0x376
 [<c0146100>] handle_mm_fault+0xd6/0x166
 [<c011c1f7>] do_page_fault+0x31a/0x4ff
 [<c013bdba>] __rmqueue+0xcc/0x131
 [<c013c1ea>] buffered_rmqueue+0xd6/0x182
 [<c014d7dc>] map_area_pmd+0x66/0x8e
 [<c014d6ca>] unmap_area_pmd+0x4b/0x56
 [<d9b7b000>] atp870u_intr_handle+0x0/0x78e [atp870u]
 [<c014dbbc>] vfree+0x27/0x35
 [<c0135e4d>] load_module+0x6d4/0x908
 [<d9b7eb7a>] atp870u_release+0x0/0xa6 [atp870u]
 [<d9b8203e>] init_this_scsi_driver+0x3e/0xf4 [atp870u]
 [<c0136198>] sys_init_module+0x117/0x228
 [<c02d259b>] syscall_call+0x7/0xb

Code: ff c6 44 24 3d 00 c7 44 24 18 00 00 00 00 21 e2 89 54 24 2c 8b 44 24 18 8b
4c 24 30 8b 94 84 40 03 00 00 85 d2 0f 84 60 03 00 00 <8b> 82 14 01 00 00 89 44
24 34 0f b6 82 0c 01 00 00 88 44 24 3e

