Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266112AbSKLCk1>; Mon, 11 Nov 2002 21:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266125AbSKLCk1>; Mon, 11 Nov 2002 21:40:27 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:55252 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266112AbSKLCkZ>; Mon, 11 Nov 2002 21:40:25 -0500
Date: Tue, 12 Nov 2002 15:47:06 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Oopsen with pcmcia aironet wireless (2.5.47)
Message-ID: <5860000.1037069226@localhost.localdomain>
X-Mailer: Mulberry/3.0.0a5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see lots of oopsen when I insert an Aironet PC4800 802.11 card.

Dell Inspiron 8000
Red Hat 8.0 + linux 2.5.47

Nov 12 15:40:38 localhost cardmgr[647]: socket 1: Aironet PC4800
Nov 12 15:40:38 localhost kernel: cs: memory probe 0xa0000000-0xa0ffffff: 
clean.Nov 12 15:40:38 localhost cardmgr[647]: executing: 'modprobe airo_cs'
Nov 12 15:40:38 localhost kernel: airo:  Probing for PCI adapters
Nov 12 15:40:38 localhost kernel: airo:  Finished probing for PCI adapters
Nov 12 15:40:38 localhost kernel: airo: MAC enabled eth1 0:40:96:28:c5:9c
Nov 12 15:40:38 localhost kernel: eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 
3, io
0x0100-0x013f
Nov 12 15:40:38 localhost cardmgr[647]: executing: './network start eth1'
Nov 12 15:40:38 localhost /etc/hotplug/net.agent: invoke ifup eth1
Nov 12 15:40:38 localhost /etc/hotplug/net.agent: invoke ifup wifi0
Nov 12 15:40:39 localhost kernel: end_request: I/O error, dev hdb, sector 0
Nov 12 15:40:39 localhost last message repeated 3 times
Nov 12 15:40:39 localhost kernel: end_request: I/O error, dev hdc, sector 0
Nov 12 15:40:39 localhost last message repeated 2 times
Nov 12 15:40:39 localhost kernel: Debug: sleeping function called from 
illegal context at include/asm/semaphore.h:145
Nov 12 15:40:39 localhost kernel: Call Trace:
Nov 12 15:40:39 localhost kernel:  [<e1a59215>] PC4500_readrid+0x55/0x160 
[airo]Nov 12 15:40:39 localhost kernel:  [<e1a5f5fa>] 
.rodata.str1.1+0x2e2/0x73f [airo]
Nov 12 15:40:39 localhost kernel:  [<e1a566a9>] readStatsRid+0x29/0x50 
[airo]
Nov 12 15:40:39 localhost kernel:  [<e1a56c99>] airo_get_stats+0x29/0xe0 
[airo]
Nov 12 15:40:39 localhost kernel:  [<c013f82c>] __pagevec_free+0x1c/0x30
Nov 12 15:40:39 localhost kernel:  [<c013d29e>] release_pages+0x14e/0x180
Nov 12 15:40:39 localhost kernel:  [<c013f3c1>] buffered_rmqueue+0xb1/0x150
Nov 12 15:40:39 localhost kernel:  [<c013f4e4>] __alloc_pages+0x84/0x2c0
Nov 12 15:40:39 localhost kernel:  [<c013d2f3>] __pagevec_release+0x23/0x40
Nov 12 15:40:39 localhost kernel:  [<c0133b68>] 
do_anonymous_page+0x1b8/0x1e0
Nov 12 15:40:39 localhost kernel:  [<c0176578>] proc_alloc_inode+0x18/0x50
Nov 12 15:40:39 localhost kernel:  [<c0163f03>] alloc_inode+0x173/0x1a0
Nov 12 15:40:39 localhost kernel:  [<c0176578>] proc_alloc_inode+0x18/0x50
Nov 12 15:40:39 localhost kernel:  [<c01648d7>] 
get_new_inode_fast+0x47/0x100
Nov 12 15:40:39 localhost kernel:  [<c0164c40>] iget_locked+0x70/0x80
Nov 12 15:40:39 localhost kernel:  [<c01651af>] wake_up_inode+0xf/0xd0
Nov 12 15:40:39 localhost kernel:  [<c021bf57>] vsnprintf+0x207/0x450
Nov 12 15:40:39 localhost kernel:  [<c021c1f7>] vsprintf+0x27/0x30
Nov 12 15:40:39 localhost kernel:  [<c021c21f>] sprintf+0x1f/0x30
Nov 12 15:40:39 localhost kernel:  [<c0331b1b>] sprintf_stats+0xeb/0x100
Nov 12 15:40:39 localhost kernel:  [<c0331b82>] dev_get_info+0x52/0xc0
Nov 12 15:40:39 localhost kernel:  [<c0178aa1>] proc_file_read+0x1a1/0x1c0
Nov 12 15:40:39 localhost kernel:  [<c014c57c>] vfs_read+0xdc/0x150
Nov 12 15:40:39 localhost kernel:  [<c01108ff>] sys_mmap2+0x9f/0xe0
Nov 12 15:40:39 localhost kernel:  [<c014c83e>] sys_read+0x3e/0x60
Nov 12 15:40:39 localhost kernel:  [<c010b183>] syscall_call+0x7/0xb
Nov 12 15:40:39 localhost kernel:
Nov 12 15:40:40 localhost kernel: Debug: sleeping function called from 
illegal context at include/asm/semaphore.h:145
Nov 12 15:40:40 localhost kernel: Call Trace:
Nov 12 15:40:40 localhost kernel:  [<e1a59215>] PC4500_readrid+0x55/0x160 
[airo]Nov 12 15:40:40 localhost kernel:  [<e1a5f5fa>] 
.rodata.str1.1+0x2e2/0x73f [airo]
Nov 12 15:40:40 localhost kernel:  [<e1a566a9>] readStatsRid+0x29/0x50 
[airo]
Nov 12 15:40:40 localhost kernel:  [<e1a56c99>] airo_get_stats+0x29/0xe0 
[airo]
Nov 12 15:40:40 localhost kernel:  [<c0176578>] proc_alloc_inode+0x18/0x50
Nov 12 15:40:40 localhost kernel:  [<c0163f03>] alloc_inode+0x173/0x1a0
Nov 12 15:40:40 localhost kernel:  [<c0176578>] proc_alloc_inode+0x18/0x50
Nov 12 15:40:40 localhost kernel:  [<c01648d7>] 
get_new_inode_fast+0x47/0x100
Nov 12 15:40:40 localhost kernel:  [<c0164c40>] iget_locked+0x70/0x80
Nov 12 15:40:40 localhost kernel:  [<c01651af>] wake_up_inode+0xf/0xd0
Nov 12 15:40:40 localhost kernel:  [<c021bf57>] vsnprintf+0x207/0x450
Nov 12 15:40:40 localhost kernel:  [<c021c1f7>] vsprintf+0x27/0x30
Nov 12 15:40:40 localhost kernel:  [<c021c21f>] sprintf+0x1f/0x30
Nov 12 15:40:40 localhost kernel:  [<c0331b1b>] sprintf_stats+0xeb/0x100
Nov 12 15:40:40 localhost kernel:  [<c0331b82>] dev_get_info+0x52/0xc0
Nov 12 15:40:40 localhost kernel:  [<c0178aa1>] proc_file_read+0x1a1/0x1c0
Nov 12 15:40:40 localhost kernel:  [<c014c57c>] vfs_read+0xdc/0x150
Nov 12 15:40:40 localhost kernel:  [<c01108ff>] sys_mmap2+0x9f/0xe0
Nov 12 15:40:40 localhost kernel:  [<c014c83e>] sys_read+0x3e/0x60
Nov 12 15:40:40 localhost kernel:  [<c010b183>] syscall_call+0x7/0xb
Nov 12 15:40:40 localhost kernel:
Nov 12 15:40:40 localhost kernel: bad: scheduling while atomic!
Nov 12 15:40:40 localhost kernel: Call Trace:
Nov 12 15:40:40 localhost kernel:  [<c0118dfb>] schedule+0x30b/0x310
Nov 12 15:40:40 localhost kernel:  [<e1a58bc0>] issuecommand+0x60/0x90 
[airo]
Nov 12 15:40:40 localhost kernel:  [<e1a59187>] PC4500_accessrid+0x57/0x90 
[airo]
Nov 12 15:40:40 localhost kernel:  [<e1a59242>] PC4500_readrid+0x82/0x160 
[airo]Nov 12 15:40:40 localhost kernel:  [<e1a566a9>] 
readStatsRid+0x29/0x50 [airo]
Nov 12 15:40:40 localhost kernel:  [<e1a56c99>] airo_get_stats+0x29/0xe0 
[airo]
Nov 12 15:40:40 localhost kernel:  [<c021bf57>] vsnprintf+0x207/0x450
Nov 12 15:40:40 localhost kernel:  [<c021c1f7>] vsprintf+0x27/0x30
Nov 12 15:40:40 localhost kernel:  [<c021c21f>] sprintf+0x1f/0x30
Nov 12 15:40:40 localhost kernel:  [<c0331b1b>] sprintf_stats+0xeb/0x100
Nov 12 15:40:40 localhost kernel:  [<c0331b82>] dev_get_info+0x52/0xc0
Nov 12 15:40:40 localhost kernel:  [<c0178aa1>] proc_file_read+0x1a1/0x1c0
Nov 12 15:40:40 localhost kernel:  [<c014c57c>] vfs_read+0xdc/0x150
Nov 12 15:40:40 localhost kernel:  [<c01108ff>] sys_mmap2+0x9f/0xe0
Nov 12 15:40:40 localhost kernel:  [<c014c83e>] sys_read+0x3e/0x60
Nov 12 15:40:40 localhost kernel:  [<c010b183>] syscall_call+0x7/0xb
Nov 12 15:40:40 localhost kernel:
Nov 12 15:40:41 localhost kernel: Debug: sleeping function called from 
illegal context at include/asm/semaphore.h:145
Nov 12 15:40:41 localhost kernel: Call Trace:
Nov 12 15:40:41 localhost kernel:  [<e1a59215>] PC4500_readrid+0x55/0x160 
[airo]Nov 12 15:40:41 localhost kernel:  [<e1a5f5fa>] 
.rodata.str1.1+0x2e2/0x73f [airo]
Nov 12 15:40:41 localhost kernel:  [<e1a566a9>] readStatsRid+0x29/0x50 
[airo]
Nov 12 15:40:41 localhost kernel:  [<e1a56c99>] airo_get_stats+0x29/0xe0 
[airo]
Nov 12 15:40:41 localhost kernel:  [<c0176578>] proc_alloc_inode+0x18/0x50
Nov 12 15:40:41 localhost kernel:  [<c0163f03>] alloc_inode+0x173/0x1a0
Nov 12 15:40:41 localhost kernel:  [<c0176578>] proc_alloc_inode+0x18/0x50
Nov 12 15:40:41 localhost kernel:  [<c01648d7>] 
get_new_inode_fast+0x47/0x100
Nov 12 15:40:41 localhost kernel:  [<c0164c40>] iget_locked+0x70/0x80
Nov 12 15:40:41 localhost kernel:  [<c01651af>] wake_up_inode+0xf/0xd0
Nov 12 15:40:41 localhost kernel:  [<c021bf57>] vsnprintf+0x207/0x450
Nov 12 15:40:41 localhost kernel:  [<c021c1f7>] vsprintf+0x27/0x30
Nov 12 15:40:41 localhost kernel:  [<c021c21f>] sprintf+0x1f/0x30
Nov 12 15:40:41 localhost kernel:  [<c0331b1b>] sprintf_stats+0xeb/0x100
Nov 12 15:40:41 localhost kernel:  [<c0331b82>] dev_get_info+0x52/0xc0
Nov 12 15:40:41 localhost kernel:  [<c0178aa1>] proc_file_read+0x1a1/0x1c0
Nov 12 15:40:41 localhost kernel:  [<c014c57c>] vfs_read+0xdc/0x150
Nov 12 15:40:41 localhost kernel:  [<c01108ff>] sys_mmap2+0x9f/0xe0
Nov 12 15:40:41 localhost kernel:  [<c014c83e>] sys_read+0x3e/0x60
Nov 12 15:40:41 localhost kernel:  [<c010b183>] syscall_call+0x7/0xb
Nov 12 15:40:41 localhost kernel:
Nov 12 15:40:42 localhost kernel: Debug: sleeping function called from 
illegal context at include/asm/semaphore.h:145
Nov 12 15:40:42 localhost kernel: Call Trace:
Nov 12 15:40:42 localhost kernel:  [<e1a59215>] PC4500_readrid+0x55/0x160 
[airo]Nov 12 15:40:42 localhost kernel:  [<e1a5f5fa>] 
.rodata.str1.1+0x2e2/0x73f [airo]
Nov 12 15:40:42 localhost kernel:  [<e1a566a9>] readStatsRid+0x29/0x50 
[airo]
Nov 12 15:40:42 localhost kernel:  [<e1a56c99>] airo_get_stats+0x29/0xe0 
[airo]
Nov 12 15:40:42 localhost kernel:  [<c0176578>] proc_alloc_inode+0x18/0x50
Nov 12 15:40:42 localhost kernel:  [<c0163f03>] alloc_inode+0x173/0x1a0
Nov 12 15:40:42 localhost kernel:  [<c0176578>] proc_alloc_inode+0x18/0x50
Nov 12 15:40:42 localhost kernel:  [<c01648d7>] 
get_new_inode_fast+0x47/0x100
Nov 12 15:40:42 localhost kernel:  [<c0164c40>] iget_locked+0x70/0x80
Nov 12 15:40:42 localhost kernel:  [<c01651af>] wake_up_inode+0xf/0xd0
Nov 12 15:40:42 localhost kernel:  [<c021bf57>] vsnprintf+0x207/0x450
Nov 12 15:40:42 localhost kernel:  [<c021c1f7>] vsprintf+0x27/0x30
Nov 12 15:40:42 localhost kernel:  [<c021c21f>] sprintf+0x1f/0x30
Nov 12 15:40:42 localhost kernel:  [<c0331b1b>] sprintf_stats+0xeb/0x100
Nov 12 15:40:42 localhost kernel:  [<c0331b82>] dev_get_info+0x52/0xc0
Nov 12 15:40:42 localhost kernel:  [<c0178aa1>] proc_file_read+0x1a1/0x1c0
Nov 12 15:40:42 localhost kernel:  [<c014c57c>] vfs_read+0xdc/0x150
Nov 12 15:40:42 localhost kernel:  [<c01108ff>] sys_mmap2+0x9f/0xe0
Nov 12 15:40:42 localhost kernel:  [<c014c83e>] sys_read+0x3e/0x60
Nov 12 15:40:42 localhost kernel:  [<c010b183>] syscall_call+0x7/0xb
Nov 12 15:40:42 localhost kernel:

