Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVFOSBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFOSBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVFOSBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:01:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:55468 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261252AbVFOR7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:59:52 -0400
Subject: 2.6.12-rc6-mm1 & 2K lun testing
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="=-FnJL1OP+PdKwQIe9hNr0"
Organization: 
Message-Id: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jun 2005 10:36:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FnJL1OP+PdKwQIe9hNr0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I sniff tested 2K lun support with 2.6.12-rc6-mm1 on
my AMD64 box. I had to tweak qlogic driver and
scsi_scan.c to see all the luns.

(2.6.12-rc6 doesn't see all the LUNS due to max_lun
issue - which is fixed in scsi-git tree).

Test 1:
	run dds on all 2048 "raw" devices - worked
great. No issues.

Tests 2: 
	run "dds" on 2048 filesystems (one file
per filesystem). Kind of works. I was expecting better
responsiveness & stability.


Overall - Good news is, it works. 

Not so good news - with filesystem tests, machine becomes 
unresponsive, lots of page allocation failures but machine 
stays up and completes the tests and recovers.

Thanks,
Badari


--=-FnJL1OP+PdKwQIe9hNr0
Content-Disposition: attachment; filename=failures.out
Content-Type: text/plain; name=failures.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

elm3b29 login: dd: page allocation failure. order:0, mode:0x20

Call Trace: <IRQ> <ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
       <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff80166e86>{kmem_cache_alloc+54}
       <ffffffff8033d021>{scsi_get_command+81} <ffffffff8034181d>{scsi_prep_fn+301}
       <ffffffff802f7b98>{elv_next_request+72} <ffffffff80341c1d>{scsi_request_fn+221}
       <ffffffff802fb61d>{blk_run_queue+61} <ffffffff803420ff>{scsi_end_request+223}
       <ffffffff80342355>{scsi_io_completion+565} <ffffffff8034ada1>{sd_rw_intr+609}
       <ffffffff8033c696>{scsi_finish_command+166} <ffffffff8033c79b>{scsi_softirq+235}
       <ffffffff8013b601>{__do_softirq+113} <ffffffff8013b6b5>{do_softirq+53}
       <ffffffff801107d7>{do_IRQ+71} <ffffffff8010e253>{ret_from_intr+0}
        <EOI> <ffffffff80295ca1>{__memset+65} <ffffffff80187fee>{bio_alloc_bioset+382}
       <ffffffff801a875b>{mpage_alloc+43} <ffffffff801a8b96>{__mpage_writepage+918}
       <ffffffff8024fb10>{jfs_get_block+0} <ffffffff803e9e75>{__wait_on_bit_lock+101}
       <ffffffff8024fb10>{jfs_get_block+0} <ffffffff802fa77f>{submit_bio+223}
       <ffffffff8014c6b0>{wake_bit_function+0} <ffffffff80163b34>{get_writeback_state+52}
       <ffffffff8024fb10>{jfs_get_block+0} <ffffffff801a8d77>{mpage_writepage+55}
       <ffffffff80186fc0>{nobh_writepage+192} <ffffffff8016aa60>{shrink_zone+2720}
       <ffffffff80293351>{__up_read+33} <ffffffff8025e127>{dbAlloc+1095}
       <ffffffff801a85a4>{__mark_inode_dirty+52} <ffffffff80265429>{extAlloc+1129}
       <ffffffff802931b1>{__up_write+49} <ffffffff8024fad9>{jfs_get_blocks+521}
       <ffffffff8015d38c>{find_get_page+92} <ffffffff80184ac5>{__find_get_block_slow+85}
       <ffffffff8016b90d>{try_to_free_pages+317} <ffffffff80163132>{__alloc_pages+610}
       <ffffffff801a85a4>{__mark_inode_dirty+52} <ffffffff8015de7c>{generic_file_buffered_write+412}
       <ffffffff8013a965>{current_fs_time+85} <ffffffff80162e63>{buffered_rmqueue+723}
       <ffffffff8019d9ae>{inode_update_time+62} <ffffffff8015e63a>{__generic_file_aio_write_nolock+938}
       <ffffffff8016d67c>{do_no_page+860} <ffffffff8015e81e>{__generic_file_write_nolock+158}
       <ffffffff80170ade>{zeromap_page_range+990} <ffffffff8014c680>{autoremove_wake_function+0}
       <ffffffff80293351>{__up_read+33} <ffffffff8015e985>{generic_file_write+101}
       <ffffffff801830a9>{vfs_write+233} <ffffffff80183253>{sys_write+83}
       <ffffffff8010dc8e>{system_call+126} 
Mem-info:
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:41
cpu 1 hot: low 62, high 186, batch 31 used:80
cpu 1 cold: low 0, high 62, batch 31 used:58
cpu 2 hot: low 62, high 186, batch 31 used:94
cpu 2 cold: low 0, high 62, batch 31 used:48
cpu 3 hot: low 62, high 186, batch 31 used:126
cpu 3 cold: low 0, high 62, batch 31 used:53
Node 3 HighMem per-cpu: empty
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 31 used:44
cpu 1 hot: low 62, high 186, batch 31 used:174
cpu 1 cold: low 0, high 62, batch 31 used:35
cpu 2 hot: low 62, high 186, batch 31 used:98
cpu 2 cold: low 0, high 62, batch 31 used:61
cpu 3 hot: low 62, high 186, batch 31 used:107
cpu 3 cold: low 0, high 62, batch 31 used:52
Node 2 HighMem per-cpu: empty
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:60
cpu 1 hot: low 62, high 186, batch 31 used:93
cpu 1 cold: low 0, high 62, batch 31 used:60
cpu 2 hot: low 62, high 186, batch 31 used:109
cpu 2 cold: low 0, high 62, batch 31 used:55
cpu 3 hot: low 62, high 186, batch 31 used:93
cpu 3 cold: low 0, high 62, batch 31 used:57
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:6
cpu 0 cold: low 0, high 2, batch 1 used:0
cpu 1 hot: low 2, high 6, batch 1 used:0
cpu 1 cold: low 0, high 2, batch 1 used:0
cpu 2 hot: low 2, high 6, batch 1 used:0
cpu 2 cold: low 0, high 2, batch 1 used:0
cpu 3 hot: low 2, high 6, batch 1 used:0
cpu 3 cold: low 0, high 2, batch 1 used:0
Node 0 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:70
cpu 0 cold: low 0, high 62, batch 31 used:54
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:52
cpu 2 hot: low 62, high 186, batch 31 used:89
cpu 2 cold: low 0, high 62, batch 31 used:50
cpu 3 hot: low 62, high 186, batch 31 used:74
cpu 3 cold: low 0, high 62, batch 31 used:59
Node 0 HighMem per-cpu: empty

