Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbTIEKYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTIEKYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:24:40 -0400
Received: from lorien.s2s.msu.ru ([193.232.119.108]:28575 "EHLO
	lorien.s2s.msu.ru") by vger.kernel.org with ESMTP id S262244AbTIEKYi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:24:38 -0400
From: Alexander Vodomerov <alex@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Subject: sync crashed with segfault on 2.6.0-test4 (reiserfs partition)
Date: Fri, 5 Sep 2003 14:24:48 +0400
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051424.48834.alex@sectorb.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I've tried 2.6.0-test4 kernel. It works fine about 17 hours, but
suddenly sync command causes a segfault. I've made sync many times
before and it worked. After this segfault, I've tried to run sync once more.
It hangs (without any error). I've tried to kill it with SIGKILL, it doesn't helped :(
After having more hanged syncs, I rebooted machine, everything seems ok,
I cannot reproduce bug any more.
The disk was /dev/hda4, 164 Gb reiserfs 3.6 partition. Kernel compiled with
PAGE_OFFSET changed to 0x80000000.
I can provide ony other information (hardware info, kernel config etc). I just do
not know what may be useful.
Kernel log: 
Sep  4 16:43:36 lorien kernel:  printing eip:
Sep  4 16:43:36 lorien kernel: 80168ffd
Sep  4 16:43:36 lorien kernel: Oops: 0002 [#1]
Sep  4 16:43:36 lorien kernel: CPU:    0
Sep  4 16:43:36 lorien kernel: EIP:    0060:[mpage_writepages+301/688]  
Sep  4 16:43:36 lorien kernel: EFLAGS: 00010202
Sep  4 16:43:36 lorien kernel: EIP is at mpage_writepages+0x12d/0x2b0
Sep  4 16:43:36 lorien kernel: eax: 9c43f124   ebx: 9c43f11c   ecx: 9c43f124   edx: 00100100
Sep  4 16:43:36 lorien kernel: esi: 9c43f104   edi: b2d5def0   ebp: 9c43f12c   esp: b2d5de34
Sep  4 16:43:36 lorien kernel: ds: 007b   es: 007b   ss: 0068
Sep  4 16:43:36 lorien kernel: Process sync (pid: 27831, threadinfo=b2d5c000 task=92881240)
Sep  4 16:43:36 lorien kernel: Stack: 816557e8 b2d5def0 803a1a00 00000001 00000000 bc7c4ec4 9c43f124 801b8b10 
Sep  4 16:43:36 lorien kernel:        00000000 00000000 81bbc51c 00000000 00000000 9c43f11c 9c43f104 9c43f078 
Sep  4 16:43:36 lorien kernel:        b2d5def0 801379a6 9c43f104 b2d5def0 00000000 80167a49 9c43f104 b2d5def0 
Sep  4 16:43:36 lorien kernel: Call Trace:
Sep  4 16:43:36 lorien kernel:  [reiserfs_writepage+0/64] reiserfs_writepage+0x0/0x40
Sep  4 16:43:36 lorien kernel:  [do_writepages+54/64] do_writepages+0x36/0x40
Sep  4 16:43:36 lorien kernel:  [__sync_single_inode+169/496] __sync_single_inode+0xa9/0x1f0
Sep  4 16:43:36 lorien kernel:  [sync_sb_inodes+396/560] sync_sb_inodes+0x18c/0x230
Sep  4 16:43:36 lorien kernel:  [sync_inodes_sb+119/144] sync_inodes_sb+0x77/0x90
Sep  4 16:43:36 lorien kernel:  [sync_inodes+43/160] sync_inodes+0x2b/0xa0
Sep  4 16:43:36 lorien kernel:  [do_sync+35/112] do_sync+0x23/0x70
Sep  4 16:43:36 lorien kernel:  [sys_sync+15/32] sys_sync+0xf/0x20
Sep  4 16:43:36 lorien kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  4 16:43:36 lorien kernel: 
Sep  4 16:43:36 lorien kernel: Code: 89 42 04 89 53 08 8b 54 24 18 89 46 20 89 50 04 ff 43 04 0f 

With best regards,
   Alexander.
