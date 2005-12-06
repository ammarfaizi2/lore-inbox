Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVLFQId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVLFQId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbVLFQId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:08:33 -0500
Received: from solarneutrino.net ([66.199.224.43]:38661 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1750832AbVLFQIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:08:32 -0500
Date: Tue, 6 Dec 2005 11:08:15 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051206160815.GC11560@tau.solarneutrino.net>
References: <20051129092432.0f5742f0.akpm@osdl.org> <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net> <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com> <20051202180326.GB7634@tau.solarneutrino.net> <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com> <20051202194447.GA7679@tau.solarneutrino.net> <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another crash during last night's backup:

Bad page state at free_hot_cold_page (in process 'taper', page ffff810002410cc0)
flags:0x010000000000000c mapping:ffff81017d5beb70 mapcount:2 count:0
Backtrace:

Call Trace:<ffffffff80159fd3>{bad_page+99} <ffffffff8015a9a5>{free_hot_cold_page+101}
       <ffffffff80162047>{__page_cache_release+151} <ffffffff802b9068>{sgl_unmap_user_pages+120}
       <ffffffff802b497b>{release_buffering+27} <ffffffff802b5031>{st_write+1697}
       <ffffffff8017af86>{vfs_write+198} <ffffffff8017b0e3>{sys_write+83}
       <ffffffff8010db7a>{system_call+126} 
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'taper', page ffff810002410cc0)
flags:0x010000000000081c mapping:ffff810064cd6910 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff80159fd3>{bad_page+99} <ffffffff8015a9a5>{free_hot_cold_page+101}
       <ffffffff80162047>{__page_cache_release+151} <ffffffff802b9068>{sgl_unmap_user_pages+120}
       <ffffffff802b497b>{release_buffering+27} <ffffffff802b5031>{st_write+1697}
       <ffffffff8017af86>{vfs_write+198} <ffffffff8017b0e3>{sys_write+83}
       <ffffffff8010db7a>{system_call+126} 
Trying to fix it up, but a reboot is needed
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at include/linux/mm.h:341
invalid operand: 0000 [1] SMP 
CPU 1 
Modules linked in: bonding
Pid: 11402, comm: taper Tainted: G    B 2.6.14.3 #1
RIP: 0010:[<ffffffff802b904d>] <ffffffff802b904d>{sgl_unmap_user_pages+93}
RSP: 0018:ffff8100ca6d9e18  EFLAGS: 00010256
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000005
RDX: 00000000000000e0 RSI: 0000000000000001 RDI: ffff810002410cc0
RBP: ffff810004990068 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000008000 R11: 0000000000000200 R12: 0000000000000008
R13: 0000000000000000 R14: 0000000000008000 R15: ffff810004953d10
FS:  00002aaaab53d880(0000) GS:ffffffff804db880(0000) knlGS:00000000555bc920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 000000008c49e000 CR4: 00000000000006e0
Process taper (pid: 11402, threadinfo ffff8100ca6d8000, task ffff81017dabc200)
Stack: ffff81017ff1e600 ffff810004990000 0000000000000040 0000000000008000 
       ffff810004953c00 ffffffff802b497b ffff810004990000 ffffffff802b5031 
       ffff810000000000 ffffffff00000001 
Call Trace:<ffffffff802b497b>{release_buffering+27} <ffffffff802b5031>{st_write+1697}
       <ffffffff8017af86>{vfs_write+198} <ffffffff8017b0e3>{sys_write+83}
       <ffffffff8010db7a>{system_call+126} 

Code: 0f 0b 68 3a 13 3a 80 c2 55 01 f0 83 47 08 ff 0f 98 c0 84 c0 
RIP <ffffffff802b904d>{sgl_unmap_user_pages+93} RSP <ffff8100ca6d9e18>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/rmap.c:487
invalid operand: 0000 [2] SMP 
CPU 1 
Modules linked in: bonding
Pid: 11402, comm: taper Tainted: G    B 2.6.14.3 #1
RIP: 0010:[<ffffffff8016f437>] <ffffffff8016f437>{page_remove_rmap+39}
RSP: 0018:ffff8100ca6d9ab0  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff8100cc4e96f8 RCX: ffff81000000f000
RDX: 0000000000000000 RSI: 800000005bba8067 RDI: ffff810002410cc0
RBP: 00002aaaaaadf000 R08: 0000000000000000 R09: ffff810002802738
R10: 00000000fffffffa R11: 0000000000000000 R12: ffff810101c22380
R13: 800000005bba8067 R14: ffff810002410cc0 R15: 0000000000000000
FS:  00002aaaab53d880(0000) GS:ffffffff804db880(0000) knlGS:00000000555bc920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 000000008c49e000 CR4: 00000000000006e0
Process taper (pid: 11402, threadinfo ffff8100ca6d8000, task ffff81017dabc200)
Stack: ffffffff80166f0d 00002aaaaab62000 ffff81006d16faa8 00002aaaaab62000 
       00002aaaaab62000 00002aaaaab61fff ffff8100b424c550 00002aaaaab62000 
       ffffffff801671c0 ffff8100ca6d9d68 
