Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUIXHy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUIXHy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 03:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUIXHy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 03:54:27 -0400
Received: from smtp1.telegraaf.nl ([217.196.45.193]:21669 "EHLO
	smtp1.telegraaf.nl") by vger.kernel.org with ESMTP id S268392AbUIXHyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 03:54:19 -0400
Date: Fri, 24 Sep 2004 09:54:16 +0200
From: Roel van der Made <roel@telegraafnet.nl>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.9-rc2-mm1 system hangup
Message-ID: <20040924075416.GH7334@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
X-telegraaf-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm having problems with servers hanging spontanely without any logging
or console output. They're running a 2.6.9-rc2-mm1 kernel and are Dell
PowerEdge 1750 dual Xeon servers with 4G ECC Reg. and 3 disks in
sw-raid 5.

The systems still responds to ping and listens to ie. the mysql port, but does
not give a MySQL prompt, seems the disks are in deadlock state or so ?

Using the sysrq showTasks I see the following traces (I will only show
some since the total log is much too long to show here, the full log
including the .config can be found on http://roel.net/backtrace/):

pdflush       D 00000008     0    56     15            57    23 (L-TLB)
f7ca7c10 00000046 f7ca7c00 00000008 00000003 00000000 00000000 6c4e4dc0
       00000011 c31c6000 00000000 00000000 f64ff800 00000000 00000000 00000000
       00000000 00000008 00000000 006d3803 00000013 c2fca020 00000003 c31c6154
Call Trace:
 [<c0361ce2>] __down+0x8e/0x10d
 [<c011818f>] default_wake_function+0x0/0x12
 [<c0361eb0>] __down_failed+0x8/0xc
 [<c03030fc>] .text.lock.md+0x9b/0xf3
 [<c02f9c92>] make_request+0x1df/0x226
 [<c026508f>] generic_make_request+0x113/0x194
 [<c01395d2>] mempool_alloc+0x8b/0x15d
 [<c012f9ab>] autoremove_wake_function+0x0/0x57
 [<c0265180>] submit_bio+0x70/0x121
 [<c0159707>] bio_alloc+0xd9/0x1ac
 [<c0158fba>] submit_bh+0xe0/0x133
 [<c019604a>] reiserfs_write_full_page+0x2eb/0x4d0
 [<c019626a>] reiserfs_writepage+0x26/0x3e
 [<c017659d>] mpage_writepages+0x207/0x3b2
 [<c0196244>] reiserfs_writepage+0x0/0x3e
 [<c016cabc>] d_rehash+0x55/0x79
 [<c017388b>] simple_lookup+0x40/0x44
 [<c013c17c>] do_writepages+0x3d/0x43
 [<c0174a37>] __sync_single_inode+0x66/0x1f1
 [<c0174c32>] __writeback_single_inode+0x70/0x157
 [<c0174ef6>] generic_sync_sb_inodes+0x1dd/0x2e7
 [<c013caa9>] pdflush+0x0/0x2c
 [<c01751ce>] sync_inodes_sb+0xba/0xc9
 [<c0175264>] get_super_to_sync+0x54/0x75
 [<c01752b0>] sync_inodes+0x2b/0x90
 [<c0155df5>] do_sync+0x23/0x74
 [<c013c9d7>] __pdflush+0xbf/0x191
 [<c013cad1>] pdflush+0x28/0x2c
 [<c0155dd2>] do_sync+0x0/0x74
 [<c013caa9>] pdflush+0x0/0x2c
 [<c012f4e5>] kthread+0xb7/0xbd
 [<c012f42e>] kthread+0x0/0xbd
 [<c0103f59>] kernel_thread_helper+0x5/0xb

sshd          D 00000008     0 24085   1220               24084 (NOTLB)
e8e59cac 00000082 e8e59c98 00000008 00000003 00000001 e9e60b7c bd0483c0
       00000004 e8e19000 e8e29900 e8e28440 e8e1b080 00000082 c04830c0 f3ff6550
       00000000 e9e60b7c e8e1b080 dcda1904 00000012 c2fca020 00000003 e8e19154
Call Trace:
 [<c0361ce2>] __down+0x8e/0x10d
 [<c011818f>] default_wake_function+0x0/0x12
 [<c0361eb0>] __down_failed+0x8/0xc
 [<c01b3474>] .text.lock.journal+0x4b/0xcb
 [<c01b1816>] journal_begin+0x6b/0xc3
 [<c019f63a>] reiserfs_dirty_inode+0x58/0xd3
 [<c0174982>] __mark_inode_dirty+0x1d2/0x1d7
 [<c016e996>] update_atime+0xd9/0xde
 [<c0136ac2>] do_generic_mapping_read+0x3cb/0x53d
 [<c0136f0f>] __generic_file_aio_read+0x1ef/0x22b
 [<c0136c34>] file_read_actor+0x0/0xec
 [<c01626ad>] link_path_walk+0x9ed/0xd38
 [<c0137079>] generic_file_read+0xba/0xd2
 [<c01473ff>] __vma_link+0x44/0x73
 [<c01481da>] do_mmap_pgoff+0x509/0x779
 [<c012f9ab>] autoremove_wake_function+0x0/0x57
 [<c015e3b2>] sys_fstat64+0x37/0x39
 [<c01546f3>] vfs_read+0xbc/0x127
 [<c01549c1>] sys_read+0x51/0x80
 [<c0105dab>] syscall_call+0x7/0xb

etc. not sure which are relevant here, so please look at the mentioned location above.

Thanks,

-- 
Roel van der Made                             .--.
GNU/Linux Systems/Network Engineer           |o_o |
Telegraaf Media ICT BV - Internet Services   |:_/ |
Tel.: +31 (0)20 585 2229                    //   \ \
GnuPG Key available at: http://roel.net/gpgkey.asc 
