Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWIVNbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWIVNbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWIVNbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:31:08 -0400
Received: from deeppurple.startpda.net ([213.193.242.66]:46742 "EHLO
	deeppurple.startpda.net") by vger.kernel.org with ESMTP
	id S932448AbWIVNbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:31:07 -0400
Message-ID: <4513E5A4.4090707@hyves.nl>
Date: Fri, 22 Sep 2006 15:31:16 +0200
From: "jeffrey@hyves.nl" <jeffrey@hyves.nl>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at fs/reiserfs/prints.c:362 (2.6.15)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently bumped into the following kernel bug:

Sep 20 17:56:56  ReiserFS: dm-2: warning: vs-13060: reiserfs_update_sd: stat data of object [2 14665 0x0 SD]
(nlink == 1) not found (pos 1)
Sep 20 17:56:56 src@cl90 ReiserFS: dm-2: warning: vs-13060: reiserfs_update_sd: stat data of object [2 14665 0x0 SD]
(nlink == 1) not found (pos 1)
Sep 20 17:56:56   ReiserFS: warning: vs-16090: direntry_bytes_number: bytes number is asked for direntry
Sep 20 17:56:56   REISERFS: panic (device dm-2): green-9011: Unexpected key type [2 14665 0x1 UNKNOWN]
Sep 20 17:56:56  
Sep 20 17:56:56   ----------- [cut here ] --------- [please bite here ] ---------
Sep 20 17:56:56   Kernel BUG at fs/reiserfs/prints.c:362
Sep 20 17:56:56   invalid operand: 0000 [1] SMP
Sep 20 17:56:56   CPU 0
Sep 20 17:56:56   Modules linked in: ipmi_si ipmi_devintf ipmi_watchdog ipmi_poweroff ipmi_msghandler dummy
Sep 20 17:56:56   Pid: 2864, comm: wget Not tainted 2.6.15-gentoo-r1 #5
Sep 20 17:56:56   RIP: 0010:[<ffffffff801b9f4a>] <ffffffff801b9f4a>{reiserfs_panic+192}
Sep 20 17:56:56   RSP: 0018:ffff810194741ac8  EFLAGS: 00010296
Sep 20 17:56:56   RAX: 000000000000005f RBX: ffffffff80521a9d RCX: 00000000000451e1
Sep 20 17:56:56   RDX: 0000000000000246 RSI: 0000000000000246 RDI: ffffffff805aae20
Sep 20 17:56:56   RBP: fffffffffffffff4 R08: 0000000000000001 R09: 0000000000000000
Sep 20 17:56:56   R10: 0000000000000000 R11: 0000000000000000 R12: ffff8101feada240
Sep 20 17:56:56   R13: ffff8101feada000 R14: ffff810194741d78 R15: ffff810162978000
Sep 20 17:56:56   FS:  00002aaaab48a6e0(0000) GS:ffffffff8076d800(0000) knlGS:000000005568e6c0
Sep 20 17:56:56   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 20 17:56:56   CR2: 00002aaaab5a0000 CR3: 0000000137a98000 CR4: 00000000000006e0
Sep 20 17:56:56   Process wget (pid: 2864, threadinfo ffff810194740000, task ffff8101fabc09c0)
Sep 20 17:56:56   Stack: 0000003000000018 ffff810194741bb8 ffff810194741ae8 ffff810194741cd8
Sep 20 17:56:56   ffff810194741d58 ffff8101feada000 ffff810194741d58 0000000000000000
Sep 20 17:56:56   00000000ffffffff 0000000000000286
Sep 20 17:56:56   Call Trace:<ffffffff801b2c24>{reiserfs_file_write+4839}
<ffffffff80455340>{release_sock+15}
Sep 20 17:56:56   <ffffffff8015294b>{__alloc_pages+80} <ffffffff8017cecb>{do_select+911}
Sep 20 17:56:56   <ffffffff8016b859>{do_sync_read+202} <ffffffff802ec206>{__up_read+16}
Sep 20 17:56:56   <ffffffff804d5e9a>{do_page_fault+1018} <ffffffff80160a24>{do_mmap_pgoff+1577}
Sep 20 17:56:56   <ffffffff8016bb92>{vfs_write+176} <ffffffff8016bce3>{sys_write+69}
Sep 20 17:56:56   <ffffffff8010d852>{system_call+126}
Sep 20 17:56:56  
Sep 20 17:56:56   Code: 0f 0b 68 1f 3c 52 80 c2 6a 01 4d 85 ed 48 c7 c2 a0 85 72 80
Sep 20 17:56:56   RIP <ffffffff801b9f4a>{reiserfs_panic+192} RSP <ffff810194741ac8>
  

We use the 2.6.15 kernel on a x86_64 AMD Opteron(tm) Processor 248. The 
machine is a HP Proliant DL145.

Hope this helps...

-- 
---------------------------------
Jeffrey Lensen
hyves:     http://skyler.hyves.nl
mail/msn:  jeffrey@hyves.nl

