Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUBSTOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUBSTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:14:33 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:9710 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S267478AbUBSTOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:14:08 -0500
From: Gertjan van Wingerde <gwingerde@home.nl>
To: linux-kernel@vger.kernel.org
Subject: Ext3 and/or SCSI bug?
Date: Thu, 19 Feb 2004 20:11:40 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402192011.40854.gwingerde@home.nl>
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

(Please CC: me on replies, I'm not subscribed to the list)

Below is an part of my dmesg output that I captured when all of a sudden one
of my filesystems became mounted read-only (while some heavy reading/
writing was being performed to that filesystem).

Can anyone explain to me what is going on here, and why this is happening 
to me about every 10 days.
Please note that this happened twice now in the last 10 days, both while 
running kernel version 2.6.2 and kernel 2.6.3 (for the last day). After the first
time I've fsck'ed the file-system thoroughly.

System details:
Dual Athlon MP2000+, Asus A7M266-D motherboard.
QLA12160 based SCSI card connected to 3 Maxtor Atlas IV 10K RPM drives.

	Best regards,

		Gertjan.

Kernel output:

 EXT3-fs error (device sdb8): ext3_free_blocks: bit already cleared for block 1142880
 Aborting journal on device sdb8.
 bad: scheduling while atomic!
 Call Trace:
  [<c012049e>] schedule+0x68e/0x6a0
  [<c021cce0>] scsi_request_fn+0x240/0x390
  [<c020d49d>] generic_unplug_device+0x8d/0x90
  [<c0121776>] io_schedule+0x26/0x40
  [<c0163574>] __wait_on_buffer+0xc4/0xd0
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c016754b>] sync_dirty_buffer+0x4b/0xb0
  [<c01bb5d5>] journal_update_superblock+0x95/0x130
  [<c01ac5f9>] ext3_handle_error+0x59/0xb0
  [<c01ac6a5>] ext3_error+0x55/0x60
  [<c01a0d03>] ext3_free_blocks+0x523/0x5d0
  [<c01a6958>] ext3_free_data+0x128/0x150
  [<c01a6a6e>] ext3_free_branches+0xee/0x270
  [<c01a715e>] ext3_truncate+0x56e/0x670
  [<c01b34b9>] journal_start+0xa9/0xd0
  [<c01a4203>] start_transaction+0x23/0x60
  [<c01a4396>] ext3_delete_inode+0xc6/0x110
  [<c01a42d0>] ext3_delete_inode+0x0/0x110
  [<c017efcb>] generic_delete_inode+0xab/0x190
  [<c017f2b2>] iput+0x62/0x90
  [<c017b855>] dput+0x115/0x250
  [<c0174a6e>] sys_rename+0x1fe/0x220
  [<c0154e5f>] do_munmap+0x16f/0x1e0
  [<c0154f15>] sys_munmap+0x45/0x70
  [<c010959b>] syscall_call+0x7/0xb
 
 bad: scheduling while atomic!
 Call Trace:
  [<c012049e>] schedule+0x68e/0x6a0
  [<c020ec2a>] generic_make_request+0x16a/0x1f0
  [<c0121776>] io_schedule+0x26/0x40
  [<c0163574>] __wait_on_buffer+0xc4/0xd0
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c016754b>] sync_dirty_buffer+0x4b/0xb0
  [<c01ac60d>] ext3_handle_error+0x6d/0xb0
  [<c01ac6a5>] ext3_error+0x55/0x60
  [<c01a0d03>] ext3_free_blocks+0x523/0x5d0
  [<c01a6958>] ext3_free_data+0x128/0x150
  [<c01a6a6e>] ext3_free_branches+0xee/0x270
  [<c01a715e>] ext3_truncate+0x56e/0x670
  [<c01b34b9>] journal_start+0xa9/0xd0
  [<c01a4203>] start_transaction+0x23/0x60
  [<c01a4396>] ext3_delete_inode+0xc6/0x110
  [<c01a42d0>] ext3_delete_inode+0x0/0x110
  [<c017efcb>] generic_delete_inode+0xab/0x190
  [<c017f2b2>] iput+0x62/0x90
  [<c017b855>] dput+0x115/0x250
  [<c0174a6e>] sys_rename+0x1fe/0x220
  [<c0154e5f>] do_munmap+0x16f/0x1e0
  [<c0154f15>] sys_munmap+0x45/0x70
  [<c010959b>] syscall_call+0x7/0xb
 
 EXT3-fs error (device sdb8): ext3_free_blocks: bit already cleared for block 1142881
 bad: scheduling while atomic!
 Call Trace:
  [<c012049e>] schedule+0x68e/0x6a0
  [<c021cce0>] scsi_request_fn+0x240/0x390
  [<c020d49d>] generic_unplug_device+0x8d/0x90
  [<c0121776>] io_schedule+0x26/0x40
  [<c0163574>] __wait_on_buffer+0xc4/0xd0
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c016754b>] sync_dirty_buffer+0x4b/0xb0
  [<c01ac60d>] ext3_handle_error+0x6d/0xb0
  [<c01ac6a5>] ext3_error+0x55/0x60
  [<c01a0d03>] ext3_free_blocks+0x523/0x5d0
  [<c01a6958>] ext3_free_data+0x128/0x150
  [<c01a6a6e>] ext3_free_branches+0xee/0x270
  [<c01a715e>] ext3_truncate+0x56e/0x670
  [<c01b34b9>] journal_start+0xa9/0xd0
  [<c01a4203>] start_transaction+0x23/0x60
  [<c01a4396>] ext3_delete_inode+0xc6/0x110
  [<c01a42d0>] ext3_delete_inode+0x0/0x110
  [<c017efcb>] generic_delete_inode+0xab/0x190
  [<c017f2b2>] iput+0x62/0x90
  [<c017b855>] dput+0x115/0x250
  [<c0174a6e>] sys_rename+0x1fe/0x220
  [<c0154e5f>] do_munmap+0x16f/0x1e0
  [<c0154f15>] sys_munmap+0x45/0x70
  [<c010959b>] syscall_call+0x7/0xb
 
 EXT3-fs error (device sdb8): ext3_free_blocks: bit already cleared for block 1142882
 bad: scheduling while atomic!
 Call Trace:
  [<c012049e>] schedule+0x68e/0x6a0
  [<c020ec2a>] generic_make_request+0x16a/0x1f0
  [<c0121776>] io_schedule+0x26/0x40
  [<c0163574>] __wait_on_buffer+0xc4/0xd0
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c016754b>] sync_dirty_buffer+0x4b/0xb0
  [<c01ac60d>] ext3_handle_error+0x6d/0xb0
  [<c01ac6a5>] ext3_error+0x55/0x60
  [<c01a0d03>] ext3_free_blocks+0x523/0x5d0
  [<c01a6958>] ext3_free_data+0x128/0x150
  [<c01a6a6e>] ext3_free_branches+0xee/0x270
  [<c01a715e>] ext3_truncate+0x56e/0x670
  [<c01b34b9>] journal_start+0xa9/0xd0
  [<c01a4203>] start_transaction+0x23/0x60
  [<c01a4396>] ext3_delete_inode+0xc6/0x110
  [<c01a42d0>] ext3_delete_inode+0x0/0x110
  [<c017efcb>] generic_delete_inode+0xab/0x190
  [<c017f2b2>] iput+0x62/0x90
  [<c017b855>] dput+0x115/0x250
  [<c0174a6e>] sys_rename+0x1fe/0x220
  [<c0154e5f>] do_munmap+0x16f/0x1e0
  [<c0154f15>] sys_munmap+0x45/0x70
  [<c010959b>] syscall_call+0x7/0xb
 
 EXT3-fs error (device sdb8): ext3_free_blocks: bit already cleared for block 1142883
 bad: scheduling while atomic!
 Call Trace:
  [<c012049e>] schedule+0x68e/0x6a0
  [<c0214488>] as_next_request+0x38/0x50
  [<c020b7c6>] elv_next_request+0x16/0x100
  [<c020d490>] generic_unplug_device+0x80/0x90
  [<c0121776>] io_schedule+0x26/0x40
  [<c0163574>] __wait_on_buffer+0xc4/0xd0
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c016754b>] sync_dirty_buffer+0x4b/0xb0
  [<c01ac60d>] ext3_handle_error+0x6d/0xb0
  [<c01ac6a5>] ext3_error+0x55/0x60
  [<c01a0d03>] ext3_free_blocks+0x523/0x5d0
  [<c01a6958>] ext3_free_data+0x128/0x150
  [<c01a6a6e>] ext3_free_branches+0xee/0x270
  [<c01a715e>] ext3_truncate+0x56e/0x670
  [<c01b34b9>] journal_start+0xa9/0xd0
  [<c01a4203>] start_transaction+0x23/0x60
  [<c01a4396>] ext3_delete_inode+0xc6/0x110
  [<c01a42d0>] ext3_delete_inode+0x0/0x110
  [<c017efcb>] generic_delete_inode+0xab/0x190
  [<c017f2b2>] iput+0x62/0x90
  [<c017b855>] dput+0x115/0x250
  [<c0174a6e>] sys_rename+0x1fe/0x220
  [<c0154e5f>] do_munmap+0x16f/0x1e0
  [<c0154f15>] sys_munmap+0x45/0x70
  [<c010959b>] syscall_call+0x7/0xb
 
 EXT3-fs error (device sdb8): ext3_free_blocks: bit already cleared for block 1142884
 bad: scheduling while atomic!
 Call Trace:
  [<c012049e>] schedule+0x68e/0x6a0
  [<c020ec2a>] generic_make_request+0x16a/0x1f0
  [<c0121776>] io_schedule+0x26/0x40
  [<c0163574>] __wait_on_buffer+0xc4/0xd0
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c016754b>] sync_dirty_buffer+0x4b/0xb0
  [<c01ac60d>] ext3_handle_error+0x6d/0xb0
  [<c01ac6a5>] ext3_error+0x55/0x60
  [<c01a0d03>] ext3_free_blocks+0x523/0x5d0
  [<c01a6958>] ext3_free_data+0x128/0x150
  [<c01a6a6e>] ext3_free_branches+0xee/0x270
  [<c01a715e>] ext3_truncate+0x56e/0x670
  [<c01b34b9>] journal_start+0xa9/0xd0
  [<c01a4203>] start_transaction+0x23/0x60
  [<c01a4396>] ext3_delete_inode+0xc6/0x110
  [<c01a42d0>] ext3_delete_inode+0x0/0x110
  [<c017efcb>] generic_delete_inode+0xab/0x190
  [<c017f2b2>] iput+0x62/0x90
  [<c017b855>] dput+0x115/0x250
  [<c0174a6e>] sys_rename+0x1fe/0x220
  [<c0154e5f>] do_munmap+0x16f/0x1e0
  [<c0154f15>] sys_munmap+0x45/0x70
  [<c010959b>] syscall_call+0x7/0xb
 
 EXT3-fs error (device sdb8): ext3_free_blocks: bit already cleared for block 1142885
 bad: scheduling while atomic!
 Call Trace:
  [<c012049e>] schedule+0x68e/0x6a0
  [<c0214488>] as_next_request+0x38/0x50
  [<c020b7c6>] elv_next_request+0x16/0x100
  [<c020d490>] generic_unplug_device+0x80/0x90
  [<c0121776>] io_schedule+0x26/0x40
  [<c0163574>] __wait_on_buffer+0xc4/0xd0
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c016754b>] sync_dirty_buffer+0x4b/0xb0
  [<c01ac60d>] ext3_handle_error+0x6d/0xb0
  [<c01ac6a5>] ext3_error+0x55/0x60
  [<c01a0d03>] ext3_free_blocks+0x523/0x5d0
  [<c01a6958>] ext3_free_data+0x128/0x150
  [<c01a6a6e>] ext3_free_branches+0xee/0x270
  [<c01a715e>] ext3_truncate+0x56e/0x670
  [<c01b34b9>] journal_start+0xa9/0xd0
  [<c01a4203>] start_transaction+0x23/0x60
  [<c01a4396>] ext3_delete_inode+0xc6/0x110
  [<c01a42d0>] ext3_delete_inode+0x0/0x110
  [<c017efcb>] generic_delete_inode+0xab/0x190
  [<c017f2b2>] iput+0x62/0x90
  [<c017b855>] dput+0x115/0x250
  [<c0174a6e>] sys_rename+0x1fe/0x220
  [<c0154e5f>] do_munmap+0x16f/0x1e0
  [<c0154f15>] sys_munmap+0x45/0x70
  [<c010959b>] syscall_call+0x7/0xb
 
 EXT3-fs error (device sdb8): ext3_free_blocks: bit already cleared for block 1142886
 bad: scheduling while atomic!
 Call Trace:
  [<c012049e>] schedule+0x68e/0x6a0
  [<c0214488>] as_next_request+0x38/0x50
  [<c020b7c6>] elv_next_request+0x16/0x100
  [<c020d490>] generic_unplug_device+0x80/0x90
  [<c0121776>] io_schedule+0x26/0x40
  [<c0163574>] __wait_on_buffer+0xc4/0xd0
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c016754b>] sync_dirty_buffer+0x4b/0xb0
  [<c01ac60d>] ext3_handle_error+0x6d/0xb0
  [<c01ac6a5>] ext3_error+0x55/0x60
  [<c01a0d03>] ext3_free_blocks+0x523/0x5d0
  [<c01a6958>] ext3_free_data+0x128/0x150
  [<c01a6a6e>] ext3_free_branches+0xee/0x270
  [<c01a715e>] ext3_truncate+0x56e/0x670
  [<c01b34b9>] journal_start+0xa9/0xd0
  [<c01a4203>] start_transaction+0x23/0x60
  [<c01a4396>] ext3_delete_inode+0xc6/0x110
  [<c01a42d0>] ext3_delete_inode+0x0/0x110
  [<c017efcb>] generic_delete_inode+0xab/0x190
  [<c017f2b2>] iput+0x62/0x90
  [<c017b855>] dput+0x115/0x250
  [<c0174a6e>] sys_rename+0x1fe/0x220
  [<c0154e5f>] do_munmap+0x16f/0x1e0
  [<c0154f15>] sys_munmap+0x45/0x70
  [<c010959b>] syscall_call+0x7/0xb
 
 EXT3-fs error (device sdb8): ext3_free_blocks: bit already cleared for block 1142887
 bad: scheduling while atomic!
 Call Trace:
  [<c012049e>] schedule+0x68e/0x6a0
  [<c0214488>] as_next_request+0x38/0x50
  [<c020b7c6>] elv_next_request+0x16/0x100
  [<c020d490>] generic_unplug_device+0x80/0x90
  [<c0121776>] io_schedule+0x26/0x40
  [<c0163574>] __wait_on_buffer+0xc4/0xd0
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c01229d0>] autoremove_wake_function+0x0/0x50
  [<c016754b>] sync_dirty_buffer+0x4b/0xb0
  [<c01ac60d>] ext3_handle_error+0x6d/0xb0
  [<c01ac6a5>] ext3_error+0x55/0x60
  [<c01a0d03>] ext3_free_blocks+0x523/0x5d0
  [<c01a6958>] ext3_free_data+0x128/0x150
  [<c01a6a6e>] ext3_free_branches+0xee/0x270
  [<c01a715e>] ext3_truncate+0x56e/0x670
  [<c01b34b9>] journal_start+0xa9/0xd0
  [<c01a4203>] start_transaction+0x23/0x60
  [<c01a4396>] ext3_delete_inode+0xc6/0x110
  [<c01a42d0>] ext3_delete_inode+0x0/0x110
  [<c017efcb>] generic_delete_inode+0xab/0x190
  [<c017f2b2>] iput+0x62/0x90
  [<c017b855>] dput+0x115/0x250
  [<c0174a6e>] sys_rename+0x1fe/0x220
  [<c0154e5f>] do_munmap+0x16f/0x1e0
  [<c0154f15>] sys_munmap+0x45/0x70
  [<c010959b>] syscall_call+0x7/0xb
 
 ext3_abort called.
 EXT3-fs abort (device sdb8): ext3_journal_start: Detected aborted journal
 Remounting filesystem read-only
 ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device sdb8) in ext3_reserve_inode_write: Journal has aborted
 EXT3-fs error (device sdb8) in ext3_truncate: Journal has aborted
 ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device sdb8) in ext3_reserve_inode_write: Journal has aborted
 EXT3-fs error (device sdb8) in ext3_orphan_del: Journal has aborted
 ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device sdb8) in ext3_reserve_inode_write: Journal has aborted
 EXT3-fs error (device sdb8) in ext3_delete_inode: Journal has aborted
 EXT3-fs error (device sdb8) in start_transaction: Journal has aborted
Feb 19 19:46:05 wingerd last message repeated 30 times
 __journal_remove_journal_head: freeing b_committed_data