Free pages:       18864kB (0kB HighMem)
Active:101677 inactive:1471000 dirty:1490116 writeback:13161 unstable:0 free:4716 slab:76480 mapped:98020 pagetables:17144
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 3 Normal free:508kB min:1492kB low:1864kB high:2236kB active:92496kB inactive:242628kB present:524284kB pages_scanned:5984 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 2 Normal free:512kB min:1492kB low:1864kB high:2236kB active:113072kB inactive:117892kB present:524284kB pages_scanned:13627 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 1 Normal free:548kB min:1492kB low:1864kB high:2236kB active:44912kB inactive:209476kB present:524284kB pages_scanned:6452 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA free:10628kB min:44kB low:52kB high:64kB active:0kB inactive:0kB present:16384kB pages_scanned:56 all_unreclaimable? yes
lowmem_reserve[]: 0 6127 6127
Node 0 Normal free:6668kB min:17896kB low:22368kB high:26844kB active:156228kB inactive:5313748kB present:6275068kB pages_scanned:38737 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 DMA: empty
Node 3 Normal: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 508kB
Node 3 HighMem: empty
Node 2 DMA: empty
Node 2 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 512kB
Node 2 HighMem: empty
Node 1 DMA: empty
Node 1 Normal: 1*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 548kB
Node 1 HighMem: empty
Node 0 DMA: 5*4kB 4*8kB 5*16kB 4*32kB 4*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 10628kB
Node 0 Normal: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB = 6668kB
Node 0 HighMem: empty
Swap cache: add 1, delete 0, find 0/0, race 0+0
Free swap  = 1048780kB
Total swap = 1048784kB
Free swap:       1048780kB
1966076 pages of RAM
163061 reserved pages
716790 pages shared
1 pages swap cached
jfsCommit: page allocation failure. order:0, mode:0x20

Call Trace: <IRQ> <ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
       <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff80166e86>{kmem_cache_alloc+54}
       <ffffffff8033d021>{scsi_get_command+81} <ffffffff8034181d>{scsi_prep_fn+301}
       <ffffffff802f7b98>{elv_next_request+72} <ffffffff80341c1d>{scsi_request_fn+221}
       <ffffffff802fb61d>{blk_run_queue+61} <ffffffff803420ff>{scsi_end_request+223}
       <ffffffff80342355>{scsi_io_completion+565} <ffffffff8034ada1>{sd_rw_intr+609}
       <ffffffff8033c696>{scsi_finish_command+166} <ffffffff8033c79b>{scsi_softirq+235}
       <ffffffff8013b601>{__do_softirq+113} <ffffffff8013b6b5>{do_softirq+53}
       <ffffffff801107d7>{do_IRQ+71} <ffffffff8010e253>{ret_from_intr+0}
        <EOI> <ffffffff8016a639>{shrink_zone+1657} <ffffffff8016a639>{shrink_zone+1657}
       <ffffffff8016b90d>{try_to_free_pages+317} <ffffffff80163132>{__alloc_pages+610}
       <ffffffff80265860>{metapage_readpage+0} <ffffffff8017c183>{alloc_page_interleave+67}
       <ffffffff8015ec62>{read_cache_page+82} <ffffffff8026654f>{__get_metapage+271}
       <ffffffff8015d413>{unlock_page+35} <ffffffff80266898>{__get_metapage+1112}
       <ffffffff80131893>{__wake_up+67} <ffffffff8025e4c8>{dbUpdatePMap+376}
       <ffffffff80258165>{diUpdatePMap+805} <ffffffff8026abff>{txUpdateMap+495}
       <ffffffff8026c66f>{jfs_lazycommit+271} <ffffffff80130e20>{default_wake_function+0}
       <ffffffff80130e20>{default_wake_function+0} <ffffffff80133050>{schedule_tail+64}
       <ffffffff8010e967>{child_rip+8} <ffffffff8026c560>{jfs_lazycommit+0}
       <ffffffff8010e95f>{child_rip+0} 
Mem-info:
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:41
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:58
cpu 2 hot: low 62, high 186, batch 31 used:116
cpu 2 cold: low 0, high 62, batch 31 used:49
cpu 3 hot: low 62, high 186, batch 31 used:92
cpu 3 cold: low 0, high 62, batch 31 used:53
Node 3 HighMem per-cpu: empty
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 31 used:44
cpu 1 hot: low 62, high 186, batch 31 used:174
cpu 1 cold: low 0, high 62, batch 31 used:35
cpu 2 hot: low 62, high 186, batch 31 used:100
cpu 2 cold: low 0, high 62, batch 31 used:61
cpu 3 hot: low 62, high 186, batch 31 used:108
cpu 3 cold: low 0, high 62, batch 31 used:52
Node 2 HighMem per-cpu: empty
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:60
cpu 1 hot: low 62, high 186, batch 31 used:93
cpu 1 cold: low 0, high 62, batch 31 used:60
cpu 2 hot: low 62, high 186, batch 31 used:134
cpu 2 cold: low 0, high 62, batch 31 used:55
cpu 3 hot: low 62, high 186, batch 31 used:93
cpu 3 cold: low 0, high 62, batch 31 used:57
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:6
cpu 0 cold: low 0, high 2, batch 1 used:0
cpu 1 hot: low 2, high 6, batch 1 used:0
cpu 1 cold: low 0, high 2, batch 1 used:0
cpu 2 hot: low 2, high 6, batch 1 used:0
cpu 2 cold: low 0, high 2, batch 1 used:0
cpu 3 hot: low 2, high 6, batch 1 used:0
cpu 3 cold: low 0, high 2, batch 1 used:0
Node 0 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:70
cpu 0 cold: low 0, high 62, batch 31 used:54
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:53
cpu 2 hot: low 62, high 186, batch 31 used:92
cpu 2 cold: low 0, high 62, batch 31 used:46
cpu 3 hot: low 62, high 186, batch 31 used:74
cpu 3 cold: low 0, high 62, batch 31 used:59
Node 0 HighMem per-cpu: empty

