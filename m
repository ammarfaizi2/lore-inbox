Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVECNxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVECNxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 09:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVECNxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 09:53:36 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:37598 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S261544AbVECNxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 09:53:11 -0400
Date: Tue, 3 May 2005 15:53:09 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: cache_free_debugcheck BUG() on SMP x86_64
Message-ID: <20050503135309.GE28151@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello all,

I have 2.6.11.3 on SMP x86_64 box. I've got the following BUG()
today. The server runs XFS over LVM, main load is NFS serving.
More details available on request.

	Thanks,

-Yenya

slab error in cache_free_debugcheck(): cache `size-1024': double free, or memory outside object was overwritten

Call Trace:<ffffffff8015b493>{cache_free_debugcheck+371} <ffffffff8015c615>{kfree+213} 
       <ffffffff8021ec16>{nlm4svc_callback+150} <ffffffff8021e6f0>{nlm4svc_proc_unlock_msg+112} 
       <ffffffff8021d7d0>{nlm4svc_decode_unlockargs+48} <ffffffff803ff445>{svc_process+853} 
       <ffffffff80218987>{lockd+359} <ffffffff80218820>{lockd+0} 
       <ffffffff8010ddbf>{child_rip+8} <ffffffff80218820>{lockd+0} 
       <ffffffff80218820>{lockd+0} <ffffffff8010ddb7>{child_rip+0} 
       
ffff810658ca5218: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at host:250
invalid operand: 0000 [1] SMP 
CPU 2 
Modules linked in: ide_cd cdrom
Pid: 18049, comm: rpciod/2 Not tainted 2.6.11.3
RIP: 0010:[<ffffffff8021841f>] <ffffffff8021841f>{nlm_release_host+47}
RSP: 0000:ffff8103ffba1da8  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff8101a51d0058 RCX: ffff8102d22cdab8
RDX: 00000000fffffffb RSI: 0000000000000296 RDI: ffff8101a51d0058
RBP: ffff8100b8aa1e58 R08: 0000000000000000 R09: ffff8100b8aa14f8
R10: ffffffff80582a80 R11: 0000000000000000 R12: ffff81067fe68e48
R13: ffffffff80149380 R14: 0000000000000000 R15: ffffffff80149380
FS:  00002aaaaaf1c740(0000) GS:ffffffff80582b80(0000) knlGS:00000000555bdae0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaab532c30 CR3: 00000005ef479000 CR4: 00000000000006e0
Process rpciod/2 (pid: 18049, threadinfo ffff8103ffba0000, task ffff8103ff6731d0)
Stack: ffff8101500d5ad0 ffffffff8021ec79 0000000000000000 ffffffff803fcc47 
       ffff8103ffba1e58 ffffffff8040e71a ffffffff80545850 0000007300000000 
       0000000300000000 ffff81067fe68e88 
Call Trace:<ffffffff8021ec79>{nlm4svc_callback_exit+57} <ffffffff803fcc47>{__rpc_execute+855} 
       <ffffffff8040e71a>{thread_return+42} <ffffffff8012f483>{__wake_up+67} 
       <ffffffff803fcd20>{rpc_async_schedule+0} <ffffffff8014477c>{worker_thread+476} 
       <ffffffff8012f3c0>{default_wake_function+0} <ffffffff8012f3c0>{default_wake_function+0} 
       <ffffffff80148d80>{keventd_create_kthread+0} <ffffffff801445a0>{worker_thread+0} 
       <ffffffff80148d80>{keventd_create_kthread+0} <ffffffff80148d42>{kthread+146} 
       <ffffffff8010ddbf>{child_rip+8} <ffffffff80148d80>{keventd_create_kthread+0} 
       <ffffffff80148cb0>{kthread+0} <ffffffff8010ddb7>{child_rip+0} 
       

Code: 0f 0b 7b 1d 45 80 ff ff ff ff fa 00 66 66 90 66 90 5b c3 66 
RIP <ffffffff8021841f>{nlm_release_host+47} RSP <ffff8103ffba1da8>
 <3>Slab corruption: start=ffff810658ca5220, len=1024
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<ffffffff8037e970>](alloc_skb+0x50/0x110)
000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
020: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
030: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
040: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Prev obj: start=ffff810658ca4e08, len=1024
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8037ec49>](kfree_skbmem+0x9/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ffff810658ca5638, len=1024
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8037ec49>](kfree_skbmem+0x9/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
slab error in cache_alloc_debugcheck_after(): cache `size-1024': double free, or memory outside object was overwritten

