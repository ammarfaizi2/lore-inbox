Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267634AbUHELGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbUHELGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267640AbUHELGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:06:40 -0400
Received: from [195.157.53.70] ([195.157.53.70]:48244 "HELO mx1.fotango.com")
	by vger.kernel.org with SMTP id S267634AbUHELC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:02:28 -0400
Mime-Version: 1.0 (Apple Message framework v618)
To: linux-kernel@vger.kernel.org
Message-Id: <EE086E35-E6CE-11D8-977D-000A95DC4E78@fotango.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-9--420089428
From: James Bromberger <jbromberger@fotango.com>
Subject: AMD64 pdflush Ooopses (2.6.8-rc1)
Date: Thu, 5 Aug 2004 12:02:23 +0100
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-9--420089428
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hello World,

I've got a few IBM xSeries 325 AMD Opteron machines, each with 8GB RAM, 
a pair of Qlogic SAN HBAs, and 275 GB LUNs from the SAN. When I do a 
large amount of I/O, I find I get Oopses, generally in pdflush. For 
example, I set up md multipath on /dev/md0 (from two devices 
/dev/sd[ce]1), and then set up LVM2 on top of this (pvcreate /dev/md0; 
vgcreate <vgname> /dev/md0; lvcreate -L 100G -n <lvname> <vgname>). 
When I then went to format this with ext3, I got:

OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
13107200 inodes, 26214400 blocks
1310720 blocks (5.00%) reserved for the super user
First data block=0
800 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks:
         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 
2654208,
         4096000, 7962624, 11239424, 20480000, 23887872

Writing inode tables: 437/800
Message from syslogd@localhost at Thu Aug  5 11:27:59 2004 ...
localhost kernel: Oops: 0000 [1] SMP



Attached is the Ooops from the syslog in full.


I have had the same thing with different filesystems on top (eg, XFS), 
except it didn't panic during XFS creation, but let me get all the way 
to putting a database on there, and only panicked when doing backups, 
and again when testing with 'dd' and putting large file son there very 
quickly.


Happy to provide any more data on request, and or test stuff. I was 
about to run this through ksymoops, but the machine has now panicked, 
and its in a datacentre... it seems that any large I/O to any partition 
can cause and Ooops or a panic.





--Apple-Mail-9--420089428
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-mac-type=2A2A2A2A;
	x-unix-mode=0644;
	x-mac-creator=48647261;
	name="dragon-oops-pdflush.txt"
Content-Disposition: attachment;
	filename=dragon-oops-pdflush.txt

ug  5 11:27:59 localhost kernel: Unable to handle kernel paging request at 0000000000001770 RIP: 
Aug  5 11:27:59 localhost kernel: <ffffffff8015ab54>{kmem_getpages+132}
Aug  5 11:27:59 localhost kernel: PML4 1c8669067 PGD 1c81b0067 PMD 0 
Aug  5 11:27:59 localhost kernel: Oops: 0000 [1] SMP 
Aug  5 11:27:59 localhost kernel: CPU 0 
Aug  5 11:27:59 localhost kernel: Modules linked in: multipath md ipv6 qla2300 qla2xxx scsi_transport_fc ohci_hcd hw_random amd74xx evdev
 tg3 rtc bonding dm_snapshot dm_mod ide_generic ide_cd ide_core cdrom isofs ext2 ext3 jbd mbcache unix sd_mod mptscsih mptbase scsi_mod x