Free pages:       18896kB (0kB HighMem)
Active:100907 inactive:1466089 dirty:1489475 writeback:13761 unstable:0 free:4724 slab:76736 mapped:97911 pagetables:17120
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 3 Normal free:540kB min:1492kB low:1864kB high:2236kB active:92064kB inactive:237628kB present:524284kB pages_scanned:442 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 2 Normal free:512kB min:1492kB low:1864kB high:2236kB active:113072kB inactive:111876kB present:524284kB pages_scanned:19243 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 1 Normal free:548kB min:1492kB low:1864kB high:2236kB active:42372kB inactive:208688kB present:524284kB pages_scanned:10176 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA free:10628kB min:44kB low:52kB high:64kB active:0kB inactive:0kB present:16384kB pages_scanned:56 all_unreclaimable? yes
lowmem_reserve[]: 0 6127 6127
Node 0 Normal free:6668kB min:17896kB low:22368kB high:26844kB active:156120kB inactive:5306204kB present:6275068kB pages_scanned:10672 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 DMA: empty
Node 3 Normal: 1*4kB 3*8kB 0*16kB 2*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 540kB
Node 3 HighMem: empty
Node 2 DMA: empty
Node 2 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 512kB
Node 2 HighMem: empty
Node 1 DMA: empty
Node 1 Normal: 1*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 548kB
Node 1 HighMem: empty
Node 0 DMA: 5*4kB 4*8kB 5*16kB 4*32kB 4*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 10628kB
Node 0 Normal: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB = 6668kB
Node 0 HighMem: empty
Swap cache: add 1, delete 0, find 0/0, race 0+0
Free swap  = 1048780kB
Total swap = 1048784kB
Free swap:       1048780kB
1966076 pages of RAM
163061 reserved pages
716887 pages shared
1 pages swap cached
jfsCommit: page allocation failure. order:0, mode:0x20

Call Trace: <IRQ> <ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
       <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff80166e86>{kmem_cache_alloc+54}
       <ffffffff8033d021>{scsi_get_command+81} <ffffffff8034181d>{scsi_prep_fn+301}
       <ffffffff802f7b98>{elv_next_request+72} <ffffffff80341c1d>{scsi_request_fn+221}
       <ffffffff802fb61d>{blk_run_queue+61} <ffffffff803420ff>{scsi_end_request+223}
       <ffffffff80342355>{scsi_io_completion+565} <ffffffff8034ada1>{sd_rw_intr+609}
       <ffffffff8033c696>{scsi_finish_command+166} <ffffffff8033c79b>{scsi_softirq+235}
       <ffffffff8013b601>{__do_softirq+113} <ffffffff8013b6b5>{do_softirq+53}
       <ffffffff801107d7>{do_IRQ+71} <ffffffff8010e253>{ret_from_intr+0}
        <EOI> <ffffffff8016a639>{shrink_zone+1657} <ffffffff8016a639>{shrink_zone+1657}
       <ffffffff8016b90d>{try_to_free_pages+317} <ffffffff80163132>{__alloc_pages+610}
       <ffffffff80265860>{metapage_readpage+0} <ffffffff8017c183>{alloc_page_interleave+67}
       <ffffffff8015ec62>{read_cache_page+82} <ffffffff8026654f>{__get_metapage+271}
       <ffffffff8015d413>{unlock_page+35} <ffffffff80266898>{__get_metapage+1112}
       <ffffffff80131893>{__wake_up+67} <ffffffff8025e4c8>{dbUpdatePMap+376}
       <ffffffff80258165>{diUpdatePMap+805} <ffffffff8026abff>{txUpdateMap+495}
       <ffffffff8026c66f>{jfs_lazycommit+271} <ffffffff80130e20>{default_wake_function+0}
       <ffffffff80130e20>{default_wake_function+0} <ffffffff80133050>{schedule_tail+64}
       <ffffffff8010e967>{child_rip+8} <ffffffff8026c560>{jfs_lazycommit+0}
       <ffffffff8010e95f>{child_rip+0} 
Mem-info:
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:41
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:58
cpu 2 hot: low 62, high 186, batch 31 used:116
cpu 2 cold: low 0, high 62, batch 31 used:49
cpu 3 hot: low 62, high 186, batch 31 used:92
cpu 3 cold: low 0, high 62, batch 31 used:53
Node 3 HighMem per-cpu: empty
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 31 used:44
cpu 1 hot: low 62, high 186, batch 31 used:174
cpu 1 cold: low 0, high 62, batch 31 used:35
cpu 2 hot: low 62, high 186, batch 31 used:100
cpu 2 cold: low 0, high 62, batch 31 used:62
cpu 3 hot: low 62, high 186, batch 31 used:108
cpu 3 cold: low 0, high 62, batch 31 used:52
Node 2 HighMem per-cpu: empty
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:60
cpu 1 hot: low 62, high 186, batch 31 used:93
cpu 1 cold: low 0, high 62, batch 31 used:60
cpu 2 hot: low 62, high 186, batch 31 used:134
cpu 2 cold: low 0, high 62, batch 31 used:55
cpu 3 hot: low 62, high 186, batch 31 used:93
cpu 3 cold: low 0, high 62, batch 31 used:57
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:6
cpu 0 cold: low 0, high 2, batch 1 used:0
cpu 1 hot: low 2, high 6, batch 1 used:0
cpu 1 cold: low 0, high 2, batch 1 used:0
cpu 2 hot: low 2, high 6, batch 1 used:0
cpu 2 cold: low 0, high 2, batch 1 used:0
cpu 3 hot: low 2, high 6, batch 1 used:0
cpu 3 cold: low 0, high 2, batch 1 used:0
Node 0 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:70
cpu 0 cold: low 0, high 62, batch 31 used:54
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:53
cpu 2 hot: low 62, high 186, batch 31 used:92
cpu 2 cold: low 0, high 62, batch 31 used:60
cpu 3 hot: low 62, high 186, batch 31 used:74
cpu 3 cold: low 0, high 62, batch 31 used:59
Node 0 HighMem per-cpu: empty

