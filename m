Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935959AbWK1Rhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935959AbWK1Rhd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935956AbWK1Rhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:37:33 -0500
Received: from ribosome.natur.cuni.cz ([195.113.57.20]:44295 "EHLO
	ribosome.natur.cuni.cz") by vger.kernel.org with ESMTP
	id S935957AbWK1Rhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:37:31 -0500
Message-ID: <456C73D8.50907@ribosome.natur.cuni.cz>
Date: Tue, 28 Nov 2006 18:37:28 +0100
From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060426
X-Accept-Language: cs
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: XFS: possible recursive locking detected in 2.6.18 to 2.6.19-rc6-git10
 but not 2.6.17.11
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have a looong time opened a bugreport on XFS at
http://bugzilla.kernel.org/show_bug.cgi?id=7287 and I see it still
appear in my kernel output during bootup. I guess this is one of the
relatively new kernel self-testing features introduced recently. I
just wanted to let you know about that.


=============================================
[ INFO: possible recursive locking detected ]
2.6.19-rc6-git10 #1
---------------------------------------------
mount/3439 is trying to acquire lock:
 (&(&ip->i_lock)->mr_lock){----}, at: [<c11136fc>] xfs_ilock+0x4a/0x68

but task is already holding lock:
 (&(&ip->i_lock)->mr_lock){----}, at: [<c11136fc>] xfs_ilock+0x4a/0x68

other info that might help us debug this:
2 locks held by mount/3439:
 #0:  (&inode->i_mutex){--..}, at: [<c12f138d>] mutex_lock+0x8/0xa
 #1:  (&(&ip->i_lock)->mr_lock){----}, at: [<c11136fc>]
xfs_ilock+0x4a/0x68

stack backtrace:
 [<c1003107>] show_trace_log_lvl+0x1a/0x2f
 [<c1003202>] show_trace+0x12/0x14
 [<c10039c5>] dump_stack+0x19/0x1b
 [<c10307da>] __lock_acquire+0x106/0x94e
 [<c10315d7>] lock_acquire+0x5c/0x79
 [<c102d5da>] down_write+0x2b/0x44
 [<c11136fc>] xfs_ilock+0x4a/0x68
 [<c1113fd2>] xfs_iget+0x2a0/0x5de
 [<c112a239>] xfs_trans_iget+0xd6/0x135
 [<c1117e95>] xfs_ialloc+0xa7/0x41f
 [<c112abde>] xfs_dir_ialloc+0x6d/0x267
 [<c11314d8>] xfs_create+0x2f4/0x5ae
 [<c113981d>] xfs_vn_mknod+0x127/0x242
 [<c1139961>] xfs_vn_create+0x12/0x14
 [<c105d615>] vfs_create+0x6a/0xb4
 [<c105fbe1>] open_namei+0x179/0x57a
 [<c1055b79>] do_filp_open+0x26/0x3b
 [<c1055bd1>] do_sys_open+0x43/0xc7
 [<c1055c8d>] sys_open+0x1c/0x1e
 [<c1002cc5>] sysenter_past_esp+0x56/0x8d
 =======================

I can provide more details upon request. Please Cc: me in replies.
Thanks.
Martin
