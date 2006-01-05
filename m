Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751953AbWAEFkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbWAEFkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWAEFkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:40:22 -0500
Received: from solarneutrino.net ([66.199.224.43]:7172 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751950AbWAEFkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:40:21 -0500
Date: Thu, 5 Jan 2006 00:40:05 -0500
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20060105054005.GA481@tau.solarneutrino.net>
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
> This looks similar to my output except that the page flags are 
> 0x060000000000006c in your case whereas I have 0x010000000000006c.

Well, here's another.  It seems to happen much more often with 2.6.15.


 st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981656
 1: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981657
 2: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981658
 3: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981659
 4: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981660
 5: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981661
 6: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981662
 7: flags:0x010000000000006c mapping:ffff8100f6eb4520 mapcount:2 count:4 pfn:981663
Bad page state at free_hot_cold_page (in process 'taper', page ffff810004422e88)
flags:0x010000000000000c mapping:ffff81017513fe58 mapcount:2 count:0
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff80150c3f>{free_hot_cold_page+105}
       <ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'taper', page ffff8100019b4b30)
flags:0x010000000000000c mapping:ffff81017513fe58 mapcount:2 count:0
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
Pid: 6392, comm: taper Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff8015751c>] <ffffffff8015751c>{put_page+96}
RSP: 0018:ffff81017514be18  EFLAGS: 00010256
RAX: 0000000000000000 RBX: 00000000000000c0 RCX: ffff810004422e88
RDX: ffff810004422e88 RSI: 0000000000000001 RDI: ffff810004422e88
RBP: 0000000000000006 R08: ffff81017514a000 R09: 0000000000000001
R10: ffff8100049237f8 R11: 0000000000000046 R12: 0000000000000008
R13: ffff8100f6f84068 R14: 0000000000000000 R15: 0000000000008000
FS:  00002aaaab53d880(0000) GS:ffffffff804a9800(0000) knlGS:00000000555bc920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 0000000175146000 CR4: 00000000000006e0
Process taper (pid: 6392, threadinfo ffff81017514a000, task ffff81017da40300)
Stack: 010000000000000c ffffffff8028c534 0000000000008000 0000000000008000
       ffff8100f6f84000 ffff81000493e400 0000000000008000 0000000000000040
       0000000000008000 ffffffff8028826d
Call Trace:<ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}


Code: 0f 0b 68 ae b1 36 80 c2 31 00 f0 83 42 08 ff 0f 98 c0 84 c0
RIP <ffffffff8015751c>{put_page+96} RSP <ffff81017514be18>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/rmap.c:486
invalid operand: 0000 [2] SMP
CPU 0
Modules linked in: bonding
Pid: 6392, comm: taper Tainted: G    B 2.6.15 #1
RIP: 0010:[<ffffffff80163736>] <ffffffff80163736>{page_remove_rmap+19}
RSP: 0018:ffff81017514baa0  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff810004422e88 RCX: 0000000000000020
RDX: 80000000ee567067 RSI: 80000000ee567067 RDI: ffff810004422e88
RBP: 80000000ee567067 R08: 0000000000000020 R09: 00002aaaaaafe000
R10: 00000000000ee567 R11: 0000000000000000 R12: ffff81000c002280
R13: ffff8100edd037f0 R14: 00002aaaaaafe000 R15: 0000000000000000
FS:  00002aaaab53d880(0000) GS:ffffffff804a9800(0000) knlGS:00000000555bc920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaab5ffff CR3: 0000000175146000 CR4: 00000000000006e0
Process taper (pid: 6392, threadinfo ffff81017514a000, task ffff81017da40300)
Stack: ffffffff8015be23 ffff81017514bae8 ffff8100044058b8 ffffffc100000000
       ffff81017fb0cc40 ffff81017514bbb8 00002aaaaab62000 ffff81017da75700
       00002aaaaab62000 ffff8100edd02aa8
Call Trace:<ffffffff8015be23>{zap_pte_range+464} <ffffffff8015c0ff>{unmap_page_range+476}
       <ffffffff8015c24e>{unmap_vmas+238} <ffffffff8016167b>{exit_mmap+114}
       <ffffffff8012d638>{mmput+34} <ffffffff8013214a>{do_exit+489}
       <ffffffff8010f203>{die_nmi+0} <ffffffff8010f587>{do_invalid_op+145}
       <ffffffff8015751c>{put_page+96} <ffffffff803448db>{thread_return+0}
       <ffffffff8010e49d>{error_exit+0} <ffffffff8015751c>{put_page+96}
       <ffffffff8028c534>{sgl_unmap_user_pages+124} <ffffffff8028826d>{release_buffering+27}
       <ffffffff802888f9>{st_write+1670} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8016dac8>{sys_write+69} <ffffffff8010d762>{system_call+126}


Code: 0f 0b 68 b0 b2 36 80 c2 e6 01 48 83 ce ff bf 20 00 00 00 e9
RIP <ffffffff80163736>{page_remove_rmap+19} RSP <ffff81017514baa0>
 <1>Fixing recursive fault but reboot is needed!