Free pages:       18804kB (0kB HighMem)
Active:100796 inactive:1465891 dirty:1489134 writeback:14099 unstable:0 free:4701 slab:76918 mapped:97830 pagetables:17102
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 3 Normal free:448kB min:1492kB low:1864kB high:2236kB active:91740kB inactive:237500kB present:524284kB pages_scanned:279 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 2 Normal free:512kB min:1492kB low:1864kB high:2236kB active:113072kB inactive:111872kB present:524284kB pages_scanned:19514 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 1 Normal free:548kB min:1492kB low:1864kB high:2236kB active:42248kB inactive:208684kB present:524284kB pages_scanned:10411 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA free:10628kB min:44kB low:52kB high:64kB active:0kB inactive:0kB present:16384kB pages_scanned:56 all_unreclaimable? yes
lowmem_reserve[]: 0 6127 6127
Node 0 Normal free:6668kB min:17896kB low:22368kB high:26844kB active:156124kB inactive:5305508kB present:6275068kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 DMA: empty
Node 3 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 448kB
Node 3 HighMem: empty
Node 2 DMA: empty
Node 2 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 512kB
Node 2 HighMem: empty
Node 1 DMA: empty
Node 1 Normal: 1*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 548kB
Node 1 HighMem: empty
Node 0 DMA: 5*4kB 4*8kB 5*16kB 4*32kB 4*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 10628kB
Node 0 Normal: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB = 6668kB
Node 0 HighMem: empty
Swap cache: add 1, delete 0, find 0/0, race 0+0
Free swap  = 1048780kB
Total swap = 1048784kB
Free swap:       1048780kB
dd: page allocation failure. order:0, mode:0x20

Call Trace: <IRQ> <ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
       <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff80166e86>{kmem_cache_alloc+54}
       <ffffffff8033d021>{scsi_get_command+81} <ffffffff8034181d>{scsi_prep_fn+301}
       <ffffffff802f7b98>{elv_next_request+72} <ffffffff80341c1d>{scsi_request_fn+221}
       <ffffffff802fb61d>{blk_run_queue+61} <ffffffff803420ff>{scsi_end_request+223}
       <ffffffff80342355>{scsi_io_completion+565} <ffffffff8034ada1>{sd_rw_intr+609}
       <ffffffff8033c696>{scsi_finish_command+166} <ffffffff8033c79b>{scsi_softirq+235}
       <ffffffff8013b601>{__do_softirq+113} <ffffffff8013b6b5>{do_softirq+53}
       <ffffffff8010e615>{apic_timer_interrupt+133}  <EOI> <ffffffff802fc28c>{__make_request+1324}
       <ffffffff802fc28c>{__make_request+1324} <ffffffff8024fb10>{jfs_get_block+0}
       <ffffffff802fa67b>{generic_make_request+555} <ffffffff8014c680>{autoremove_wake_function+0}
       <ffffffff8014c680>{autoremove_wake_function+0} <ffffffff803e9e75>{__wait_on_bit_lock+101}
       <ffffffff8024fb10>{jfs_get_block+0} <ffffffff802fa77f>{submit_bio+223}
       <ffffffff8012e6b3>{__wake_up_common+67} <ffffffff80163b34>{get_writeback_state+52}
       <ffffffff8024fb10>{jfs_get_block+0} <ffffffff801a87f2>{mpage_bio_submit+34}
       <ffffffff801a8d89>{mpage_writepage+73} <ffffffff80186fc0>{nobh_writepage+192}
       <ffffffff8016aa60>{shrink_zone+2720} <ffffffff801652aa>{kmem_freepages+298}
       <ffffffff80165f32>{free_block+338} <ffffffff80131893>{__wake_up+67}
       <ffffffff8016b90d>{try_to_free_pages+317} <ffffffff80163132>{__alloc_pages+610}
       <ffffffff801a85a4>{__mark_inode_dirty+52} <ffffffff8015de7c>{generic_file_buffered_write+412}
       <ffffffff8013a965>{current_fs_time+85} <ffffffff80162e63>{buffered_rmqueue+723}
       <ffffffff8019d9ae>{inode_update_time+62} <ffffffff8015e63a>{__generic_file_aio_write_nolock+938}
       <ffffffff8016d67c>{do_no_page+860} <ffffffff8015e81e>{__generic_file_write_nolock+158}
       <ffffffff80170ade>{zeromap_page_range+990} <ffffffff8014c680>{autoremove_wake_function+0}
       <ffffffff80293351>{__up_read+33} <ffffffff8015e985>{generic_file_write+101}
       <ffffffff801830a9>{vfs_write+233} <ffffffff80183253>{sys_write+83}
       <ffffffff8010dc8e>{system_call+126} 
Mem-info:
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:41
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:58
cpu 2 hot: low 62, high 186, batch 31 used:116
cpu 2 cold: low 0, high 62, batch 31 used:49
cpu 3 hot: low 62, high 186, batch 31 used:92
cpu 3 cold: low 0, high 62, batch 31 used:53
Node 3 HighMem per-cpu: empty
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 31 used:44
cpu 1 hot: low 62, high 186, batch 31 used:174
cpu 1 cold: low 0, high 62, batch 31 used:35
cpu 2 hot: low 62, high 186, batch 31 used:100
cpu 2 cold: low 0, high 62, batch 31 used:62
cpu 3 hot: low 62, high 186, batch 31 used:108
cpu 3 cold: low 0, high 62, batch 31 used:52
Node 2 HighMem per-cpu: empty
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:60
cpu 1 hot: low 62, high 186, batch 31 used:93
cpu 1 cold: low 0, high 62, batch 31 used:60
cpu 2 hot: low 62, high 186, batch 31 used:134
cpu 2 cold: low 0, high 62, batch 31 used:55
cpu 3 hot: low 62, high 186, batch 31 used:93
cpu 3 cold: low 0, high 62, batch 31 used:57
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:6
cpu 0 cold: low 0, high 2, batch 1 used:0
cpu 1 hot: low 2, high 6, batch 1 used:0
cpu 1 cold: low 0, high 2, batch 1 used:0
cpu 2 hot: low 2, high 6, batch 1 used:0
cpu 2 cold: low 0, high 2, batch 1 used:0
cpu 3 hot: low 2, high 6, batch 1 used:0
cpu 3 cold: low 0, high 2, batch 1 used:0
Node 0 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:70
cpu 0 cold: low 0, high 62, batch 31 used:54
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:53
cpu 2 hot: low 62, high 186, batch 31 used:92
cpu 2 cold: low 0, high 62, batch 31 used:60
cpu 3 hot: low 62, high 186, batch 31 used:74
cpu 3 cold: low 0, high 62, batch 31 used:59
Node 0 HighMem per-cpu: empty

