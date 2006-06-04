Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932187AbWFDHMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWFDHMU (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 03:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWFDHMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 03:12:20 -0400
Received: from mx2.mail.ru ([194.67.23.122]:38692 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S932187AbWFDHMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 03:12:20 -0400
Date: Sun, 4 Jun 2006 11:16:48 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: jfs-discussion@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] jfs: possible deadlocks
Message-ID: <20060604071648.GA13858@rain.homenetwork>
Mail-Followup-To: jfs-discussion@lists.sourceforge.net,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try 2.6.17-rc5-mm2:

====================================
[ BUG: possible deadlock detected! ]
------------------------------------
mount/5587 is trying to acquire lock:
 (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15

but task is already holding lock:
 (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15

which could potentially lead to deadlocks!

other info that might help us debug this:
2 locks held by mount/5587:
 #0:  (&inode->i_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
 #1:  (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15

stack backtrace:
 [<c0103095>] show_trace+0x16/0x19
 [<c0103562>] dump_stack+0x1a/0x1f
 [<c012ddd7>] __lockdep_acquire+0x6c6/0x907
 [<c012e063>] lockdep_acquire+0x4b/0x63
 [<c02f6f0c>] __mutex_lock_slowpath+0xa4/0x21c
 [<c02f7096>] mutex_lock+0x12/0x15
 [<c01b99be>] jfs_create+0x90/0x2b8
 [<c0161016>] vfs_create+0x91/0xda
 [<c0163939>] open_namei+0x15a/0x5b0
 [<c015326c>] do_filp_open+0x22/0x39
 [<c01541a8>] do_sys_open+0x40/0xbc
 [<c015424d>] sys_open+0x13/0x15
 [<c02f875d>] sysenter_past_esp+0x56/0x8d

-- 
/Evgeniy

