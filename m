Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267395AbUBSWjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUBSWjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:39:24 -0500
Received: from 217-124-42-84.dialup.nuria.telefonica-data.net ([217.124.42.84]:13186
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S267395AbUBSWiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:38:51 -0500
Date: Thu, 19 Feb 2004 23:38:45 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: [linux kernel 2.6.2-bk3]: Bad page state at prep_new_page
Message-ID: <20040219223845.GA8528@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

While downloading my daily spam^Wemail through a slow 56K modem, and
trying to tell spam apart from ham using spamassassin I have suffered a
kernel failure, or at least X stopped responding, and nothing but SysRq
worked (didn't try remote pinging or accessing the box though).

Linux kernel version is 2.6.2-bk3 compiled with gcc 3.2.3 from Debian
Sid. I got the following in the logs, and the system continued to work
for a while, but in the end it stopped. I tried several SysRq+T and
SysRq+M, but nothing went to the logs. However, SysRq+B worked.


Feb 19 21:51:25 dardhal kernel: Bad page state at prep_new_page
Feb 19 21:51:25 dardhal kernel: flags:0x20000064 mapping:00000000 mapped:0 count:0
Feb 19 21:51:25 dardhal kernel: Backtrace:
Feb 19 21:51:25 dardhal kernel: Call Trace:
Feb 19 21:51:25 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:51:25 dardhal kernel: [<c0135be2>] prep_new_page+0x32/0x60
Feb 19 21:51:25 dardhal kernel: [<c013603e>] buffered_rmqueue+0x9e/0x110
Feb 19 21:51:25 dardhal kernel: [<c0136154>] __alloc_pages+0xa4/0x350
Feb 19 21:51:25 dardhal kernel: [<c013ed1e>] do_anonymous_page+0x6e/0x190
Feb 19 21:51:25 dardhal kernel: [<c013eea1>] do_no_page+0x61/0x2d0
Feb 19 21:51:25 dardhal kernel: [<c013f300>] handle_mm_fault+0xf0/0x160
Feb 19 21:51:25 dardhal kernel: [<c0116a4c>] do_page_fault+0x12c/0x535
Feb 19 21:51:25 dardhal kernel: [<c0203bf9>] serial8250_stop_tx+0x79/0x80
Feb 19 21:51:25 dardhal kernel: [<c0123086>] update_process_times+0x46/0x60
Feb 19 21:51:25 dardhal kernel: [<c0122eeb>] update_wall_time+0xb/0x40
Feb 19 21:51:25 dardhal kernel: [<c012331f>] do_timer+0xdf/0xf0
Feb 19 21:51:25 dardhal kernel: [<c010b4f9>] do_IRQ+0xc9/0xf0
Feb 19 21:51:25 dardhal kernel: [<c0116920>] do_page_fault+0x0/0x535
Feb 19 21:51:25 dardhal kernel: [<c0109915>] error_code+0x2d/0x38
Feb 19 21:51:25 dardhal kernel: 
Feb 19 21:51:25 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:52:48 dardhal kernel: Bad page state at prep_new_page
Feb 19 21:52:48 dardhal kernel: flags:0x20000004 mapping:00000000 mapped:1 count:0
Feb 19 21:52:48 dardhal kernel: Backtrace:
Feb 19 21:52:48 dardhal kernel: Call Trace:
Feb 19 21:52:48 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:52:48 dardhal kernel: [<c0135be2>] prep_new_page+0x32/0x60
Feb 19 21:52:48 dardhal kernel: [<c013603e>] buffered_rmqueue+0x9e/0x110
Feb 19 21:52:48 dardhal kernel: [<c0136154>] __alloc_pages+0xa4/0x350
Feb 19 21:52:48 dardhal kernel: [<c013ed1e>] do_anonymous_page+0x6e/0x190
Feb 19 21:52:48 dardhal kernel: [<c013eea1>] do_no_page+0x61/0x2d0
Feb 19 21:52:48 dardhal kernel: [<c01178a0>] recalc_task_prio+0x90/0x1a0
Feb 19 21:52:48 dardhal kernel: [<c013f300>] handle_mm_fault+0xf0/0x160
Feb 19 21:52:48 dardhal kernel: [<c0116a4c>] do_page_fault+0x12c/0x535
Feb 19 21:52:48 dardhal kernel: [<c0129d00>] delayed_work_timer_fn+0x0/0x60
Feb 19 21:52:48 dardhal kernel: [<c01178a0>] recalc_task_prio+0x90/0x1a0
Feb 19 21:52:48 dardhal kernel: [<c0118655>] schedule+0x315/0x510
Feb 19 21:52:48 dardhal kernel: [<c0116920>] do_page_fault+0x0/0x535
Feb 19 21:52:48 dardhal kernel: [<c0109915>] error_code+0x2d/0x38
Feb 19 21:52:48 dardhal kernel: 
Feb 19 21:52:48 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:52:59 dardhal kernel: Bad page state at free_hot_cold_page
Feb 19 21:52:59 dardhal kernel: flags:0x20000014 mapping:00000000 mapped:1 count:0
Feb 19 21:52:59 dardhal kernel: Backtrace:
Feb 19 21:52:59 dardhal kernel: Call Trace:
Feb 19 21:52:59 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:52:59 dardhal kernel: [<c0135ef3>] free_hot_cold_page+0x53/0xe0
Feb 19 21:52:59 dardhal kernel: [<c013dad8>] zap_pte_range+0x138/0x180
Feb 19 21:52:59 dardhal kernel: [<c013db6b>] zap_pmd_range+0x4b/0x70
Feb 19 21:52:59 dardhal kernel: [<c013dbd3>] unmap_page_range+0x43/0x70
Feb 19 21:52:59 dardhal kernel: [<c013dccf>] unmap_vmas+0xcf/0x220
Feb 19 21:52:59 dardhal kernel: [<c01417e0>] exit_mmap+0x70/0x180
Feb 19 21:52:59 dardhal kernel: [<c0119e4e>] mmput+0x4e/0x90
Feb 19 21:52:59 dardhal kernel: [<c011d778>] do_exit+0x128/0x310
Feb 19 21:52:59 dardhal kernel: [<c011da24>] do_group_exit+0x54/0x80
Feb 19 21:52:59 dardhal kernel: [<c0126240>] get_signal_to_deliver+0x1c0/0x300
Feb 19 21:52:59 dardhal kernel: [<c0108d2d>] do_signal+0xdd/0x110
Feb 19 21:52:59 dardhal kernel: [<c0123400>] process_timeout+0x0/0x10
Feb 19 21:52:59 dardhal kernel: [<c0117b0e>] wake_up_process+0x1e/0x20
Feb 19 21:52:59 dardhal kernel: [<c01178a0>] recalc_task_prio+0x90/0x1a0
Feb 19 21:52:59 dardhal kernel: [<c0118655>] schedule+0x315/0x510
Feb 19 21:52:59 dardhal kernel: [<c0116920>] do_page_fault+0x0/0x535
Feb 19 21:52:59 dardhal kernel: [<c0108db6>] do_notify_resume+0x56/0x58
Feb 19 21:52:59 dardhal kernel: [<c0108f56>] work_notifysig+0x13/0x15
Feb 19 21:52:59 dardhal kernel: 
Feb 19 21:52:59 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:52:59 dardhal kernel: Bad page state at prep_new_page
Feb 19 21:52:59 dardhal kernel: flags:0x20000004 mapping:00000000 mapped:1 count:0
Feb 19 21:52:59 dardhal kernel: Backtrace:
Feb 19 21:52:59 dardhal kernel: Call Trace:
Feb 19 21:52:59 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:52:59 dardhal kernel: [<c0135be2>] prep_new_page+0x32/0x60
Feb 19 21:52:59 dardhal kernel: [<c013603e>] buffered_rmqueue+0x9e/0x110
Feb 19 21:52:59 dardhal kernel: [<c0136154>] __alloc_pages+0xa4/0x350
Feb 19 21:52:59 dardhal kernel: [<c013ed1e>] do_anonymous_page+0x6e/0x190
Feb 19 21:52:59 dardhal kernel: [<c013eea1>] do_no_page+0x61/0x2d0
Feb 19 21:52:59 dardhal kernel: [<c013f300>] handle_mm_fault+0xf0/0x160
Feb 19 21:52:59 dardhal kernel: [<c0116a4c>] do_page_fault+0x12c/0x535
Feb 19 21:52:59 dardhal kernel: [<c0123086>] update_process_times+0x46/0x60
Feb 19 21:52:59 dardhal kernel: [<c0122eeb>] update_wall_time+0xb/0x40
Feb 19 21:52:59 dardhal kernel: [<c012331f>] do_timer+0xdf/0xf0
Feb 19 21:52:59 dardhal kernel: [<c010b4f9>] do_IRQ+0xc9/0xf0
Feb 19 21:52:59 dardhal kernel: [<c0116920>] do_page_fault+0x0/0x535
Feb 19 21:52:59 dardhal kernel: [<c0109915>] error_code+0x2d/0x38
Feb 19 21:52:59 dardhal kernel: 
Feb 19 21:52:59 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:53:18 dardhal kernel: Bad page state at free_hot_cold_page
Feb 19 21:53:18 dardhal kernel: flags:0x20000014 mapping:00000000 mapped:1 count:0
Feb 19 21:53:18 dardhal kernel: Backtrace:
Feb 19 21:53:18 dardhal kernel: Call Trace:
Feb 19 21:53:18 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:53:18 dardhal kernel: [<c0135ef3>] free_hot_cold_page+0x53/0xe0
Feb 19 21:53:18 dardhal kernel: [<c013dad8>] zap_pte_range+0x138/0x180
Feb 19 21:53:18 dardhal kernel: [<c013db6b>] zap_pmd_range+0x4b/0x70
Feb 19 21:53:18 dardhal kernel: [<c013dbd3>] unmap_page_range+0x43/0x70
Feb 19 21:53:18 dardhal kernel: [<c013dccf>] unmap_vmas+0xcf/0x220
Feb 19 21:53:18 dardhal kernel: [<c01417e0>] exit_mmap+0x70/0x180
Feb 19 21:53:18 dardhal kernel: [<c0119e4e>] mmput+0x4e/0x90
Feb 19 21:53:18 dardhal kernel: [<c011d778>] do_exit+0x128/0x310
Feb 19 21:53:18 dardhal kernel: [<c014b549>] filp_close+0x59/0x90
Feb 19 21:53:18 dardhal kernel: [<c011da24>] do_group_exit+0x54/0x80
Feb 19 21:53:18 dardhal kernel: [<c0108f0b>] syscall_call+0x7/0xb
Feb 19 21:53:18 dardhal kernel: 
Feb 19 21:53:18 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:53:18 dardhal kernel: Bad page state at prep_new_page
Feb 19 21:53:18 dardhal kernel: flags:0x20000004 mapping:00000000 mapped:1 count:0
Feb 19 21:53:18 dardhal kernel: Backtrace:
Feb 19 21:53:18 dardhal kernel: Call Trace:
Feb 19 21:53:18 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:53:18 dardhal kernel: [<c0135be2>] prep_new_page+0x32/0x60
Feb 19 21:53:18 dardhal kernel: [<c013603e>] buffered_rmqueue+0x9e/0x110
Feb 19 21:53:18 dardhal kernel: [<c0136154>] __alloc_pages+0xa4/0x350
Feb 19 21:53:18 dardhal kernel: [<c013ed1e>] do_anonymous_page+0x6e/0x190
Feb 19 21:53:18 dardhal kernel: [<c013eea1>] do_no_page+0x61/0x2d0
Feb 19 21:53:18 dardhal kernel: [<c01178a0>] recalc_task_prio+0x90/0x1a0
Feb 19 21:53:18 dardhal kernel: [<c013f300>] handle_mm_fault+0xf0/0x160
Feb 19 21:53:18 dardhal kernel: [<c0116a4c>] do_page_fault+0x12c/0x535
Feb 19 21:53:18 dardhal kernel: [<c0203e0f>] receive_chars+0x10f/0x280
Feb 19 21:53:18 dardhal kernel: [<c020401a>] transmit_chars+0x9a/0xd0
Feb 19 21:53:18 dardhal kernel: [<c02041b7>] serial8250_interrupt+0x27/0xc0
Feb 19 21:53:18 dardhal kernel: [<c010b18a>] handle_IRQ_event+0x3a/0x70
Feb 19 21:53:18 dardhal kernel: [<c010b4c2>] do_IRQ+0x92/0xf0
Feb 19 21:53:18 dardhal kernel: [<c0116920>] do_page_fault+0x0/0x535
Feb 19 21:53:18 dardhal kernel: [<c0109915>] error_code+0x2d/0x38
Feb 19 21:53:18 dardhal kernel: 
Feb 19 21:53:18 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:53:18 dardhal kernel: Bad page state at free_hot_cold_page
Feb 19 21:53:18 dardhal kernel: flags:0x20000014 mapping:00000000 mapped:1 count:0
Feb 19 21:53:18 dardhal kernel: Backtrace:
Feb 19 21:53:18 dardhal kernel: Call Trace:
Feb 19 21:53:18 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:53:18 dardhal kernel: [<c0135ef3>] free_hot_cold_page+0x53/0xe0
Feb 19 21:53:18 dardhal kernel: [<c013dad8>] zap_pte_range+0x138/0x180
Feb 19 21:53:18 dardhal kernel: [<c013db6b>] zap_pmd_range+0x4b/0x70
Feb 19 21:53:18 dardhal kernel: [<c013dbd3>] unmap_page_range+0x43/0x70
Feb 19 21:53:18 dardhal kernel: [<c013dccf>] unmap_vmas+0xcf/0x220
Feb 19 21:53:18 dardhal kernel: [<c01417e0>] exit_mmap+0x70/0x180
Feb 19 21:53:18 dardhal kernel: [<c0119e4e>] mmput+0x4e/0x90
Feb 19 21:53:18 dardhal kernel: [<c011d778>] do_exit+0x128/0x310
Feb 19 21:53:18 dardhal kernel: [<c011da24>] do_group_exit+0x54/0x80
Feb 19 21:53:18 dardhal kernel: [<c0126240>] get_signal_to_deliver+0x1c0/0x300
Feb 19 21:53:18 dardhal kernel: [<c0108d2d>] do_signal+0xdd/0x110
Feb 19 21:53:18 dardhal kernel: [<c0141000>] unmap_vma+0x40/0x80
Feb 19 21:53:18 dardhal kernel: [<c014105f>] unmap_vma_list+0x1f/0x30
Feb 19 21:53:18 dardhal kernel: [<c014144d>] do_munmap+0x11d/0x150
Feb 19 21:53:18 dardhal kernel: [<c0116920>] do_page_fault+0x0/0x535
Feb 19 21:53:18 dardhal kernel: [<c0108db6>] do_notify_resume+0x56/0x58
Feb 19 21:53:18 dardhal kernel: [<c0108f56>] work_notifysig+0x13/0x15
Feb 19 21:53:18 dardhal kernel: 
Feb 19 21:53:18 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:53:19 dardhal kernel: Bad page state at prep_new_page
Feb 19 21:53:19 dardhal kernel: flags:0x20000004 mapping:00000000 mapped:1 count:0
Feb 19 21:53:19 dardhal kernel: Backtrace:
Feb 19 21:53:19 dardhal kernel: Call Trace:
Feb 19 21:53:19 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:53:19 dardhal kernel: [<c0135be2>] prep_new_page+0x32/0x60
Feb 19 21:53:19 dardhal kernel: [<c013603e>] buffered_rmqueue+0x9e/0x110
Feb 19 21:53:19 dardhal kernel: [<c0136154>] __alloc_pages+0xa4/0x350
Feb 19 21:53:19 dardhal kernel: [<c013ed1e>] do_anonymous_page+0x6e/0x190
Feb 19 21:53:19 dardhal kernel: [<c013eea1>] do_no_page+0x61/0x2d0
Feb 19 21:53:19 dardhal kernel: [<c013f300>] handle_mm_fault+0xf0/0x160
Feb 19 21:53:19 dardhal kernel: [<c0116a4c>] do_page_fault+0x12c/0x535
Feb 19 21:53:19 dardhal kernel: [<c0204024>] transmit_chars+0xa4/0xd0
Feb 19 21:53:19 dardhal kernel: [<c014bb0d>] sys_llseek+0xcd/0x100
Feb 19 21:53:19 dardhal kernel: [<c0116920>] do_page_fault+0x0/0x535
Feb 19 21:53:19 dardhal kernel: [<c0109915>] error_code+0x2d/0x38
Feb 19 21:53:19 dardhal kernel: 
Feb 19 21:53:19 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:53:20 dardhal kernel: Bad page state at free_hot_cold_page
Feb 19 21:53:20 dardhal kernel: flags:0x20000014 mapping:00000000 mapped:1 count:0
Feb 19 21:53:20 dardhal kernel: Backtrace:
Feb 19 21:53:20 dardhal kernel: Call Trace:
Feb 19 21:53:20 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:53:20 dardhal kernel: [<c0135ef3>] free_hot_cold_page+0x53/0xe0
Feb 19 21:53:20 dardhal kernel: [<c013dad8>] zap_pte_range+0x138/0x180
Feb 19 21:53:20 dardhal kernel: [<c013db6b>] zap_pmd_range+0x4b/0x70
Feb 19 21:53:20 dardhal kernel: [<c013dbd3>] unmap_page_range+0x43/0x70
Feb 19 21:53:20 dardhal kernel: [<c013dccf>] unmap_vmas+0xcf/0x220
Feb 19 21:53:20 dardhal kernel: [<c01417e0>] exit_mmap+0x70/0x180
Feb 19 21:53:20 dardhal kernel: [<c0119e4e>] mmput+0x4e/0x90
Feb 19 21:53:20 dardhal kernel: [<c011d778>] do_exit+0x128/0x310
Feb 19 21:53:20 dardhal kernel: [<c011da24>] do_group_exit+0x54/0x80
Feb 19 21:53:20 dardhal kernel: [<c0126240>] get_signal_to_deliver+0x1c0/0x300
Feb 19 21:53:20 dardhal kernel: [<c0108d2d>] do_signal+0xdd/0x110
Feb 19 21:53:20 dardhal kernel: [<c020401a>] transmit_chars+0x9a/0xd0
Feb 19 21:53:20 dardhal kernel: [<c02041b7>] serial8250_interrupt+0x27/0xc0
Feb 19 21:53:20 dardhal kernel: [<c010b18a>] handle_IRQ_event+0x3a/0x70
Feb 19 21:53:20 dardhal kernel: [<c010b4c2>] do_IRQ+0x92/0xf0
Feb 19 21:53:20 dardhal kernel: [<c0116920>] do_page_fault+0x0/0x535
Feb 19 21:53:20 dardhal kernel: [<c0108db6>] do_notify_resume+0x56/0x58
Feb 19 21:53:20 dardhal kernel: [<c0108f56>] work_notifysig+0x13/0x15
Feb 19 21:53:20 dardhal kernel: 
Feb 19 21:53:20 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:53:20 dardhal kernel: Bad page state at prep_new_page
Feb 19 21:53:20 dardhal kernel: flags:0x20000004 mapping:00000000 mapped:1 count:0
Feb 19 21:53:20 dardhal kernel: Backtrace:
Feb 19 21:53:20 dardhal kernel: Call Trace:
Feb 19 21:53:20 dardhal kernel: [<c01358cd>] bad_page+0x5d/0x90
Feb 19 21:53:20 dardhal kernel: [<c0135be2>] prep_new_page+0x32/0x60
Feb 19 21:53:20 dardhal kernel: [<c013603e>] buffered_rmqueue+0x9e/0x110
Feb 19 21:53:20 dardhal kernel: [<c0136154>] __alloc_pages+0xa4/0x350
Feb 19 21:53:20 dardhal kernel: [<c0132e80>] file_read_actor+0x0/0xf0
Feb 19 21:53:20 dardhal kernel: [<c013ed1e>] do_anonymous_page+0x6e/0x190
Feb 19 21:53:20 dardhal kernel: [<c013eea1>] do_no_page+0x61/0x2d0
Feb 19 21:53:20 dardhal kernel: [<c013f300>] handle_mm_fault+0xf0/0x160
Feb 19 21:53:20 dardhal kernel: [<c0116a4c>] do_page_fault+0x12c/0x535
Feb 19 21:53:20 dardhal kernel: [<c0123086>] update_process_times+0x46/0x60
Feb 19 21:53:20 dardhal kernel: [<c0122eeb>] update_wall_time+0xb/0x40
Feb 19 21:53:20 dardhal kernel: [<c012331f>] do_timer+0xdf/0xf0
Feb 19 21:53:20 dardhal kernel: [<c010b4f9>] do_IRQ+0xc9/0xf0
Feb 19 21:53:20 dardhal kernel: [<c0116920>] do_page_fault+0x0/0x535
Feb 19 21:53:20 dardhal kernel: [<c0109915>] error_code+0x2d/0x38
Feb 19 21:53:20 dardhal kernel: 
Feb 19 21:53:20 dardhal kernel: Trying to fix it up, but a reboot is needed
Feb 19 21:53:49 dardhal kernel: VM: killing process spamassassin
Feb 19 21:53:49 dardhal kernel: swap_free: Bad swap offset entry 00080000


Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.2-bk3)