Free pages:       18804kB (0kB HighMem)
Active:100796 inactive:1465891 dirty:1489134 writeback:14099 unstable:0 free:4701 slab:76918 mapped:97830 pagetables:17102
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 3 Normal free:448kB min:1492kB low:1864kB high:2236kB active:91740kB inactive:237500kB present:524284kB pages_scanned:279 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 2 Normal free:512kB min:1492kB low:1864kB high:2236kB active:113072kB inactive:111872kB present:524284kB pages_scanned:19514 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 1 Normal free:548kB min:1492kB low:1864kB high:2236kB active:42248kB inactive:208684kB present:524284kB pages_scanned:10411 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA free:10628kB min:44kB low:52kB high:64kB active:0kB inactive:0kB present:16384kB pages_scanned:56 all_unreclaimable? yes
lowmem_reserve[]: 0 6127 6127
Node 0 Normal free:6668kB min:17896kB low:22368kB high:26844kB active:156124kB inactive:5305508kB present:6275068kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 DMA: empty
Node 3 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 448kB
Node 3 HighMem: empty
Node 2 DMA: empty
Node 2 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 512kB
Node 2 HighMem: empty
Node 1 DMA: empty
Node 1 Normal: 1*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 548kB
Node 1 HighMem: empty
Node 0 DMA: 5*4kB 4*8kB 5*16kB 4*32kB 4*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 10628kB
Node 0 Normal: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB = 6668kB
Node 0 HighMem: empty
Swap cache: add 1, delete 0, find 0/0, race 0+0
Free swap  = 1048780kB
Total swap = 1048784kB
Free swap:       1048780kB
1966076 pages of RAM
163061 reserved pages
716550 pages shared
1 pages swap cached
1966076 pages of RAM
163061 reserved pages
716484 pages shared
1 pages swap cached
ksoftirqd/2: page allocation failure. order:0, mode:0x20

Call Trace:<ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
       <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff80166e86>{kmem_cache_alloc+54}
       <ffffffff8033d021>{scsi_get_command+81} <ffffffff8034181d>{scsi_prep_fn+301}
       <ffffffff802f7b98>{elv_next_request+72} <ffffffff80341c1d>{scsi_request_fn+221}
       <ffffffff802fb61d>{blk_run_queue+61} <ffffffff803420ff>{scsi_end_request+223}
       <ffffffff80342355>{scsi_io_completion+565} <ffffffff8034ada1>{sd_rw_intr+609}
       <ffffffff8033c696>{scsi_finish_command+166} <ffffffff8033c79b>{scsi_softirq+235}
       <ffffffff8013b601>{__do_softirq+113} <ffffffff8013b710>{ksoftirqd+0}
       <ffffffff8013b6b5>{do_softirq+53} <ffffffff8013b77a>{ksoftirqd+106}
       <ffffffff8013b710>{ksoftirqd+0} <ffffffff8014c4ab>{kthread+219}
       <ffffffff8010e967>{child_rip+8} <ffffffff8014c3d0>{kthread+0}
       <ffffffff8010e95f>{child_rip+0} 
Mem-info:
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:41
cpu 1 hot: low 62, high 186, batch 31 used:123
cpu 1 cold: low 0, high 62, batch 31 used:42
cpu 2 hot: low 62, high 186, batch 31 used:107
cpu 2 cold: low 0, high 62, batch 31 used:45
cpu 3 hot: low 62, high 186, batch 31 used:181
cpu 3 cold: low 0, high 62, batch 31 used:55
Node 3 HighMem per-cpu: empty
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 31 used:44
cpu 1 hot: low 62, high 186, batch 31 used:105
cpu 1 cold: low 0, high 62, batch 31 used:11
cpu 2 hot: low 62, high 186, batch 31 used:116
cpu 2 cold: low 0, high 62, batch 31 used:54
cpu 3 hot: low 62, high 186, batch 31 used:167
cpu 3 cold: low 0, high 62, batch 31 used:51
Node 2 HighMem per-cpu: empty
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:60
cpu 1 hot: low 62, high 186, batch 31 used:132
cpu 1 cold: low 0, high 62, batch 31 used:44
cpu 2 hot: low 62, high 186, batch 31 used:126
cpu 2 cold: low 0, high 62, batch 31 used:39
cpu 3 hot: low 62, high 186, batch 31 used:93
cpu 3 cold: low 0, high 62, batch 31 used:60
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:6
cpu 0 cold: low 0, high 2, batch 1 used:0
cpu 1 hot: low 2, high 6, batch 1 used:0
cpu 1 cold: low 0, high 2, batch 1 used:0
cpu 2 hot: low 2, high 6, batch 1 used:0
cpu 2 cold: low 0, high 2, batch 1 used:0
cpu 3 hot: low 2, high 6, batch 1 used:0
cpu 3 cold: low 0, high 2, batch 1 used:0
Node 0 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:70
cpu 0 cold: low 0, high 62, batch 31 used:54
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:45
cpu 2 hot: low 62, high 186, batch 31 used:112
cpu 2 cold: low 0, high 62, batch 31 used:52
cpu 3 hot: low 62, high 186, batch 31 used:88
cpu 3 cold: low 0, high 62, batch 31 used:46
Node 0 HighMem per-cpu: empty

