Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752199AbWAEUNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbWAEUNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbWAEUNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:13:05 -0500
Received: from solarneutrino.net ([66.199.224.43]:12548 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1752199AbWAEUNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:13:04 -0500
Date: Thu, 5 Jan 2006 15:12:49 -0500
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20060105201249.GB1795@tau.solarneutrino.net>
References: <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org> <1134409531.9994.13.camel@mulgrave> <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org> <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net> <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net> <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local> <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 11:48:52PM +0200, Kai Makisara wrote:
> > Here's what I got:

Another one.  I can't keep running this kernel - nearly all of our
backup tapes are erased now.  If a drive were to fail today, we would
lose hundreds of GB of irreplacible data.  I'm going back to 2.6.11.3
until we have a full set of backups again.


 st: page attributes before page_release 8
 0: flags:0x060000000000006c mapping:ffff810102bbaaf0 mapcount:2 count:4 pfn:1553908
 1: flags:0x060000000000006c mapping:ffff810102bbaaf0 mapcount:2 count:4 pfn:1553846
 2: flags:0x060000000000006c mapping:ffff810102bbaaf0 mapcount:2 count:4 pfn:1553907
 3: flags:0x060000000000006c mapping:ffff810102bbaaf0 mapcount:2 count:4 pfn:1554431
 4: flags:0x060000000000006c mapping:ffff810102bbaaf0 mapcount:2 count:4 pfn:1553947
 5: flags:0x060000000000006c mapping:ffff810102bbaaf0 mapcount:2 count:4 pfn:1553919
 6: flags:0x060000000000006c mapping:ffff810102bbaaf0 mapcount:2 count:4 pfn:1553940
 7: flags:0x060000000000006c mapping:ffff810102bbaaf0 mapcount:2 count:4 pfn:1553918
Bad page state at free_hot_cold_page (in process 'taper', page ffff81000455f7b0)
flags:0x010000000000000c mapping:ffff810102bbaaf0 mapcount:2 count:0
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff80150c3f>{free_hot_cold_page+105}
       <ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}

Trying to fix it up, but a reboot is needed
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/swap.c:49
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in: bonding
Pid: 2166, comm: taper Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff8015751c>] <ffffffff8015751c>{put_page+96}
RSP: 0018:ffff81017b6bfe18  EFLAGS: 00010256
RAX: 0000000000000000 RBX: 00000000000000e0 RCX: ffff81000455f7b0
RDX: ffff81000455f7b0 RSI: 0000000000000001 RDI: ffff81000455f7b0
RBP: 0000000000000007 R08: ffff81017b6be000 R09: 0000000000000001
R10: ffff810004878aa0 R11: 0000000000000046 R12: 0000000000000008
R13: ffff8100f6f9e068 R14: 0000000000000000 R15: 0000000000008000
FS:  00002aaaab53d880(0000) GS:ffffffff804a9800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 000000017b06e000 CR4: 00000000000006e0
Process taper (pid: 2166, threadinfo ffff81017b6be000, task ffff81017b6b4700)
Stack: 010000000000000c ffffffff8028c534 0000000000008000 0000000000008000
       ffff8100f6f9e000 ffff81000c06e200 0000000000008000 0000000000000040
       0000000000008000 ffffffff8028826d
Call Trace:<ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}


Code: 0f 0b 68 ae b1 36 80 c2 31 00 f0 83 42 08 ff 0f 98 c0 84 c0
RIP <ffffffff8015751c>{put_page+96} RSP <ffff81017b6bfe18>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/swap.c:215
invalid operand: 0000 [2] SMP
CPU 0
Modules linked in: bonding
Pid: 2166, comm: taper Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff801578d9>] <ffffffff801578d9>{release_pages+79}
RSP: 0018:ffff81017b6bfb08  EFLAGS: 00010256
RAX: 0000000000000000 RBX: ffff81000455f7b0 RCX: ffff81000000f518
RDX: ffff81000455f7b0 RSI: 0000000000000006 RDI: ffff81000c006dd0
RBP: 0000000000000000 R08: ffffffff803cfa68 R09: 0000000000000286
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000005
R13: 0000000000000006 R14: ffff81000c006dd0 R15: 0000000000008000
FS:  00002aaaab53d880(0000) GS:ffffffff804a9800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 000000017b06e000 CR4: 00000000000006e0
Process taper (pid: 2166, threadinfo ffff81017b6be000, task ffff81017b6b4700)
Stack: 0000000000000000 0000000000000000 0000000000008000 ffff81017b6bfd68
       0000000000000000 0000000000000000 ffffffff80362e14 000000000000000f
       0000000000000000 0000000000000000
