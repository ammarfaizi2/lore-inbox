Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTLBB0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 20:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTLBB0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 20:26:18 -0500
Received: from viefep13-int.chello.at ([213.46.255.15]:14107 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id S261827AbTLBB0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 20:26:06 -0500
Date: Tue, 2 Dec 2003 02:26:11 +0100
To: linux-kernel@vger.kernel.org
Subject: gathering of oopses in /var/log/messages
Message-ID: <20031202012611.GA975@lazy.shacknet.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: root <root@lazy.shacknet.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello list,

I have been running the test releases on my home system since they
started. Just to not have to patch xfs, and finally have multiple opens
on audio devices.

there have been some crashes though. now I found out, where the oopses
live. and there are lots of them :)

I write to you, because I read, the preempt feature was unstable in
concert with certain config options/drivers.

I cannot rule out faulty memory chips, as the system has the cheapest
ones, with the name of the manufacturer overwritten/engraved with
another name. they even fail the bios test: but then the system runs for
days, mostly when not watching any video.

chkrootkit has nothing suspicious to report.

attached excerpts from /var/log/messages: both with test11. the first
without the nvidia driver, the second with it. otherwise same config:
preemption, acpi, xfs, alsa etc.etc.

uname -a gives: (compiled with gcc3.3.2 from current debian unstable)
Linux lazy 2.6.0-test11 #4 Fri Nov 28 17:50:26 CET 2003 i686 GNU/Linux

the attachments:

messagesX - which has 2 consecutive oopses. I cant remember, what
happened then; but it looks like it ended in a reboot.  the preceding
messages were all from bttv. this may or may not be a coincidence.

messagesY - first messages were unnoticed, got noticed like that:
mozilla firebird froze.  other programs, that already ran, kept running,
but every attempt to start a new process failed with a memory fault
(thats the ksh talk).

not attached for size reasons .config; maybe grep -v "is not set" was
nice; will be delivered on request.

If the kernel is at fault, I hope this can help find the specifics.

regards.

hungerburg

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=messagesX