Free pages:       18776kB (0kB HighMem)
Active:99193 inactive:1460277 dirty:1385806 writeback:113713 unstable:0 free:4694 slab:83714 mapped:97380 pagetables:17003
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 3 Normal free:560kB min:1492kB low:1864kB high:2236kB active:90144kB inactive:237272kB present:524284kB pages_scanned:761 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 2 Normal free:492kB min:1492kB low:1864kB high:2236kB active:113136kB inactive:111312kB present:524284kB pages_scanned:9864 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 1 Normal free:444kB min:1492kB low:1864kB high:2236kB active:36192kB inactive:212236kB present:524284kB pages_scanned:5746 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA free:10628kB min:44kB low:52kB high:64kB active:0kB inactive:0kB present:16384kB pages_scanned:62 all_unreclaimable? yes
lowmem_reserve[]: 0 6127 6127
Node 0 Normal free:6652kB min:17896kB low:22368kB high:26844kB active:157300kB inactive:5280288kB present:6275068kB pages_scanned:2579 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 DMA: empty
Node 3 Normal: 0*4kB 0*8kB 3*16kB 2*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 560kB
Node 3 HighMem: empty
Node 2 DMA: empty
Node 2 Normal: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 492kB
Node 2 HighMem: empty
Node 1 DMA: empty
Node 1 Normal: 1*4kB 1*8kB 1*16kB 1*32kB 0*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 444kB
Node 1 HighMem: empty
Node 0 DMA: 5*4kB 4*8kB 5*16kB 4*32kB 4*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 10628kB
Node 0 Normal: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 1*2048kB 1*4096kB = 6652kB
Node 0 HighMem: empty
Swap cache: add 1, delete 0, find 0/0, race 0+0
Free swap  = 1048780kB
Total swap = 1048784kB
Free swap:       1048780kB
1966076 pages of RAM
163061 reserved pages
711737 pages shared
1 pages swap cached
kblockd/3: page allocation failure. order:0, mode:0x20

Call Trace:<ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
       <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff802f84e0>{blk_unplug_work+0}
       <ffffffff80166e86>{kmem_cache_alloc+54} <ffffffff8033d021>{scsi_get_command+81}
       <ffffffff8034181d>{scsi_prep_fn+301} <ffffffff802f7b98>{elv_next_request+72}
       <ffffffff80341c1d>{scsi_request_fn+221} <ffffffff802fb680>{__generic_unplug_device+32}
       <ffffffff802fbba8>{generic_unplug_device+24} <ffffffff802f84ea>{blk_unplug_work+10}
       <ffffffff80147b1c>{worker_thread+476} <ffffffff80130e20>{default_wake_function+0}
       <ffffffff8012e6b3>{__wake_up_common+67} <ffffffff80130e20>{default_wake_function+0}
       <ffffffff8014c350>{keventd_create_kthread+0} <ffffffff80147940>{worker_thread+0}
       <ffffffff8014c350>{keventd_create_kthread+0} <ffffffff8014c4ab>{kthread+219}
       <ffffffff8010e967>{child_rip+8} <ffffffff8014c350>{keventd_create_kthread+0}
       <ffffffff8014c3d0>{kthread+0} <ffffffff8010e95f>{child_rip+0}
       
Mem-info:
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:41
cpu 1 hot: low 62, high 186, batch 31 used:75
cpu 1 cold: low 0, high 62, batch 31 used:34
cpu 2 hot: low 62, high 186, batch 31 used:120
cpu 2 cold: low 0, high 62, batch 31 used:35
cpu 3 hot: low 62, high 186, batch 31 used:143
cpu 3 cold: low 0, high 62, batch 31 used:51
Node 3 HighMem per-cpu: empty
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 31 used:44
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:45
cpu 2 hot: low 62, high 186, batch 31 used:123
cpu 2 cold: low 0, high 62, batch 31 used:55
cpu 3 hot: low 62, high 186, batch 31 used:60
cpu 3 cold: low 0, high 62, batch 31 used:0
Node 2 HighMem per-cpu: empty
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:60
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:46
cpu 2 hot: low 62, high 186, batch 31 used:105
cpu 2 cold: low 0, high 62, batch 31 used:39
cpu 3 hot: low 62, high 186, batch 31 used:64
cpu 3 cold: low 0, high 62, batch 31 used:51
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:6
cpu 0 cold: low 0, high 2, batch 1 used:0
cpu 1 hot: low 2, high 6, batch 1 used:0
cpu 1 cold: low 0, high 2, batch 1 used:0
cpu 2 hot: low 2, high 6, batch 1 used:0
cpu 2 cold: low 0, high 2, batch 1 used:0
cpu 3 hot: low 2, high 6, batch 1 used:0
cpu 3 cold: low 0, high 2, batch 1 used:0
Node 0 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:70
cpu 0 cold: low 0, high 62, batch 31 used:54
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:60
cpu 2 hot: low 62, high 186, batch 31 used:145
cpu 2 cold: low 0, high 62, batch 31 used:36
cpu 3 hot: low 62, high 186, batch 31 used:63
cpu 3 cold: low 0, high 62, batch 31 used:19
Node 0 HighMem per-cpu: empty