Bad page state at prep_new_page (in process 'gzip', page ffff810004422e88)
flags:0x010000000000001c mapping:0000000000000000 mapcount:-1 count:0
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff801506eb>{prep_new_page+70}
       <ffffffff80150e12>{buffered_rmqueue+311} <ffffffff80150fe3>{get_page_from_freelist+130}
       <ffffffff80151067>{__alloc_pages+86} <ffffffff8015df88>{do_anonymous_page+69}
       <ffffffff8015e6f9>{__handle_mm_fault+396} <ffffffff8011d10f>{do_page_fault+520}
       <ffffffff80142cca>{autoremove_wake_function+0} <ffffffff8019722f>{dnotify_parent+28}
       <ffffffff8016d7dc>{vfs_read+212} <ffffffff8010e49d>{error_exit+0}

Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'dumper', page ffff8100019b4b30)
flags:0x0100000000000064 mapping:ffff81017de5eaf9 mapcount:1 count:1
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff801506eb>{prep_new_page+70}
       <ffffffff80150e12>{buffered_rmqueue+311} <ffffffff80150fe3>{get_page_from_freelist+130}
       <ffffffff80151067>{__alloc_pages+86} <ffffffff8014e7f9>{generic_file_buffered_write+402}
       <ffffffff80134113>{current_fs_time+97} <ffffffff8014ef95>{__generic_file_aio_write_nolock+891}
       <ffffffff802ea7fb>{sock_common_recvmsg+45} <ffffffff802e7724>{sock_aio_read+252}
       <ffffffff8014f1ff>{generic_file_aio_write+105} <ffffffff801a2979>{ext3_file_write+22}
       <ffffffff8016d8d5>{do_sync_write+202} <ffffffff8017e9e8>{__pollwait+0}
       <ffffffff80142cca>{autoremove_wake_function+0} <ffffffff8017f22a>{sys_select+952}
       <ffffffff8016d9bc>{vfs_write+173} <0>Bad page state at prep_new_page (in process 'dumper', page ffff810001a24af8)
flags:0x0100000000000064 mapping:ffff81017de5eaf9 mapcount:1 count:1
Backtrace:

Call Trace: <IRQ> <ffffffff80150234>{bad_page+116} <ffffffff801506eb>{prep_new_page+70}
       <ffffffff80150e12>{buffered_rmqueue+311} <ffffffff80150fe3>{get_page_from_freelist+130}
       <ffffffff80151067>{__alloc_pages+86} <ffffffff801545b1>{kmem_getpages+88}
       <ffffffff80155789>{cache_grow+195} <ffffffff801559d0>{cache_alloc_refill+408}
       <ffffffff80155feb>{__kmalloc+100} <ffffffff802eb11b>{__alloc_skb+83}
       <ffffffff802663a6>{tg3_alloc_rx_skb+186} <ffffffff80266630>{tg3_rx+338}
       <ffffffff80266998>{tg3_poll+135} <ffffffff802f0a85>{net_rx_action+129}
       <ffffffff801342b8>{__do_softirq+80} <ffffffff8010eae3>{call_softirq+31}
       <ffffffff80110384>{do_softirq+47} <ffffffff8010e34a>{apic_timer_interrupt+98}
        <EOI> <ffffffff8013008d>{release_console_sem+76} <ffffffff8012ff8d>{vprintk+543}
       <ffffffff8012ae27>{__wake_up+54} <ffffffff8016d9bc>{vfs_write+173}
       <ffffffff8012fd66>{printk+141} <ffffffff80149172>{module_text_address+48}
       <ffffffff8010edd8>{show_trace+430} <ffffffff8010eecf>{dump_stack+9}
       <ffffffff80150234>{bad_page+116} <ffffffff801506eb>{prep_new_page+70}
       <ffffffff80150e12>{buffered_rmqueue+311} <ffffffff80150fe3>{get_page_from_freelist+130}
       <ffffffff80151067>{__alloc_pages+86} <ffffffff8014e7f9>{generic_file_buffered_write+402}
       <ffffffff80134113>{current_fs_time+97} <ffffffff8014ef95>{__generic_file_aio_write_nolock+891}
       <ffffffff802ea7fb>{sock_common_recvmsg+45} <ffffffff802e7724>{sock_aio_read+252}
       <ffffffff8014f1ff>{generic_file_aio_write+105} <ffffffff801a2979>{ext3_file_write+22}
       <ffffffff8016d8d5>{do_sync_write+202} <ffffffff8017e9e8>{__pollwait+0}
       <ffffffff80142cca>{autoremove_wake_function+0} <ffffffff8017f22a>{sys_select+952}
       <ffffffff8016d9bc>{vfs_write+173} <ffffffff8016dac8>{sys_write+69}
       <ffffffff8010d762>{system_call+126}
Trying to fix it up, but a reboot is needed
<ffffffff8016dac8>{sys_write+69}
       <ffffffff8010d762>{system_call+126}
Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page (in process 'dumper', page ffff81000449ab00)
flags:0x0100000000000064 mapping:ffff81017de5eaf9 mapcount:1 count:1
Backtrace:

Call Trace:<ffffffff80150234>{bad_page+116} <ffffffff801506eb>{prep_new_page+70}

-ryan
