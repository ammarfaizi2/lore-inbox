Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270858AbTHSQSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270805AbTHSQPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:15:42 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S270984AbTHSQNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:13:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: 2.6.0-test3-mm2: JFS/cryptoapi OOPS
Date: Tue, 19 Aug 2003 15:43:30 +0000
Message-ID: <slrnbk4hd2.8pm.andreashappe@flatline.ath.cx>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trying to run 'mkfs.jfs /dev/loop1' on a file backed cryptoloop using
aes creates following OOPS. System is a P3m, UP with enabled preemption.

kernel BUG at mm/filemap.c:1930!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c013e919>]    Not tainted VLI
EFLAGS: 00010282
EIP is at generic_file_aio_write_nolock+0xe9/0x100
eax: c1523c20   ebx: 0ff01000   ecx: c156bdab   edx: c014b1ab
esi: 00000000   edi: cfc19f6c   ebp: cfc19e84   esp: cfc19e40
ds: 007b   es: 007b   ss: 0068
Process mkfs.jfs (pid: 8985, threadinfo=cfc18000 task=cb42b920)
Stack: 00000000 cfc18000 c03837d0 c0383898 c03837d0 cf84dba0 cf84dc30 cbd635e0 
       cfc19e84 cbd635e0 0ff01000 00000000 c013ea92 cfc19e84 cfc19f6c 00000001 
       cbd63600 00000000 00000002 00000000 00000001 ffffffff cbd635e0 c20a630c 
Call Trace:
 [<c013ea92>] __crc_generic_read_dir+0x14/0x32
 [<c014b1ab>] do_anonymous_page+0x13b/0x250
 [<c011d630>] autoremove_wake_function+0x0/0x50
 [<c01192dc>] do_page_fault+0x23c/0x456
 [<c01d94b2>] tty_read+0xf2/0x170
 [<c0163107>] blkdev_file_write+0x37/0x40
 [<c0159ce2>] vfs_write+0xe2/0x150
 [<c0159e02>] sys_write+0x42/0x70
 [<c03320cb>] syscall_call+0x7/0xb

Code: f2 90 89 7c 24 04 8b 44 24 40 c7 44 24 08 01 00 00 00 89 2c 24 89 44 24 0c e8 74 f3 ff ff 83 7d 10 ff 89 c7 75 cd e9 6f ff ff ff <0f> 0b 8a 07 9f a1 34 c0 e9 53 ff ff ff 8d 76 00 8d bc 27 00 00 

	--Andreas