Call Trace:<ffffffff8012fd66>{printk+141} <ffffffff80157b74>{__pagevec_lru_add+195}
       <ffffffff801577b9>{lru_add_drain+32} <ffffffff8016162a>{exit_mmap+33}
       <ffffffff8012d638>{mmput+34} <ffffffff8013214a>{do_exit+489}
       <ffffffff8010f203>{die_nmi+0} <ffffffff8010f587>{do_invalid_op+145}
       <ffffffff8015751c>{put_page+96} <ffffffff803448db>{thread_return+0}
       <ffffffff8010e49d>{error_exit+0} <ffffffff8015751c>{put_page+96}
       <ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}


Code: 0f 0b 68 ae b1 36 80 c2 d7 00 f0 83 43 08 ff 0f 98 c0 84 c0
RIP <ffffffff801578d9>{release_pages+79} RSP <ffff81017b6bfb08>
 <1>Fixing recursive fault but reboot is needed!
Bad page state at prep_new_page (in process 'nfsd', page ffff81000455f7b0)
flags:0x010000000000002c mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff801506eb>{prep_new_page+70}
       <ffffffff80150e12>{buffered_rmqueue+311} <ffffffff80150fe3>{get_page_from_freelist+130}
       <ffffffff80151067>{__alloc_pages+86} <ffffffff801545b1>{kmem_getpages+88}
       <ffffffff80155789>{cache_grow+195} <ffffffff801559d0>{cache_alloc_refill+408}
       <ffffffff80155d56>{kmem_cache_alloc+51} <ffffffff80341e2a>{cache_make_upcall+85}
       <ffffffff80340c99>{cache_check+183} <ffffffff801defc6>{exp_find_key+118}
       <ffffffff8012ae27>{__wake_up+54} <ffffffff80341f00>{cache_make_upcall+299}
       <ffffffff801d9d9f>{fh_verify+401} <ffffffff801e224c>{nfsd3_proc_getattr+129}
       <ffffffff801d844b>{nfsd_dispatch+226} <ffffffff8033be8c>{svc_process+1003}
       <ffffffff8012ad76>{default_wake_function+0} <ffffffff801d8018>{nfsd+0}
       <ffffffff801d81e1>{nfsd+457} <ffffffff8010e652>{child_rip+8}
       <ffffffff801d8018>{nfsd+0} <ffffffff801d8018>{nfsd+0}
       <ffffffff8010e64a>{child_rip+0}
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'nfsd', page ffff81000455b840)
flags:0x010000000000002c mapping:ffff810102bbaaf0 mapcount:2 count:3
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff801506eb>{prep_new_page+70}
       <ffffffff80150e12>{buffered_rmqueue+311} <ffffffff80150fe3>{get_page_from_freelist+130}
       <ffffffff801d8018>{nfsd+0} <ffffffff80151067>{__alloc_pages+86}
       <ffffffff801d8018>{nfsd+0} <ffffffff8033d9d8>{svc_recv+291}
       <ffffffff8012ad76>{default_wake_function+0} <ffffffff8012ad76>{default_wake_function+0}
       <ffffffff801d8018>{nfsd+0} <ffffffff801d8125>{nfsd+269}
       <ffffffff8010e652>{child_rip+8} <ffffffff801d8018>{nfsd+0}
       <ffffffff801d8018>{nfsd+0} <ffffffff8010e64a>{child_rip+0}

Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'zsh', page ffff81000455f3c0)
flags:0x010000000000002c mapping:ffff810102bbaaf0 mapcount:2 count:3
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff801506eb>{prep_new_page+70}
       <ffffffff80150e12>{buffered_rmqueue+311} <ffffffff80150fe3>{get_page_from_freelist+130}
       <ffffffff80151067>{__alloc_pages+86} <ffffffff8015d50c>{do_wp_page+400}
       <ffffffff8015e7df>{__handle_mm_fault+626} <ffffffff8011d10f>{do_page_fault+520}
       <ffffffff80205410>{__put_user_4+32} <ffffffff8010e49d>{error_exit+0}