Free pages:       18788kB (0kB HighMem)
Active:98467 inactive:1458392 dirty:1377983 writeback:120734 unstable:0 free:4697 slab:86492 mapped:97190 pagetables:16961
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 3 Normal free:492kB min:1492kB low:1864kB high:2236kB active:88628kB inactive:236836kB present:524284kB pages_scanned:66 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 2 Normal free:468kB min:1492kB low:1864kB high:2236kB active:112180kB inactive:117068kB present:524284kB pages_scanned:2273 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 1 Normal free:504kB min:1492kB low:1864kB high:2236kB active:35632kB inactive:208708kB present:524284kB pages_scanned:103 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA free:10628kB min:44kB low:52kB high:64kB active:0kB inactive:0kB present:16384kB pages_scanned:66 all_unreclaimable? yes
lowmem_reserve[]: 0 6127 6127
Node 0 Normal free:6696kB min:17896kB low:22368kB high:26844kB active:157428kB inactive:5270956kB present:6275068kB pages_scanned:108 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 DMA: empty
Node 3 Normal: 1*4kB 1*8kB 0*16kB 3*32kB 0*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 492kB
Node 3 HighMem: empty
Node 2 DMA: empty
Node 2 Normal: 1*4kB 0*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 468kB
Node 2 HighMem: empty
Node 1 DMA: empty
Node 1 Normal: 0*4kB 1*8kB 5*16kB 1*32kB 0*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 504kB
Node 1 HighMem: empty
Node 0 DMA: 5*4kB 4*8kB 5*16kB 4*32kB 4*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 10628kB
Node 0 Normal: 0*4kB 1*8kB 0*16kB 1*32kB 2*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 1*2048kB 1*4096kB = 6696kB
Node 0 HighMem: empty
Swap cache: add 1, delete 0, find 0/0, race 0+0
Free swap  = 1048780kB
Total swap = 1048784kB
Free swap:       1048780kB
1966076 pages of RAM
163061 reserved pages
710953 pages shared
1 pages swap cached
kblockd/3: page allocation failure. order:0, mode:0x20

Call Trace:<ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
       <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff802f84e0>{blk_unplug_work+0}
       <ffffffff80166e86>{kmem_cache_alloc+54} <ffffffff8033d021>{scsi_get_command+81}
       <ffffffff8034181d>{scsi_prep_fn+301} <ffffffff802f7b98>{elv_next_request+72}
       <ffffffff80341c1d>{scsi_request_fn+221} <ffffffff802fb680>{__generic_unplug_device+32}
       <ffffffff802fbba8>{generic_unplug_device+24} <ffffffff802f84ea>{blk_unplug_work+10}
       <ffffffff80147b1c>{worker_thread+476} <ffffffff80130e20>{default_wake_function+0}
       <ffffffff8012e6b3>{__wake_up_common+67} <ffffffff80130e20>{default_wake_function+0}
       <ffffffff8014c350>{keventd_create_kthread+0} <ffffffff80147940>{worker_thread+0}
       <ffffffff8014c350>{keventd_create_kthread+0} <ffffffff8014c4ab>{kthread+219}
       <ffffffff8010e967>{child_rip+8} <ffffffff8014c350>{keventd_create_kthread+0}
       <ffffffff8014c3d0>{kthread+0} <ffffffff8010e95f>{child_rip+0}
       
Mem-info:
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:41
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:37
cpu 2 hot: low 62, high 186, batch 31 used:77
cpu 2 cold: low 0, high 62, batch 31 used:33
cpu 3 hot: low 62, high 186, batch 31 used:141
cpu 3 cold: low 0, high 62, batch 31 used:49
Node 3 HighMem per-cpu: empty
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 31 used:44
cpu 1 hot: low 62, high 186, batch 31 used:83
cpu 1 cold: low 0, high 62, batch 31 used:61
cpu 2 hot: low 62, high 186, batch 31 used:92
cpu 2 cold: low 0, high 62, batch 31 used:49
cpu 3 hot: low 62, high 186, batch 31 used:89
cpu 3 cold: low 0, high 62, batch 31 used:1
Node 2 HighMem per-cpu: empty
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:60
cpu 1 hot: low 62, high 186, batch 31 used:62
cpu 1 cold: low 0, high 62, batch 31 used:52
cpu 2 hot: low 62, high 186, batch 31 used:92
cpu 2 cold: low 0, high 62, batch 31 used:62
cpu 3 hot: low 62, high 186, batch 31 used:66
cpu 3 cold: low 0, high 62, batch 31 used:37
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:6
cpu 0 cold: low 0, high 2, batch 1 used:0
cpu 1 hot: low 2, high 6, batch 1 used:0
cpu 1 cold: low 0, high 2, batch 1 used:0
cpu 2 hot: low 2, high 6, batch 1 used:0
cpu 2 cold: low 0, high 2, batch 1 used:0
cpu 3 hot: low 2, high 6, batch 1 used:0
cpu 3 cold: low 0, high 2, batch 1 used:0
Node 0 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:70
cpu 0 cold: low 0, high 62, batch 31 used:54
cpu 1 hot: low 62, high 186, batch 31 used:92
cpu 1 cold: low 0, high 62, batch 31 used:46
cpu 2 hot: low 62, high 186, batch 31 used:64
cpu 2 cold: low 0, high 62, batch 31 used:32
cpu 3 hot: low 62, high 186, batch 31 used:88
cpu 3 cold: low 0, high 62, batch 31 used:56
Node 0 HighMem per-cpu: empty

Free pages:       18776kB (0kB HighMem)
Active:98101 inactive:1451858 dirty:1348391 writeback:148762 unstable:0 free:4694 slab:93485 mapped:96813 pagetables:16877
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 3 Normal free:480kB min:1492kB low:1864kB high:2236kB active:87124kB inactive:236748kB present:524284kB pages_scanned:70 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 2 Normal free:468kB min:1492kB low:1864kB high:2236kB active:112120kB inactive:109040kB present:524284kB pages_scanned:486 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 1 Normal free:504kB min:1492kB low:1864kB high:2236kB active:35648kB inactive:204080kB present:524284kB pages_scanned:69 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA free:10628kB min:44kB low:52kB high:64kB active:0kB inactive:0kB present:16384kB pages_scanned:68 all_unreclaimable? yes
lowmem_reserve[]: 0 6127 6127
Node 0 Normal free:6696kB min:17896kB low:22368kB high:26844kB active:157512kB inactive:5257564kB present:6275068kB pages_scanned:198 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 DMA: empty
Node 3 Normal: 0*4kB 0*8kB 2*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 480kB
Node 3 HighMem: empty
Node 2 DMA: empty
Node 2 Normal: 1*4kB 0*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 468kB
Node 2 HighMem: empty
Node 1 DMA: empty
Node 1 Normal: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 504kB
Node 1 HighMem: empty
Node 0 DMA: 5*4kB 4*8kB 5*16kB 4*32kB 4*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 10628kB
Node 0 Normal: 0*4kB 1*8kB 0*16kB 1*32kB 2*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 1*2048kB 1*4096kB = 6696kB
Node 0 HighMem: empty
Swap cache: add 1, delete 0, find 0/0, race 0+0
Free swap  = 1048780kB
Total swap = 1048784kB
Free swap:       1048780kB
1966076 pages of RAM
163061 reserved pages
709603 pages shared
1 pages swap cached
kblockd/3: page allocation failure. order:0, mode:0x20