Call Trace:<ffffffff80166f0d>{zap_pte_range+477} <ffffffff801671c0>{unmap_page_range+496}
       <ffffffff80167325>{unmap_vmas+293} <ffffffff8016cfe2>{exit_mmap+162}
       <ffffffff80131ce1>{mmput+49} <ffffffff801371c6>{do_exit+438}
       <ffffffff8010f6f1>{die+81} <ffffffff8010f9df>{do_invalid_op+159}
       <ffffffff802b904d>{sgl_unmap_user_pages+93} <ffffffff80381ff6>{thread_return+86}
       <ffffffff802a86e2>{sym_setup_data_and_start+402} <ffffffff8010e84d>{error_exit+0}
       <ffffffff802b904d>{sgl_unmap_user_pages+93} <ffffffff802b9068>{sgl_unmap_user_pages+120}
       <ffffffff802b497b>{release_buffering+27} <ffffffff802b5031>{st_write+1697}
       <ffffffff8017af86>{vfs_write+198} <ffffffff8017b0e3>{sys_write+83}
       <ffffffff8010db7a>{system_call+126} 

Code: 0f 0b 68 1b 36 3a 80 c2 e7 01 48 c7 c6 ff ff ff ff bf 20 00 
RIP <ffffffff8016f437>{page_remove_rmap+39} RSP <ffff8100ca6d9ab0>
 <1>Fixing recursive fault but reboot is needed!
Bad page state at prep_new_page (in process 'dumper', page ffff810002410cc0)
flags:0x010000000000001c mapping:0000000000000000 mapcount:-1 count:0
Backtrace:

Call Trace:<ffffffff80159fd3>{bad_page+99} <ffffffff8015a3b1>{prep_new_page+65}
       <ffffffff8015ab6e>{buffered_rmqueue+302} <ffffffff8015adc5>{__alloc_pages+261}
       <ffffffff801581fd>{generic_file_buffered_write+413}
       <ffffffff801963ae>{inode_update_time+62} <ffffffff80158a48>{__generic_file_aio_write_nolock+936}
       <ffffffff8031f524>{sock_common_recvmsg+52}<0>Bad page state at free_hot_cold_page (in process 'dump', page ffff810002410cc0)
flags:0x010000000000001c mapping:0000000000000000 mapcount:-1 count:0
Backtrace:

Call Trace:<ffffffff80159fd3>{bad_page+99} <ffffffff8015a9a5>{free_hot_cold_page+101}
       <ffffffff8015b1d0>{__pagevec_free+32} <ffffffff801621dd>{release_pages+349}
       <ffffffff801c6ee0>{journal_stop+512} <ffffffff801c06fd>{__ext3_journal_stop+45}
       <ffffffff80162217>{__pagevec_release+23} <ffffffff801a0a02>{mpage_writepages+690}
       <ffffffff801ba1f0>{ext3_ordered_writepage+0} <ffffffff8019ef12>{__sync_single_inode+114}
       <ffffffff8019f223>{__writeback_single_inode+355} <ffffffff801567ff>{find_get_pages_tag+127}
       <ffffffff8016252a>{pagevec_lookup_tag+26} <ffffffff80155f0c>{wait_on_page_writeback_range+220}
       <ffffffff8019f421>{sync_sb_inodes+481} <ffffffff8019f664>{sync_inodes_sb+132}
       <ffffffff8019f734>{__sync_inodes+116} <ffffffff8019f7a1>{sync_inodes+17}
       <ffffffff8017c542>{do_sync+18} <ffffffff8017c59e>{sys_sync+14}
       <ffffffff8010db7a>{system_call+126} 
