Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVCSVIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVCSVIu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVCSVIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:08:50 -0500
Received: from outbound04.telus.net ([199.185.220.223]:57571 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S261804AbVCSVI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:08:27 -0500
Subject: Nasty ReiserFS bug in 2.6.12-rc1, 2.6.12-rc1-bk1
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 14:17:59 -0700
Message-Id: <1111267079.7961.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I have built 2.6.12-rc1 and 2.6.12-rc1-bk1.  There seems to be a
nasty bug in ReiserFS (things are fine in 2.6.11.4).  The system wants
to un-configure my SCSI Adaptec devices, and stall at "starting Hal
daemon".  I also get the following error message (applied variously at
different times to different drives):
Mar 19 12:17:35 localhost kernel: ReiserFS: sdb1: using ordered data
mode
Mar 19 12:17:35 localhost kernel: ReiserFS: sdb1: journal params: device
sdb1, s ize 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
Mar 19 12:17:35 localhost kernel: ReiserFS: sdb1: checking transaction
log (sdb1 )
Mar 19 12:17:36 localhost kernel: ReiserFS: sdb1: Using r5 hash to sort
names
Mar 19 12:20:25 localhost su(pam_unix)[6809]: session opened for user
root by bo b(uid=500)
Mar 19 12:25:13 localhost kernel: Unable to handle kernel NULL pointer
dereferen ce at virtual address 0000000e
Mar 19 12:25:13 localhost kernel:  printing eip:
Mar 19 12:25:13 localhost kernel: c021c4af
Mar 19 12:25:13 localhost kernel: *pde = 00000000
Mar 19 12:25:13 localhost kernel: Oops: 0000 [#1]
Mar 19 12:25:13 localhost kernel: PREEMPT
Mar 19 12:25:13 localhost kernel: Modules linked in: nvidia agpgart imm
snd_emu1 0k1_synth snd_emux_synth snd_seq_oss raw1394
snd_seq_virmidi snd_seq_midi_emul snd_seq_midi snd_seq_midi_event
snd_seq_dummy snd_seq ipt_REJECT ipt_state ip_conntrack iptable_filter
ip_tables binfmt_misc s d_mod video thermal processor fan button battery
ac usblp ohci1394 ohci_hcd usbc
ore tuner
bttv video_buf i2c_algo_bit v4l2_common btcx_risc tveeprom videodev
i2c_sis96x i 2c_core snd_emu10k1 snd_rawmidi snd_seq_device
snd_ac97_codec snd_pcm_oss snd_mi xer_oss snd_pcm snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd soundcore si s900 sbp2
scsi_mod ieee1394
Mar 19 12:25:13 localhost kernel: CPU:    0
Mar 19 12:25:13 localhost kernel: EIP:    0060:[<c021c4af>]    Tainted:
P      V LI
Mar 19 12:25:13 localhost kernel: EFLAGS: 00010086   (2.6.12-rc1)
Mar 19 12:25:13 localhost kernel: EIP is at as_find_arq_hash+0x38/0x7d
Mar 19 12:25:13 localhost kernel: eax: f751d000   ebx: 00000000   ecx:
00000006   edx: f7b60a64
Mar 19 12:25:13 localhost kernel: esi: f7489e00   edi: f7b60d80   ebp:
0de8e63f   esp: d0373bd4
Mar 19 12:25:13 localhost kernel: ds: 007b   es: 007b   ss: 0068
Mar 19 12:25:13 localhost kernel: Process cc1 (pid: 6878,
threadinfo=d0372000 ta sk=e08c8a00)
Mar 19 12:25:13 localhost kernel: Stack: c1bf00ac d0473894 0de8e647
f7d26b4c d02 43a80 00000000 c021de95 f7b60d80
Mar 19 12:25:13 localhost kernel:        0de8e63f 00000020 c1bfc5d0
f7b60d80 000 00000 f7d26b4c c1bf00ac 00000000
Mar 19 12:25:13 localhost kernel:        c02188f5 c1bf00ac d0373c34
d0243a80 000 00000 0de8e63f 00000008 00000008
Mar 19 12:25:13 localhost kernel: Call Trace:
Mar 19 12:25:13 localhost kernel:  [<c021de95>] as_merge+0x64/0x1ad
Mar 19 12:25:13 localhost kernel:  [<c02188f5>] __make_request
+0xac/0x4ed
Mar 19 12:25:13 localhost kernel:  [<c0219044>] generic_make_request
+0x90/0x1ff
Mar 19 12:25:13 localhost kernel:  [<c015762a>] bio_alloc_bioset
+0x10f/0x1bf
Mar 19 12:25:13 localhost kernel:  [<c012b3b7>] autoremove_wake_function
+0x0/0x4 b
Mar 19 12:25:13 localhost kernel:  [<c012b3b7>] autoremove_wake_function
+0x0/0x4 b
Mar 19 12:25:13 localhost kernel:  [<c017536d>] do_mpage_readpage
+0x28e/0x3c7
Mar 19 12:25:13 localhost kernel:  [<c0219200>] submit_bio+0x4d/0xdc
Mar 19 12:25:13 localhost kernel:  [<c01be8a9>] radix_tree_insert
+0x83/0x12a
Mar 19 12:25:13 localhost kernel:  [<c013e309>] __pagevec_lru_add
+0xde/0x107
Mar 19 12:25:13 localhost kernel:  [<c0174fc4>] mpage_bio_submit
+0x2b/0x32
Mar 19 12:25:13 localhost kernel:  [<c0175579>] mpage_readpages
+0xd3/0x173
Mar 19 12:25:13 localhost kernel:  [<c018fd2d>] reiserfs_get_block
+0x0/0x1530
Mar 19 12:25:13 localhost kernel:  [<c013b747>] read_pages+0x13f/0x14f
Mar 19 12:25:13 localhost kernel:  [<c018fd2d>] reiserfs_get_block
+0x0/0x1530
Mar 19 12:25:13 localhost kernel:  [<c01394e2>] __alloc_pages
+0x173/0x3e1
Mar 19 12:25:13 localhost kernel:  [<c013b8a3>]
__do_page_cache_readahead+0x14c/ 0x183
Mar 19 12:25:13 localhost kernel:  [<c0135b71>] filemap_nopage
+0x29a/0x3d9
Mar 19 12:25:13 localhost kernel:  [<c01358d7>] filemap_nopage+0x0/0x3d9
Mar 19 12:25:13 localhost kernel:  [<c0143fd6>] do_no_page+0xaf/0x3a5
Mar 19 12:25:13 localhost kernel:  [<c0142101>] pte_alloc_map+0x99/0xbe
Mar 19 12:25:13 localhost kernel:  [<c0144530>] handle_mm_fault
+0x16e/0x1b0
Mar 19 12:25:13 localhost kernel:  [<c0112bb9>] do_page_fault
+0x1c5/0x5c7
Mar 19 12:25:13 localhost kernel:  [<c0146224>] do_mmap_pgoff
+0x4a7/0x78e
Mar 19 12:25:13 localhost kernel:  [<c0108813>] sys_mmap2+0x7a/0xa9
Mar 19 12:25:13 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Mar 19 12:25:13 localhost kernel:  [<c0103907>] error_code+0x2b/0x30
Mar 19 12:25:13 localhost kernel: Code: 24 1c 89 e8 8b 57 30 c1 e8 03 69
c0 01 0 0 37 9e c1 e8 1a 8d 34 c2 8b 1e 39 f3 74 2c 8d 53 e4 8b 1b 8b 42
24 8b 4a 14 85 c0 74 3b <8b> 41 08 a8 6c 75 04 a8 10 75 1c 89 54 24 04
8b 07 89 04 24 e8
Mar 19 12:25:13 localhost kernel:  <6>note: cc1[6878] exited with
preempt_count
1
Mar 19 12:25:13 localhost kernel: scheduling while atomic:
cc1/0x10000001/6878
Mar 19 12:25:13 localhost kernel:  [<c02b2098>] schedule+0x558/0x606
Mar 19 12:25:13 localhost kernel:  [<c01426c8>] unmap_page_range
+0x7f/0xb6
Mar 19 12:25:13 localhost kernel:  [<c02b288e>] cond_resched+0x27/0x40
Mar 19 12:25:13 localhost kernel:  [<c0142908>] unmap_vmas+0x209/0x21d
Mar 19 12:25:13 localhost kernel:  [<c0147277>] exit_mmap+0x84/0x15b
Mar 19 12:25:13 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Mar 19 12:25:13 localhost kernel:  [<c0115977>] mmput+0x2b/0x8e
Mar 19 12:25:13 localhost kernel:  [<c011a06f>] do_exit+0xba/0x3a1
Mar 19 12:25:13 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Mar 19 12:25:13 localhost kernel:  [<c010406e>] do_trap+0x0/0xd5
Mar 19 12:25:13 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Mar 19 12:25:13 localhost kernel:  [<c0118021>] printk+0x17/0x1b
Mar 19 12:25:13 localhost kernel:  [<c0112db8>] do_page_fault
+0x3c4/0x5c7
Mar 19 12:25:13 localhost kernel:  [<c021cde5>] as_update_arq+0x25/0x5a
Mar 19 12:25:13 localhost kernel:  [<c021daea>] as_add_request
+0x1c8/0x25a
Mar 19 12:25:13 localhost kernel:  [<c021542a>] __elv_add_request
+0x84/0xb4
Mar 19 12:25:13 localhost kernel:  [<c0137fba>] mempool_alloc+0x75/0x170
Mar 19 12:25:13 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Mar 19 12:25:13 localhost kernel:  [<c0103907>] error_code+0x2b/0x30
Mar 19 12:25:13 localhost kernel:  [<c021c4af>] as_find_arq_hash
+0x38/0x7d
Mar 19 12:25:13 localhost kernel:  [<c021de95>] as_merge+0x64/0x1ad
Mar 19 12:25:13 localhost kernel:  [<c02188f5>] __make_request
+0xac/0x4ed
Mar 19 12:25:13 localhost kernel:  [<c0219044>] generic_make_request
+0x90/0x1ff
Mar 19 12:25:13 localhost kernel:  [<c015762a>] bio_alloc_bioset
+0x10f/0x1bf
Mar 19 12:25:13 localhost kernel:  [<c012b3b7>] autoremove_wake_function
+0x0/0x4 b
Mar 19 12:25:13 localhost kernel:  [<c012b3b7>] autoremove_wake_function
+0x0/0x4 b
Mar 19 12:25:13 localhost kernel:  [<c017536d>] do_mpage_readpage
+0x28e/0x3c7
Mar 19 12:25:13 localhost kernel:  [<c0219200>] submit_bio+0x4d/0xdc
Mar 19 12:25:13 localhost kernel:  [<c01be8a9>] radix_tree_insert
+0x83/0x12a
Mar 19 12:25:13 localhost kernel:  [<c013e309>] __pagevec_lru_add
+0xde/0x107
Mar 19 12:25:13 localhost kernel:  [<c0174fc4>] mpage_bio_submit
+0x2b/0x32
Mar 19 12:25:13 localhost kernel:  [<c0175579>] mpage_readpages
+0xd3/0x173
Mar 19 12:25:13 localhost kernel:  [<c018fd2d>] reiserfs_get_block
+0x0/0x1530
Mar 19 12:25:13 localhost kernel:  [<c013b747>] read_pages+0x13f/0x14f
Mar 19 12:25:13 localhost kernel:  [<c018fd2d>] reiserfs_get_block
+0x0/0x1530
Mar 19 12:25:13 localhost kernel:  [<c01394e2>] __alloc_pages
+0x173/0x3e1
Mar 19 12:25:13 localhost kernel:  [<c013b8a3>]
__do_page_cache_readahead+0x14c/ 0x183
Mar 19 12:25:13 localhost kernel:  [<c0135b71>] filemap_nopage
+0x29a/0x3d9
Mar 19 12:25:13 localhost kernel:  [<c01358d7>] filemap_nopage+0x0/0x3d9
Mar 19 12:25:13 localhost kernel:  [<c0143fd6>] do_no_page+0xaf/0x3a5
Mar 19 12:25:13 localhost kernel:  [<c0142101>] pte_alloc_map+0x99/0xbe
Mar 19 12:25:13 localhost kernel:  [<c0144530>] handle_mm_fault
+0x16e/0x1b0
Mar 19 12:25:13 localhost kernel:  [<c0112bb9>] do_page_fault
+0x1c5/0x5c7
Mar 19 12:25:13 localhost kernel:  [<c0146224>] do_mmap_pgoff
+0x4a7/0x78e
Mar 19 12:25:13 localhost kernel:  [<c0108813>] sys_mmap2+0x7a/0xa9
Mar 19 12:25:13 localhost kernel:  [<c01129f4>] do_page_fault+0x0/0x5c7
Mar 19 12:25:13 localhost kernel:  [<c0103907>] error_code+0x2b/0x30
Mar 19 12:27:16 localhost su(pam_unix)[7554]: session opened for user
root by bo b(uid=500)
Mar 19 12:35:45 localhost gpm[5318]: *** info [mice.c(1766)]:


... When booted with 2.6.11-4, unmounted and checked with reiserfsck it
shows
Do you want to run this program?[N/Yes] (note need to type Yes if you
do):Yes
###########
reiserfsck --check started at Sat Mar 19 12:46:48 2005
###########
Replaying journal..
Reiserfs journal '/dev/hdb1' in blocks [18..8211]: 0 transactions
replayed
Checking internal tree..finished
Comparing bitmaps..finished
Checking Semantic tree:
finished
No corruptions found
There are on the filesystem:
        Leaves 185935
        Internal nodes 1237
        Directories 617339
        Other files 1196346
        Data block pointers 14019144 (162053 of them are zero)
        Safe links 0
###########
reiserfsck finished at Sat Mar 19 13:05:10 2005
###########
It may not be a ReiserFS problem, but something that tripped some
ReiserFS code... 
...So my drive isn't dead/corrupted, and all data is accessable when
booting with an older kernel.  Please feel free to mail me for more info
(and you will have to as I'm not on the list).

TIA,
Bob
-- 
Bob Gill <gillb4@telusplanet.net>

