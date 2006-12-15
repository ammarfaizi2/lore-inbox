Return-Path: <linux-kernel-owner+w=401wt.eu-S1751497AbWLOLAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWLOLAZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 06:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWLOLAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 06:00:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:52643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751497AbWLOLAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 06:00:25 -0500
X-Authenticated: #14349625
Subject: [lockdep] 2.6.19.1 - umount - possible circular locking dependency
	detected
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 12:00:17 +0100
Message-Id: <1166180417.6268.5.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I received the below while shutting down 2.6.19.1 prior to booting the
shiny new 2.6.20-rc1 kernel.

Unmounting file systems
/dev/hda6 umounted
/dev/hda5 umounted
/dev/hda1 umounted
[ 9245.631538] 
[ 9245.631547] =======================================================
[ 9245.681603] [ INFO: possible circular locking dependency detected ]
[ 9245.709897] 2.6.19.1-smp #77
[ 9245.734150] -------------------------------------------------------
[ 9245.763093] umount/12367 is trying to acquire lock:
[ 9245.790836]  (iprune_mutex){--..}, at: [<c13e23dd>] mutex_lock+0x8/0xa
[ 9245.821530] 
[ 9245.821535] but task is already holding lock:
[ 9245.872857]  (&type->s_lock_key#6){--..}, at: [<c13e23dd>] mutex_lock+0x8/0xa
[ 9245.904047] 
[ 9245.904052] which lock already depends on the new lock.
[ 9245.904058] 
[ 9245.981047] 
[ 9245.981053] the existing dependency chain (in reverse order) is:
[ 9246.034239] 
[ 9246.034242] -> #3 (&type->s_lock_key#6){--..}:
[ 9246.085560]        [<c103dd54>] add_lock_to_list+0x3b/0x87
[ 9246.114129]        [<c1040420>] __lock_acquire+0xb75/0xc1a
[ 9246.142207]        [<c10407f1>] lock_acquire+0x5d/0x79
[ 9246.170140]        [<c13e21ad>] __mutex_lock_slowpath+0x6e/0x296
[ 9246.199547]        [<c13e23dd>] mutex_lock+0x8/0xa
[ 9246.227310]        [<c10c64e5>] ext3_orphan_add+0x37/0x1f4
[ 9246.255370]        [<c10c3ab1>] ext3_setattr+0x18c/0x200
[ 9246.282959]        [<c108b9ca>] notify_change+0x2aa/0x36c
[ 9246.310186]        [<c10763ac>] do_truncate+0x53/0x6c
[ 9246.336668]        [<c107fd9f>] may_open+0x1c2/0x264
[ 9246.362506]        [<c1081e95>] open_namei+0x75/0x664
[ 9246.387974]        [<c10760fb>] do_filp_open+0x26/0x43
[ 9246.413418]        [<c1076159>] do_sys_open+0x41/0xc5
[ 9246.439131]        [<c1076215>] sys_open+0x1c/0x1e
[ 9246.464189]        [<c1003173>] syscall_call+0x7/0xb
[ 9246.489140]        [<0805cf97>] 0x805cf97
[ 9246.513303]        [<ffffffff>] 0xffffffff
[ 9246.536826] 
[ 9246.536829] -> #2 (&inode->i_alloc_sem){--..}:
[ 9246.578970]        [<c103dd54>] add_lock_to_list+0x3b/0x87
[ 9246.603222]        [<c1040420>] __lock_acquire+0xb75/0xc1a
[ 9246.627777]        [<c10407f1>] lock_acquire+0x5d/0x79
[ 9246.651598]        [<c103bd81>] down_write+0x2b/0x45
[ 9246.674840]        [<c108b999>] notify_change+0x279/0x36c
[ 9246.698330]        [<c10763ac>] do_truncate+0x53/0x6c
[ 9246.721087]        [<c107fd9f>] may_open+0x1c2/0x264
[ 9246.743362]        [<c1081e95>] open_namei+0x75/0x664
[ 9246.765448]        [<c10760fb>] do_filp_open+0x26/0x43
[ 9246.787653]        [<c1076159>] do_sys_open+0x41/0xc5
[ 9246.809368]        [<c1076215>] sys_open+0x1c/0x1e
[ 9246.830338]        [<c1003173>] syscall_call+0x7/0xb
[ 9246.850989]        [<b7e53857>] 0xb7e53857
[ 9246.870873]        [<ffffffff>] 0xffffffff
[ 9246.890894] 
[ 9246.890898] -> #1 (&inode->i_mutex){--..}:
[ 9246.926067]        [<c103dd54>] add_lock_to_list+0x3b/0x87
[ 9246.947419]        [<c1040420>] __lock_acquire+0xb75/0xc1a
[ 9246.968599]        [<c10407f1>] lock_acquire+0x5d/0x79
[ 9246.989342]        [<c13e21ad>] __mutex_lock_slowpath+0x6e/0x296
[ 9247.011279]        [<c13e23dd>] mutex_lock+0x8/0xa
[ 9247.031696]        [<c117657a>] ntfs_put_inode+0x42/0x77
[ 9247.052712]        [<c108a1bd>] iput+0x2b/0x6c
[ 9247.072559]        [<c10a025f>] inotify_unmount_inodes+0x14d/0x18d
[ 9247.094668]        [<c108b072>] invalidate_inodes+0x36/0xd6
[ 9247.116202]        [<c1079308>] generic_shutdown_super+0x4f/0x11c
[ 9247.138409]        [<c10793f5>] kill_block_super+0x20/0x32
[ 9247.159946]        [<c10794bb>] deactivate_super+0x63/0x75
[ 9247.181408]        [<c108d034>] mntput_no_expire+0x44/0x74
[ 9247.202804]        [<c107e3df>] path_release_on_umount+0x15/0x18
[ 9247.225053]        [<c108e0fd>] sys_umount+0x3b/0x264
[ 9247.246357]        [<c108e33f>] sys_oldumount+0x19/0x1b
[ 9247.267763]        [<c1003173>] syscall_call+0x7/0xb
[ 9247.288788]        [<b7e84c3d>] 0xb7e84c3d
[ 9247.308810]        [<ffffffff>] 0xffffffff
[ 9247.328928] 
[ 9247.328933] -> #0 (iprune_mutex){--..}:
[ 9247.364381]        [<c103f875>] print_circular_bug_tail+0x30/0x66
[ 9247.386545]        [<c1040231>] __lock_acquire+0x986/0xc1a
[ 9247.408336]        [<c10407f1>] lock_acquire+0x5d/0x79
[ 9247.429710]        [<c13e21ad>] __mutex_lock_slowpath+0x6e/0x296
[ 9247.452340]        [<c13e23dd>] mutex_lock+0x8/0xa
[ 9247.473526]        [<c108b05a>] invalidate_inodes+0x1e/0xd6
[ 9247.495752]        [<c1079308>] generic_shutdown_super+0x4f/0x11c
[ 9247.518735]        [<c10793f5>] kill_block_super+0x20/0x32
[ 9247.541071]        [<c10794bb>] deactivate_super+0x63/0x75
[ 9247.563304]        [<c108d034>] mntput_no_expire+0x44/0x74
[ 9247.585587]        [<c107e3df>] path_release_on_umount+0x15/0x18
[ 9247.608641]        [<c108e0fd>] sys_umount+0x3b/0x264
[ 9247.630683]        [<c108e33f>] sys_oldumount+0x19/0x1b
[ 9247.652996]        [<c1003173>] syscall_call+0x7/0xb
[ 9247.675075]        [<b7e84c3d>] 0xb7e84c3d
[ 9247.696032]        [<ffffffff>] 0xffffffff
[ 9247.716323] 
[ 9247.716326] other info that might help us debug this:
[ 9247.716332] 
[ 9247.770368] 2 locks held by umount/12367:
[ 9247.790145]  #0:  (&type->s_umount_key#14){----}, at: [<c10794b6>] deactivate_super+0x5e/0x75
[ 9247.816437]  #1:  (&type->s_lock_key#6){--..}, at: [<c13e23dd>] mutex_lock+0x8/0xa
[ 9247.842046] 
[ 9247.842050] stack backtrace:
[ 9247.879470]  [<c10041e3>] dump_trace+0x1c1/0x1f0
[ 9247.901070]  [<c100422c>] show_trace_log_lvl+0x1a/0x30
[ 9247.923161]  [<c1004967>] show_trace+0x12/0x14
[ 9247.944458]  [<c1004a88>] dump_stack+0x19/0x1b
[ 9247.965607]  [<c103f8a2>] print_circular_bug_tail+0x5d/0x66
[ 9247.987904]  [<c1040231>] __lock_acquire+0x986/0xc1a
[ 9248.009735]  [<c10407f1>] lock_acquire+0x5d/0x79
[ 9248.031240]  [<c13e21ad>] __mutex_lock_slowpath+0x6e/0x296
[ 9248.053972]  [<c13e23dd>] mutex_lock+0x8/0xa
[ 9248.075334]  [<c108b05a>] invalidate_inodes+0x1e/0xd6
[ 9248.097799]  [<c1079308>] generic_shutdown_super+0x4f/0x11c
[ 9248.121004]  [<c10793f5>] kill_block_super+0x20/0x32
[ 9248.143751]  [<c10794bb>] deactivate_super+0x63/0x75
[ 9248.166061]  [<c108d034>] mntput_no_expire+0x44/0x74
[ 9248.188218]  [<c107e3df>] path_release_on_umount+0x15/0x18
[ 9248.211080]  [<c108e0fd>] sys_umount+0x3b/0x264
[ 9248.232795]  [<c108e33f>] sys_oldumount+0x19/0x1b
[ 9248.254554]  [<c1003173>] syscall_call+0x7/0xb
[ 9248.275897]  [<b7e84c3d>] 0xb7e84c3d
[ 9248.296118]  =======================
/dev/hdc1 umounted
devpts umounted
sysfs umounted
/dev/hdc3 umounted
doneShutting down MD Raid done
Stopping udevd:done
done
proc umounted
Please stand by while rebooting the system...
[ 9252.127548] md: stopping all md devices.
[ 9253.589125] Restarting system.