Call Trace:<IRQ> <ffffffff8037e970>{alloc_skb+80} <ffffffff8015b9f7>{cache_alloc_debugcheck_after+167} 
       <ffffffff8015c357>{__kmalloc+183} <ffffffff8037e970>{alloc_skb+80} 
       <ffffffff802fd055>{tg3_rx+533} <ffffffff802fd360>{tg3_poll+176} 
       <ffffffff80385277>{net_rx_action+135} <ffffffff8013883e>{__do_softirq+126} 
       <ffffffff801388f3>{do_softirq+51} <ffffffff80110277>{do_IRQ+71} 
       <ffffffff8010d7ad>{ret_from_intr+0}  <EOI> <ffffffff8010d826>{retint_careful+13} 
       
ffff810658ca5218: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5.
general protection fault: 0000 [2] SMP 
CPU 3 
Modules linked in: ide_cd cdrom
Pid: 17940, comm: nfsd Not tainted 2.6.11.3
RIP: 0010:[<ffffffff8015d2c4>] <ffffffff8015d2c4>{put_page+4}
RSP: 0018:ffff8105f87b99e8  EFLAGS: 00010296
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff810658ca5320
RDX: 000000006b6b6b6b RSI: 00000000ce4a47cf RDI: 6b6b6b6b6b6b6b6b
RBP: ffff81043f600990 R08: 00000000ffffff95 R09: 0000000000000000
R10: ffffffff804ebf40 R11: ffffffff80582a80 R12: ffff8101c65aedd0
R13: ffff8101c65aee68 R14: 0000000000000000 R15: ffff8101c65af298
FS:  00002aaaaae054c0(0000) GS:ffffffff80582c00(0000) knlGS:000000005557daa0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaac4000 CR3: 00000005ef479000 CR4: 00000000000006e0
Process nfsd (pid: 17940, threadinfo ffff8105f87b8000, task ffff8105f801a1b0)
Stack: ffff8102c1aff048 ffffffff8037ebf5 ffff8105f87b9a88 ffff81043f600990 
       ffff81043f600990 ffffffff8037ec49 00000000ffffffff ffffffff803a1b45 
       0000000800000000 ffff81067f88d510 
Call Trace:<ffffffff8037ebf5>{skb_release_data+85} <ffffffff8037ec49>{kfree_skbmem+9} 
       <ffffffff803a1b45>{tcp_recvmsg+1797} <ffffffff8037e727>{sock_common_recvmsg+55} 
       <ffffffff8037ad29>{sock_recvmsg+249} <ffffffff802fde74>{tg3_start_xmit+1348} 
       <ffffffff80149380>{autoremove_wake_function+0} <ffffffff8039aae7>{ip_finish_output+359} 
       <ffffffff8037ad8b>{kernel_recvmsg+59} <ffffffff8040000b>{svc_recvfrom+107} 
       <ffffffff8012e3b3>{move_tasks+211} <ffffffff80400bdf>{svc_tcp_recvfrom+383} 
       <ffffffff8012dc60>{finish_task_switch+64} <ffffffff8040e71a>{thread_return+42} 
       <ffffffff8013c733>{del_timer+115} <ffffffff8013c819>{del_singleshot_timer_sync+9} 
       <ffffffff8040f2b5>{schedule_timeout+181} <ffffffff80401569>{svc_recv+1065} 
       <ffffffff8012f3c0>{default_wake_function+0} <ffffffff8012f3c0>{default_wake_function+0} 
       <ffffffff801f6f30>{nfsd+0} <ffffffff801f7040>{nfsd+272} 
       <ffffffff8012dcd1>{schedule_tail+17} <ffffffff8010ddbf>{child_rip+8} 
       <ffffffff801f6f30>{nfsd+0} <ffffffff801f6f30>{nfsd+0} 
       <ffffffff8010ddb7>{child_rip+0} 

Code: 8b 07 48 89 fa 48 c1 e8 0f a9 01 00 00 00 74 43 48 8b 57 10 
RIP <ffffffff8015d2c4>{put_page+4} RSP <ffff8105f87b99e8>
 

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
-- Yes. CVS is much denser.                                               --
-- CVS is also total crap. So your point is?             --Linus Torvalds --
