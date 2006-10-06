Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422817AbWJFSUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWJFSUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWJFSUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:20:46 -0400
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:45260 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1422817AbWJFSUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:20:45 -0400
Date: Fri, 6 Oct 2006 20:20:38 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.19-rc1] possible recursive locking detected
Message-ID: <20061006202038.63561735@localhost>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ uname -a
Linux tux 2.6.19-rc1 #1 PREEMPT Thu Oct 5 18:18:18 CEST 2006 x86_64 AMD Athlon(tm) 64 Processor 3200+ GNU/Linux


=============================================
[ INFO: possible recursive locking detected ]
2.6.19-rc1 #1
---------------------------------------------
fuser/13370 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<ffffffff804b9c52>] mutex_lock+0x25/0x2a

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<ffffffff804b9c52>] mutex_lock+0x25/0x2a

other info that might help us debug this:
1 lock held by fuser/13370:
 #0:  (&inode->i_mutex){--..}, at: [<ffffffff804b9c52>] mutex_lock+0x25/0x2a

stack backtrace:

Call Trace:
 [<ffffffff8023ed7e>] __lock_acquire+0x146/0xa31
 [<ffffffff8023e162>] find_usage_backwards+0x7c/0xb1
 [<ffffffff804b9c52>] mutex_lock+0x25/0x2a
 [<ffffffff8023f6e4>] lock_acquire+0x7b/0xa1
 [<ffffffff804b9c52>] mutex_lock+0x25/0x2a
 [<ffffffff804b9a94>] __mutex_lock_slowpath+0xd2/0x26b
 [<ffffffff804b9c52>] mutex_lock+0x25/0x2a
 [<ffffffff80274b51>] pipe_read_fasync+0x31/0x6b
 [<ffffffff80274efa>] pipe_read_release+0x16/0x29
 [<ffffffff8026fefc>] __fput+0xc2/0x1e6
 [<ffffffff80270033>] fput+0x13/0x15
 [<ffffffff8026d55d>] filp_close+0x65/0x70
 [<ffffffff80228889>] put_files_struct+0x73/0xca
 [<ffffffff802a47ae>] proc_readfd+0x1e6/0x20e
 [<ffffffff8027ac18>] filldir+0x0/0xc5
 [<ffffffff8027ac18>] filldir+0x0/0xc5
 [<ffffffff8027ad42>] vfs_readdir+0x65/0x9a
 [<ffffffff8027afb6>] sys_getdents+0x7a/0xc4
 [<ffffffff8020988e>] system_call+0x7e/0x83

-- 
	Paolo Ornati
	Linux 2.6.19-rc1 on x86_64
