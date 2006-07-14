Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWGNJ4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWGNJ4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGNJ4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:56:00 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:5596 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S964812AbWGNJz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:55:59 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: BUG: held lock freed! (xfs)
Date: Fri, 14 Jul 2006 11:55:53 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       xfs-masters@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607141155.55209.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.6.18-rc1-git8 (duncan@baldrick) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #5 PREEMPT Fri Jul 14 10:59:33 CEST 2006

On system shutdown:

[ 1919.170295] [ BUG: held lock freed! ]
[ 1919.181280] -------------------------
[ 1919.192270] umount/6157 is freeing memory d9d49000-d9d49fff, with a lock still held there!
[ 1919.217046]  (&(&ip->i_iolock)->mr_lock){----}, at: [<e0a99fa2>] xfs_ilock+0x1c/0x68 [xfs]
[ 1919.242191] 4 locks held by umount/6157:
[ 1919.253956]  #0:  (&type->s_umount_key#16){----}, at: [<c015381e>] deactivate_super+0x3a/0x51
[ 1919.279981]  #1:  (&type->s_lock_key#7){--..}, at: [<c028d8f4>] mutex_lock+0x1c/0x1f
[ 1919.303669]  #2:  (&(&ip->i_iolock)->mr_lock){----}, at: [<e0a99fa2>] xfs_ilock+0x1c/0x68 [xfs]
[ 1919.330135]  #3:  (&(&ip->i_lock)->mr_lock){----}, at: [<e0a99fd0>] xfs_ilock+0x4a/0x68 [xfs]
[ 1919.356083]
[ 1919.356085] stack backtrace:
[ 1919.369460]  [<c01039df>] show_trace_log_lvl+0x54/0xfd
[ 1919.384961]  [<c0104afe>] show_trace+0xd/0x10
[ 1919.398130]  [<c0104b18>] dump_stack+0x17/0x1b
[ 1919.411558]  [<c0129264>] debug_check_no_locks_freed+0xe2/0x11c
[ 1919.429551]  [<c010fb54>] kernel_map_pages+0x28/0x78
[ 1919.444594]  [<c014a2a5>] cache_free_debugcheck+0x224/0x23e
[ 1919.461647]  [<c014aa81>] kmem_cache_free+0x66/0xb2
[ 1919.476568]  [<e0a9d0d3>] xfs_idestroy+0x5e/0x61 [xfs]
[ 1919.492171]  [<e0a9a06c>] xfs_ireclaim+0x55/0x58 [xfs]
[ 1919.507708]  [<e0ab4614>] xfs_finish_reclaim+0x111/0x11a [xfs]
[ 1919.525384]  [<e0ab4686>] xfs_reclaim+0x69/0xca [xfs]
[ 1919.540695]  [<e0ac03ce>] xfs_fs_clear_inode+0x54/0x70 [xfs]
[ 1919.557864]  [<c0163767>] clear_inode+0x97/0xc8
[ 1919.571843]  [<c0163d20>] generic_drop_inode+0x12c/0x13e
[ 1919.588135]  [<c0163053>] iput+0x67/0x6a
[ 1919.600263]  [<e0ab2925>] xfs_unmount+0xb5/0x125 [xfs]
[ 1919.615838]  [<e0ac0f9c>] vfs_unmount+0x1a/0x1e [xfs]
[ 1919.631183]  [<e0ac0488>] xfs_fs_put_super+0x2e/0x5e [xfs]
[ 1919.647802]  [<c01535d2>] generic_shutdown_super+0x7f/0x111
[ 1919.664823]  [<c0153684>] kill_block_super+0x20/0x32
[ 1919.680043]  [<c0153823>] deactivate_super+0x3f/0x51
[ 1919.695265]  [<c01651a9>] mntput_no_expire+0x42/0x66
[ 1919.710528]  [<c01593d9>] path_release_on_umount+0x15/0x18
[ 1919.727306]  [<c0165f83>] sys_umount+0x199/0x1a3
[ 1919.741518]  [<c0165f9a>] sys_oldumount+0xd/0xf
[ 1919.755465]  [<c01027e5>] sysenter_past_esp+0x56/0x8d
