Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTL1UHM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 15:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTL1UHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 15:07:12 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:60312 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261973AbTL1UHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 15:07:10 -0500
Date: Sun, 28 Dec 2003 12:07:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: pivi@pivistrello.it
Subject: [Bug 1758] New: kernel BUG at fs/buffer.c:2658!
Message-ID: <7440000.1072642028@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1758

           Summary: kernel BUG at fs/buffer.c:2658!
    Kernel Version: 2.6.0
            Status: NEW
          Severity: normal
             Owner: fs_vfs@kernel-bugs.osdl.org
         Submitter: pivi@pivistrello.it


Distribution: debian unstable updated at 27 dec 2003
Hardware Environment: intel p3 650 speedstep notebook


Steps to reproduce: umounting a loop device, I was just playing with 
crypto-loop and I don't remember what I was doing exactly. 
(playing with losetup, mounting and umounting)

EXT3 FS on loop0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
------------[ cut here ]------------
kernel BUG at fs/buffer.c:2658!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01493b6>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bh+0x1e/0x114
eax: 00000005   ebx: c4212850   ecx: c0c72860   edx: c4212d30
esi: 00000001   edi: c6dd0400   ebp: cc5b9800   esp: c3463ed0
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 2128, threadinfo=c3462000 task=ce712690)
Stack: c4212850 00000002 c0149592 00000001 c4212850 c4212850 cc5b9800 c017c869 
       c4212850 c6dd0400 c0c72860 c02ac6e0 c017ae56 cc5b9800 c6dd0400 00000001 
       00000000 cc5b9800 c02ac6e0 cc5b9850 c014a8d1 cc5b9800 cc5b9800 cffe1740 
Call Trace:
 [<c0149592>] sync_dirty_buffer+0x6a/0x94
 [<c017c869>] ext3_commit_super+0x49/0x54
 [<c017ae56>] ext3_put_super+0x52/0x148
 [<c014a8d1>] generic_shutdown_super+0x95/0x15c
 [<c014b36e>] kill_block_super+0x12/0x2c
 [<c014a741>] deactivate_super+0x55/0x8c
 [<c015d1a2>] __mntput+0x1e/0x24
 [<c0150b0b>] path_release+0x27/0x2c
 [<c015d825>] sys_umount+0x71/0x7c
 [<c013c923>] sys_munmap+0x37/0x54
 [<c015d83c>] sys_oldumount+0xc/0x10
 [<c0108caf>] syscall_call+0x7/0xb

Code: 0f 0b 62 0a 51 4a 26 c0 89 f6 83 7b 20 00 75 0a 0f 0b 63 0a 
 <6>kjournald starting.  Commit interval 5 seconds
EXT3 FS on loop1, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.


