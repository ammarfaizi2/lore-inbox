Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbVJ0WYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbVJ0WYi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbVJ0WYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:24:38 -0400
Received: from 81-5-177-201.dsl.eclipse.net.uk ([81.5.177.201]:64917 "EHLO
	hades.smop.co.uk") by vger.kernel.org with ESMTP id S1751250AbVJ0WYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:24:37 -0400
Date: Thu, 27 Oct 2005 23:24:24 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Badness in __writeback_single_inode
Message-ID: <20051027222424.GA7453@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: adrian <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just hit this too (2.6.14rc5-mm1) but in my case it's on NTFS
(mounted RO).  Kernel was compiled with Debian gcc 4.0.2-2 FWIW.

NTFS driver 2.1.25 [Flags: R/W MODULE].
Badness in __writeback_single_inode at fs/fs-writeback.c:251
 [<c0193dca>] __writeback_single_inode+0x1aa/0x1c0
 [<c02d04ee>] io_schedule+0xe/0x20
 [<c01944d8>] write_inode_now+0x58/0xe0
 [<c01895c7>] generic_forget_inode+0xb7/0x1b0
 [<f8df98e0>] load_and_init_upcase+0x370/0x4b0 [ntfs]
 [<f8dd5ac0>] ntfs_readpage+0x0/0x380 [ntfs]
 [<f8df9ad1>] load_system_files+0xb1/0xf40 [ntfs]
 [<f8dfcb18>] generate_default_upcase+0x38/0x120 [ntfs]
 [<f8dfbb78>] ntfs_fill_super+0x328/0x8d0 [ntfs]
 [<c01720bc>] get_sb_bdev+0x11c/0x160
 [<f8dfc170>] ntfs_get_sb+0x30/0x34 [ntfs]
 [<f8dfb850>] ntfs_fill_super+0x0/0x8d0 [ntfs]
 [<c0172399>] do_kern_mount+0xd9/0x190
 [<c018c98a>] do_new_mount+0x9a/0xe0
 [<c018d206>] do_mount+0x1c6/0x200
 [<c018cff7>] copy_mount_options+0x77/0xc0
 [<c018d69d>] sys_mount+0x9d/0xe0
 [<c01033d1>] syscall_call+0x7/0xb
Badness in __sync_single_inode at fs/fs-writeback.c:232
 [<c0193bcf>] __sync_single_inode+0x22f/0x280
 [<c0193c7b>] __writeback_single_inode+0x5b/0x1c0
 [<c02d04ee>] io_schedule+0xe/0x20
 [<c01944d8>] write_inode_now+0x58/0xe0
 [<c01895c7>] generic_forget_inode+0xb7/0x1b0
 [<f8df98e0>] load_and_init_upcase+0x370/0x4b0 [ntfs]
 [<f8dd5ac0>] ntfs_readpage+0x0/0x380 [ntfs]
 [<f8df9ad1>] load_system_files+0xb1/0xf40 [ntfs]
 [<f8dfcb18>] generate_default_upcase+0x38/0x120 [ntfs]
 [<f8dfbb78>] ntfs_fill_super+0x328/0x8d0 [ntfs]
 [<c01720bc>] get_sb_bdev+0x11c/0x160
 [<f8dfc170>] ntfs_get_sb+0x30/0x34 [ntfs]
 [<f8dfb850>] ntfs_fill_super+0x0/0x8d0 [ntfs]
 [<c0172399>] do_kern_mount+0xd9/0x190
 [<c018c98a>] do_new_mount+0x9a/0xe0
 [<c018d206>] do_mount+0x1c6/0x200
 [<c018cff7>] copy_mount_options+0x77/0xc0
 [<c018d69d>] sys_mount+0x9d/0xe0
 [<c01033d1>] syscall_call+0x7/0xb
Badness in __writeback_single_inode at fs/fs-writeback.c:251
 [<c0193dca>] __writeback_single_inode+0x1aa/0x1c0
 [<c02d04ee>] io_schedule+0xe/0x20
 [<c01944d8>] write_inode_now+0x58/0xe0
 [<c01895c7>] generic_forget_inode+0xb7/0x1b0
 [<f8df94f0>] load_and_init_attrdef+0x2b0/0x330 [ntfs]
 [<f8dd5ac0>] ntfs_readpage+0x0/0x380 [ntfs]
 [<f8df9ae1>] load_system_files+0xc1/0xf40 [ntfs]
 [<f8dfcb18>] generate_default_upcase+0x38/0x120 [ntfs]
 [<f8dfbb78>] ntfs_fill_super+0x328/0x8d0 [ntfs]
 [<c01720bc>] get_sb_bdev+0x11c/0x160
 [<f8dfc170>] ntfs_get_sb+0x30/0x34 [ntfs]
 [<f8dfb850>] ntfs_fill_super+0x0/0x8d0 [ntfs]
 [<c0172399>] do_kern_mount+0xd9/0x190
 [<c018c98a>] do_new_mount+0x9a/0xe0
 [<c018d206>] do_mount+0x1c6/0x200
 [<c018cff7>] copy_mount_options+0x77/0xc0
 [<c018d69d>] sys_mount+0x9d/0xe0
 [<c01033d1>] syscall_call+0x7/0xb
Badness in __sync_single_inode at fs/fs-writeback.c:232
 [<c0193bcf>] __sync_single_inode+0x22f/0x280
 [<c0193c7b>] __writeback_single_inode+0x5b/0x1c0
 [<c02d04ee>] io_schedule+0xe/0x20
 [<c01944d8>] write_inode_now+0x58/0xe0
 [<c01895c7>] generic_forget_inode+0xb7/0x1b0
 [<f8df94f0>] load_and_init_attrdef+0x2b0/0x330 [ntfs]
 [<f8dd5ac0>] ntfs_readpage+0x0/0x380 [ntfs]
 [<f8df9ae1>] load_system_files+0xc1/0xf40 [ntfs]
 [<f8dfcb18>] generate_default_upcase+0x38/0x120 [ntfs]
 [<f8dfbb78>] ntfs_fill_super+0x328/0x8d0 [ntfs]
 [<c01720bc>] get_sb_bdev+0x11c/0x160
 [<f8dfc170>] ntfs_get_sb+0x30/0x34 [ntfs]
 [<f8dfb850>] ntfs_fill_super+0x0/0x8d0 [ntfs]
 [<c0172399>] do_kern_mount+0xd9/0x190
 [<c018c98a>] do_new_mount+0x9a/0xe0
 [<c018d206>] do_mount+0x1c6/0x200
 [<c018cff7>] copy_mount_options+0x77/0xc0
 [<c018d69d>] sys_mount+0x9d/0xe0
 [<c01033d1>] syscall_call+0x7/0xb
NTFS volume version 3.1.
NTFS-fs warning (device hda2): load_system_files(): $LogFile is not clean.  Will not be able to remount read-write.  Mount in Windows.
Badness in __writeback_single_inode at fs/fs-writeback.c:251
 [<c0193dca>] __writeback_single_inode+0x1aa/0x1c0
 [<c02d04ee>] io_schedule+0xe/0x20
 [<c01944d8>] write_inode_now+0x58/0xe0
 [<c01895c7>] generic_forget_inode+0xb7/0x1b0
 [<f8df8b01>] check_windows_hibernation_status+0x271/0x2e0 [ntfs]
 [<f8dd5ac0>] ntfs_readpage+0x0/0x380 [ntfs]
 [<f8dfa22c>] load_system_files+0x80c/0xf40 [ntfs]
 [<f8dfbb78>] ntfs_fill_super+0x328/0x8d0 [ntfs]
 [<c01720bc>] get_sb_bdev+0x11c/0x160
 [<f8dfc170>] ntfs_get_sb+0x30/0x34 [ntfs]
 [<f8dfb850>] ntfs_fill_super+0x0/0x8d0 [ntfs]
 [<c0172399>] do_kern_mount+0xd9/0x190
 [<c018c98a>] do_new_mount+0x9a/0xe0
 [<c018d206>] do_mount+0x1c6/0x200
 [<c018cff7>] copy_mount_options+0x77/0xc0
 [<c018d69d>] sys_mount+0x9d/0xe0
 [<c01033d1>] syscall_call+0x7/0xb
Badness in __sync_single_inode at fs/fs-writeback.c:232
 [<c0193bcf>] __sync_single_inode+0x22f/0x280
 [<c0193c7b>] __writeback_single_inode+0x5b/0x1c0
 [<c02d04ee>] io_schedule+0xe/0x20
 [<c01944d8>] write_inode_now+0x58/0xe0
 [<c01895c7>] generic_forget_inode+0xb7/0x1b0
 [<f8df8b01>] check_windows_hibernation_status+0x271/0x2e0 [ntfs]
 [<f8dd5ac0>] ntfs_readpage+0x0/0x380 [ntfs]
 [<f8dfa22c>] load_system_files+0x80c/0xf40 [ntfs]
 [<f8dfbb78>] ntfs_fill_super+0x328/0x8d0 [ntfs]
 [<c01720bc>] get_sb_bdev+0x11c/0x160
 [<f8dfc170>] ntfs_get_sb+0x30/0x34 [ntfs]
 [<f8dfb850>] ntfs_fill_super+0x0/0x8d0 [ntfs]
 [<c0172399>] do_kern_mount+0xd9/0x190
 [<c018c98a>] do_new_mount+0x9a/0xe0
 [<c018d206>] do_mount+0x1c6/0x200
 [<c018cff7>] copy_mount_options+0x77/0xc0
 [<c018d69d>] sys_mount+0x9d/0xe0
 [<c01033d1>] syscall_call+0x7/0xb
NTFS-fs warning (device hda2): load_system_files(): Windows is hibernated.  Will not be able to remount read-write.  Run chkdsk.

