Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWINAcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWINAcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 20:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWINAcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 20:32:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50102 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751155AbWINAcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 20:32:09 -0400
Message-ID: <4508A2FB.7040704@melbourne.sgi.com>
Date: Thu, 14 Sep 2006 10:31:55 +1000
From: David Chatterton <chatz@melbourne.sgi.com>
Reply-To: chatz@melbourne.sgi.com
Organization: SGI
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Luca <kronos.it@gmail.com>
CC: xfs-masters@oss.sgi.com, linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS: lockdep warning: BUG: held lock freed!
References: <20060912163600.GA2948@dreamland.darkstar.lan>
In-Reply-To: <20060912163600.GA2948@dreamland.darkstar.lan>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca,

I've added this report to a list of lockdep related work we need to
do in XFS.

Thanks,

David



Luca wrote:
> Hi,
> I see that this error has alredy been observed with 2.6.17-mm; I'm
> running kernel 2.6.18-rc5 (x86, UP, with PREEMPT) and may have
> additional information. In my case the FS was affected by 2.6.17
> directory corruption (I forgot to run xfs_repair on this machine); after
> the FS was shut down I rebooted the machine (with init=/bin/bash, rootfs
> on ext2, so it was not affected) and mounted XFS partition read-only to
> recover the log.
> I tried to reproduce with "simple" crashes (i.e. write a file and
> reboot, I don't want to trash the FS too much ;)) without success, so
> the error may be related to directory corruption.
> 
> lockdep message:
> 
> SGI XFS with no debug enabled
> XFS mounting filesystem hda8
> Starting XFS recovery on filesystem: hda8 (logdev: internal)
> 
> =========================
> [ BUG: held lock freed! ]
> -------------------------
> mount/290 is freeing memory ef798b70-ef798baf, with a lock still held there!
>  (&(&ip->i_lock)->mr_lock){--..}, at: [<f193e4ed>] xfs_ilock+0x7d/0xb0 [xfs]
> 3 locks held by mount/290:
>  #0:  (&type->s_umount_key#14){--..}, at: [<b01689cc>] sget+0x19c/0x320
>  #1:  (&(&ip->i_iolock)->mr_lock){--..}, at: [<f193e50e>] xfs_ilock+0x9e/0xb0 [xfs]
>  #2:  (&(&ip->i_lock)->mr_lock){--..}, at: [<f193e4ed>] xfs_ilock+0x7d/0xb0 [xfs]
> 
> stack backtrace:
>  [<b0104376>] show_trace_log_lvl+0x176/0x1a0
>  [<b0104a32>] show_trace+0x12/0x20
>  [<b0104a99>] dump_stack+0x19/0x20
>  [<b0135699>] debug_check_no_locks_freed+0x169/0x180
>  [<b01d5c71>] __init_rwsem+0x21/0x60
>  [<f193e855>] xfs_inode_lock_init+0x25/0x80 [xfs]
>  [<f193ee4a>] xfs_iget+0x18a/0x5b8 [xfs]
>  [<f194f0d6>] xlog_recover_process_iunlinks+0x316/0x500 [xfs]
>  [<f194f57e>] xlog_recover_finish+0x2be/0x380 [xfs]
>  [<f194af47>] xfs_log_mount_finish+0x37/0x50 [xfs]
>  [<f1953b70>] xfs_mountfs+0xe50/0x1020 [xfs]
>  [<f1945579>] xfs_ioinit+0x29/0x40 [xfs]
>  [<f195af8c>] xfs_mount+0x65c/0xa10 [xfs]
>  [<f196d855>] vfs_mount+0x25/0x30 [xfs]
>  [<f196d676>] xfs_fs_fill_super+0x76/0x1e0 [xfs]
>  [<b01692bc>] get_sb_bdev+0xec/0x130
>  [<f196c7f1>] xfs_fs_get_sb+0x21/0x30 [xfs]
>  [<b0168dc0>] vfs_kern_mount+0x40/0xa0
>  [<b0168e76>] do_kern_mount+0x36/0x50
>  [<b017f2ee>] do_mount+0x22e/0x610
>  [<b017f73f>] sys_mount+0x6f/0xb0
>  [<b0103173>] syscall_call+0x7/0xb
>  [<a7ef00be>] 0xa7ef00be
>  [<b0104a32>] show_trace+0x12/0x20
>  [<b0104a99>] dump_stack+0x19/0x20
>  [<b0135699>] debug_check_no_locks_freed+0x169/0x180
>  [<b01d5c71>] __init_rwsem+0x21/0x60
>  [<f193e855>] xfs_inode_lock_init+0x25/0x80 [xfs]
>  [<f193ee4a>] xfs_iget+0x18a/0x5b8 [xfs]
>  [<f194f0d6>] xlog_recover_process_iunlinks+0x316/0x500 [xfs]
>  [<f194f57e>] xlog_recover_finish+0x2be/0x380 [xfs]
>  [<f194af47>] xfs_log_mount_finish+0x37/0x50 [xfs]
>  [<f1953b70>] xfs_mountfs+0xe50/0x1020 [xfs]
>  [<f1945579>] xfs_ioinit+0x29/0x40 [xfs]
>  [<f195af8c>] xfs_mount+0x65c/0xa10 [xfs]
>  [<f196d855>] vfs_mount+0x25/0x30 [xfs]
>  [<f196d676>] xfs_fs_fill_super+0x76/0x1e0 [xfs]
>  [<b01692bc>] get_sb_bdev+0xec/0x130
>  [<f196c7f1>] xfs_fs_get_sb+0x21/0x30 [xfs]
>  [<b0168dc0>] vfs_kern_mount+0x40/0xa0
>  [<b0168e76>] do_kern_mount+0x36/0x50
>  [<b017f2ee>] do_mount+0x22e/0x610
>  [<b017f73f>] sys_mount+0x6f/0xb0
>  [<b0103173>] syscall_call+0x7/0xb
> Ending XFS recovery on filesystem: hda8 (logdev: internal)
> 
> 
> Luca

-- 
David Chatterton
XFS Engineering Manager
SGI Australia
