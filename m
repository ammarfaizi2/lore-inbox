Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVAKJ7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVAKJ7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVAKJ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:59:19 -0500
Received: from rotfl.wrota.net ([81.21.195.197]:16803 "EHLO wrota.net")
	by vger.kernel.org with ESMTP id S262663AbVAKJ7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:59:08 -0500
Date: Tue, 11 Jan 2005 10:59:08 +0100
From: Daniel Fenert <daniel@fenert.net>
To: linux-kernel@vger.kernel.org
Subject: "kernel BUG at mm/rmap.c:474!" error on 2.6.9
Message-ID: <20050111095908.GA5041@fenert.net>
Mail-Followup-To: Daniel Fenert <daniel@fenert.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Organization: WROTA.net
X-Operating-System: Linux 2.4.26
X-Wyslij-mi-SMSa: Lepiej nie...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What could be the real cause of such messages? (I assume that it was not
really apache or php fault (httpd and php shown in logs below)).

Kernel 2.6.9, SATA drive on intel chipset (ICH5), processor is P4 with HT,
1GB of memory. Glibc 2.3.2, gcc version 3.3.4.

On console I've got:
Message from syslogd@sh at Tue Jan 11 10:01:01 2005 ...
sh kernel: Bad page state at prep_new_page (in process 'php', page c17b4580)

Message from syslogd@sh at Tue Jan 11 10:01:01 2005 ...
sh kernel: flags:0x40000114 mapping:00000000 mapcount:-1 count:0

Message from syslogd@sh at Tue Jan 11 10:01:01 2005 ...
sh kernel: Backtrace:

Message from syslogd@sh at Tue Jan 11 10:01:01 2005 ...
sh kernel: Trying to fix it up, but a reboot is needed

