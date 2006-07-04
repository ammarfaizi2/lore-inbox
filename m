Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWGDP74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWGDP74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWGDP74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:59:56 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:53412 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751279AbWGDP7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:59:55 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: possible recursive locking in ATM layer
Date: Tue, 4 Jul 2006 17:59:42 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, chas@cmf.nrl.navy.mil
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041759.43064.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.6.17-git22 (duncan@baldrick) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #20 PREEMPT Tue Jul 4 10:35:04 CEST 2006

[ 2381.598609] =============================================
[ 2381.619314] [ INFO: possible recursive locking detected ]
[ 2381.635497] ---------------------------------------------
[ 2381.651706] atmarpd/2696 is trying to acquire lock:
[ 2381.666354]  (&skb_queue_lock_key){-+..}, at: [<c028c540>] skb_migrate+0x24/0x6c
[ 2381.688848]
[ 2381.688849] but task is already holding lock:
[ 2381.706406]  (&skb_queue_lock_key){-+..}, at: [<c028c536>] skb_migrate+0x1a/0x6c
[ 2381.728898]
[ 2381.728900] other info that might help us debug this:
[ 2381.748534] 2 locks held by atmarpd/2696:
[ 2381.760560]  #0:  (ioctl_mutex){--..}, at: [<c028f814>] mutex_lock+0x1c/0x1f
[ 2381.782066]  #1:  (&skb_queue_lock_key){-+..}, at: [<c028c536>] skb_migrate+0x1a/0x6c
[ 2381.805935]
[ 2381.805937] stack backtrace:
[ 2381.819319]  [<c010398b>] show_trace_log_lvl+0x54/0xfd
[ 2381.834838]  [<c0104aaa>] show_trace+0xd/0x10
[ 2381.848009]  [<c0104ac4>] dump_stack+0x17/0x1b
[ 2381.861436]  [<c0129e46>] __lock_acquire+0x76c/0x9d3
[ 2381.876582]  [<c012a38a>] lock_acquire+0x5e/0x80
[ 2381.890656]  [<c029075f>] _spin_lock+0x23/0x32
[ 2381.904220]  [<c028c540>] skb_migrate+0x24/0x6c
[ 2381.919084]  [<c028db9d>] clip_ioctl+0x2a1/0x480
[ 2381.934248]  [<c028a2e1>] vcc_ioctl+0x241/0x2f8
[ 2381.949142]  [<c024475d>] sock_ioctl+0x191/0x1b7
[ 2381.964134]  [<c015ddec>] do_ioctl+0x20/0x65
[ 2381.977330]  [<c015e089>] vfs_ioctl+0x258/0x26b
[ 2381.991283]  [<c015e0c6>] sys_ioctl+0x2a/0x44
[ 2382.004711]  [<c0102791>] sysenter_past_esp+0x56/0x8d
