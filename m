Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265566AbTGBXCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTGBXAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:00:52 -0400
Received: from 213-0-202-117.dialup.nuria.telefonica-data.net ([213.0.202.117]:54423
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S265544AbTGBW7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:59:04 -0400
Date: Thu, 3 Jul 2003 01:13:25 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.73]: Bad page state at free_hot_cold_page
Message-ID: <20030702231325.GA28040@localhost>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

While compiling some application I got a "signal 11" on the compiler,
and the following in the logs. As this box is known to have random
hungs, specially after minutes of heavy compiling (CPU hot), take this
bug report with a BIG grain of salt, it could be another case of crappy
hardware, though "memtest86" showed no problems at all.


Jul  3 00:48:16 dardhal kernel: Bad page state at free_hot_cold_page
Jul  3 00:48:16 dardhal kernel: flags:0x01000010 mapping:00000000 mapped:1 count:0
Jul  3 00:48:16 dardhal kernel: Backtrace:
Jul  3 00:48:16 dardhal kernel: Call Trace:
Jul  3 00:48:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:48:16 dardhal kernel: [<c01319f3>] free_hot_cold_page+0x53/0xe0
Jul  3 00:48:16 dardhal kernel: [<c013918e>] zap_pte_range+0x16e/0x1c0
Jul  3 00:48:16 dardhal kernel: [<c012e396>] unlock_page+0x16/0x50
Jul  3 00:48:16 dardhal kernel: [<c013922e>] zap_pmd_range+0x4e/0x70
Jul  3 00:48:16 dardhal kernel: [<c0139291>] unmap_page_range+0x41/0x70
Jul  3 00:48:16 dardhal kernel: [<c013938d>] unmap_vmas+0xcd/0x220
Jul  3 00:48:16 dardhal kernel: [<c013ceee>] exit_mmap+0x6e/0x170
Jul  3 00:48:16 dardhal kernel: [<c011725c>] mmput+0x4c/0x90
Jul  3 00:48:16 dardhal kernel: [<c011a8ba>] do_exit+0xfa/0x330
Jul  3 00:48:16 dardhal kernel: [<c011abb2>] do_group_exit+0x52/0x80
Jul  3 00:48:16 dardhal kernel: [<c01090ef>] syscall_call+0x7/0xb
Jul  3 00:48:16 dardhal kernel: 
Jul  3 00:48:16 dardhal kernel: Trying to fix it up, but a reboot is needed
Jul  3 00:48:16 dardhal kernel: Bad page state at prep_new_page
Jul  3 00:48:16 dardhal kernel: flags:0x01000000 mapping:00000000 mapped:1 count:0
Jul  3 00:48:16 dardhal kernel: Backtrace:
Jul  3 00:48:16 dardhal kernel: Call Trace:
Jul  3 00:48:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:48:16 dardhal kernel: [<c01317f3>] prep_new_page+0x33/0x50
Jul  3 00:48:16 dardhal kernel: [<c0131b3f>] buffered_rmqueue+0x9f/0x110
Jul  3 00:48:16 dardhal kernel: [<c0131c3d>] __alloc_pages+0x8d/0x330
Jul  3 00:48:16 dardhal kernel: [<c013ed03>] pte_chain_alloc+0x53/0x90
Jul  3 00:48:16 dardhal kernel: [<c0139cc0>] do_wp_page+0xc0/0x310
Jul  3 00:48:16 dardhal kernel: [<c013a503>] do_anonymous_page+0x123/0x1f0
Jul  3 00:48:16 dardhal kernel: [<c013aa9f>] handle_mm_fault+0x13f/0x150
Jul  3 00:48:16 dardhal kernel: [<c011443d>] do_page_fault+0x15d/0x4a2
Jul  3 00:48:16 dardhal kernel: [<c0148033>] __fput+0xa3/0xf0
Jul  3 00:48:16 dardhal kernel: [<c013c7c5>] unmap_vma+0x75/0x80
Jul  3 00:48:16 dardhal kernel: [<c013c7ef>] unmap_vma_list+0x1f/0x30
Jul  3 00:48:16 dardhal kernel: [<c013cb79>] do_munmap+0x119/0x150
Jul  3 00:48:16 dardhal kernel: [<c012588a>] sys_getrlimit+0x7a/0x80
Jul  3 00:48:16 dardhal kernel: [<c01142e0>] do_page_fault+0x0/0x4a2
Jul  3 00:48:16 dardhal kernel: [<c0109299>] error_code+0x2d/0x38
Jul  3 00:48:16 dardhal kernel: 
Jul  3 00:48:16 dardhal kernel: Trying to fix it up, but a reboot is needed
Jul  3 00:48:16 dardhal kernel: Bad page state at free_hot_cold_page
Jul  3 00:48:16 dardhal kernel: flags:0x01000010 mapping:00000000 mapped:1 count:0
Jul  3 00:48:16 dardhal kernel: Backtrace:
Jul  3 00:48:16 dardhal kernel: Call Trace:
Jul  3 00:48:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:48:16 dardhal kernel: [<c01319f3>] free_hot_cold_page+0x53/0xe0
Jul  3 00:48:16 dardhal kernel: [<c013918e>] zap_pte_range+0x16e/0x1c0
Jul  3 00:48:16 dardhal kernel: [<c013922e>] zap_pmd_range+0x4e/0x70
Jul  3 00:48:16 dardhal kernel: [<c0139291>] unmap_page_range+0x41/0x70
Jul  3 00:48:16 dardhal kernel: [<c013938d>] unmap_vmas+0xcd/0x220
Jul  3 00:48:16 dardhal kernel: [<c013ceee>] exit_mmap+0x6e/0x170
Jul  3 00:48:16 dardhal kernel: [<c011725c>] mmput+0x4c/0x90
Jul  3 00:48:16 dardhal kernel: [<c011a8ba>] do_exit+0xfa/0x330
Jul  3 00:48:16 dardhal kernel: [<c011abb2>] do_group_exit+0x52/0x80
Jul  3 00:48:16 dardhal kernel: [<c01090ef>] syscall_call+0x7/0xb
Jul  3 00:48:16 dardhal kernel: 
Jul  3 00:48:16 dardhal kernel: Trying to fix it up, but a reboot is needed
Jul  3 00:48:16 dardhal kernel: Bad page state at prep_new_page
Jul  3 00:48:16 dardhal kernel: flags:0x01000000 mapping:00000000 mapped:1 count:0
Jul  3 00:48:16 dardhal kernel: Backtrace:
Jul  3 00:48:16 dardhal kernel: Call Trace:
Jul  3 00:48:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:48:16 dardhal kernel: [<c01317f3>] prep_new_page+0x33/0x50
Jul  3 00:48:16 dardhal kernel: [<c0131b3f>] buffered_rmqueue+0x9f/0x110
Jul  3 00:48:16 dardhal kernel: [<c0131c3d>] __alloc_pages+0x8d/0x330
Jul  3 00:48:16 dardhal kernel: [<c012f480>] filemap_nopage+0x1d0/0x2c0
Jul  3 00:48:16 dardhal kernel: [<c013ed03>] pte_chain_alloc+0x53/0x90
Jul  3 00:48:16 dardhal kernel: [<c013a78b>] do_no_page+0x1bb/0x2b0
Jul  3 00:48:16 dardhal kernel: [<c013aa45>] handle_mm_fault+0xe5/0x150
Jul  3 00:48:16 dardhal kernel: [<c011443d>] do_page_fault+0x15d/0x4a2
Jul  3 00:48:16 dardhal kernel: [<c010ec51>] old_mmap+0x131/0x160
Jul  3 00:48:16 dardhal kernel: [<c01468eb>] filp_close+0x4b/0x80
Jul  3 00:48:16 dardhal kernel: [<c01142e0>] do_page_fault+0x0/0x4a2
Jul  3 00:48:16 dardhal kernel: [<c0109299>] error_code+0x2d/0x38
Jul  3 00:48:16 dardhal kernel: 
Jul  3 00:48:16 dardhal kernel: Trying to fix it up, but a reboot is needed
Jul  3 00:48:16 dardhal kernel: Bad page state at free_hot_cold_page
Jul  3 00:48:16 dardhal kernel: flags:0x01000010 mapping:00000000 mapped:1 count:0
Jul  3 00:48:16 dardhal kernel: Backtrace:
Jul  3 00:48:16 dardhal kernel: Call Trace:
Jul  3 00:48:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:48:16 dardhal kernel: [<c01319f3>] free_hot_cold_page+0x53/0xe0
Jul  3 00:48:16 dardhal kernel: [<c013918e>] zap_pte_range+0x16e/0x1c0
Jul  3 00:48:16 dardhal kernel: [<c013922e>] zap_pmd_range+0x4e/0x70
Jul  3 00:48:16 dardhal kernel: [<c0139291>] unmap_page_range+0x41/0x70
Jul  3 00:48:16 dardhal kernel: [<c013938d>] unmap_vmas+0xcd/0x220
Jul  3 00:48:16 dardhal kernel: [<c013ceee>] exit_mmap+0x6e/0x170
Jul  3 00:48:16 dardhal kernel: [<c011725c>] mmput+0x4c/0x90
Jul  3 00:48:16 dardhal kernel: [<c011a8ba>] do_exit+0xfa/0x330
Jul  3 00:48:16 dardhal kernel: [<c011abb2>] do_group_exit+0x52/0x80
Jul  3 00:48:16 dardhal kernel: [<c01090ef>] syscall_call+0x7/0xb
Jul  3 00:48:16 dardhal kernel: 
Jul  3 00:48:16 dardhal kernel: Trying to fix it up, but a reboot is needed
Jul  3 00:48:16 dardhal kernel: Bad page state at prep_new_page
Jul  3 00:48:16 dardhal kernel: flags:0x01000000 mapping:00000000 mapped:1 count:0
Jul  3 00:48:16 dardhal kernel: Backtrace:
Jul  3 00:48:16 dardhal kernel: Call Trace:
Jul  3 00:48:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:48:16 dardhal kernel: [<c01317f3>] prep_new_page+0x33/0x50
Jul  3 00:48:16 dardhal kernel: [<c0131b3f>] buffered_rmqueue+0x9f/0x110
Jul  3 00:48:16 dardhal kernel: [<c0131c3d>] __alloc_pages+0x8d/0x330
Jul  3 00:48:16 dardhal kernel: [<c012f480>] filemap_nopage+0x1d0/0x2c0
Jul  3 00:48:16 dardhal kernel: [<c013ed03>] pte_chain_alloc+0x53/0x90
Jul  3 00:48:16 dardhal kernel: [<c013a78b>] do_no_page+0x1bb/0x2b0
Jul  3 00:48:16 dardhal kernel: [<c013aa45>] handle_mm_fault+0xe5/0x150
Jul  3 00:48:16 dardhal kernel: [<c011443d>] do_page_fault+0x15d/0x4a2
Jul  3 00:48:16 dardhal kernel: [<c010ec51>] old_mmap+0x131/0x160
Jul  3 00:48:16 dardhal kernel: [<c01468eb>] filp_close+0x4b/0x80
Jul  3 00:48:16 dardhal kernel: [<c01142e0>] do_page_fault+0x0/0x4a2
Jul  3 00:48:16 dardhal kernel: [<c0109299>] error_code+0x2d/0x38
Jul  3 00:48:16 dardhal kernel: 
Jul  3 00:48:16 dardhal kernel: Trying to fix it up, but a reboot is needed
Jul  3 00:52:16 dardhal kernel: Bad page state at free_hot_cold_page
Jul  3 00:52:16 dardhal kernel: flags:0x01000010 mapping:00000000 mapped:1 count:0
Jul  3 00:52:16 dardhal kernel: Backtrace:
Jul  3 00:52:16 dardhal kernel: Call Trace:
Jul  3 00:52:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:52:16 dardhal kernel: [<c01319f3>] free_hot_cold_page+0x53/0xe0
Jul  3 00:52:16 dardhal kernel: [<c013918e>] zap_pte_range+0x16e/0x1c0
Jul  3 00:52:16 dardhal kernel: [<c012e396>] unlock_page+0x16/0x50
Jul  3 00:52:16 dardhal kernel: [<c013922e>] zap_pmd_range+0x4e/0x70
Jul  3 00:52:16 dardhal kernel: [<c0139291>] unmap_page_range+0x41/0x70
Jul  3 00:52:16 dardhal kernel: [<c013938d>] unmap_vmas+0xcd/0x220
Jul  3 00:52:16 dardhal kernel: [<c013ceee>] exit_mmap+0x6e/0x170
Jul  3 00:52:16 dardhal kernel: [<c011725c>] mmput+0x4c/0x90
Jul  3 00:52:16 dardhal kernel: [<c011a8ba>] do_exit+0xfa/0x330
Jul  3 00:52:16 dardhal kernel: [<c0115c30>] default_wake_function+0x0/0x30
Jul  3 00:52:16 dardhal kernel: [<c011abb2>] do_group_exit+0x52/0x80
Jul  3 00:52:16 dardhal kernel: [<c01090ef>] syscall_call+0x7/0xb
Jul  3 00:52:16 dardhal kernel: 
Jul  3 00:52:16 dardhal kernel: Trying to fix it up, but a reboot is needed
Jul  3 00:52:16 dardhal kernel: Bad page state at prep_new_page
Jul  3 00:52:16 dardhal kernel: flags:0x01000000 mapping:00000000 mapped:1 count:0
Jul  3 00:52:16 dardhal kernel: Backtrace:
Jul  3 00:52:16 dardhal kernel: Call Trace:
Jul  3 00:52:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:52:16 dardhal kernel: [<c01317f3>] prep_new_page+0x33/0x50
Jul  3 00:52:16 dardhal kernel: [<c0131b3f>] buffered_rmqueue+0x9f/0x110
Jul  3 00:52:16 dardhal kernel: [<c0131c3d>] __alloc_pages+0x8d/0x330
Jul  3 00:52:16 dardhal kernel: [<c013a44a>] do_anonymous_page+0x6a/0x1f0
Jul  3 00:52:16 dardhal kernel: [<c013aa45>] handle_mm_fault+0xe5/0x150
Jul  3 00:52:16 dardhal kernel: [<c011443d>] do_page_fault+0x15d/0x4a2
Jul  3 00:52:16 dardhal kernel: [<c013cd5b>] do_brk+0x12b/0x200
Jul  3 00:52:16 dardhal kernel: [<c013b790>] sys_brk+0xf0/0x120
Jul  3 00:52:16 dardhal kernel: [<c01142e0>] do_page_fault+0x0/0x4a2
Jul  3 00:52:16 dardhal kernel: [<c0109299>] error_code+0x2d/0x38
Jul  3 00:52:16 dardhal kernel: 
Jul  3 00:52:16 dardhal kernel: Trying to fix it up, but a reboot is needed
Jul  3 00:52:16 dardhal kernel: Bad page state at free_hot_cold_page
Jul  3 00:52:16 dardhal kernel: flags:0x01000014 mapping:00000000 mapped:1 count:0
Jul  3 00:52:16 dardhal kernel: Backtrace:
Jul  3 00:52:16 dardhal kernel: Call Trace:
Jul  3 00:52:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:52:16 dardhal kernel: [<c01319f3>] free_hot_cold_page+0x53/0xe0
Jul  3 00:52:16 dardhal kernel: [<c013918e>] zap_pte_range+0x16e/0x1c0
Jul  3 00:52:16 dardhal kernel: [<c013922e>] zap_pmd_range+0x4e/0x70
Jul  3 00:52:16 dardhal kernel: [<c0139291>] unmap_page_range+0x41/0x70
Jul  3 00:52:16 dardhal kernel: [<c013938d>] unmap_vmas+0xcd/0x220
Jul  3 00:52:16 dardhal kernel: [<c013ceee>] exit_mmap+0x6e/0x170
Jul  3 00:52:16 dardhal kernel: [<c011725c>] mmput+0x4c/0x90
Jul  3 00:52:16 dardhal kernel: [<c011a8ba>] do_exit+0xfa/0x330
Jul  3 00:52:16 dardhal kernel: [<c011abb2>] do_group_exit+0x52/0x80
Jul  3 00:52:16 dardhal kernel: [<c01090ef>] syscall_call+0x7/0xb
Jul  3 00:52:16 dardhal kernel: 
Jul  3 00:52:16 dardhal kernel: Trying to fix it up, but a reboot is needed
Jul  3 00:52:16 dardhal kernel: Bad page state at prep_new_page
Jul  3 00:52:16 dardhal kernel: flags:0x01000004 mapping:00000000 mapped:1 count:0
Jul  3 00:52:16 dardhal kernel: Backtrace:
Jul  3 00:52:16 dardhal kernel: Call Trace:
Jul  3 00:52:16 dardhal kernel: [<c013150d>] bad_page+0x5d/0x90
Jul  3 00:52:16 dardhal kernel: [<c01317f3>] prep_new_page+0x33/0x50
Jul  3 00:52:16 dardhal kernel: [<c0131b3f>] buffered_rmqueue+0x9f/0x110
Jul  3 00:52:16 dardhal kernel: [<c0131c3d>] __alloc_pages+0x8d/0x330
Jul  3 00:52:16 dardhal kernel: [<c012eb67>] do_generic_mapping_read+0x347/0x390
Jul  3 00:52:16 dardhal kernel: [<c012ebb0>] file_read_actor+0x0/0x120
Jul  3 00:52:16 dardhal kernel: [<c012ee79>] __generic_file_aio_read+0x1a9/0x1f0
Jul  3 00:52:16 dardhal kernel: [<c012ebb0>] file_read_actor+0x0/0x120
Jul  3 00:52:16 dardhal kernel: [<c012ef12>] generic_file_aio_read+0x52/0x70
Jul  3 00:52:16 dardhal kernel: [<c0146f89>] do_sync_read+0x89/0xc0
Jul  3 00:52:16 dardhal kernel: [<c0214995>] __ide_do_rw_disk+0x405/0x760
Jul  3 00:52:16 dardhal kernel: [<c0209605>] start_request+0x175/0x290
Jul  3 00:52:16 dardhal kernel: [<c020994a>] ide_do_request+0x1fa/0x390
Jul  3 00:52:16 dardhal kernel: [<c0217ded>] ide_dma_intr+0x9d/0xc0
Jul  3 00:52:16 dardhal kernel: [<c014706d>] vfs_read+0xad/0x120
Jul  3 00:52:16 dardhal kernel: [<c01473d4>] sys_pread64+0x54/0x80
Jul  3 00:52:16 dardhal kernel: [<c01090ef>] syscall_call+0x7/0xb
Jul  3 00:52:16 dardhal kernel: 
Jul  3 00:52:16 dardhal kernel: Trying to fix it up, but a reboot is needed


Hope it helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.5.73)
