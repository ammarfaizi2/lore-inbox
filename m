Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVDHHjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVDHHjA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVDHHjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:39:00 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:23947 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S262724AbVDHHi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:38:56 -0400
Date: Fri, 8 Apr 2005 09:38:54 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11.3 slab error crash
Message-ID: <20050408073854.GC30441@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

yesterday our HP DL-585 quad opteron server running 2.6.11.3 crashed
with the attached messages. The main load is NFS serving and running
postfix as well as some other userland processes. The server uses XFS
on top of LVM for NFS-exported volumes. More details available at request.

	Thanks,

-Yenya

Apr  7 16:25:11 opteron kernel: slab error in cache_free_debugcheck(): cache `size-1024': double free, or memory outside object was overwritten
Apr  7 16:25:11 opteron kernel: 
Apr  7 16:25:11 opteron kernel: Call Trace:<ffffffff8015b493>{cache_free_debugcheck+371} <ffffffff8015c615>{kfree+213} 
Apr  7 16:25:11 opteron kernel:        <ffffffff8021ec16>{nlm4svc_callback+150} <ffffffff8021e6f0>{nlm4svc_proc_unlock_msg+112} 
Apr  7 16:25:11 opteron kernel:        <ffffffff8021d7d0>{nlm4svc_decode_unlockargs+48} <ffffffff803ff445>{svc_process+853} 
Apr  7 16:25:11 opteron kernel:        <ffffffff80218987>{lockd+359} <ffffffff80218820>{lockd+0} 
Apr  7 16:25:11 opteron kernel:        <ffffffff8010ddbf>{child_rip+8} <ffffffff80218820>{lockd+0} 
Apr  7 16:25:11 opteron kernel:        <ffffffff80218820>{lockd+0} <ffffffff8010ddb7>{child_rip+0} 
Apr  7 16:25:11 opteron kernel:        
Apr  7 16:25:11 opteron kernel: ffff81050ffacae8: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
Apr  7 16:25:11 opteron kernel: ----------- [cut here ] --------- [please bite here ] ---------
Apr  7 16:25:11 opteron kernel: Kernel BUG at host:250
Apr  7 16:25:11 opteron kernel: invalid operand: 0000 [1] SMP 
Apr  7 16:25:11 opteron kernel: CPU 2 
Apr  7 16:25:11 opteron kernel: Modules linked in: ide_cd cdrom
Apr  7 16:25:12 opteron kernel: Pid: 18003, comm: rpciod/2 Not tainted 2.6.11.3
Apr  7 16:25:12 opteron kernel: RIP: 0010:[<ffffffff8021841f>] <ffffffff8021841f>{nlm_release_host+47}
Apr  7 16:25:12 opteron kernel: RSP: 0000:ffff810207177da8  EFLAGS: 00010286
Apr  7 16:25:12 opteron kernel: RAX: 00000000ffffffff RBX: ffff8103cb093248 RCX: ffff810064b23470
Apr  7 16:25:12 opteron kernel: RDX: 00000000fffffffb RSI: 0000000000000296 RDI: ffff8103cb093248
Apr  7 16:25:12 opteron kernel: RBP: ffff810142def688 R08: 0000000000000000 R09: ffff810142def9a8
Apr  7 16:25:12 opteron kernel: R10: ffffffff80582a80 R11: 0000000000002000 R12: ffff8100bfc33678
Apr  7 16:25:12 opteron kernel: R13: ffffffff80149380 R14: 0000000000000000 R15: ffffffff80149380
Apr  7 16:25:12 opteron kernel: FS:  00002aaaaae054c0(0000) GS:ffffffff80582b80(0000) knlGS:00000000556b7080
Apr  7 16:25:12 opteron kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Apr  7 16:25:12 opteron kernel: CR2: 00002aaaab1a5970 CR3: 0000000082e30000 CR4: 00000000000006e0
Apr  7 16:25:12 opteron kernel: Process rpciod/2 (pid: 18003, threadinfo ffff810207176000, task ffff810207281210)
Apr  7 16:25:12 opteron kernel: Stack: ffff8101467b8658 ffffffff8021ec79 0000000000000000 ffffffff803fcc47 
Apr  7 16:25:12 opteron kernel:        ffff810207177e58 ffffffff8040e71a 0000000000002000 00000076000027d8 
Apr  7 16:25:12 opteron kernel:        0000000300000000 ffff8100bfc336b8 
Apr  7 16:25:12 opteron kernel: Call Trace:<ffffffff8021ec79>{nlm4svc_callback_exit+57} <ffffffff803fcc47>{__rpc_execute+855} 
Apr  7 16:25:12 opteron kernel:        <ffffffff8040e71a>{thread_return+42} <ffffffff8012f483>{__wake_up+67} 
Apr  7 16:25:12 opteron kernel:        <ffffffff803fcd20>{rpc_async_schedule+0} <ffffffff8014477c>{worker_thread+476} 
Apr  7 16:25:12 opteron kernel:        <ffffffff8012f3c0>{default_wake_function+0} <ffffffff8012f3c0>{default_wake_function+0} 
Apr  7 16:25:12 opteron kernel:        <ffffffff80148d80>{keventd_create_kthread+0} <ffffffff801445a0>{worker_thread+0} 
Apr  7 16:25:12 opteron kernel:        <ffffffff80148d80>{keventd_create_kthread+0} <ffffffff80148d42>{kthread+146} 
Apr  7 16:25:12 opteron kernel:        <ffffffff8010ddbf>{child_rip+8} <ffffffff80148d80>{keventd_create_kthread+0} 
Apr  7 16:25:12 opteron kernel:        <ffffffff80148cb0>{kthread+0} <ffffffff8010ddb7>{child_rip+0} 
Apr  7 16:25:12 opteron kernel:        
Apr  7 16:25:12 opteron kernel: 
Apr  7 16:25:12 opteron kernel: Code: 0f 0b 7b 1d 45 80 ff ff ff ff fa 00 66 66 90 66 90 5b c3 66 

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
