Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267462AbUG2V4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267462AbUG2V4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUG2V4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:56:30 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:33164 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267462AbUG2V4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:56:24 -0400
Subject: arch_init_sched_domains() oops
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091138180.23502.81.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 14:56:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened on a NUMA running 2.6.8-rc2-mm1:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c049a5dd
*pde = 004bc001
*pte = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c049a5dd>]    Not tainted VLI
EFLAGS: 00010256   (2.6.8-rc2-mm1)
EIP is at arch_init_sched_domains+0x5d/0x4fc
eax: 00000001   ebx: c04cf5cc   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: eb9b9fd8   esp: eb9b9f68
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=eb9b9000 task=eb991730)
Stack: c04cf5cc 00000000 00000000 c04cf5cc 00002865 0000ffff eb9b9000 c011032a
       00000001 00000000 00000000 00000000 00000001 004bc001 c0113224 c04d314c
       00000020 00000000 c04d314c 00000020 00000000 c0494eb3 c0002000 00000001
Call Trace:
 [<c011032a>] flush_tlb_all+0x22/0x3c
 [<c0113224>] zap_low_mappings+0x54/0x5c
 [<c0494eb3>] smp_cpus_done+0x1b/0x20
 [<c048d5cc>] smp_init+0x94/0x9c
 [<c049aa84>] sched_init_smp+0x8/0x14
 [<c010052d>] init+0xa9/0x1a4
 [<c0100484>] init+0x0/0x1a4
 [<c0102385>] kernel_thread_helper+0x5/0xc
Code: 07 0f 8f 96 02 00 00 8d b4 26 00 00 00 00 8b 45 bc c1 e0 02 89 45 b4 89 c2 8b 82 00 10 3f c0 c1 e0 02 8b 80 c0 0f 3f c0 89 45 b0 <8b> 3d 04 00 00 00 83 c7 04 b9 01 00 00 00 89 fb 31 c0 f3 af 74
 <0>Kernel panic - not syncing: Attempted to kill init!

Is there an updated sched domains patch I should be trying instead?

-- Dave

