Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTDRUrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 16:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTDRUrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 16:47:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31434 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263234AbTDRUrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 16:47:20 -0400
Date: Fri, 18 Apr 2003 13:48:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Bill Irwin <wli@holomorphy.com>
Subject: [Bug 601] New: BUG when running ipcs after huge page shm
Message-ID: <1382570000.1050698909@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=601

           Summary: BUG when running ipcs after huge page shm
    Kernel Version: 2.5.67-bk current
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: plars@austin.ibm.com


Distribution:
Hardware Environment: 2-way PIII-550, 2GB ram
Software Environment:
CONFIG_HUGETLB_PAGE=y

Problem Description:

kernel BUG at include/asm/spinlock.h:123!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c02055ad>]    Not tainted
EFLAGS: 00010286
EIP is at shm_get_stat+0x5d/0xbc
eax: 0000000e   ebx: f772e14c   ecx: c04a1be0   edx: c0411d88
esi: f772e1b0   edi: 00000000   ebp: f747df38   esp: f747dde4
ds: 007b   es: 007b   ss: 0068
Process ipcs (pid: 778, threadinfo=f747c000 task=f762e100)
Stack: c03a9ab7 c0205595 f747df2c bffff620 f747df44 c050bfb0 c0205801 f747df34
       f747df38 bffff5bc 0000000e 00000000 00000000 00000000 00000000 00000000
       00000001 00000001 00000019 00000000 00000000 c0512bc0 f7c181cc f7c181bc
Call Trace:
 [<c0205595>] shm_get_stat+0x45/0xbc
 [<c0205801>] sys_shmctl+0x1f5/0x820
 [<c013a1e0>] check_poison_obj+0x38/0x188
 [<c013baa6>] kmem_cache_alloc+0x126/0x134
 [<c01483b2>] page_add_rmap+0x12/0x158
 [<c0143e26>] do_no_page+0x47a/0x488
 [<c014401d>] handle_mm_fault+0x105/0x220
 [<c01168b0>] do_page_fault+0x120/0x45d
 [<c0116790>] do_page_fault+0x0/0x45d
 [<c0215ef1>] tty_write+0x33d/0x378
 [<c021b298>] write_chan+0x0/0x20c
 [<c010f918>] sys_ipc+0x1d4/0x1ec
 [<c0109a2d>] error_code+0x2d/0x38
 [<c0108fa3>] syscall_call+0x7/0xb

Code: 0f 0b 7b 00 a0 9a 3a c0 83 c4 08 f0 fe 0b 0f 88 04 0d 00 00

Steps to reproduce:
echo 10 > /proc/sys/vm/nr_hugepages
ran a quick test program that used shm to allocate 8MB with SHM_HUGETLB
run the 'ipcs' command