Nov 30 23:51:08 lazy -- MARK --
Nov 30 23:58:21 lazy kernel:  printing eip:
Nov 30 23:58:21 lazy kernel: c0161b76
Nov 30 23:58:21 lazy kernel: Oops: 0002 [#1]
Nov 30 23:58:21 lazy kernel: CPU:    0
Nov 30 23:58:21 lazy kernel: EIP:    0060:[prune_dcache+54/448]    Not tainted
Nov 30 23:58:21 lazy kernel: EFLAGS: 00010206
Nov 30 23:58:21 lazy kernel: EIP is at prune_dcache+0x36/0x1c0
Nov 30 23:58:21 lazy kernel: eax: c02f2030   ebx: c37883c0   ecx: c37880cc   edx: 14000808
Nov 30 23:58:21 lazy kernel: esi: c13f2000   edi: c13f2000   ebp: 0000001e   esp: c13f3e78
Nov 30 23:58:21 lazy kernel: ds: 007b   es: 007b   ss: 0068
Nov 30 23:58:21 lazy kernel: Process kswapd0 (pid: 7, threadinfo=c13f2000 task=c13f72e0)
Nov 30 23:58:21 lazy kernel: Stack: c1132f90 c10750a8 00000080 c13f2000 00000024 cffeeb60 c016213f 00000080 
Nov 30 23:58:21 lazy kernel:        00000080 c013adee 00000080 000000d0 0000dd35 0047651c 00000000 00000052 
Nov 30 23:58:21 lazy kernel:        00000000 00000299 c02f0f74 00000001 ffffff07 c013c0f2 00000299 000000d0 
Nov 30 23:58:21 lazy kernel: Call Trace:
Nov 30 23:58:21 lazy kernel:  [shrink_dcache_memory+63/80] shrink_dcache_memory+0x3f/0x50
Nov 30 23:58:21 lazy kernel:  [shrink_slab+270/352] shrink_slab+0x10e/0x160
Nov 30 23:58:21 lazy kernel:  [balance_pgdat+466/512] balance_pgdat+0x1d2/0x200
Nov 30 23:58:21 lazy kernel:  [kswapd+252/256] kswapd+0xfc/0x100
Nov 30 23:58:21 lazy kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Nov 30 23:58:21 lazy kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Nov 30 23:58:21 lazy kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Nov 30 23:58:21 lazy kernel:  [kswapd+0/256] kswapd+0x0/0x100
Nov 30 23:58:21 lazy kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Nov 30 23:58:21 lazy kernel: 
Nov 30 23:58:21 lazy kernel: Code: 89 02 89 49 04 89 09 a1 34 20 2f c0 8d 44 20 00 ff 0d 3c 20 
Nov 30 23:58:21 lazy kernel:  <6>note: kswapd0[7] exited with preempt_count 1
Nov 30 23:58:21 lazy kernel:  printing eip:
Nov 30 23:58:21 lazy kernel: c0161fd6
Nov 30 23:58:21 lazy kernel: Oops: 0000 [#2]
Nov 30 23:58:21 lazy kernel: CPU:    0
Nov 30 23:58:21 lazy kernel: EIP:    0060:[select_parent+86/176]    Not tainted
Nov 30 23:58:21 lazy kernel: EFLAGS: 00010246
Nov 30 23:58:21 lazy kernel: EIP is at select_parent+0x56/0xb0
Nov 30 23:58:21 lazy kernel: eax: 14000808   ebx: c09079c0   ecx: c09079cc   edx: c09076cc
Nov 30 23:58:21 lazy kernel: esi: c0907d94   edi: c09073c0   ebp: c09073dc   esp: c12bbed4
Nov 30 23:58:21 lazy kernel: ds: 007b   es: 007b   ss: 0068
Nov 30 23:58:21 lazy kernel: Process init (pid: 1, threadinfo=c12ba000 task=c12b98c0)
Nov 30 23:58:21 lazy kernel: Stack: 00000000 c09073c0 c13f72e0 c09073c0 00000007 c0162040 c09073c0 c09073c0 
Nov 30 23:58:21 lazy kernel:        c0175797 c09073c0 c12ba000 c011b5af c09073c0 c12b9e84 c13f72e0 bffff6ec 
Nov 30 23:58:21 lazy kernel:        00000000 c011cde8 c13f72e0 c12b9e84 c12bbfc4 00000011 00000000 c13f72e0 
Nov 30 23:58:21 lazy kernel: Call Trace:
Nov 30 23:58:21 lazy kernel:  [shrink_dcache_parent+16/48] shrink_dcache_parent+0x10/0x30
Nov 30 23:58:21 lazy kernel:  [proc_pid_flush+23/48] proc_pid_flush+0x17/0x30
Nov 30 23:58:21 lazy kernel:  [release_task+335/464] release_task+0x14f/0x1d0
Nov 30 23:58:21 lazy kernel:  [wait_task_zombie+360/464] wait_task_zombie+0x168/0x1d0
Nov 30 23:58:21 lazy kernel:  [sys_wait4+538/624] sys_wait4+0x21a/0x270
Nov 30 23:58:21 lazy kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Nov 30 23:58:21 lazy kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Nov 30 23:58:21 lazy kernel:  [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
Nov 30 23:58:21 lazy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 30 23:58:21 lazy kernel: 
Nov 30 23:58:21 lazy kernel: Code: 8b 10 89 4a 04 89 53 0c 89 41 04 89 08 ff 04 24 ff 05 3c 20 
Nov 30 23:58:21 lazy kernel:  <0>Kernel panic: Attempted to kill init!
Nov 30 23:58:21 lazy kernel: Call Trace:
Nov 30 23:58:21 lazy kernel:  [schedule+1373/1392] schedule+0x55d/0x570
Nov 30 23:58:21 lazy kernel:  [__down+134/256] __down+0x86/0x100
Nov 30 23:58:21 lazy kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Nov 30 23:58:21 lazy kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
[reboot]

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=messagesY

Dec  1 11:52:40 lazy -- MARK --
Dec  1 11:58:01 lazy kernel: Bad page state at free_hot_cold_page
Dec  1 11:58:01 lazy kernel: flags:0x01010014 mapping:00000000 mapped:1 count:0
Dec  1 11:58:01 lazy kernel: Backtrace:
Dec  1 11:58:01 lazy kernel: Call Trace:
Dec  1 11:58:01 lazy kernel:  [bad_page+93/144] bad_page+0x5d/0x90
Dec  1 11:58:01 lazy kernel:  [free_hot_cold_page+82/256] free_hot_cold_page+0x52/0x100
Dec  1 11:58:01 lazy kernel:  [zap_pte_range+322/384] zap_pte_range+0x142/0x180
Dec  1 11:58:01 lazy kernel:  [zap_pmd_range+75/112] zap_pmd_range+0x4b/0x70
Dec  1 11:58:01 lazy kernel:  [unmap_page_range+67/112] unmap_page_range+0x43/0x70
Dec  1 11:58:01 lazy kernel:  [unmap_vmas+229/528] unmap_vmas+0xe5/0x210
Dec  1 11:58:01 lazy kernel:  [exit_mmap+123/400] exit_mmap+0x7b/0x190
Dec  1 11:58:01 lazy kernel:  [mmput+100/192] mmput+0x64/0xc0
Dec  1 11:58:01 lazy kernel:  [exec_mmap+181/304] exec_mmap+0xb5/0x130
Dec  1 11:58:01 lazy kernel:  [flush_old_exec+300/2112] flush_old_exec+0x12c/0x840
Dec  1 11:58:01 lazy kernel:  [kernel_read+80/96] kernel_read+0x50/0x60
Dec  1 11:58:01 lazy kernel:  [load_elf_binary+719/2928] load_elf_binary+0x2cf/0xb70
Dec  1 11:58:01 lazy kernel:  [linvfs_open+116/128] linvfs_open+0x74/0x80
Dec  1 11:58:01 lazy kernel:  [kernel_read+80/96] kernel_read+0x50/0x60
Dec  1 11:58:01 lazy kernel:  [load_elf_binary+0/2928] load_elf_binary+0x0/0xb70
Dec  1 11:58:01 lazy kernel:  [search_binary_handler+117/480] search_binary_handler+0x75/0x1e0
Dec  1 11:58:01 lazy kernel:  [load_script+520/576] load_script+0x208/0x240
Dec  1 11:58:01 lazy kernel:  [__alloc_pages+166/800] __alloc_pages+0xa6/0x320
Dec  1 11:58:01 lazy kernel:  [copy_strings+404/544] copy_strings+0x194/0x220
Dec  1 11:58:01 lazy kernel:  [load_script+0/576] load_script+0x0/0x240
Dec  1 11:58:01 lazy kernel:  [search_binary_handler+117/480] search_binary_handler+0x75/0x1e0
Dec  1 11:58:01 lazy kernel:  [do_execve+498/592] do_execve+0x1f2/0x250
Dec  1 11:58:01 lazy kernel:  [sys_execve+66/128] sys_execve+0x42/0x80
Dec  1 11:58:01 lazy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec  1 11:58:01 lazy kernel:
[ some binary garbage snipped ]
Dec  1 11:58:02 lazy kernel:  [sys_select+719/1264] sys_select+0x2cf/0x4f0
Dec  1 11:58:02 lazy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec  1 11:58:02 lazy kernel: 
Dec  1 11:58:02 lazy kernel: Trying to fix it up, but a reboot is needed
[ and many more of those, all in the same second ]
[ later, no reboot (this isnt macos7 ! ]
Dec  1 16:52:41 lazy -- MARK --
Dec  1 17:06:53 lazy kernel: Bad page state at free_hot_cold_page
Dec  1 17:06:53 lazy kernel: flags:0x01000008 mapping:cf571268 mapped:0 count:0
Dec  1 17:06:53 lazy kernel: Backtrace:
Dec  1 17:06:53 lazy kernel: Call Trace:
Dec  1 17:06:53 lazy kernel:  [bad_page+93/144] bad_page+0x5d/0x90
Dec  1 17:06:53 lazy kernel:  [free_hot_cold_page+82/256] free_hot_cold_page+0x52/0x100
Dec  1 17:06:53 lazy kernel:  [__pagevec_free+28/48] __pagevec_free+0x1c/0x30
Dec  1 17:06:53 lazy kernel:  [release_pages+119/368] release_pages+0x77/0x170
Dec  1 17:06:53 lazy kernel:  [__pagevec_release+40/64] __pagevec_release+0x28/0x40
Dec  1 17:06:53 lazy kernel:  [shrink_cache+658/768] shrink_cache+0x292/0x300
Dec  1 17:06:53 lazy kernel:  [balance_pgdat+372/512] balance_pgdat+0x174/0x200
Dec  1 17:06:53 lazy kernel:  [kswapd+252/256] kswapd+0xfc/0x100
Dec  1 17:06:53 lazy kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Dec  1 17:06:53 lazy kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Dec  1 17:06:53 lazy kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Dec  1 17:06:53 lazy kernel:  [kswapd+0/256] kswapd+0x0/0x100
Dec  1 17:06:53 lazy kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Dec  1 17:06:53 lazy kernel: 
Dec  1 17:06:53 lazy kernel: Trying to fix it up, but a reboot is needed
Dec  1 17:07:07 lazy kernel:  printing eip:
Dec  1 17:07:07 lazy kernel: c016b3f5
Dec  1 17:07:07 lazy kernel: Oops: 0000 [#1]
Dec  1 17:07:07 lazy kernel: CPU:    0
Dec  1 17:07:07 lazy kernel: EIP:    0060:[mpage_readpages+69/368]    Tainted: P  
Dec  1 17:07:07 lazy kernel: EFLAGS: 00210297
Dec  1 17:07:07 lazy kernel: EIP is at mpage_readpages+0x45/0x170
Dec  1 17:07:07 lazy kernel: eax: c7c97e4c   ebx: 00200200   ecx: 00000000   edx: ffffffef
Dec  1 17:07:07 lazy kernel: esi: 002001f8   edi: 00000002   ebp: 00000008   esp: c7c97d3c
Dec  1 17:07:07 lazy kernel: ds: 007b   es: 007b   ss: 0068
Dec  1 17:07:07 lazy kernel: Process MozillaFirebird (pid: 1517, threadinfo=c7c96000 task=c39900c0)
Dec  1 17:07:07 lazy kernel: Stack: c7c97e44 c68d88e8 00000000 000000d0 c01e1c10 cffc8640 00014a29 00000001 
Dec  1 17:07:07 lazy kernel:        00000000 c10a6d60 00000000 cd753360 00000001 c7c97d9c c0116467 cd753360 
Dec  1 17:07:07 lazy kernel:        c7c97da0 c011629e cd753360 821bd2da ccc30540 c39900c0 c39900e0 cd2b5eb0 
Dec  1 17:07:07 lazy kernel: Call Trace:
Dec  1 17:07:07 lazy kernel:  [linvfs_get_block+0/80] linvfs_get_block+0x0/0x50
Dec  1 17:07:07 lazy kernel:  [try_to_wake_up+167/352] try_to_wake_up+0xa7/0x160
Dec  1 17:07:07 lazy kernel:  [recalc_task_prio+142/432] recalc_task_prio+0x8e/0x1b0
Dec  1 17:07:07 lazy kernel:  [schedule+761/1392] schedule+0x2f9/0x570
Dec  1 17:07:07 lazy kernel:  [read_pages+312/336] read_pages+0x138/0x150
Dec  1 17:07:07 lazy kernel:  [linvfs_get_block+0/80] linvfs_get_block+0x0/0x50
Dec  1 17:07:07 lazy kernel:  [__alloc_pages+166/800] __alloc_pages+0xa6/0x320
Dec  1 17:07:07 lazy kernel:  [do_page_cache_readahead+244/368] do_page_cache_readahead+0xf4/0x170
Dec  1 17:07:07 lazy kernel:  [filemap_nopage+265/768] filemap_nopage+0x109/0x300
Dec  1 17:07:07 lazy kernel:  [do_no_page+192/848] do_no_page+0xc0/0x350
Dec  1 17:07:07 lazy kernel:  [linvfs_file_mmap+124/240] linvfs_file_mmap+0x7c/0xf0
Dec  1 17:07:07 lazy kernel:  [handle_mm_fault+212/368] handle_mm_fault+0xd4/0x170
Dec  1 17:07:07 lazy kernel:  [do_page_fault+812/1292] do_page_fault+0x32c/0x50c
Dec  1 17:07:07 lazy kernel:  [do_mmap_pgoff+870/1664] do_mmap_pgoff+0x366/0x680
Dec  1 17:07:07 lazy kernel:  [filp_close+89/144] filp_close+0x59/0x90
Dec  1 17:07:07 lazy kernel:  [do_page_fault+0/1292] do_page_fault+0x0/0x50c
Dec  1 17:07:07 lazy kernel:  [error_code+45/56] error_code+0x2d/0x38
Dec  1 17:07:07 lazy kernel: 
Dec  1 17:07:07 lazy kernel: Code: 8b 03 8b 53 04 89 50 04 89 02 c7 43 04 00 02 20 00 c7 03 00 
Dec  1 17:08:01 lazy kernel:  Bad page state at prep_new_page
[soon to crash ...]

--oyUTqETQ0mS9luUI--
