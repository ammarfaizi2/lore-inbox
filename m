Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVEVSuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVEVSuL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 14:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEVSuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 14:50:11 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:37579 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S261597AbVEVSuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 14:50:01 -0400
Date: Sun, 22 May 2005 20:49:59 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Double-free BUG() on 2.6.11.10
Message-ID: <20050522184959.GB20449@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

My server crashed a hour ago with the following messages. The server
is 4-Opteron HP DL-585, running 2.6.11.10. I hope this helps somebody
to find the bug in kernel.

May 22 19:36:30 server kernel: slab: double free detected in cache 'size-128', objp ffff81050c6216e8.
May 22 19:36:30 server kernel: ----------- [cut here ] --------- [please bite here ] ---------
May 22 19:36:30 server kernel: Kernel BUG at slab:2185
May 22 19:36:30 server kernel: invalid operand: 0000 [1] SMP
May 22 19:36:30 server kernel: CPU 2
May 22 19:36:30 server kernel: Modules linked in: ide_cd cdrom
May 22 19:36:30 server kernel: Pid: 12, comm: events/2 Not tainted 2.6.11.10
May 22 19:36:30 server kernel: RIP: 0010:[<ffffffff8015bbf7>] <ffffffff8015bbf7>{free_block+343}
May 22 19:36:30 server kernel: RSP: 0000:ffff8101fffabd98  EFLAGS: 00010096
May 22 19:36:30 server kernel: RAX: 000000000000004a RBX: ffff81050c621000 RCX: ffffffff80499688
May 22 19:36:30 server kernel: RDX: ffffffff80499688 RSI: 0000000000000096 RDI: ffffffff80499680
May 22 19:36:30 server kernel: RBP: ffff81050c6216e8 R08: ffff8105ffe66040 R09: 0000000000000000
May 22 19:36:30 server kernel: R10: 0000000000000000 R11: 0000000000000010 R12: ffff8101ffffe540
May 22 19:36:30 server kernel: R13: 000000000000000b R14: ffff81050c621028 R15: 000000000000000b
May 22 19:36:30 server kernel: FS:  00002aaaab7f44c0(0000) GS:ffffffff80582b00(0000) knlGS:00000000557096e0
May 22 19:36:30 server kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
May 22 19:36:30 server kernel: CR2: 00002aaaaaac4000 CR3: 000000013c957000 CR4: 00000000000006e0
May 22 19:36:30 server kernel: Process events/2 (pid: 12, threadinfo ffff8101fffaa000, task ffff8101fffa87c0)
May 22 19:36:30 server kernel: Stack: ffff8101fffa87c0 ffff8101ffffe568 ffff8101ffffe588 0000000100000000
May 22 19:36:30 server kernel:        ffff81040002b8f0 ffff81040002b8f0 0000000000000001 ffff81040002b8e0
May 22 19:36:30 server kernel:        ffff8101ffffe540 ffff8101ffffe5c8
May 22 19:36:30 server kernel: Call Trace:<ffffffff8015ca10>{cache_reap+0} <ffffffff8015c9b1>{drain_array_locked+129}
May 22 19:36:30 server kernel:        <ffffffff8015cabe>{cache_reap+174} <ffffffff8015ca10>{cache_reap+0}
May 22 19:36:30 server kernel:        <ffffffff8014477c>{worker_thread+476} <ffffffff8012f3c0>{default_wake_function+0}
May 22 19:36:30 server kernel:        <ffffffff8012f3c0>{default_wake_function+0} <ffffffff801445a0>{worker_thread+0}
May 22 19:36:30 server kernel:        <ffffffff80148d42>{kthread+146} <ffffffff8010ddbf>{child_rip+8}
May 22 19:36:30 server kernel:        <ffffffff801445a0>{worker_thread+0} <ffffffff80148cb0>{kthread+0}
May 22 19:36:30 server kernel:        <ffffffff8010ddb7>{child_rip+0}
May 22 19:36:30 server kernel:
May 22 19:36:30 server kernel: Code: 0f 0b 24 5e 43 80 ff ff ff ff 89 08 0f b7 43 24 48 89 de 4c
May 22 19:36:30 server kernel: RIP <ffffffff8015bbf7>{free_block+343} RSP <ffff8101fffabd98>

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
-- Yes. CVS is much denser.                                               --
-- CVS is also total crap. So your point is?             --Linus Torvalds --
