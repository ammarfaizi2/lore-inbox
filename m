Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUDZOUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUDZOUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUDZOUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:20:15 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:9609 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261998AbUDZOT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 10:19:58 -0400
Date: Mon, 26 Apr 2004 07:19:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: claus.rosenberger@rocnet.de
Subject: [Bug 2594] New: kernel BUG at	drivers/block/ll_rw_blk.c:2467! with ext3 and 3ware 
Message-ID: <710700000.1082989190@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2594

           Summary: kernel BUG at drivers/block/ll_rw_blk.c:2467! with ext3
                    and 3ware
    Kernel Version: 2.6.5
            Status: NEW
          Severity: normal
             Owner: axboe@suse.de
         Submitter: claus.rosenberger@rocnet.de


Distribution: kernel BUG at drivers/block/ll_rw_blk.c:2467!
Hardware Environment: AMD Athlon XP, Nvidia NForce2 Chipset, 3ware ATA Raid
Controller
Software Environment: Debian Sarge with Kernel 2.6.5
Problem Description: the server stops working after this error appears, no
reboot is possible, only hardware reset, but the server doesn't freeze. i don't
use software-raid. i use hardware ide-raid with a 3ware 7006-2 and an ext3
filesystem.

Steps to reproduce: until now i didn't find a way to reproduce this error.


detail kernel message:

Apr 26 08:42:16 deathstar kernel: ------------[ cut here ]------------
Apr 26 08:42:16 deathstar kernel: kernel BUG at drivers/block/ll_rw_blk.c:2467!
Apr 26 08:42:16 deathstar kernel: invalid operand: 0000 [#1]
Apr 26 08:42:16 deathstar kernel: PREEMPT 
Apr 26 08:42:16 deathstar kernel: CPU:    0
Apr 26 08:42:16 deathstar kernel: EIP:    0060:[submit_bio+97/112]    Not tainte
d
Apr 26 08:42:16 deathstar kernel: EFLAGS: 00010246   (2.6.5-RoCNet-TS) 
Apr 26 08:42:16 deathstar kernel: EIP is at submit_bio+0x61/0x70
Apr 26 08:42:16 deathstar kernel: eax: 00000000   ebx: 00000000   ecx: 00000001 
  edx: c0f4ccc0
Apr 26 08:42:16 deathstar kernel: esi: 0000002e   edi: 00000001   ebp: 00000040 
  esp: d020bc0c
Apr 26 08:42:16 deathstar kernel: ds: 007b   es: 007b   ss: 0068
Apr 26 08:42:16 deathstar kernel: Process dpkg (pid: 4612, threadinfo=d020a000 t
ask=d039b980)
Apr 26 08:42:16 deathstar kernel: Stack: d5421db0 d5421db0 c014e9f0 00000001 c0f
4ccc0 d020a000 d020bc98 d020bca0 
Apr 26 08:42:16 deathstar kernel:        d020bc98 c0196365 00000001 00000040 d02
0bca0 d5421f00 d020bc9c 00000001 
Apr 26 08:42:16 deathstar kernel:        c0196455 f7d24c80 d020bca0 d020bc98 000
1d6d1 c0333540 f6772db0 00000000 
Apr 26 08:42:16 deathstar kernel: Call Trace:
Apr 26 08:42:16 deathstar kernel:  [ll_rw_block+96/128] ll_rw_block+0x60/0x80
Apr 26 08:42:16 deathstar kernel:  [__flush_batch+53/112] __flush_batch+0x35/0x7
0
Apr 26 08:42:16 deathstar kernel:  [__flush_buffer+181/352] __flush_buffer+0xb5/
0x160
Apr 26 08:42:16 deathstar kernel:  [log_do_checkpoint+167/432] log_do_checkpoint
+0xa7/0x1b0
Apr 26 08:42:16 deathstar kernel:  [__log_wait_for_space+143/192] __log_wait_for
_space+0x8f/0xc0
Apr 26 08:42:16 deathstar kernel:  [start_this_handle+248/960] start_this_handle
+0xf8/0x3c0
Apr 26 08:42:16 deathstar kernel:  [autoremove_wake_function+0/80] autoremove_wa
ke_function+0x0/0x50
Apr 26 08:42:16 deathstar kernel:  [autoremove_wake_function+0/80] autoremove_wa
ke_function+0x0/0x50
Apr 26 08:42:16 deathstar kernel:  [journal_start+169/208] journal_start+0xa9/0x
d0
Apr 26 08:42:16 deathstar kernel:  [journal_get_write_access+67/96] journal_get_
write_access+0x43/0x60
Apr 26 08:42:16 deathstar kernel:  [ext3_rename+43/1423] ext3_rename+0x2b/0x58f
Apr 26 08:42:16 deathstar kernel:  [vfs_rename_other+161/224] vfs_rename_other+0
xa1/0xe0
Apr 26 08:42:16 deathstar kernel:  [vfs_rename+391/1040] vfs_rename+0x187/0x410
Apr 26 08:42:16 deathstar kernel:  [sys_rename+496/544] sys_rename+0x1f0/0x220
Apr 26 08:42:16 deathstar kernel:  [__fput+187/288] __fput+0xbb/0x120
Apr 26 08:42:16 deathstar kernel:  [sys_close+97/160] sys_close+0x61/0xa0
Apr 26 08:42:16 deathstar kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 26 08:42:16 deathstar kernel: 
Apr 26 08:42:16 deathstar kernel: Code: 0f 0b a3 09 55 3e 28 c0 eb b0 90 8d 74 2
6 00 53 8b 5c 24 08


