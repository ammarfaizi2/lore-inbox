Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWHBQPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWHBQPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWHBQPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:15:41 -0400
Received: from mta3.glocalnet.net ([213.163.128.207]:36049 "EHLO
	mta3.glocalnet.net") by vger.kernel.org with ESMTP id S932087AbWHBQPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:15:40 -0400
Message-ID: <44D0CFA1.60308@glocalnet.net>
Date: Wed, 02 Aug 2006 18:15:29 +0200
From: HM <hm@glocalnet.net>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: INFO: possible recursive locking detected  using reiser and 2.6.18-rc3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

I found the following when running 2.6.18-rc3 and reiserfs.

Please cc me as I'm not on the mailing list.

/Henk

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
kdm/4199 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c0297b95>] mutex_lock+0x21/0x24

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c0297b95>] mutex_lock+0x21/0x24

other info that might help us debug this:
1 lock held by kdm/4199:
 #0:  (&inode->i_mutex){--..}, at: [<c0297b95>] mutex_lock+0x21/0x24

stack backtrace:
 [<c0103f65>] show_trace_log_lvl+0x16f/0x192
 [<c010462d>] show_trace+0x12/0x14
 [<c01046c9>] dump_stack+0x19/0x1b
 [<c0131571>] __lock_acquire+0x8aa/0xd2a
 [<c0131d63>] lock_acquire+0x6f/0x8c
 [<c029798a>] __mutex_lock_slowpath+0x65/0x24f
 [<c0297b95>] mutex_lock+0x21/0x24
 [<f0e1092a>] xattr_readdir+0x51/0x4b1 [reiserfs]
 [<f0e11452>] reiserfs_chown_xattrs+0xbd/0x10d [reiserfs]
 [<f0df4b09>] reiserfs_setattr+0xf1/0x220 [reiserfs]
 [<c01726aa>] notify_change+0x20a/0x280
 [<c0158aba>] chown_common+0x9d/0xab
 [<c0158cf3>] sys_chown+0x34/0x46
 [<c0102e3d>] sysenter_past_esp+0x56/0x8d
 [<b7f73410>] 0xb7f73410
 [<c010462d>] show_trace+0x12/0x14
 [<c01046c9>] dump_stack+0x19/0x1b
 [<c0131571>] __lock_acquire+0x8aa/0xd2a
 [<c0131d63>] lock_acquire+0x6f/0x8c
 [<c029798a>] __mutex_lock_slowpath+0x65/0x24f
 [<c0297b95>] mutex_lock+0x21/0x24
 [<f0e1092a>] xattr_readdir+0x51/0x4b1 [reiserfs]
 [<f0e11452>] reiserfs_chown_xattrs+0xbd/0x10d [reiserfs]
 [<f0df4b09>] reiserfs_setattr+0xf1/0x220 [reiserfs]
 [<c01726aa>] notify_change+0x20a/0x280
 [<c0158aba>] chown_common+0x9d/0xab
 [<c0158cf3>] sys_chown+0x34/0x46
 [<c0102e3d>] sysenter_past_esp+0x56/0x8d

