Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVIFFLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVIFFLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 01:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVIFFLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 01:11:17 -0400
Received: from 1-1-1-12a.nvik.sth.bostream.se ([82.183.147.11]:49051 "EHLO
	zappa.cx") by vger.kernel.org with ESMTP id S932404AbVIFFLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 01:11:15 -0400
Subject: Re: nfs4 client bug
From: Andreas Sundstrom <sunkan@zappa.cx>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 06 Sep 2005 07:10:49 +0200
Message-Id: <1125983449.3503.3.camel@sunkan.zappa.cx>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-5.899) ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[J. Bruce Fields]
> On Sun, Sep 04, 2005 at 01:51:08PM -0700, Bret Towe wrote:
> > On 9/4/05, Bret Towe <magnade@xxxxxxxxx> wrote:
> > > On 9/4/05, Francois Romieu <romieu@xxxxxxxxxxxxx> wrote:
> > > > Bret Towe <magnade@xxxxxxxxx> :
> > > > [...]
> > > > > after moving some files on the server to a new location then
> trying to
> > > > > add the files
> > > > > to xmms playlist i found the following in dmesg after xmms
> froze
> > > > > wonder how many more items i can find...
> > > >
> > > > The system includes some binary only stuff. Please contact your
> vendor
> > > > or provide the traces for a configuration wherein the relevant
> module
> > > > was not loaded after boot. It may make sense to get in touch
> with
> > > > nfs@xxxxxxxxxxxxxxxxxxxxx then.
> > > 
> > > the 'binary only stuff' is ati-drivers kernel module and it crashs
> > > with or without it
> > > ill provide a 'untainted' trace as soon as i can repeat the bug
> again
> > 
> > ok without ati-drivers kernel module loaded the computer basicly
> just
> > hard locks when
> > some bug hits dunno if its the same item 
> 
> Do you get anything from alt-sysrq-T?

I managed to get the following after another crash, I hope it helps
someone to figure out what is going on.

