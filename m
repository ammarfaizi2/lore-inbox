Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWCRUXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWCRUXP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWCRUXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:23:15 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:16348 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750927AbWCRUXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:23:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc6-mm2
Date: Sat, 18 Mar 2006 21:21:57 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060318044056.350a2931.akpm@osdl.org>
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182121.58071.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 13:40, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/

I get the following oops from it 100% of the time (on boot):

Trying to free ramdisk memory ... ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/buffer.c:1629
invalid opcode: 0000 [1] PREEMPT
last sysfs file: /block/hdc/range
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.16-rc6-mm2 #16
RIP: 0010:[<ffffffff80280d9a>] <ffffffff80280d9a>{block_invalidatepage+202}
RSP: 0000:ffff81005ff07ac8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff810037c09138 RCX: ffff810037c09228
RDX: 0000000000000000 RSI: ffff81005ff07a88 RDI: 0000000000000000
RBP: ffff81005ff07af8 R08: 0000000000000002 R09: ffff81005ff07a99
R10: ffff810037c09138 R11: 0000000000000010 R12: ffff810037c09138
R13: 0000000000001000 R14: ffff810037c09138 R15: ffff810001c34e28
FS:  0000000000000000(0000) GS:ffffffff80690000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002afbe89a3000 CR3: 000000005fe36000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff81005ff06000, task ffff81005ff05530)
Stack: 0000000000000000 ffff810001c34e28 0000000000000002 0000000000000001
       ffff810037df47e0 ffffffffffffffff ffff81005ff07b08 ffffffff8027f7b3
       ffff81005ff07b28 ffffffff802610d5
Call Trace: <ffffffff8027f7b3>{do_invalidatepage+35}
       <ffffffff802610d5>{truncate_complete_page+37} <ffffffff8026154f>{truncate_inode_pages_range+207}
       <ffffffff802617c0>{truncate_inode_pages+16} <ffffffff803bac96>{rd_ioctl+86}
       <ffffffff8034541d>{blkdev_driver_ioctl+109} <ffffffff80345574>{blkdev_ioctl+164}
       <ffffffff8046bb1d>{_spin_unlock_irqrestore+29} <ffffffff8022cdb7>{release_console_sem+423}
       <ffffffff8022da48>{vprintk+824} <ffffffff8046bbd3>{_spin_unlock+19}
       <ffffffff80284dec>{put_super+44} <ffffffff80284f91>{deactivate_super+145}
       <ffffffff8028617b>{block_ioctl+27} <ffffffff80292801>{do_ioctl+49}
       <ffffffff80292b1b>{vfs_ioctl+683} <ffffffff80292baa>{sys_ioctl+106}
       <ffffffff8069c6d1>{initrd_load+737} <ffffffff80699e1b>{prepare_namespace+139}
       <ffffffff8020722c>{init+460} <ffffffff8046bad4>{_spin_unlock_irq+20}
       <ffffffff80228b09>{schedule_tail+73} <ffffffff8020a8de>{child_rip+8}
       <ffffffff80207060>{init+0} <ffffffff8020a8d6>{child_rip+0}

Code: 0f 0b 68 b9 80 49 80 c2 5d 06 48 8b 5d d8 4c 8b 65 e0 4c 8b
RIP <ffffffff80280d9a>{block_invalidatepage+202} RSP <ffff81005ff07ac8>
 <0>Kernel panic - not syncing: Attempted to kill init!

Of course booting with "noinitrd" helps.

Greetings,
Rafael

