Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWAKU1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWAKU1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWAKU1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:27:14 -0500
Received: from cantor2.suse.de ([195.135.220.15]:2438 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964817AbWAKU1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:27:14 -0500
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-git7 oopses in ext3 during LTP runs
Date: Wed, 11 Jan 2006 21:26:59 +0100
User-Agent: KMail/1.8.2
Cc: sct@redhat.com, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601112126.59796.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running LTP with the default runfile on a 4 virtual CPU x86-64 
system gives

To reproduce: run ltp 20040908 (newer one will probably work
too) with runltp -p -q -l `uname -r` on a ext3 file system

config is x86-64 defconfig.

-Andi

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at /home/lsrc/quilt/linux/fs/ext3/super.c:2154
invalid opcode: 0000 [1] SMP 
CPU 0 
Modules linked in:
Pid: 14055, comm: pdflush Not tainted 2.6.15-git7 #90
RIP: 0010:[<ffffffff801d998e>] <ffffffff801d998e>{ext3_write_super+20}
RSP: 0018:ffff810117fb1e08  EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff81011f9ae800 RCX: ffffffff80492060
RDX: 0000000000000000 RSI: ffff810117fb0000 RDI: ffff81011f9ae888
RBP: ffff81011f9ae888 R08: ffff810117fb0000 R09: ffff810004f219e0
R10: 0000000000000000 R11: 0000000000000002 R12: ffff81011f9ae870
R13: ffffffff80159aee R14: ffff8100cdce1d68 R15: ffffffff80146b14
FS:  0000000000000000(0000) GS:ffffffff8060d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaab61000 CR3: 000000011baf3000 CR4: 00000000000006e0
Process pdflush (pid: 14055, threadinfo ffff810117fb0000, task ffff81011fe5c400)
Stack: ffff81011f9ae800 ffffffff8017aa43 0000000000000064 0000000000000000 
       ffff8100cdce1d78 ffffffff801592f9 ffff81011fe5c400 ffffffff80494000 
       0000000000000000 0000000000000000 
Call Trace: <ffffffff8017aa43>{sync_supers+133} <ffffffff801592f9>{wb_kupdate+49}
       <ffffffff80159aee>{pdflush+0} <ffffffff80159c40>{pdflush+338}
       <ffffffff801592c8>{wb_kupdate+0} <ffffffff80146c7f>{kthread+203}
       <ffffffff801107ca>{child_rip+8} <ffffffff80146b14>{keventd_create_kthread+0}
       <ffffffff80146bb4>{kthread+0} <ffffffff801107c2>{child_rip+0}

Code: 0f 0b 68 e9 0d 43 80 c2 6a 08 c6 43 21 00 5b c3 49 c7 c0 ca 
RIP <ffffffff801d998e>{ext3_write_super+20} RSP <ffff810117fb1e08>
 Badness in do_exit at /home/lsrc/quilt/linux/kernel/exit.c:796

Call Trace: <ffffffff80136800>{do_exit+84} <ffffffff804024dd>{_spin_unlock_irqrestore+8}
       <ffffffff80146b14>{keventd_create_kthread+0} <ffffffff801114ef>{kernel_math_error+0}
       <ffffffff80159aee>{pdflush+0} <ffffffff80111c61>{do_invalid_op+163}
       <ffffffff801d998e>{ext3_write_super+20} <ffffffff8040116a>{thread_return+0}
       <ffffffff80110611>{error_exit+0} <ffffffff80146b14>{keventd_create_kthread+0}
       <ffffffff80159aee>{pdflush+0} <ffffffff801d998e>{ext3_write_super+20}
       <ffffffff801d998a>{ext3_write_super+16} <ffffffff8017aa43>{sync_supers+133}
       <ffffffff801592f9>{wb_kupdate+49} <ffffffff80159aee>{pdflush+0}
       <ffffffff80159c40>{pdflush+338} <ffffffff801592c8>{wb_kupdate+0}
       <ffffffff80146c7f>{kthread+203} <ffffffff801107ca>{child_rip+8}
       <ffffffff80146b14>{keventd_create_kthread+0} <ffffffff80146bb4>{kthread+0}
       <ffffffff801107c2>{child_rip+0}