Trying to fix it up, but a reboot is needed
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/swap.c:303
invalid operand: 0000 [3] SMP
CPU 0
Modules linked in: bonding
Pid: 171, comm: pdflush Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff80157b10>] <ffffffff80157b10>{__pagevec_lru_add+95}
RSP: 0018:ffff8100f6fbdba8  EFLAGS: 00010086
RAX: 00000000ffffffff RBX: ffff81000000f300 RCX: 000000000000000f
RDX: ffffffff804ebe60 RSI: ffff81000000f000 RDI: ffff81000000f500
RBP: ffff81000c006dc0 R08: 0000000000000000 R09: ffffffff801a4f68
R10: 0000000000000001 R11: ffff81017fc63c00 R12: ffff810004474798
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
FS:  00002aaaaae00640(0000) GS:ffffffff804a9800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00007fffffd68f60 CR3: 000000017b223000 CR4: 00000000000006e0
Process pdflush (pid: 171, threadinfo ffff8100f6fbc000, task ffff8100f6fbaf80)
Stack: ffff81008bb1af60 ffff8100f6fbdc48 ffff8100f6fbde78 ffff81017d204350
       ffff8100f6f21978 ffffffff801577b9 ffff81017fc63c00 ffffffff80157a00
       ffff810101b3b930 ffffffff8018e5a1
Call Trace:<ffffffff801577b9>{lru_add_drain+32} <ffffffff80157a00>{__pagevec_release+9}
       <ffffffff8018e5a1>{mpage_writepages+663} <ffffffff801a4f81>{ext3_ordered_writepage+0}
       <ffffffff801534f1>{mapping_tagged+58} <ffffffff8018cd2e>{__sync_single_inode+108}
       <ffffffff8018d027>{__writeback_single_inode+353} <ffffffff8013817f>{process_timeout+0}
       <ffffffff802e1a2d>{dm_table_any_congested+18} <ffffffff802e1a2d>{dm_table_any_congested+18}
       <ffffffff8018d204>{sync_sb_inodes+468} <ffffffff8014280f>{keventd_create_kthread+0}
       <ffffffff8018d36e>{writeback_inodes+133} <ffffffff801536c8>{pdflush+0}
       <ffffffff80152ce5>{background_writeout+102} <ffffffff80153621>{__pdflush+289}
       <ffffffff80153702>{pdflush+58} <ffffffff80152c7f>{background_writeout+0}
       <ffffffff801427e6>{kthread+129} <ffffffff8010e652>{child_rip+8}
       <ffffffff8014280f>{keventd_create_kthread+0} <ffffffff80142765>{kthread+0}
       <ffffffff8010e64a>{child_rip+0}

Code: 0f 0b 68 ae b1 36 80 c2 2f 01 48 8b 93 18 02 00 00 49 8d 44
RIP <ffffffff80157b10>{__pagevec_lru_add+95} RSP <ffff8100f6fbdba8>
 NMI Watchdog detected LOCKUP on CPU 0
CPU 0
Modules linked in: bonding
Pid: 1619, comm: irqbalance Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff80345d2f>] <ffffffff80345d2f>{.text.lock.spinlock+32}
RSP: 0018:ffff8100f648de90  EFLAGS: 00000086
RAX: ffff81000000f300 RBX: ffff81000000f300 RCX: 00002aaaaaac0000
RDX: ffffffff804ebe60 RSI: ffff8100f09339e0 RDI: ffff81000000f500
RBP: ffff81000c006dc0 R08: 00002aaaaaac1000 R09: 00000000ffffffff
R10: ffff81000c399da8 R11: ffff81000c399088 R12: ffff810004474798
R13: 0000000000000000 R14: 00002aaaaaac1000 R15: 00002aaaaaac0000
FS:  00002aaaaae00640(0000) GS:ffffffff804a9800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaac0000 CR3: 00000000f6486000 CR4: 00000000000006e0
Process irqbalance (pid: 1619, threadinfo ffff8100f648c000, task ffff810004aac340)
Stack: ffffffff80157b03 ffff81008bb1af60 ffffffff804e7320 ffff8100f65c6580
       ffff81000c399d78 ffff81000c399088 ffffffff801577b9 ffff81000c399088
       ffffffff80160eb9 ffff8100f09339e0
Call Trace:<ffffffff80157b03>{__pagevec_lru_add+82} <ffffffff801577b9>{lru_add_drain+32}
       <ffffffff80160eb9>{unmap_region+65} <ffffffff801612d9>{do_munmap+387}
       <ffffffff80161329>{sys_munmap+57} <ffffffff8010d762>{system_call+126}


Code: f3 90 83 3f 00 7e f9 e9 66 fe ff ff f3 90 83 3f 00 7e f9 e9
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

-ryan
