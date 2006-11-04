Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753586AbWKDFDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbWKDFDW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 00:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbWKDFDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 00:03:22 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:1766 "EHLO
	MAIL.13thfloor.at") by vger.kernel.org with ESMTP id S1753583AbWKDFDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 00:03:21 -0500
Date: Sat, 4 Nov 2006 06:03:20 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: shaggy@austin.ibm.com
Subject: JFS possible recursive locking
Message-ID: <20061104050318.GA20209@MAIL.13thfloor.at>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	shaggy@austin.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stumbled about those, but had not time to investigate
(or fix) yet, just wanted to report them before they
get lost

# uname -a

Linux (none) 2.6.18.1 #1 SMP PREEMPT Sat Nov 4 05:54:06 CET 2006 i686 unknown


# mkfs.jfs -f /dev/hdc1
# mount /dev/hdc1 /test
# echo blah >/test/blah

[   19.602318] 
[   19.602413] =============================================
[   19.603294] [ INFO: possible recursive locking detected ]
[   19.603817] ---------------------------------------------
[   19.604356] sh/26 is trying to acquire lock:
[   19.604900]  (&jfs_ip->commit_mutex){--..}, at: [<782d407c>] mutex_lock+0x1c/0x20
[   19.606262] 
[   19.606296] but task is already holding lock:
[   19.606874]  (&jfs_ip->commit_mutex){--..}, at: [<782d407c>] mutex_lock+0x1c/0x20
[   19.607934] 
[   19.607966] other info that might help us debug this:
[   19.608745] 2 locks held by sh/26:
[   19.609170]  #0:  (&inode->i_mutex){--..}, at: [<782d407c>] mutex_lock+0x1c/0x20
[   19.610296]  #1:  (&jfs_ip->commit_mutex){--..}, at: [<782d407c>] mutex_lock+0x1c/0x20
[   19.611450] 
[   19.611479] stack backtrace:
[   19.617847]  [<78103bdc>] show_trace_log_lvl+0x17c/0x190
[   19.619232]  [<78103c02>] show_trace+0x12/0x20
[   19.620279]  [<78103d29>] dump_stack+0x19/0x20
[   19.621311]  [<78137dd2>] print_deadlock_bug+0xc2/0xd0
[   19.625698]  [<78137e43>] check_deadlock+0x63/0x80
[   19.630094]  [<781396f8>] __lock_acquire+0x348/0x9a0
[   19.634437]  [<7813a472>] lock_acquire+0x72/0x90
[   19.638880]  [<782d35d1>] __mutex_lock_slowpath+0x71/0x290
[   19.643039]  [<782d407c>] mutex_lock+0x1c/0x20
[   19.647083]  [<781ce557>] jfs_create+0xa7/0x3a0
[   19.658696]  [<78178b41>] vfs_create+0x91/0x110
[   19.666927]  [<781793a8>] open_namei+0x5f8/0x660
[   19.675213]  [<78167cec>] do_filp_open+0x2c/0x50
[   19.682152]  [<78168052>] do_sys_open+0x52/0xe0
[   19.689115]  [<781680fc>] sys_open+0x1c/0x20
[   19.695981]  [<78102c23>] syscall_call+0x7/0xb
[   19.697148]  [<6ff52af4>] 0x6ff52af4

best,
Herbert