Trying to fix it up, but a reboot is needed
 <ffffffff8031bbb0>{sock_aio_read+272}
       <ffffffff80158d3e>{generic_file_aio_write+110} <ffffffff801b77c3>{ext3_file_write+35}
       <ffffffff8017ae83>{do_sync_write+211} <ffffffff8018ed00>{__pollwait+0}
       <ffffffff8014a2f0>{autoremove_wake_function+0} <ffffffff8018f6c1>{sys_select+1153}
       <ffffffff8017af86>{vfs_write+198} <ffffffff8017b0e3>{sys_write+83}
       <ffffffff8010db7a>{system_call+126} 
Trying to fix it up, but a reboot is needed
general protection fault: 0000 [3] SMP 
CPU 0 
Modules linked in: bonding
Pid: 1303, comm: kjournald Tainted: G    B 2.6.14.3 #1
RIP: 0010:[<ffffffff8015fdfa>] <ffffffff8015fdfa>{cache_alloc_refill+330}
RSP: 0018:ffff81017ed4dc38  EFLAGS: 00010012
RAX: cb0f489d027409f5 RBX: 000000000000002c RCX: 000000000000000f
RDX: ffff810004820760 RSI: ffff81005bba8000 RDI: ffff81001a184030
RBP: ffff81000483a400 R08: ffff810004820750 R09: ffff810004820760
R10: 0000000000000180 R11: 0000000000000000 R12: ffff810004820740
R13: ffff810004834440 R14: ffff810004820788 R15: 0000000000011200
FS:  00002aaaab00c4a0(0000) GS:ffffffff804db800(0000) knlGS:00000000555bc920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaac0000 CR3: 00000000a21ae000 CR4: 00000000000006e0
Process kjournald (pid: 1303, threadinfo ffff81017ed4c000, task ffff8101028bcf40)
Stack: ffffffff8014a2f0 0000000000011200 0000000000011210 ffff810004820ec0 
       0000000000000010 ffff81017eda3000 0000000000000200 ffffffff80160266 
       0000000000000296 ffffffff80159669 
Call Trace:<ffffffff8014a2f0>{autoremove_wake_function+0} <ffffffff80160266>{kmem_cache_alloc+54}
       <ffffffff80159669>{mempool_alloc+57} <ffffffff8014a320>{wake_bit_function+0}
       <ffffffff8017fdcc>{bio_alloc_bioset+28} <ffffffff8017ff50>{bio_alloc+16}
       <ffffffff8017f6c6>{submit_bh+150} <ffffffff8017f7ef>{ll_rw_block+143}
       <ffffffff801c82fa>{journal_commit_transaction+1114}
       <ffffffff80381fa0>{thread_return+0} <ffffffff80381ff6>{thread_return+86}
       <ffffffff8013d349>{lock_timer_base+41} <ffffffff801cb03e>{kjournald+238}
       <ffffffff8014a2f0>{autoremove_wake_function+0} <ffffffff8014a2f0>{autoremove_wake_function+0}
       <ffffffff801caf40>{commit_timeout+0} <ffffffff8010ea02>{child_rip+8}
       <ffffffff801caf50>{kjournald+0} <ffffffff8010e9fa>{child_rip+0}
       

Code: 48 89 50 08 48 89 02 48 c7 46 08 00 02 20 00 83 7e 24 ff 48 
RIP <ffffffff8015fdfa>{cache_alloc_refill+330} RSP <ffff81017ed4dc38>
 NMI Watchdog detected LOCKUP on CPU 1
CPU 1 
Modules linked in: bonding
Pid: 918, comm: md0_raid5 Tainted: G    B 2.6.14.3 #1
RIP: 0010:[<ffffffff8038385b>] <ffffffff8038385b>{.text.lock.spinlock+116}
RSP: 0018:ffff8101028a1c90  EFLAGS: 00000086
RAX: ffff810004820740 RBX: ffff810004820788 RCX: 000000000000000c
RDX: 0000000000000001 RSI: ffff81000000f000 RDI: ffff810004820788
RBP: ffff810004834440 R08: ffff8100048208c0 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000001 R12: 0000000000000000
R13: ffff8101028547c0 R14: ffff8101028547d0 R15: 0000000000000001
FS:  00002aaaab53d8e0(0000) GS:ffffffff804db880(0000) knlGS:00000000555bc920
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaaac0000 CR3: 00000000a21af000 CR4: 00000000000006e0
Process md0_raid5 (pid: 918, threadinfo ffff8101028a0000, task ffff8101028bc1c0)

(serial console output cut off here)

-ryan
