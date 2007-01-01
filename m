Return-Path: <linux-kernel-owner+w=401wt.eu-S932878AbXAADAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878AbXAADAI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 22:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbXAADAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 22:00:07 -0500
Received: from squeaker.ratbox.org ([66.212.148.233]:45189 "EHLO
	squeaker.ratbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878AbXAADAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 22:00:06 -0500
Date: Sun, 31 Dec 2006 22:00:04 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: linux-kernel@vger.kernel.org
Subject: BUG: scheduling while atomic on 2.6.20-rc2-git1 on x86-64
Message-ID: <Pine.LNX.4.64.0612312158140.31290@squeaker.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got the following trace on 2.6.20-rc2-git2 on x86-64.  Let me know if 
there is additional details that is needed.

-Aaron

BUG: scheduling while atomic: hald-addon-stor/0x20000000/2902

Call Trace:
  [<ffffffff8055043d>] __sched_text_start+0x5d/0x834
  [<ffffffff8022b6c3>] __wake_up+0x43/0x70
  [<ffffffff80425ce0>] scsi_done+0x0/0x20
  [<ffffffff80442ed0>] atapi_xlat+0x0/0x120
  [<ffffffff8022ddcc>] __cond_resched+0x1c/0x50
  [<ffffffff80550d29>] cond_resched+0x29/0x40
  [<ffffffff80552d66>] __reacquire_kernel_lock+0x26/0x47
  [<ffffffff80550cb8>] thread_return+0xa4/0xec
  [<ffffffff80425ce0>] scsi_done+0x0/0x20
  [<ffffffff8022ddcc>] __cond_resched+0x1c/0x50
  [<ffffffff80550d29>] cond_resched+0x29/0x40
  [<ffffffff80550d77>] wait_for_completion+0x17/0xf0
  [<ffffffff8038cbe8>] blk_execute_rq_nowait+0x88/0xb0
  [<ffffffff8038ccce>] blk_execute_rq+0xbe/0x110
  [<ffffffff8038ce27>] get_request_wait+0x37/0x170
  [<ffffffff8042c1ed>] scsi_execute+0xed/0x120
  [<ffffffff8042c2ef>] scsi_execute_req+0xcf/0x110
  [<ffffffff804272c4>] ioctl_internal_command+0x74/0x1a0
  [<ffffffff8042743f>] scsi_set_medium_removal+0x4f/0x90
  [<ffffffff802a2268>] bd_claim+0x18/0x80
  [<ffffffff802a32b0>] blkdev_open+0x0/0x80
  [<ffffffff8044aaba>] cdrom_release+0x1ba/0x240
  [<ffffffff8027a065>] __dentry_open+0x115/0x1e0
  [<ffffffff804348b9>] sr_block_release+0x29/0x50
  [<ffffffff802a2aee>] __blkdev_put+0x7e/0x160
  [<ffffffff8027cdc5>] __fput+0xc5/0x1c0
  [<ffffffff80279e41>] filp_close+0x71/0x90
  [<ffffffff8027b4b2>] sys_close+0x92/0xf0
  [<ffffffff8020a03e>] system_call+0x7e/0x83



