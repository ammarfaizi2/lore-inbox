Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263640AbTCUQI6>; Fri, 21 Mar 2003 11:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263643AbTCUQI6>; Fri, 21 Mar 2003 11:08:58 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:59288 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263640AbTCUQI4>; Fri, 21 Mar 2003 11:08:56 -0500
Date: Fri, 21 Mar 2003 16:19:54 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.65 ext3/nfsd oops.
Message-ID: <20030321161954.GD3762@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Box was serving ext3 mount over NFS, client was beating up with fsx,
whilst cron.daily's updatedb was running.

Assertion failure in journal_dirty_metadata() at fs/jbd/transaction.c:1072: "jh->b_jlist != 1"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:1072!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01d141d>]    Not tainted
EFLAGS: 00010286
EIP is at journal_dirty_metadata+0x25d/0x3a0
eax: 00000062   ebx: c6674a48   ecx: c64c2cc0   edx: c05c1798
esi: c7281b34   edi: c29473b8   ebp: c64a7adc   esp: c64a7ab0
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 238, threadinfo=c64a6000 task=c64c2cc0)
Stack: c0555c40 c053588a c0550152 00000430 c05502a5 c64a7ae8 c01d07d2 c7281a00 
       c69b9cdc c67e38bc 00000000 c64a7b0c c01befd3 c67e38bc c69b9cdc c01be9ee 
       c67e38bc c69b9cdc 00001000 c7281b34 c69b9cdc c69b9cdc 00001000 c64a7b2c 
Call Trace:
 [<c01d07d2>] journal_get_write_access+0x72/0xa0
 [<c01befd3>] commit_write_fn+0x23/0x80
 [<c01be9ee>] do_journal_get_write_access+0x1e/0x80
 [<c01be9c0>] walk_page_buffers+0x70/0x80
 [<c01bf161>] ext3_commit_write+0x131/0x3f0
 [<c01befb0>] commit_write_fn+0x0/0x80
 [<c014c1c4>] generic_file_aio_write_nolock+0x414/0xab0
 [<c046aa13>] do_rw_disk+0x593/0x900
 [<c035a504>] __delay+0x14/0x20
 [<c01539b9>] kmalloc+0x169/0x1c0
 [<c04a8efe>] alloc_skb+0xae/0x260
 [<c015188b>] check_poison_obj+0x3b/0x1b0
 [<c014c8d8>] generic_file_write_nolock+0x78/0x90
 [<c01d144a>] journal_dirty_metadata+0x28a/0x3a0
 [<c04a8efe>] alloc_skb+0xae/0x260
 [<c0453b68>] boomerang_rx+0x178/0x430
 [<c050d84b>] packet_rcv_spkt+0xbb/0x4d0
 [<c014cb1d>] generic_file_writev+0x5d/0x80
 [<c01708d6>] do_readv_writev+0x146/0x300
 [<c0170360>] do_sync_write+0x0/0xc0
 [<c0170b65>] vfs_writev+0x65/0x70
 [<c02166e6>] nfsd_write+0x116/0x390
 [<c0121c9a>] __wake_up_common+0x3a/0x60
 [<c021de7d>] nfsd3_proc_write+0xbd/0x160
 [<c0211f57>] nfsd_dispatch+0xe7/0x200
 [<c0523c4a>] svc_process+0x4fa/0x690
 [<c02119d1>] nfsd+0x331/0x7d0
 [<c02116a0>] nfsd+0x0/0x7d0
 [<c01075fd>] kernel_thread_helper+0x5/0x18

Code: 0f 0b 30 04 52 01 55 c0 e9 0f ff ff ff 8b 7b 0c 85 ff 75 1e 
 <6>note: nfsd[238] exited with preempt_count 2
fs/jbd/journal.c:1746: spin_lock(fs/jbd/journal.c:c05c7908) already locked by fs/jbd/transaction.c/1052