Call Trace:<ffffffff801632ae>{__alloc_pages+990} <ffffffff801668da>{cache_grow+314}
       <ffffffff80166d7f>{cache_alloc_refill+543} <ffffffff802f84e0>{blk_unplug_work+0}
       <ffffffff80166e86>{kmem_cache_alloc+54} <ffffffff8033d021>{scsi_get_command+81}
       <ffffffff8034181d>{scsi_prep_fn+301} <ffffffff802f7b98>{elv_next_request+72}
       <ffffffff80341c1d>{scsi_request_fn+221} <ffffffff802fb680>{__generic_unplug_device+32}
       <ffffffff802fbba8>{generic_unplug_device+24} <ffffffff802f84ea>{blk_unplug_work+10}
       <ffffffff80147b1c>{worker_thread+476} <ffffffff80130e20>{default_wake_function+0}
       <ffffffff8012e6b3>{__wake_up_common+67} <ffffffff80130e20>{default_wake_function+0}
       <ffffffff8014c350>{keventd_create_kthread+0} <ffffffff80147940>{worker_thread+0}
       <ffffffff8014c350>{keventd_create_kthread+0} <ffffffff8014c4ab>{kthread+219}
       <ffffffff8010e967>{child_rip+8} <ffffffff8014c350>{keventd_create_kthread+0}
       <ffffffff8014c3d0>{kthread+0} <ffffffff8010e95f>{child_rip+0}
       
Mem-info:
Node 3 DMA per-cpu: empty
Node 3 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:41
cpu 1 hot: low 62, high 186, batch 31 used:88
cpu 1 cold: low 0, high 62, batch 31 used:44
cpu 2 hot: low 62, high 186, batch 31 used:92
cpu 2 cold: low 0, high 62, batch 31 used:33
cpu 3 hot: low 62, high 186, batch 31 used:120
cpu 3 cold: low 0, high 62, batch 31 used:50
Node 3 HighMem per-cpu: empty
Node 2 DMA per-cpu: empty
Node 2 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 31 used:44
cpu 1 hot: low 62, high 186, batch 31 used:140
cpu 1 cold: low 0, high 62, batch 31 used:45
cpu 2 hot: low 62, high 186, batch 31 used:92
cpu 2 cold: low 0, high 62, batch 31 used:33
cpu 3 hot: low 62, high 186, batch 31 used:84
cpu 3 cold: low 0, high 62, batch 31 used:54
Node 2 HighMem per-cpu: empty
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:157
cpu 0 cold: low 0, high 62, batch 31 used:60
cpu 1 hot: low 62, high 186, batch 31 used:64
cpu 1 cold: low 0, high 62, batch 31 used:47
cpu 2 hot: low 62, high 186, batch 31 used:90
cpu 2 cold: low 0, high 62, batch 31 used:52
cpu 3 hot: low 62, high 186, batch 31 used:92
cpu 3 cold: low 0, high 62, batch 31 used:40
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:6
cpu 0 cold: low 0, high 2, batch 1 used:0
cpu 1 hot: low 2, high 6, batch 1 used:0
cpu 1 cold: low 0, high 2, batch 1 used:0
cpu 2 hot: low 2, high 6, batch 1 used:0
cpu 2 cold: low 0, high 2, batch 1 used:0
cpu 3 hot: low 2, high 6, batch 1 used:0
cpu 3 cold: low 0, high 2, batch 1 used:0
Node 0 Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:70
cpu 0 cold: low 0, high 62, batch 31 used:54
cpu 1 hot: low 62, high 186, batch 31 used:65
cpu 1 cold: low 0, high 62, batch 31 used:55
cpu 2 hot: low 62, high 186, batch 31 used:92
cpu 2 cold: low 0, high 62, batch 31 used:52
cpu 3 hot: low 62, high 186, batch 31 used:62
cpu 3 cold: low 0, high 62, batch 31 used:61
Node 0 HighMem per-cpu: empty

Free pages:       18824kB (0kB HighMem)
Active:97960 inactive:1449604 dirty:1341857 writeback:152751 unstable:0 free:4706 slab:95975 mapped:96651 pagetables:16841
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 3 Normal free:528kB min:1492kB low:1864kB high:2236kB active:86472kB inactive:236064kB present:524284kB pages_scanned:33 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 2 Normal free:468kB min:1492kB low:1864kB high:2236kB active:112120kB inactive:111072kB present:524284kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 511 511
Node 1 Normal free:504kB min:1492kB low:1864kB high:2236kB active:35644kB inactive:203524kB present:524284kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA free:10628kB min:44kB low:52kB high:64kB active:0kB inactive:0kB present:16384kB pages_scanned:70 all_unreclaimable? yes
lowmem_reserve[]: 0 6127 6127
Node 0 Normal free:6696kB min:17896kB low:22368kB high:26844kB active:157604kB inactive:5247756kB present:6275068kB pages_scanned:1144 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 DMA: empty
Node 3 Normal: 0*4kB 0*8kB 1*16kB 0*32kB 2*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 528kB
Node 3 HighMem: empty
Node 2 DMA: empty
Node 2 Normal: 1*4kB 0*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 468kB
Node 2 HighMem: empty
Node 1 DMA: empty
Node 1 Normal: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 504kB
Node 1 HighMem: empty
Node 0 DMA: 5*4kB 4*8kB 5*16kB 4*32kB 4*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 2*4096kB = 10628kB
Node 0 Normal: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 2*128kB 1*256kB 0*512kB 0*1024kB 1*2048kB 1*4096kB = 6696kB
Node 0 HighMem: empty
Swap cache: add 1, delete 0, find 0/0, race 0+0
Free swap  = 1048780kB
Total swap = 1048784kB
Free swap:       1048780kB
1966076 pages of RAM
163061 reserved pages
708003 pages shared
1 pages swap cached

--=-FnJL1OP+PdKwQIe9hNr0--

