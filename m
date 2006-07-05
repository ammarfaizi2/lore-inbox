Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWGEIw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWGEIw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWGEIw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:52:28 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:48824 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932410AbWGEIw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:52:28 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: possible recursive locking: xfs_ilock
Date: Wed, 5 Jul 2006 10:52:26 +0200
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       xfs-masters@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607051052.27159.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On system shutdown.

Linux version 2.6.17-git24 (duncan@baldrick) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 PREEMPT Wed Jul 5 10:19:10 CEST 2006

[ 1071.210727] =============================================
[ 1071.231352] [ INFO: possible recursive locking detected ]
[ 1071.247508] ---------------------------------------------
[ 1071.263663] scp/5211 is trying to acquire lock:
[ 1071.277221]  (&(&ip->i_lock)->mr_lock){----}, at: [<e0ae11c6>] xfs_ilock+0x4d/0x6e [xfs]
[ 1071.301689]
[ 1071.301691] but task is already holding lock:
[ 1071.319169]  (&(&ip->i_lock)->mr_lock){----}, at: [<e0ae11c6>] xfs_ilock+0x4d/0x6e [xfs]
[ 1071.343611]
[ 1071.343613] other info that might help us debug this:
[ 1071.363195] 2 locks held by scp/5211:
[ 1071.374154]  #0:  (&inode->i_mutex){--..}, at: [<c028f824>] mutex_lock+0x1c/0x1f
[ 1071.396545]  #1:  (&(&ip->i_lock)->mr_lock){----}, at: [<e0ae11c6>] xfs_ilock+0x4d/0x6e [xfs]
[ 1071.422336]
[ 1071.422337] stack backtrace:
[ 1071.435664]  [<c010398b>] show_trace_log_lvl+0x54/0xfd
[ 1071.451108]  [<c0104aaa>] show_trace+0xd/0x10
[ 1071.464201]  [<c0104ac4>] dump_stack+0x17/0x1b
[ 1071.477550]  [<c0129e56>] __lock_acquire+0x76c/0x9d3
[ 1071.492592]  [<c012a39a>] lock_acquire+0x5e/0x80
[ 1071.506614]  [<c0127163>] down_write+0x28/0x42
[ 1071.520086]  [<e0ae11c6>] xfs_ilock+0x4d/0x6e [xfs]
[ 1071.534831]  [<e0ae164d>] xfs_iget+0x1f5/0x525 [xfs]
[ 1071.549808]  [<e0af6e39>] xfs_trans_iget+0x91/0xf1 [xfs]
[ 1071.565842]  [<e0ae4f95>] xfs_ialloc+0x8b/0x428 [xfs]
[ 1071.581085]  [<e0af76ea>] xfs_dir_ialloc+0x4e/0x206 [xfs]
[ 1071.597388]  [<e0afd5e7>] xfs_create+0x299/0x52d [xfs]
[ 1071.612904]  [<e0b06593>] xfs_vn_mknod+0x122/0x239 [xfs]
[ 1071.628973]  [<e0b066c3>] xfs_vn_create+0xa/0xf [xfs]
[ 1071.644239]  [<c015c76f>] vfs_create+0x65/0xae
[ 1071.657894]  [<c015c90b>] open_namei+0x153/0x563
[ 1071.672043]  [<c014e189>] do_filp_open+0x1f/0x35
[ 1071.686131]  [<c014e2a0>] do_sys_open+0x3f/0xbd
[ 1071.699974]  [<c014e34a>] sys_open+0x16/0x18
[ 1071.713040]  [<c0102791>] sysenter_past_esp+0x56/0x8d