kernel: Unable to handle kernel paging request at virtual address
00100104
kernel:  printing eip:
kernel: c01803b9
kernel: *pde = 00000000
kernel: Oops: 0002 [#1]
kernel: PREEMPT
kernel: Modules linked in: evdev snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_emul snd_seq_midi snd_seq_midi_event
snd_seq snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm
snd_timer snd_page_alloc snd_util_mem snd_hwdep snd dm_mod st sbp2
kernel: CPU:    0
kernel: EIP:    0060:[generic_forget_inode+89/416]    Not tainted VLI
kernel: EFLAGS: 00010246   (2.6.13)
kernel: EIP is at generic_forget_inode+0x59/0x1a0
kernel: eax: 00200200   ebx: cb367888   ecx: 00100100   edx: cb367890
kernel: esi: f6732c00   edi: f6732a00   ebp: 00000000   esp: c1b5dd50
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process kswapd0 (pid: 165, threadinfo=c1b5d000 task=c1b5b570)
kernel: Stack: cb367888 c0180561 cb3678ac cb367888 cb3677f8 c01f12ad
cb367888 c1b5dd70
kernel:        ffffffff ffffffff cb367888 cb367888 cb36776c cb36787c
c01f17e2 cb367888
kernel:        c01429e2 cb36792c c1b5ddf4 00000000 0000000e 00000001
c1b5ddec 00000000
kernel: Call Trace:
kernel:  [iput+65/128] iput+0x41/0x80
kernel:  [nfs_wait_on_inode+125/160] nfs_wait_on_inode+0x7d/0xa0
kernel:  [__nfs_revalidate_inode+146/704] __nfs_revalidate_inode
+0x92/0x2c0
kernel:  [find_get_pages_tag+66/144] find_get_pages_tag+0x42/0x90
kernel:  [pagevec_lookup_tag+51/64] pagevec_lookup_tag+0x33/0x40
kernel:  [wait_on_page_writeback_range+109/288]
wait_on_page_writeback_range+0x6d/0x120
kernel:  [nfs_commit_inode+69/160] nfs_commit_inode+0x45/0xa0
kernel:  [nfs_sync_inode+104/128] nfs_sync_inode+0x68/0x80
kernel:  [nfs_do_return_delegation+43/96] nfs_do_return_delegation
+0x2b/0x60
kernel:  [nfs_inode_return_delegation+236/272]
nfs_inode_return_delegation+0xec/0x110
kernel:  [nfs4_clear_inode+35/176] nfs4_clear_inode+0x23/0xb0
kernel:  [clear_inode+106/192] clear_inode+0x6a/0xc0
kernel:  [dispose_list+47/288] dispose_list+0x2f/0x120
kernel:  [prune_icache+142/528] prune_icache+0x8e/0x210
kernel:  [get_writeback_state+64/80] get_writeback_state+0x40/0x50
kernel:  [shrink_icache_memory+69/80] shrink_icache_memory+0x45/0x50
kernel:  [shrink_slab+308/416] shrink_slab+0x134/0x1a0
kernel:  [balance_pgdat+571/1024] balance_pgdat+0x23b/0x400
kernel:  [kswapd+214/288] kswapd+0xd6/0x120
kernel:  [autoremove_wake_function+0/96] autoremove_wake_function
+0x0/0x60
kernel:  [kswapd+0/288] kswapd+0x0/0x120
kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
kernel: Code: 46 37 40 74 45 b8 00 f0 ff ff 21 e0 ff 48 14 8b 40 08 a8
08 0f 85 2c 01 00 00 83 c4 0c 5b 5e c3 89 f6 8d 53 08 8b 4b 08 8b 42 04
<89> 41 04 89 08 a1 ec 0c 49 c0 89 50 04 89 43 08 c7 42 04 ec 0c
kernel:  <6>note: kswapd0[165] exited with preempt_count 1
kernel: nfs_statfs: statfs error = 13
Sep  6 06:27:26 sunkan last message repeated 4 times
kernel: 8ab69c e28ab570 e28ab698 e28ab570 5561246f 000001a4 c7290000
kernel:        00017ade 00000000 e28ab570 c7290000 c7290efc 00000000
c7290000 c0421196


kernel: Call Trace:
kernel:  [schedule_timeout+118/192] schedule_timeout+0x76/0xc0
kernel:  [rwsem_wake+301/320] rwsem_wake+0x12d/0x140
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          D C053EAA0     0 17843  17769         17844 17842
(NOTLB)
kernel: ca834dac 00000086 e28ab060 c053eaa0 c11aee80 c11aeea0 ca834000
ca834000
kernel:        000016b5 c11468e0 c136db80 e28ab188 e28ab060 8903e7a5
00002690 ca834000
kernel:        8fc2276b ffffd185 c014eaf0 ca834000 c0490cf4 00000286
c0490cfc c0420065
kernel: Call Trace:
kernel:  [shrink_cache+352/752] shrink_cache+0x160/0x2f0
kernel:  [__down+213/288] __down+0xd5/0x120
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [__down_failed+7/12] __down_failed+0x7/0xc
kernel:  [.text.lock.inode+43/68] .text.lock.inode+0x2b/0x44
kernel:  [throttle_vm_writeout+76/128] throttle_vm_writeout+0x4c/0x80
kernel:  [shrink_icache_memory+69/80] shrink_icache_memory+0x45/0x50
kernel:  [shrink_slab+308/416] shrink_slab+0x134/0x1a0
kernel:  [try_to_free_pages+246/448] try_to_free_pages+0xf6/0x1c0
kernel:  [__alloc_pages+516/1088] __alloc_pages+0x204/0x440
kernel:  [__get_free_pages+27/64] __get_free_pages+0x1b/0x40
kernel:  [__pollwait+140/208] __pollwait+0x8c/0xd0
kernel:  [unix_poll+161/192] unix_poll+0xa1/0xc0
kernel:  [sock_poll+38/48] sock_poll+0x26/0x30
kernel:  [do_pollfd+77/192] do_pollfd+0x4d/0xc0
kernel:  [do_poll+93/208] do_poll+0x5d/0xd0
kernel:  [sys_poll+137/592] sys_poll+0x89/0x250
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EF48     0 17844  17769         17845 17843
(NOTLB)
kernel: ca82aeb8 00200086 f3473a40 c053ef48 000001a4 6aa3fb3f ca82a000
ca82a000
kernel:        00000e82 6aa3fb3f 000001a4 e7abfb68 e7abfa40 6aa47595
000001a4 ca82a000
kernel:        0001b530 00000000 ca82aecc 029e23a8 ca82aecc 00000000
ca82a000 c0421170
kernel: Call Trace:
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAA0     0 17845  17769         17846 17844
(NOTLB)
kernel: e49aeeb8 00200086 cbfe7570 c053eaa0 000027a2 c2cdc1be e49ae000
e49ae000
kernel:        000003cc c68e3acb 000027a2 cbfe7698 cbfe7570 c9ac049d
000027a2 e49ae000
kernel:        cdaac8f1 00000000 081b3000 e49ae000 e49aeefc 00000000
e49ae000 c0421196
kernel: Call Trace:
kernel:  [schedule_timeout+118/192] schedule_timeout+0x76/0xc0
kernel:  [find_extend_vma+41/144] find_extend_vma+0x29/0x90
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [sys_gettimeofday+59/144] sys_gettimeofday+0x3b/0x90
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAA0     0 17846  17769         17850 17845
(NOTLB)
kernel: e37b7eb8 00200086 e7abf530 c053eaa0 000024d5 c014b8d5 e37b7000
e37b7000
kernel:        0000088e 253d1904 000024d5 e7abf658 e7abf530 1c6a2166
0000278f e37b7000
kernel:        00ddccb3 00000000 e37b7ecc 00a6a5df e37b7ecc 00000000
e37b7000 c0421170
kernel: Call Trace:
kernel:  [alloc_slabmgmt+85/96] alloc_slabmgmt+0x55/0x60
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [do_fork+250/501] do_fork+0xfa/0x1f5
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAD0     0 17850  17769         17862 17846
(NOTLB)
kernel: e3880eb8 00200086 e8253020 c053ead0 000027a4 c68d7864 e3880000
e3880000
kernel:        000002ba 658f8bbd 000027a4 c4cfa188 c4cfa060 658fa947
000027a4 e3880000
kernel:        d305e654 fffffc03 082d6000 e3880000 e3880efc 00000000
e3880000 c0421196
kernel: Call Trace:
kernel:  [schedule_timeout+118/192] schedule_timeout+0x76/0xc0
kernel:  [find_extend_vma+41/144] find_extend_vma+0x29/0x90
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [sys_gettimeofday+59/144] sys_gettimeofday+0x3b/0x90
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAA0     0 17862  17769         17864 17850
(NOTLB)
kernel: d37fceb8 00200086 f1f50530 c053eaa0 00000000 c014b8d5 d37fc000
d37fc000
kernel:        0000037c d37fc000 c014bb05 f1f50658 f1f50530 558dd2f8
00002791 d37fc000
kernel:        01aee0b8 00000000 086b5000 d37fc000 d37fcefc 00000000
d37fc000 c0421196
kernel: Call Trace:
kernel:  [alloc_slabmgmt+85/96] alloc_slabmgmt+0x55/0x60
kernel:  [cache_grow+261/448] cache_grow+0x105/0x1c0
kernel:  [schedule_timeout+118/192] schedule_timeout+0x76/0xc0
kernel:  [find_extend_vma+41/144] find_extend_vma+0x29/0x90
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [do_fork+250/501] do_fork+0xfa/0x1f5
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [do_sched_setscheduler+122/208] do_sched_setscheduler+0x7a/0xd0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAA0     0 17864  17769         17865 17862
(NOTLB)
kernel: d35ceeb8 00200086 f0edf060 c053eaa0 00000000 c014b8d5 d35ce000
d35ce000
kernel:        000004ed d35ce000 c014bb05 f0edf188 f0edf060 1e4c64b8
00002791 d35ce000
kernel:        03c7609d 00000000 d35ceecc 00a4d995 d35ceecc 00000000
d35ce000 c0421170
kernel: Call Trace:
kernel:  [alloc_slabmgmt+85/96] alloc_slabmgmt+0x55/0x60
kernel:  [cache_grow+261/448] cache_grow+0x105/0x1c0
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [do_fork+250/501] do_fork+0xfa/0x1f5
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAD0     0 17865  17769         17871 17864
(NOTLB)
kernel: edf23eb8 00200086 f0edf570 c053ead0 000002f6 b6aa94ac edf23000
edf23000
kernel:        00000fc4 b6aa94ac 000002f6 f0edfba8 f0edfa80 b6aaad1c
000002f6 edf23000
kernel:        0019ad5c 00000000 086ac000 edf23000 edf23efc 00000000
edf23000 c0421196
kernel: Call Trace:
kernel:  [schedule_timeout+118/192] schedule_timeout+0x76/0xc0
kernel:  [__wake_up_common+67/112] __wake_up_common+0x43/0x70
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [do_fork+250/501] do_fork+0xfa/0x1f5
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [do_sched_setscheduler+122/208] do_sched_setscheduler+0x7a/0xd0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAD0     0 17871  17769         17873 17865
(NOTLB)
kernel: e445eeb8 00200086 f2385060 c053ead0 000027a4 c3f730d9 e445e000
e445e000
kernel:        0000149c c60a98be 000027a4 ee430ba8 ee430a80 c60b6b60
000027a4 e445e000
kernel:        c091cef1 fffffe14 e445eecc 00a4b701 e445eecc 00000000
e445e000 c0421170
kernel: Call Trace:
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAA0     0 17873  17769         17901 17871
(NOTLB)
kernel: ceca9eb8 00200086 ee430060 c053eaa0 00002311 e57eb544 ceca9000
ceca9000
kernel:        00000855 bda4e8ff 00002311 ee430188 ee430060 4fb54e99
00002785 ceca9000
kernel:        00cfda47 00000000 08362000 ceca9000 ceca9efc 00000000
ceca9000 c0421196
kernel: Call Trace:
kernel:  [schedule_timeout+118/192] schedule_timeout+0x76/0xc0
kernel:  [find_extend_vma+41/144] find_extend_vma+0x29/0x90
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [sys_gettimeofday+59/144] sys_gettimeofday+0x3b/0x90
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAA0     0 17901  17769           425 17873
(NOTLB)
kernel: e04ddeb8 00200086 f032a530 c053eaa0 00002777 47fee18b e04dd000
e04dd000
kernel:        0000050c 47fee18b 00002777 f032a658 f032a530 a8866baa
000027a4 e04dd000
kernel:        1dfc5a7a 00000000 e04ddecc 00a4c512 e04ddecc 00000000
e04dd000 c0421170
kernel: Call Trace:
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [do_fork+250/501] do_fork+0xfa/0x1f5
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAD0     0   425  17769          1569 17901
(NOTLB)
kernel: efb14eb8 00200086 e3354a40 c053ead0 000027a4 082e50f8 efb14000
efb14000
kernel:        0000127e 082e50f8 000027a4 f6244658 f6244530 082e7190
000027a4 efb14000
kernel:        08817d2f 00000000 efb14ecc 00a4bd8f efb14ecc 00000000
efb14000 c0421170
kernel: Call Trace:
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAA0     0  1569  17769          1596   425
(NOTLB)
kernel: d066bf14 00200086 f0edf570 c053eaa0 c048fbc8 d066bef0 d066b000
d066b000
kernel:        000085df d066bf9c c0147bf7 f0edf698 f0edf570 55d6dac4
00002791 d066b000
kernel:        001cedf8 00000000 d066bf28 00a4da7f d066bf28 d066bf64
00007531 c0421170
kernel: Call Trace:
kernel:  [__get_free_pages+39/64] __get_free_pages+0x27/0x40
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_poll+166/208] do_poll+0xa6/0xd0
kernel:  [sys_poll+137/592] sys_poll+0x89/0x250
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAA0     0  1596  17769          1599  1569
(NOTLB)
kernel: e448feb8 00200086 e7abf020 c053eaa0 eb79b700 e83052f5 e448f000
e448f000
kernel:        00000540 c011ce67 cfc7a020 e7abf148 e7abf020 e830a774
000027a2 e448f000
kernel:        000433ec 00000000 e448fecc 00a4b8d6 e448fecc 00000000
e448f000 c0421170
kernel: Call Trace:
kernel:  [activate_task+103/128] activate_task+0x67/0x80
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: java          S C053EAA0     0  1599  17769                1596
(NOTLB)
kernel: f6008eb8 00200086 d06c5570 c053eaa0 eb79b700 a8863d52 f6008000
f6008000
kernel:        0000055e c011ce67 f032a530 d06c5698 d06c5570 a886913d
000027a4 f6008000
kernel:        0001b8c6 00000000 f6008ecc 00a4c030 f6008ecc 00000000
f6008000 c0421170
kernel: Call Trace:
kernel:  [activate_task+103/128] activate_task+0x67/0x80
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [futex_wait+491/544] futex_wait+0x1eb/0x220
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [do_futex+116/208] do_futex+0x74/0xd0
kernel:  [sys_futex+102/320] sys_futex+0x66/0x140
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: getty         S C053EAA0     0 23442      1          1070 18624
(NOTLB)
kernel: f699feac 00000086 f7951a40 c053eaa0 00000000 00000020 f699f000
f699f000
kernel:        0000628a c02c5842 c1813000 f7951b68 f7951a40 e6395180
00000e87 f699f000
kernel:        0014ed77 00000000 c027eab3 00000000 00000019 f53dc000
f699f000 c0421196
kernel: Call Trace:
kernel:  [do_con_write+754/1504] do_con_write+0x2f2/0x5e0
kernel:  [vgacon_cursor+419/560] vgacon_cursor+0x1a3/0x230
kernel:  [schedule_timeout+118/192] schedule_timeout+0x76/0xc0
kernel:  [set_cursor+90/128] set_cursor+0x5a/0x80
kernel:  [read_chan+974/1856] read_chan+0x3ce/0x740
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [tty_read+155/224] tty_read+0x9b/0xe0
kernel:  [vfs_read+181/400] vfs_read+0xb5/0x190
kernel:  [sys_read+75/128] sys_read+0x4b/0x80
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: cron          S C053EAA0     0  1035   3487  1036
(NOTLB)
kernel: ddd69ee4 00000086 c2b2c060 c053eaa0 01000001 000000d0 ddd69000
ddd69000
kernel:        00000966 ddd69000 000000d0 c2b2c188 c2b2c060 3c9c9732
0000266f ddd69000
kernel:        0053dc04 00000000 00000246 f7ab53e4 00001000 00000000
00000000 c0170d41
kernel: Call Trace:
kernel:  [pipe_wait+113/144] pipe_wait+0x71/0x90
kernel:  [autoremove_wake_function+0/96] autoremove_wake_function
+0x0/0x60
kernel:  [pipe_readv+504/864] pipe_readv+0x1f8/0x360
kernel:  [pipe_read+55/64] pipe_read+0x37/0x40
kernel:  [vfs_read+181/400] vfs_read+0xb5/0x190
kernel:  [sys_read+75/128] sys_read+0x4b/0x80
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: sh            S C053EAA0     0  1036   1035  1039
(NOTLB)
kernel: df73df34 00000082 d2065a80 c053eaa0 ca7a94ec c0118c07 df73d000
df73d000
kernel:        00004583 00000001 00000007 d2065ba8 d2065a80 3ce2ef31
0000266f df73d000
kernel:        0022d813 00000000 0000266f d2065b2c 00000001 d2065a80
00000004 c0124daf
kernel: Call Trace:
kernel:  [do_page_fault+359/1742] do_page_fault+0x167/0x6ce
kernel:  [do_wait+655/1008] do_wait+0x28f/0x3f0
kernel:  [preempt_schedule+77/96] preempt_schedule+0x4d/0x60
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [sys_wait4+67/80] sys_wait4+0x43/0x50
kernel:  [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: run-parts     S C053EAA0     0  1039   1036  1103
(NOTLB)
kernel: e6f26ebc 00000086 f55cf570 c053eaa0 000000d0 00000001 e6f26000
e6f26000
kernel:        00000dc7 c048fbc4 00000010 f55cf698 f55cf570 718a7b3d
00002672 e6f26000
kernel:        0022a4c1 00000000 00000000 d1fbd640 00000040 00000006
0000001a c0421196
kernel: Call Trace:
kernel:  [schedule_timeout+118/192] schedule_timeout+0x76/0xc0
kernel:  [pipe_poll+205/224] pipe_poll+0xcd/0xe0
kernel:  [do_select+698/880] do_select+0x2ba/0x370
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+574/976] sys_select+0x23e/0x3d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: cupsd         S C053EAA0     0  1070      1          1598 23442
(NOTLB)
kernel: f65e2ebc 00000082 f78f1020 c053eaa0 00000001 c048fbc4 f65e2000
f65e2000
kernel:        000008e2 0c3cd223 000027a4 f78f1148 f78f1020 47c8af9c
000027a4 f65e2000
kernel:        18a2bacd 00000000 f65e2ed0 00a55fbb f65e2ed0 00000006
0000001a c0421170
kernel: Call Trace:
kernel:  [schedule_timeout+80/192] schedule_timeout+0x50/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_select+698/880] do_select+0x2ba/0x370
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+574/976] sys_select+0x23e/0x3d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: slocate       S C053EAA0     0  1103   1039  1104
(NOTLB)
kernel: f537cf34 00000086 f032aa40 c053eaa0 f515e90c c0118c07 f537c000
f537c000
kernel:        0000366b 00000001 00000007 f032ab68 f032aa40 7216f663
00002672 f537c000
kernel:        00222bf0 00000000 00002672 f032aaec 00000001 f032aa40
00000004 c0124daf
kernel: Call Trace:
kernel:  [do_page_fault+359/1742] do_page_fault+0x167/0x6ce
kernel:  [do_wait+655/1008] do_wait+0x28f/0x3f0
kernel:  [preempt_schedule+77/96] preempt_schedule+0x4d/0x60
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [sys_wait4+67/80] sys_wait4+0x43/0x50
kernel:  [sys_waitpid+39/43] sys_waitpid+0x27/0x2b
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: updatedb      D C053EAA0     0  1104   1103
(NOTLB)
kernel: f5ff8adc 00000082 f6495a40 c053eaa0 f7953040 f6495a40 f5ff8000
f5ff8000
kernel:        000039ee f5ff8000 c0420665 f6495b68 f6495a40 10a2561b
00002691 f5ff8000
kernel:        d3ed0679 00000000 e3ca1cc4 f5ff8000 c0490cf4 00000286
c0490cfc c0420065
kernel: Call Trace:
kernel:  [schedule+1093/1584] schedule+0x445/0x630
kernel:  [__down+213/288] __down+0xd5/0x120
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [__down_failed+7/12] __down_failed+0x7/0xc
kernel:  [.text.lock.inode+43/68] .text.lock.inode+0x2b/0x44
kernel:  [shrink_icache_memory+69/80] shrink_icache_memory+0x45/0x50
kernel:  [shrink_slab+308/416] shrink_slab+0x134/0x1a0
kernel:  [try_to_free_pages+246/448] try_to_free_pages+0xf6/0x1c0
kernel:  [__alloc_pages+516/1088] __alloc_pages+0x204/0x440
kernel:  [kmem_getpages+57/192] kmem_getpages+0x39/0xc0
kernel:  [pathrelse+48/80] pathrelse+0x30/0x50
kernel:  [cache_grow+181/448] cache_grow+0xb5/0x1c0
kernel:  [cache_alloc_refill+530/592] cache_alloc_refill+0x212/0x250
kernel:  [kmem_cache_alloc+56/64] kmem_cache_alloc+0x38/0x40
kernel:  [reiserfs_alloc_inode+24/48] reiserfs_alloc_inode+0x18/0x30
kernel:  [alloc_inode+27/336] alloc_inode+0x1b/0x150
kernel:  [iget5_locked+138/352] iget5_locked+0x8a/0x160
kernel:  [get_new_inode+31/400] get_new_inode+0x1f/0x190
kernel:  [reiserfs_init_locked_inode+0/32] reiserfs_init_locked_inode
+0x0/0x20
kernel:  [reiserfs_find_actor+0/48] reiserfs_find_actor+0x0/0x30
kernel:  [reiserfs_iget+72/192] reiserfs_iget+0x48/0xc0
kernel:  [reiserfs_find_actor+0/48] reiserfs_find_actor+0x0/0x30
kernel:  [reiserfs_init_locked_inode+0/32] reiserfs_init_locked_inode
+0x0/0x20
kernel:  [reiserfs_lookup+256/400] reiserfs_lookup+0x100/0x190
kernel:  [real_lookup+222/272] real_lookup+0xde/0x110
kernel:  [do_lookup+157/176] do_lookup+0x9d/0xb0
kernel:  [__link_path_walk+2133/4016] __link_path_walk+0x855/0xfb0
kernel:  [dput+307/704] dput+0x133/0x2c0
kernel:  [link_path_walk+87/288] link_path_walk+0x57/0x120
kernel:  [path_lookup+134/352] path_lookup+0x86/0x160
kernel:  [__user_walk+51/96] __user_walk+0x33/0x60
kernel:  [vfs_lstat+28/96] vfs_lstat+0x1c/0x60
kernel:  [sys_lstat64+24/64] sys_lstat64+0x18/0x40
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: SysRq : HELP : loglevel0-8 reBoot tErm Full kIll saK showMem
Nice powerOff showPc unRaw Sync showTasks Unmount
kernel: SysRq : Emergency Sync
kernel: Emergency Sync complete
kernel: SysRq : Emergency Sync


/Andreas Sundstrom

