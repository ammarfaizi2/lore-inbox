Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUIHAaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUIHAaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268816AbUIHAaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:30:46 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:64494 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268812AbUIHAan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:30:43 -0400
Date: Tue, 7 Sep 2004 20:35:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: John Levon <levon@movementarian.org>
Subject: Oprofile related oops? 2.6.9-rc1-mm4
Message-ID: <Pine.LNX.4.53.0409072031170.15087@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this with a high process count load (I'll try and get a hold of the 
app).

Sep  7 19:11:57 morocco kernel: Oops: 0000 [#1]
Sep  7 19:11:57 morocco kernel: PREEMPT SMP DEBUG_PAGEALLOC
Sep  7 19:11:57 morocco kernel: Modules linked in:
Sep  7 19:11:57 morocco kernel: CPU:    1
Sep  7 19:11:57 morocco kernel: EIP:    0060:[<c0155153>]    Not tainted VLI
Sep  7 19:11:57 morocco kernel: EFLAGS: 00010202   (2.6.9-rc1-mm4) 
Sep  7 19:11:57 morocco kernel: EIP is at find_vma+0x43/0x70
Sep  7 19:11:57 morocco kernel: eax: 083fffec   ebx: 080634a0   ecx: c0120ebe   edx: 08400004
Sep  7 19:11:57 morocco kernel: esi: cd141d9c   edi: 00000000   ebp: c1f5beac   esp: c1f5bea4
Sep  7 19:11:58 morocco kernel: ds: 007b   es: 007b   ss: 0068
Sep  7 19:11:58 morocco kernel: Process events/1 (pid: 7, threadinfo=c1f5a000 task=c1eeca90)
Sep  7 19:11:58 morocco kernel: Stack: 00000000 080634a0 c1f5bed0 c057c20d cd141d9c 080634a0 00000000 0000007b 
Sep  7 19:11:58 morocco kernel:        00000000 f8985c98 c0795080 c1f5bef0 c057c417 cd141d9c 080634a0 c1f5bee4 
Sep  7 19:11:58 morocco kernel:        00000000 00000000 00000000 c1f5bf24 c057c886 cd141d9c f8985c98 00000000 
Sep  7 19:11:58 morocco kernel: Call Trace:
Sep  7 19:11:58 morocco kernel:  [<c010806f>] show_stack+0x7f/0xa0
Sep  7 19:11:58 morocco kernel:  [<c010821f>] show_registers+0x15f/0x1d0
Sep  7 19:11:58 morocco kernel:  [<c010845c>] die+0x10c/0x1a0
Sep  7 19:11:58 morocco kernel:  [<c011c185>] do_page_fault+0x255/0x5f2
Sep  7 19:11:58 morocco kernel:  [<c0107c59>] error_code+0x2d/0x38
Sep  7 19:11:58 morocco kernel:  [<c057c20d>] lookup_dcookie+0x1d/0xa0
Sep  7 19:11:58 morocco kernel:  [<c057c417>] add_us_sample+0x27/0x70
Sep  7 19:11:58 morocco kernel:  [<c057c886>] sync_buffer+0x136/0x13b
Sep  7 19:11:58 morocco kernel:  [<c057bead>] wq_sync_buffer+0x3d/0x70
Sep  7 19:11:58 morocco kernel:  [<c013395c>] worker_thread+0x19c/0x240
Sep  7 19:11:58 morocco kernel:  [<c0137f8a>] kthread+0xba/0xc0
Sep  7 19:11:58 morocco kernel:  [<c01052e5>] kernel_thread_helper+0x5/0x10
Sep  7 19:11:58 morocco kernel: Code: 39 59 08 76 13 39 59 04 76 3b 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 8b 56 04 31 c9 85 d2 74 24 8d b4 26 00 00 00 00 8d 42 e8 <39> 58 08 76 1b 39 58 04 89 c1 76 07 8b 52 0c 85 d2 75 ea 85 c9 

(gdb) list *find_vma+0x43
0xc0155153 is in find_vma (mm/mmap.c:1265).
1260                                    struct vm_area_struct * vma_tmp;
1261
1262                                    vma_tmp = rb_entry(rb_node,
1263                                                    struct vm_area_struct, vm_rb);
1264
1265                                    if (vma_tmp->vm_end > addr) {
1266                                            vma = vma_tmp;
1267                                            if (vma_tmp->vm_start <= addr)
1268                                                    break;
