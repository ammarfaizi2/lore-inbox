Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVAMFFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVAMFFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVAMFFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:05:40 -0500
Received: from fsmlabs.com ([168.103.115.128]:63667 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261517AbVAMFF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:05:27 -0500
Date: Wed, 12 Jan 2005 22:05:38 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, clameter@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes for prep_zero_page
In-Reply-To: <Pine.LNX.4.61.0501092117040.20477@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0501122203350.4941@montezuma.fsmlabs.com>
References: <20050108010629.M469@build.pdx.osdl.net> <20050109014519.412688f6.akpm@osdl.org>
 <Pine.LNX.4.61.0501090812220.13639@montezuma.fsmlabs.com>
 <20050109125212.330c34c1.akpm@osdl.org> <Pine.LNX.4.61.0501091409490.13639@montezuma.fsmlabs.com>
 <20050109144840.W2357@build.pdx.osdl.net> <Pine.LNX.4.61.0501092117040.20477@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like it's still not happy with CONFIG_DEBUG_PAGEALLOC under load.

Unable to handle kernel paging request at virtual address ec5d97f4
 printing eip:
c014a882
*pde = 0083e067
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c014a882>]    Not tainted VLI
EFLAGS: 00010002   (2.6.10-mm2)
EIP is at check_slabuse+0x52/0xf0
eax: ec5d97f4   ebx: c18dd180   ecx: ec5b685c   edx: ec5d9000
esi: c18dd180   edi: ec5d9000   ebp: c19d1efc   esp: c19d1ed4
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 6, threadinfo=c19d0000 task=c19abac0)
Stack: c19d1efc c0149c64 c19d1f0c c0149b0e c19d1ef0 00000000 ec5b685c ec5b685c
       c18dd180 c18dd1a0 c19d1f24 c014aa19 c18dd2a0 c19d1f24 c014acec 00000000
       c18dd180 c18dd2a0 c18dd180 00000005 c19d1f48 c014af91 c18dd2c8 c18dd2a0
Call Trace:
 [<c0103fda>] show_stack+0x7a/0x90
 [<c0104166>] show_registers+0x156/0x1c0
 [<c0104380>] die+0x100/0x190
 [<c0117159>] do_page_fault+0x369/0x65f
 [<c0103c6f>] error_code+0x2b/0x30
 [<c014aa19>] check_redzone+0xf9/0x140
 [<c014af91>] cache_reap+0x221/0x230
 [<c0130b2b>] worker_thread+0x17b/0x210
 [<c0135605>] kthread+0xa5/0xb0
 [<c0101415>] kernel_thread_helper+0x5/0x10
Code: 00 00 8d bc 27 00 00 00 00 83 c4 1c 5b 5e 5f 5d c3 8b 43 38 8b 7d ec 
8b 4d f0 0f af f8 8b 410c 01 c7 89 fa 89 d8 e8 ee d3 ff ff <8b> 30 89 fa 
89 d8 e8 13 d4 ff ff 81 fe 71 f0 2c 5a 8b 00 74 7b
 <3>Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c0104007>] dump_stack+0x17/0x20
 [<c011cb7c>] __might_sleep+0xac/0xc0
 [<c0120753>] profile_task_exit+0x23/0x60
 [<c012297c>] do_exit+0x1c/0x440
 [<c0104408>] die+0x188/0x190
 [<c0117159>] do_page_fault+0x369/0x65f
 [<c0103c6f>] error_code+0x2b/0x30
 [<c014aa19>] check_redzone+0xf9/0x140
 [<c014af91>] cache_reap+0x221/0x230
 [<c0130b2b>] worker_thread+0x17b/0x210
 [<c0135605>] kthread+0xa5/0xb0
 [<c0101415>] kernel_thread_helper+0x5/0x10
note: events/0[6] exited with preempt_count 1