>From logs:
Jan 11 10:00:44 sh kernel: ------------[ cut here ]------------
Jan 11 10:00:44 sh kernel: kernel BUG at mm/rmap.c:474!
Jan 11 10:00:44 sh kernel: invalid operand: 0000 [#1]
Jan 11 10:00:44 sh kernel: PREEMPT SMP
Jan 11 10:00:44 sh kernel: Modules linked in: i8xx_tco ide_scsi e1000
Jan 11 10:00:44 sh kernel: CPU:    0
Jan 11 10:00:44 sh kernel: EIP:    0060:[<c014ea30>]    Not tainted VLI
Jan 11 10:00:44 sh kernel: EFLAGS: 00010286   (2.6.9)
Jan 11 10:00:44 sh kernel: EIP is at page_remove_rmap+0x3f/0x53
Jan 11 10:00:44 sh kernel: eax: ffffffff   ebx: 00000000   ecx: c17b4580 edx: c17b4580
Jan 11 10:00:44 sh kernel: esi: de3dd27c   edi: c17b4580   ebp: 00000020 esp: ce236e84
Jan 11 10:00:44 sh kernel: ds: 007b   es: 007b   ss: 0068
Jan 11 10:00:44 sh kernel: Process httpd (pid: 13984, threadinfo=ce236000 task=d01ff730)
Jan 11 10:00:44 sh kernel: Stack: c01485b5 c17b4580 00000000 e4efcf3c c0125ffc b7c9f000 d6773b7c b78a0000
Jan 11 10:00:44 sh kernel:        00000000 c0148789 c180f400 d6773b78 b789f000 00001000 00000000 c180f400
Jan 11 10:00:44 sh kernel:        b789f000 d6773b7c b78a0000 00000000 c01487f0 c180f400 d6773b78 b789f000
Jan 11 10:00:44 sh kernel: Call Trace:
Jan 11 10:00:44 sh kernel:  [<c01485b5>] zap_pte_range+0x13f/0x2bc
Jan 11 10:00:44 sh kernel:  [<c0125ffc>] update_process_times+0x45/0x51
Jan 11 10:00:44 sh kernel:  [<c0148789>] zap_pmd_range+0x57/0x73
Jan 11 10:00:44 sh kernel:  [<c01487f0>] unmap_page_range+0x4b/0x71
Jan 11 10:00:44 sh kernel:  [<c0148917>] unmap_vmas+0x101/0x20e
Jan 11 10:00:44 sh kernel:  [<c014cd36>] exit_mmap+0xa5/0x187
Jan 11 10:00:44 sh kernel:  [<c011b93b>] mmput+0x66/0x91
Jan 11 10:00:44 sh kernel:  [<c0120015>] do_exit+0x17b/0x42a
Jan 11 10:00:44 sh kernel:  [<c0120370>] do_group_exit+0x3c/0xa7
Jan 11 10:00:44 sh kernel:  [<c01050fb>] syscall_call+0x7/0xb
Jan 11 10:00:44 sh kernel: Code: c0 74 27 8b 42 08 83 c0 01 78 20 9c 59 fa b8 00 f0 ff ff ba 20 7c 47 c0 21 e0 8b 40 10 03 14 85 20 b0 47 c0 83 6a 10 01 51 9d c3 <0f> 0b da 01 1d 31 36 c0 eb d6 0f 0b d7 01 1d 31 36 c0 eb b8 83
Jan 11 10:00:44 sh kernel:  <6>note: httpd[13984] exited with preempt_count 1
Jan 11 10:01:01 sh kernel: Bad page state at prep_new_page (in process 'php', page c17b4580)
Jan 11 10:01:01 sh kernel: flags:0x40000114 mapping:00000000 mapcount:-1 count:0
Jan 11 10:01:01 sh kernel: Backtrace:
Jan 11 10:01:01 sh kernel:  [<c013e547>] bad_page+0x78/0xa4
Jan 11 10:01:01 sh kernel:  [<c013e8a6>] prep_new_page+0x32/0x51
Jan 11 10:01:01 sh kernel:  [<c013edf4>] buffered_rmqueue+0x10f/0x1fa
Jan 11 10:01:01 sh kernel:  [<c013f216>] __alloc_pages+0x337/0x358
Jan 11 10:01:01 sh kernel:  [<c0149c6e>] do_anonymous_page+0x98/0x1a5
Jan 11 10:01:01 sh kernel:  [<c0149dde>] do_no_page+0x63/0x324
Jan 11 10:01:01 sh kernel:  [<c014a29b>] handle_mm_fault+0xf4/0x16c
Jan 11 10:01:01 sh kernel:  [<c011713e>] do_page_fault+0x39d/0x5a4
Jan 11 10:01:01 sh kernel:  [<c01cfaba>] journal_stop+0x1ad/0x26e
Jan 11 10:01:01 sh kernel:  [<c01c4224>] ext3_mark_iloc_dirty+0x29/0x37
Jan 11 10:01:01 sh kernel:  [<c01c434d>] ext3_mark_inode_dirty+0x4f/0x51
Jan 11 10:01:01 sh kernel:  [<c01c862d>] __ext3_journal_stop+0x24/0x50
Jan 11 10:01:01 sh kernel:  [<c01c43b8>] ext3_dirty_inode+0x69/0x87
Jan 11 10:01:01 sh kernel:  [<c0116da1>] do_page_fault+0x0/0x5a4
Jan 11 10:01:01 sh kernel:  [<c0105b85>] error_code+0x2d/0x38
Jan 11 10:01:01 sh kernel:  [<c013b475>] file_read_actor+0x20/0xec
Jan 11 10:01:01 sh kernel:  [<c013b0bc>] do_generic_mapping_read+0x1a6/0x53f
Jan 11 10:01:01 sh kernel:  [<c013b735>] __generic_file_aio_read+0x1f4/0x226
Jan 11 10:01:01 sh kernel:  [<c013b455>] file_read_actor+0x0/0xec
Jan 11 10:01:01 sh kernel:  [<c016f2a0>] dput+0x24/0x1af
Jan 11 10:01:01 sh kernel:  [<c013b7c1>] generic_file_aio_read+0x5a/0x74
Jan 11 10:01:01 sh kernel:  [<c01580de>] do_sync_read+0xbe/0xeb
Jan 11 10:01:01 sh kernel:  [<c014bced>] do_mmap_pgoff+0x44e/0x735
Jan 11 10:01:01 sh kernel:  [<c011b636>] autoremove_wake_function+0x0/0x57
Jan 11 10:01:01 sh kernel:  [<c01581bb>] vfs_read+0xb0/0x119
Jan 11 10:01:01 sh kernel:  [<c0158479>] sys_read+0x51/0x80
Jan 11 10:01:01 sh kernel:  [<c01050fb>] syscall_call+0x7/0xb
Jan 11 10:01:01 sh kernel: Trying to fix it up, but a reboot is needed

And after ~15 minutes machine rebooted (possibly it was caused by i8xx_tco
module and softdog).

-- 
Daniel Fenert                 --==> daniel@fenert.net <==--