fs
Aug  5 11:27:59 localhost kernel: Pid: 44, comm: pdflush Not tainted 2.6.8-rc1
Aug  5 11:27:59 localhost kernel: RIP: 0010:[kmem_getpages+132/448] <ffffffff8015ab54>{kmem_getpages+132}
Aug  5 11:27:59 localhost kernel: RSP: 0018:00000100081338d8  EFLAGS: 00010013
Aug  5 11:27:59 localhost kernel: RAX: ffffffff7fffffff RBX: 00000101ffffe680 RCX: 0000000000000000
Aug  5 11:27:59 localhost kernel: RDX: 0000010000011700 RSI: 00000100000119c0 RDI: 0000010000012500
Aug  5 11:27:59 localhost kernel: RBP: 00000101ffffe680 R08: 000001016bc00000 R09: 0000000000000001
Aug  5 11:27:59 localhost kernel: R10: 0000000000000001 R11: 00000101ffffe6e8 R12: 0000000000000200
Aug  5 11:27:59 localhost kernel: R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000000
Aug  5 11:27:59 localhost kernel: FS:  0000000000869c80(0000) GS:ffffffff803f3880(0000) knlGS:0000000000000000
Aug  5 11:27:59 localhost kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Aug  5 11:27:59 localhost kernel: CR2: 0000000000001770 CR3: 0000000000101000 CR4: 00000000000006e0
Aug  5 11:27:59 localhost kernel: Process pdflush (pid: 44, threadinfo 0000010008132000, task 0000010008131170)
Aug  5 11:27:59 localhost kernel: Stack: 000101016c3fd000 0000000000000040 0000000000000200 ffffffff8015b9f6 
Aug  5 11:27:59 localhost kernel:        00000200fff15128 00000101ffffe680 00000101ffffe6c8 0000000000000200 
Aug  5 11:27:59 localhost kernel:        00000100081339b8 000001016c3f7be0 
Aug  5 11:27:59 localhost kernel: Call Trace:<ffffffff8015b9f6>{cache_grow+182} <ffffffff8015bc31>{cache_alloc_refill+401} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8015bf16>{kmem_cache_alloc+54} <ffffffffa025f01e>{:multipath:mp_pool_alloc+30} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80155b11>{mempool_alloc+161} <ffffffff80155b11>{mempool_alloc+161} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffff80133d70>{autoremove_wake_function+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffffa025f336>{:multipath:multipath_make_request+38} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80217aeb>{generic_make_request+347} <ffffffff801792cd>{bio_clone+13} 
Aug  5 11:27:59 localhost kernel:        <ffffffffa016e4f6>{:dm_mod:clone_bio+54} <ffffffffa016e5d5>{:dm_mod:__clone_and_map+165} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffffa016e808>{:dm_mod:__split_bio+168} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80155b11>{mempool_alloc+161} <ffffffffa016e8f2>{:dm_mod:dm_request+114}
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffff80217aeb>{generic_make_request+347} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffff80217c10>{submit_bio+272} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8017723b>{__block_write_full_page+459} <ffffffff8017b6d0>{blkdev_get_block+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801968ff>{mpage_writepages+367} <ffffffff8017b820>{blkdev_writepage+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801588fe>{do_writepages+30} <ffffffff8019501f>{__sync_single_inode+111} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8019546f>{sync_sb_inodes+495} <ffffffff801955d4>{writeback_inodes+132} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801585c7>{background_writeout+119} <ffffffff801592a0>{pdflush+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801591e9>{__pdflush+297} <ffffffff801592bc>{pdflush+28} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80158550>{background_writeout+0} <ffffffff8014a002>{kthread+146} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80111447>{child_rip+8} <ffffffff801592a0>{pdflush+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8014a040>{keventd_create_kthread+0} <ffffffff80149f70>{kthread+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8011143f>{child_rip+0} 
Aug  5 11:27:59 localhost kernel: 
Aug  5 11:27:59 localhost kernel: Code: 48 8b 91 70 17 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00 
Aug  5 11:27:59 localhost kernel: RIP <ffffffff8015ab54>{kmem_getpages+132} RSP <00000100081338d8>
Aug  5 11:27:59 localhost kernel: CR2: 0000000000001770
Aug  5 11:27:59 localhost kernel:  <1>Unable to handle kernel paging request at 0000000000001770 RIP: 
Aug  5 11:27:59 localhost kernel: <ffffffff8015ab54>{kmem_getpages+132}
Aug  5 11:27:59 localhost kernel: PML4 1c8669067 PGD 1c81b0067 PMD 0 
Aug  5 11:27:59 localhost kernel: Oops: 0000 [2] SMP 
Aug  5 11:27:59 localhost kernel: CPU 0 
Aug  5 11:27:59 localhost kernel: Modules linked in: multipath md ipv6 qla2300 qla2xxx scsi_transport_fc ohci_hcd hw_random amd74xx evdev
 tg3 rtc bonding dm_snapshot dm_mod ide_generic ide_cd ide_core cdrom isofs ext2 ext3 jbd mbcache unix sd_mod mptscsih mptbase scsi_mod x
fs
Aug  5 11:27:59 localhost kernel: Pid: 32686, comm: mkfs.ext3 Not tainted 2.6.8-rc1
Aug  5 11:27:59 localhost kernel: RIP: 0010:[kmem_getpages+132/448] <ffffffff8015ab54>{kmem_getpages+132}
Aug  5 11:27:59 localhost kernel: RSP: 0018:00000101c8f0db98  EFLAGS: 00010213
Aug  5 11:27:59 localhost kernel: RAX: ffffffff7fffffff RBX: 00000101fffc9680 RCX: 0000000000000000
Aug  5 11:27:59 localhost kernel: RDX: 0000010000011700 RSI: 00000100000119c0 RDI: 0000010000012500
Aug  5 11:27:59 localhost kernel: RBP: 00000101fffc9680 R08: 000001016bc0c000 R09: 000001016ef90cc8
Aug  5 11:27:59 localhost kernel: R10: 00000101fffc96d8 R11: 00000101fffc96e8 R12: 0000000000000050
Aug  5 11:27:59 localhost kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000010
Aug  5 11:27:59 localhost kernel: FS:  0000000000869c80(0000) GS:ffffffff803f3880(0000) knlGS:0000000000000000
Aug  5 11:27:59 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Aug  5 11:27:59 localhost kernel: CR2: 0000000000001770 CR3: 0000000000101000 CR4: 00000000000006e0
Aug  5 11:27:59 localhost kernel: Process mkfs.ext3 (pid: 32686, threadinfo 00000101c8f0c000, task 00000101fdb695f0)
Aug  5 11:27:59 localhost kernel: Stack: 0000010000012500 0000000000000012 0000000000000050 ffffffff8015b9f6 
Aug  5 11:27:59 localhost kernel:        0000005010001520 00000101fffc9680 00000101fffc96c8 0000000000000050 
Aug  5 11:27:59 localhost kernel:        0000010005f92268 0000000000000001 
Aug  5 11:27:59 localhost kernel: Call Trace:<ffffffff8015b9f6>{cache_grow+182} <ffffffff8015bc31>{cache_alloc_refill+401} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8015bf16>{kmem_cache_alloc+54} <ffffffff80178e41>{alloc_buffer_head+17} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801765ea>{create_buffers+42} <ffffffff80176fa6>{create_empty_buffers+22} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8017740f>{__block_prepare_write+175} <ffffffff8017b6d0>{blkdev_get_block+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801572a2>{__alloc_pages+818} <ffffffff80177e9a>{block_prepare_write+26} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80154db3>{generic_file_aio_write_nolock+1315} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801f80f2>{write_chan+402} <ffffffff801f818c>{write_chan+556} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80155257>{generic_file_write_nolock+103} <ffffffff8017c71a>{blkdev_file_write+26} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801740f4>{vfs_write+228} <ffffffff80174209>{sys_write+73} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8011091a>{system_call+126} 
Aug  5 11:27:59 localhost kernel: 
Aug  5 11:27:59 localhost kernel: Code: 48 8b 91 70 17 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00 
Aug  5 11:27:59 localhost kernel: RIP <ffffffff8015ab54>{kmem_getpages+132} RSP <00000101c8f0db98>
Aug  5 11:27:59 localhost kernel: CR2: 0000000000001770
Aug  5 11:27:59 localhost kernel:  <1>Unable to handle kernel paging request at 0000000000001770 RIP: 
Aug  5 11:27:59 localhost kernel: <ffffffff8015ab54>{kmem_getpages+132}
Aug  5 11:27:59 localhost kernel: PML4 1febf4067 PGD 1fe9e3067 PMD 0 
Aug  5 11:27:59 localhost kernel: Oops: 0000 [3] SMP 
Aug  5 11:27:59 localhost kernel: CPU 0 
Aug  5 11:27:59 localhost kernel: Modules linked in: multipath md ipv6 qla2300 qla2xxx scsi_transport_fc ohci_hcd hw_random amd74xx evdev
 tg3 rtc bonding dm_snapshot dm_mod ide_generic ide_cd ide_core cdrom isofs ext2 ext3 jbd mbcache unix sd_mod mptscsih mptbase scsi_mod x
fs
Aug  5 11:27:59 localhost kernel: Pid: 32686, comm: mkfs.ext3 Not tainted 2.6.8-rc1
Aug  5 11:27:59 localhost kernel: RIP: 0010:[kmem_getpages+132/448] <ffffffff8015ab54>{kmem_getpages+132}
Aug  5 11:27:59 localhost kernel: RSP: 0018:00000101c8f0d3c8  EFLAGS: 00010013
Aug  5 11:27:59 localhost kernel: RAX: ffffffff7fffffff RBX: 00000101ffffe680 RCX: 0000000000000000
Aug  5 11:27:59 localhost kernel: RDX: 0000010000011700 RSI: 00000100000119c0 RDI: 0000010000012500
Aug  5 11:27:59 localhost kernel: RBP: 00000101ffffe680 R08: 000001016bc0d000 R09: 00000100fbe67010
Aug  5 11:27:59 localhost kernel: R10: 00000101ffffe6d8 R11: 00000101ffffe6e8 R12: 0000000000000200
Aug  5 11:27:59 localhost kernel: R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000000
Aug  5 11:27:59 localhost kernel: FS:  0000002aa39e7a40(0000) GS:ffffffff803f3880(0000) knlGS:0000000000000000
Aug  5 11:27:59 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Aug  5 11:27:59 localhost kernel: CR2: 0000000000001770 CR3: 0000000000101000 CR4: 00000000000006e0
Aug  5 11:27:59 localhost kernel: Process mkfs.ext3 (pid: 32686, threadinfo 00000101c8f0c000, task 00000101fdb695f0)
Aug  5 11:27:59 localhost kernel: Stack: 0000000000000000 ffffffff801572d0 0000000000000200 ffffffff8015b9f6 
Aug  5 11:27:59 localhost kernel:        000002006e416000 00000101ffffe680 00000101ffffe6c8 0000000000000200 
Aug  5 11:27:59 localhost kernel:        00000101c8f0d4a8 00000101d1729fe8 
Aug  5 11:27:59 localhost kernel: Call Trace:<ffffffff801572d0>{__get_free_pages+16} <ffffffff8015b9f6>{cache_grow+182} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8015bc31>{cache_alloc_refill+401} <ffffffff8015bf16>{kmem_cache_alloc+54} 
Aug  5 11:27:59 localhost kernel:        <ffffffffa025f01e>{:multipath:mp_pool_alloc+30} <ffffffff80155b11>{mempool_alloc+161} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80155b11>{mempool_alloc+161} <ffffffff80133d70>{autoremove_wake_function+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffffa025f336>{:multipath:multipath_make_requ
est+38} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80217aeb>{generic_make_request+347} <ffffffff801792cd>{bio_clone+13} 
Aug  5 11:27:59 localhost kernel:        <ffffffffa016e4f6>{:dm_mod:clone_bio+54} <ffffffffa016e5d5>{:dm_mod:__clone_and_map+165} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffffa016e808>{:dm_mod:__split_bio+168} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80155b11>{mempool_alloc+161} <ffffffffa016e8f2>{:dm_mod:dm_request+114} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffff80217aeb>{generic_make_request+347} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffff80217c10>{submit_bio+272} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8017723b>{__block_write_full_page+459} <ffffffff8017b6d0>{blkdev_get_block+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801968ff>{mpage_writepages+367} <ffffffff8017b820>{blkdev_writepage+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801588fe>{do_writepages+30} <ffffffff801529b4>{__filemap_fdatawrite+132} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80175668>{sync_blockdev+40} <ffffffff8017c587>{blkdev_put+103} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80174ef2>{__fput+82} <ffffffff801737ee>{filp_close+126} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80137c13>{put_files_struct+115} <ffffffff801389e6>{do_exit+534} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80120eeb>{do_page_fault+1035} <ffffffffa01ce677>{:qla2xxx:qla2x00_next+583} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80156984>{__rmqueue+228} <ffffffff80111291>{error_exit+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8015ab54>{kmem_getpages+132} <ffffffff8015aaf6>{kmem_getpages+38} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8015b9f6>{cache_grow+182} <ffffffff8015bc31>{cache_alloc_refill+401} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8015bf16>{kmem_cache_alloc+54} <ffffffff80178e41>{alloc_buffer_head+17} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801765ea>{create_buffers+42} <ffffffff80176fa6>{create_empty_buffers+22} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8017740f>{__block_prepare_write+175} <ffffffff8017b6d0>{blkdev_get_block+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801572a2>{__alloc_pages+818} <ffffffff80177e9a>{block_prepare_write+26} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80154db3>{generic_file_aio_write_nolock+1315} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801f80f2>{write_chan+402} <ffffffff801f818c>{write_chan+556} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80155257>{generic_file_write_nolock+103} <ffffffff8017c71a>{blkdev_file_write+26} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801740f4>{vfs_write+228} <ffffffff80174209>{sys_write+73} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8011091a>{system_call+126} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80155b11>{mempool_alloc+161} <ffffffffa016e8f2>{:dm_mod:dm_request+114} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffff80217aeb>{generic_make_request+347} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80133d70>{autoremove_wake_function+0} <ffffffff80217c10>{submit_bio+272} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8017723b>{__block_write_full_page+459} <ffffffff8017b6d0>{blkdev_get_block+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801968ff>{mpage_writepages+367} <ffffffff8017b820>{blkdev_writepage+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801588fe>{do_writepages+30} <ffffffff801529b4>{__filemap_fdatawrite+132} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80175668>{sync_blockdev+40} <ffffffff8017c587>{blkdev_put+103} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80174ef2>{__fput+82} <ffffffff801737ee>{filp_close+126} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80137c13>{put_files_struct+115} <ffffffff801389e6>{do_exit+534} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80120eeb>{do_page_fault+1035} <ffffffffa01ce677>{:qla2xxx:qla2x00_next+583} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80156984>{__rmqueue+228} <ffffffff80111291>{error_exit+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8015ab54>{kmem_getpages+132} <ffffffff8015aaf6>{kmem_getpages+38} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8015b9f6>{cache_grow+182} <ffffffff8015bc31>{cache_alloc_refill+401} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8015bf16>{kmem_cache_alloc+54} <ffffffff80178e41>{alloc_buffer_head+17} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801765ea>{create_buffers+42} <ffffffff80176fa6>{create_empty_buffers+22} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8017740f>{__block_prepare_write+175} <ffffffff8017b6d0>{blkdev_get_block+0} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801572a2>{__alloc_pages+818} <ffffffff80177e9a>{block_prepare_write+26} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80154db3>{generic_file_aio_write_nolock+1315} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801f80f2>{write_chan+402} <ffffffff801f818c>{write_chan+556} 
Aug  5 11:27:59 localhost kernel:        <ffffffff80155257>{generic_file_write_nolock+103} <ffffffff8017c71a>{blkdev_file_write+26} 
Aug  5 11:27:59 localhost kernel:        <ffffffff801740f4>{vfs_write+228} <ffffffff80174209>{sys_write+73} 
Aug  5 11:27:59 localhost kernel:        <ffffffff8011091a>{system_call+126} 
Aug  5 11:27:59 localhost kernel: 
Aug  5 11:27:59 localhost kernel: Code: 48 8b 91 70 17 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00 
Aug  5 11:27:59 localhost kernel: RIP <ffffffff8015ab54>{kmem_getpages+132} RSP <00000101c8f0d3c8>
Aug  5 11:27:59 localhost kernel: CR2: 0000000000001770
--Apple-Mail-9--420089428
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="config-2.6.8-rc1"
Content-Disposition: attachment;
	filename=config-2.6.8-rc1

#
# Automatically generated make config: don't edit
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_PREEMPT is not set
CONFIG_SCHED_SMT=y
CONFIG_K8_NUMA=y
CONFIG_DISCONTIGMEM=y
CONFIG_NUMA=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NR_CPUS=8
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=m
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=m

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_USE_VECTOR=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=m
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_ATIIXP=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5520=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=m
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
# CONFIG_SCSI_3W_9XXX is not set
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_ENABLE_RD_STRM=y
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_MEGARAID=m
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=m
# CONFIG_SCSI_SATA_NV is not set
CONFIG_SCSI_SATA_PROMISE=m
# CONFIG_SCSI_SATA_SX4 is not set
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIS=m
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_SATA_VITESSE=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_EATA_LINKED_COMMANDS=y
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_IPS=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
CONFIG_SCSI_QLOGIC_FC_FIRMWARE=y
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA2XXX=m
CONFIG_SCSI_QLA21XX=m
CONFIG_SCSI_QLA22XX=m
CONFIG_SCSI_QLA2300=m
CONFIG_SCSI_QLA2322=m
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_DC390T=m
CONFIG_SCSI_DEBUG=m

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m

#
# Fusion MPT device support
#
CONFIG_FUSION=m
CONFIG_FUSION_MAX_SGE=40
CONFIG_FUSION_ISENSE=m
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_CONFIG=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IP6_NF_RAW=m

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
CONFIG_DECNET=m
# CONFIG_DECNET_SIOCGIFCONF is not set
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=m
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_X25=m
CONFIG_LAPB=m
# CONFIG_NET_DIVERT is not set
CONFIG_ECONET=m
CONFIG_ECONET_AUNUDP=y
CONFIG_ECONET_NATIVE=y
CONFIG_WAN_ROUTER=m
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_YAM=m
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_MA600_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_MCP2120_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_ACT200L_DONGLE=m

#
# Old SIR device drivers
#

#
# Old Serial dongle support
#

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_SIGMATEL_FIR=m
CONFIG_VLSI_FIR=m
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_BCSP_TXCRC is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m

#
# ARCnet devices
#
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_HP100=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
# CONFIG_AMD8111E_NAPI is not set
CONFIG_ADAPTEC_STARFIRE=m
# CONFIG_ADAPTEC_STARFIRE_NAPI is not set
CONFIG_B44=m
CONFIG_FORCEDETH=m
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
# CONFIG_E100_NAPI is not set
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_VIA_VELOCITY is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
CONFIG_DL2K=m
CONFIG_E1000=m
# CONFIG_E1000_NAPI is not set
CONFIG_NS83820=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_R8169=m
CONFIG_SK98LIN=m
CONFIG_TIGON3=m

#
# Ethernet (10000 Mbit)
#
CONFIG_IXGB=m
# CONFIG_IXGB_NAPI is not set
CONFIG_S2IO=m
# CONFIG_S2IO_NAPI is not set

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMOL=m
CONFIG_3C359=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_ABYSS=m

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
CONFIG_STRIP=m

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_DSCC4=m
CONFIG_DSCC4_PCISYNC=y
CONFIG_DSCC4_PCI_RST=y
CONFIG_LANMEDIA=m
CONFIG_SYNCLINK_SYNCPPP=m
CONFIG_HDLC=m
CONFIG_HDLC_RAW=y
CONFIG_HDLC_RAW_ETH=y
CONFIG_HDLC_CISCO=y
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=y
CONFIG_HDLC_X25=y
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
CONFIG_PC300=m
CONFIG_PC300_MLPPP=y
CONFIG_FARSYNC=m
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_WAN_ROUTER_DRIVERS=y
CONFIG_CYCLADES_SYNC=m
CONFIG_CYCLOMX_X25=y
CONFIG_LAPBETHER=m
CONFIG_X25_ASY=m
CONFIG_SBNI=m
# CONFIG_SBNI_MULTILINE is not set

#
# ATM drivers
#
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
# CONFIG_ATM_FORE200E_USE_TASKLET is not set
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_FORE200E=m
CONFIG_ATM_HE=m
CONFIG_ATM_HE_USE_SUNI=y
CONFIG_FDDI=y
# CONFIG_DEFXX is not set
CONFIG_SKFP=m
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=m
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_NET_FC=y
CONFIG_SHAPER=m
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PCIPS2=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_NEWTON=m
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_STALDRV is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_MULTIPORT=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_WAFER_WDT=m
CONFIG_I8XX_TCO=m
CONFIG_SC1200_WDT=m
CONFIG_SCx200_WDT=m
CONFIG_60XX_WDT=m
CONFIG_CPU5_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_MACHZ_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m
CONFIG_WDT_501_PCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL_MCH is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_SIS=m
CONFIG_MWAVE=m
CONFIG_RAW_DRIVER=m
# CONFIG_HPET is not set
CONFIG_MAX_RAW_DEVS=256
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCF8591=m
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
CONFIG_IBM_ASM=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5246A=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
# CONFIG_VIDEO_ZORAN is not set
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_MXB=m
CONFIG_VIDEO_DPC=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_HEXIUM_GEMINI=m
CONFIG_VIDEO_CX88=m
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
CONFIG_RADIO_GEMTEK_PCI=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MAESTRO=m

#
# Digital Video Broadcasting Devices
#
CONFIG_DVB=y
CONFIG_DVB_CORE=m

#
# Supported Frontend Modules
#
CONFIG_DVB_STV0299=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_SP887X_FIRMWARE_FILE="/usr/lib/hotplug/firmware/sc_main.mc"
CONFIG_DVB_ALPS_TDLB7=m
CONFIG_DVB_ALPS_TDMB7=m
CONFIG_DVB_ATMEL_AT76C651=m
CONFIG_DVB_CX24110=m
CONFIG_DVB_GRUNDIG_29504_491=m
CONFIG_DVB_GRUNDIG_29504_401=m
CONFIG_DVB_MT312=m
CONFIG_DVB_VES1820=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_TDA1004X_FIRMWARE_FILE="/usr/lib/hotplug/firmware/tda1004x.bin"
CONFIG_DVB_NXT6000=m

#
# Supported SAA7146 based PCI Adapters
#
CONFIG_DVB_AV7110=m
# CONFIG_DVB_AV7110_OSD is not set
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m

#
# Supported USB Adapters
#
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m

#
# Supported FlexCopII (B2C2) Adapters
#
CONFIG_DVB_B2C2_SKYSTAR=m

#
# Supported BT878 Adapters
#
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_HGA=m
# CONFIG_FB_HGA_ACCEL is not set
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_RADEON_OLD=m
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_XL_INIT=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_TRIDENT=m
# CONFIG_FB_TRIDENT_ACCEL is not set
CONFIG_FB_VIRTUAL=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
# CONFIG_LOGO is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
# CONFIG_USB_EGALAX is not set
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
# CONFIG_USB_PWC is not set
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m
CONFIG_USB_W9968CF=m

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_SPEEDTOUCH=m
# CONFIG_USB_PHIDGETSERVO is not set
CONFIG_USB_TEST=m

#
# USB Gadget Support
#
CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=m
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_SA1100 is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
CONFIG_USB_GADGET_DUALSPEED=y
CONFIG_USB_ZERO=m
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_GADGETFS=m
CONFIG_USB_FILE_STORAGE=m
# CONFIG_USB_FILE_STORAGE_TEST is not set
CONFIG_USB_G_SERIAL=m

#
# Firmware Drivers
#
CONFIG_EDD=m

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_CRAMFS=y
CONFIG_VXFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
# CONFIG_QNX4FS_RW is not set
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_POSIX is not set
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_ROOTPLUG=m
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m

--Apple-Mail-9--420089428
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



Thanks,

   James
--Apple-Mail-9--420089428--

