Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVCVEUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVCVEUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVCVERF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:17:05 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:48325 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262266AbVCVEG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:06:58 -0500
Date: Mon, 21 Mar 2005 23:06:57 -0500
To: linux-kernel@vger.kernel.org
Subject: unable to handle paging request in worker_thread on apm resume
Message-ID: <20050322040657.GA28404@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following after an apm resume on a thinkpad X31, with
2.6.12-rc1 plus some (hopefully unrelated) NFS patches.  Any ideas?

--Bruce Fields


Mar 21 18:22:44 puzzle apmd[1815]: Suspending now
Mar 21 22:37:36 puzzle kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Mar 21 22:37:36 puzzle kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Mar 21 22:37:36 puzzle kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Mar 21 22:37:39 puzzle kernel: Unable to handle kernel paging request at virtual address d28c9dbc
Mar 21 22:37:39 puzzle kernel:  printing eip:
Mar 21 22:37:39 puzzle kernel: c01331a6
Mar 21 22:37:39 puzzle kernel: *pde = 00048067
Mar 21 22:37:39 puzzle kernel: *pte = 128c9000
Mar 21 22:37:39 puzzle kernel: Oops: 0002 [#1]
Mar 21 22:37:39 puzzle kernel: PREEMPT DEBUG_PAGEALLOC
Mar 21 22:37:39 puzzle kernel: Modules linked in:
Mar 21 22:37:39 puzzle kernel: CPU:    0
Mar 21 22:37:39 puzzle kernel: EIP:    0060:[<c01331a6>]    Not tainted VLI
Mar 21 22:37:39 puzzle kernel: EFLAGS: 00010093   (2.6.12-rc1-CITI_NFS4_ALL-1) 
Mar 21 22:37:39 puzzle kernel: EIP is at worker_thread+0x1a6/0x400
Mar 21 22:37:39 puzzle kernel: eax: d28c9db8   ebx: 00000246   ecx: c0680ea4   edx: dff19f58
Mar 21 22:37:39 puzzle kernel: esi: dff19f38   edi: c0680ea0   ebp: dff0ffc4   esp: dff0ff5c
Mar 21 22:37:39 puzzle kernel: ds: 007b   es: 007b   ss: 0068
Mar 21 22:37:39 puzzle kernel: Process events/0 (pid: 3, threadinfo=dff0f000 task=dff1aa90)
Mar 21 22:37:39 puzzle kernel: Stack: dff19f80 00000000 c05643e0 dff0f000 dff19f58 ffffffff ffffffff 00000001 
Mar 21 22:37:39 puzzle kernel:        00000000 c0115ec0 00010000 00000000 dff07e44 c0571eff dff0ffc8 00000000 
Mar 21 22:37:39 puzzle kernel:        dff1aa90 c0115ec0 00100100 00200200 e1b0835a 00000000 dff1aa90 dff0f000 
Mar 21 22:37:39 puzzle kernel: Call Trace:
Mar 21 22:37:39 puzzle kernel:  [<c0103a75>] show_stack+0x75/0x90
Mar 21 22:37:39 puzzle kernel:  [<c0103bcb>] show_registers+0x11b/0x180
Mar 21 22:37:39 puzzle kernel:  [<c0103dfd>] die+0x13d/0x290
Mar 21 22:37:39 puzzle kernel:  [<c011375f>] do_page_fault+0x30f/0x68e
Mar 21 22:37:39 puzzle kernel:  [<c01035cb>] error_code+0x2b/0x30
Mar 21 22:37:39 puzzle kernel:  [<c01399e8>] kthread+0x98/0xa0
Mar 21 22:37:39 puzzle kernel:  [<c0100c49>] kernel_thread_helper+0x5/0xc
Mar 21 22:37:39 puzzle kernel: Code: 00 8b 4e 20 3b 4d a8 0f 84 0a 01 00 00 8d 56 48 89 55 98 89 f6 8d 79 fc 8b 47 0c 89 45 a0 8b 57 10 89 55 9c 8b 51 04 8b 01 89 02 <89> 50 04 89 09 89 49 04 81 3e 3c 4b 24 1d 74 18 56 68 a8 00 00 
Mar 21 22:37:39 puzzle kernel:  <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Mar 21 22:37:39 puzzle kernel: in_atomic():1, irqs_disabled():0
Mar 21 22:37:39 puzzle kernel:  [<c0103aa7>] dump_stack+0x17/0x20
Mar 21 22:37:39 puzzle kernel:  [<c0117879>] __might_sleep+0x99/0xb0
Mar 21 22:37:39 puzzle kernel:  [<c011c985>] profile_task_exit+0x15/0x50
Mar 21 22:37:39 puzzle kernel:  [<c011f06a>] do_exit+0x1a/0x760
Mar 21 22:37:39 puzzle kernel:  [<c0103f48>] die+0x288/0x290
Mar 21 22:37:39 puzzle kernel:  [<c011375f>] do_page_fault+0x30f/0x68e
Mar 21 22:37:39 puzzle kernel:  [<c01035cb>] error_code+0x2b/0x30
Mar 21 22:37:39 puzzle kernel:  [<c01399e8>] kthread+0x98/0xa0
Mar 21 22:37:39 puzzle kernel:  [<c0100c49>] kernel_thread_helper+0x5/0xc
Mar 21 22:37:39 puzzle kernel: note: events/0[3] exited with preempt_count 1
Mar 21 22:37:39 puzzle kernel: PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Mar 21 22:37:39 puzzle kernel: ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
Mar 21 22:37:39 puzzle kernel: PCI: Found IRQ 11 for device 0000:00:1f.1
Mar 21 22:37:39 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Mar 21 22:37:39 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:00.2
Mar 21 22:37:39 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Mar 21 22:37:39 puzzle kernel: PCI: Found IRQ 11 for device 0000:00:1f.5
Mar 21 22:37:39 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1f.3
Mar 21 22:37:39 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1f.6
Mar 21 22:37:39 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:00.1
Mar 21 22:37:39 puzzle kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Mar 21 22:37:40 puzzle kernel: PCI: Found IRQ 11 for device 0000:01:00.0
Mar 21 22:37:40 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1d.0
Mar 21 22:37:40 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:00.0
Mar 21 22:37:40 puzzle kernel: PCI: Found IRQ 11 for device 0000:02:00.2
Mar 21 22:37:40 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Mar 21 22:37:40 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1f.1
Mar 21 22:37:40 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Mar 21 22:37:41 puzzle kernel: PCI: Found IRQ 11 for device 0000:02:08.0
Mar 21 22:37:41 puzzle kernel: kernel/workqueue.c:82: spin_lock(kernel/workqueue.c:dff19f38) already locked by kernel/workqueue.c/174
Mar 21 22:37:41 puzzle kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Mar 21 22:37:41 puzzle kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Mar 21 22:37:41 puzzle kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
