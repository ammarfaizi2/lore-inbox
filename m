Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274953AbTHFWqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274966AbTHFWqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:46:17 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:58477 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S274953AbTHFWoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:44:44 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 00:44:25 +0200
User-Agent: KMail/1.5.3
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062129.47113.fsdeveloper@yahoo.de> <20030806150434.53c4fa8c.akpm@osdl.org>
In-Reply-To: <20030806150434.53c4fa8c.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Willy Gardiol <gardiol@libero.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JTYM/p1D65CKbmi"
Message-Id: <200308070044.41198.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_JTYM/p1D65CKbmi
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 07 August 2003 00:04, Andrew Morton wrote:
> Please boot the 2.6 machine with "profile=3D1" on the kernel boot command
> line.
>
> start the `dd', do a `readprofile -r', wait ten seconds, do
>
> 	readprofile -m /wherever/System.map
>
> then post the results.

I've done this twice and appended the results to this mail.



But I've captured a few other interesting things in the syslog.
After doing a
$ hdparm -c1 -u1 -d1 -X69 /dev/hda
I saw this in my syslog:

Aug  7 00:32:05 lfs kernel: blk: queue c049195c, I/O limit 4095Mb (mask 0xf=
fffffff)
Aug  7 00:32:05 lfs kernel: hda: Speed warnings UDMA 3/4/5 is not functiona=
l.

The onboard IDE controller is a UDMA-100 controller
and the disks do run in this mode, too.

=2D --=20
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MYTVoxoigfggmSgRAlG4AJ9AzwetBUAZBT/l/ltkwMAWKHsGWwCcCX9H
aN2KwzLzeYhYrU9y7IUgM6c=3D
=3Dr/G9
=2D----END PGP SIGNATURE-----

--Boundary-00=_JTYM/p1D65CKbmi
Content-Type: text/plain;
  charset="iso-8859-1";
  name="profile-results.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="profile-results.1"

     1 restore_sigcontext                         0,0033
     1 setup_frame                                0,0021
  1722 system_call                               39,1364
    13 syscall_call                               1,1818
     6 syscall_exit                               0,5455
     3 device_not_available                       0,0714
     8 handle_IRQ_event                           0,0816
     1 save_i387                                  0,0055
    18 delay_tsc                                  0,6667
     1 apm_bios_call                              0,0045
     1 queue_empty                                0,0500
     1 check_apm_user                             0,0189
     4 do_page_fault                              0,0034
    11 schedule                                   0,0116
   273 __wake_up                                  3,1379
     1 sys_sched_get_priority_max                 0,0286
     2 remove_wait_queue                          0,0189
     2 sys_setitimer                              0,0080
    19 current_kernel_time                        0,3167
   234 do_softirq                                 1,4625
     5 run_timer_softirq                          0,0117
     1 schedule_timeout                           0,0058
     2 group_send_sig_info                        0,0021
     3 get_signal_to_deliver                      0,0039
     1 adjust_abs_time                            0,0039
     2 __remove_from_page_cache                   0,0208
     9 add_to_page_cache                          0,0303
    30 page_waitqueue                             0,6383
     7 wait_on_page_bit                           0,0400
    55 unlock_page                                0,6962
     5 find_get_page                              0,0510
    54 find_lock_page                             0,1682
    10 remove_suid                                0,1000
   508 generic_file_aio_write_nolock              0,1636
    75 generic_file_write_nolock                  0,5172
    36 generic_file_write                         0,3396
     1 generic_file_readv                         0,0069
    33 mempool_alloc                              0,0979
     1 mempool_alloc_slab                         0,0476
    13 bad_range                                  0,1287
     8 prep_new_page                              0,1081
    64 free_hot_cold_page                         0,2452
     1 free_hot_page                              0,0909
    75 buffered_rmqueue                           0,1918
    14 __alloc_pages                              0,0194
     1 __free_pages                               0,0139
     1 __get_page_state                           0,0092
    28 balance_dirty_pages_ratelimited            0,1958
    23 __set_page_dirty_nobuffers                 0,1150
    22 test_clear_page_dirty                      0,3793
    75 kmem_cache_alloc                           1,1538
    26 __kmalloc                                  0,2203
    33 kmem_cache_free                            0,4648
    15 kfree                                      0,1596
     1 reap_timer_fnc                             0,0021
    78 mark_page_accessed                         1,5600
     1 lru_cache_add_active                       0,0093
     1 lru_add_drain                              0,0104
     8 release_pages                              0,0213
     8 __pagevec_release_nonlru                   0,0593
    22 __pagevec_lru_add                          0,0880
     1 shrink_slab                                0,0029
    20 shrink_list                                0,0142
    25 shrink_cache                               0,0346
     3 refill_inactive_zone                       0,0023
     1 shrink_zone                                0,0065
     1 blk_queue_bounce                           0,0128
     1 zap_pte_range                              0,0026
     1 do_wp_page                                 0,0010
     6 do_anonymous_page                          0,0102
     2 find_vma                                   0,0241
     9 page_referenced                            0,0552
     1 free_page_and_swap_cache                   0,0062
    55 vfs_read                                   0,2052
     2 do_sync_write                              0,0111
    47 vfs_write                                  0,1754
    74 sys_read                                   0,7957
    57 sys_write                                  0,6129
     3 fput                                       0,1200
     5 fget                                       0,0735
    72 fget_light                                 0,5255
     1 __set_page_buffers                         0,0133
     2 __clear_page_buffers                       0,0164
    18 __find_get_block_slow                      0,0647
     2 mark_buffer_async_write                    0,0870
     1 buffer_insert_list                         0,0093
     1 invalidate_inode_buffers                   0,0090
     4 create_buffers                             0,0258
     1 __getblk_slow                              0,0033
    23 mark_buffer_dirty                          0,3067
    40 __brelse                                   0,7018
   830 __find_get_block                           3,8073
   112 __getblk                                   1,4933
    98 __bread                                    1,7193
    10 set_bh_page                                0,1639
     1 try_to_release_page                        0,0101
    18 create_empty_buffers                       0,1161
     7 unmap_underlying_metadata                  0,0753
     2 __block_write_full_page                    0,0022
  1374 __block_prepare_write                      1,4870
    70 __block_commit_write                       0,5036
     2 block_read_full_page                       0,0031
    29 block_prepare_write                        0,4462
     2 block_commit_write                         0,0435
    41 generic_commit_write                       0,2680
     4 submit_bh                                  0,0118
     1 check_ttfb_buffer                          0,0125
     4 drop_buffers                               0,0209
     3 try_to_free_buffers                        0,0160
     1 recalc_bh_state                            0,0169
     7 alloc_buffer_head                          0,0769
     6 free_buffer_head                           0,0606
    18 bio_alloc                                  0,0442
     1 generic_fillattr                           0,0056
     1 cp_new_stat64                              0,0044
     1 pipe_poll                                  0,0083
     3 follow_mount                               0,0216
     1 do_lookup                                  0,0069
    11 link_path_walk                             0,0051
     2 path_lookup                                0,0064
     1 open_namei                                 0,0010
     1 sys_ioctl                                  0,0016
     1 poll_freewait                              0,0149
     3 __pollwait                                 0,0175
     3 do_select                                  0,0048
     3 sys_select                                 0,0026
     1 do_poll                                    0,0054
     3 dput                                       0,0058
    13 __d_lookup                                 0,0415
     1 alloc_inode                                0,0030
     1 shrink_icache_memory                       0,0263
     1 find_inode_fast                            0,0116
    86 inode_times_differ                         1,2464
     2 update_atime                               0,0100
    89 inode_update_time                          0,5266
    72 dnotify_parent                             0,4586
     4 __mark_inode_dirty                         0,0170
     1 write_inode                                0,0141
     1 writeback_inodes                           0,0060
    14 mpage_writepages                           0,0183
     1 proc_read_inode                            0,0175
     4 proc_lookup                                0,0150
     1 kstat_read_proc                            0,0014
     6 write_profile                              0,0909
    20 scan_bitmap_block                          0,0181
     7 scan_bitmap                                0,0136
     6 use_preallocated_list_if_available         0,0513
     7 reiserfs_allocate_blocknrs                 0,0035
    33 balance_leaf                               0,0031
    13 free_thrown                                0,1250
    20 do_balance                                 0,0766
    11 do_balance_mark_leaf_dirty                 0,0902
   133 _make_cpu_key                              0,7189
    39 make_cpu_key                               0,4149
     1 file_capable                               0,0192
     1 restart_transaction                        0,0090
   146 reiserfs_get_block                         0,0291
    48 inode2sd                                   0,3221
    64 update_stat_data                           0,2570
   232 reiserfs_update_sd                         0,5358
     1 lock_buffer_for_writepage                  0,0069
    49 reiserfs_write_full_page                   0,0641
     5 reiserfs_writepage                         0,0877
    32 reiserfs_prepare_write                     0,2286
   172 reiserfs_commit_write                      0,4057
     8 i_attrs_to_sd_attrs                        0,0748
    11 reiserfs_releasepage                       0,0714
    23 reiserfs_file_write                        0,0144
     1 get_num_ver                                0,0012
     4 set_parameters                             0,0315
     1 is_leaf_removable                          0,0034
     1 get_empty_nodes                            0,0018
     3 get_lfree                                  0,0288
    10 get_rfree                                  0,1010
    24 get_parents                                0,0603
    43 ip_check_balance                           0,0147
    11 check_balance                              0,0738
     4 get_direct_parent                          0,0205
     4 get_neighbors                              0,0117
     4 get_virtual_node_size                      0,0500
     8 get_mem_for_virtual_node                   0,0369
     2 clear_all_dirty_bits                       0,0556
    83 wait_tb_buffers_until_unlocked             0,0956
    27 fix_nodes                                  0,0250
    83 unfix_nodes                                0,2365
   748 leaf_paste_in_buffer                       1,0580
     3 leaf_cut_from_buffer                       0,0028
     1 internal_insert_childs                     0,0021
    13 decrement_counters_in_path                 0,1646
    19 pathrelse_and_restore                      0,2436
    55 pathrelse                                  1,0000
   194 is_leaf                                    0,4369
   161 is_internal                                1,1583
   167 is_tree_node                               1,6058
  2811 search_by_key                              0,7901
    35 search_for_position_by_key                 0,0362
    33 init_tb_struct                             0,4177
     6 reiserfs_paste_into_item                   0,0218
     7 B_IS_IN_TREE                               0,3333
     8 copy_item_head                             0,2222
     2 comp_short_keys                            0,0247
     4 decrement_bcount                           0,0741
     2 reiserfs_check_lock_depth                  0,4000
     1 push_journal_writer                        0,1429
     2 pop_journal_writer                         0,2857
     1 dump_journal_writers                       0,0164
    49 reiserfs_in_journal                        0,1029
    53 reiserfs_wait_on_write_block               0,3841
   104 do_journal_begin_r                         0,1600
     6 journal_begin                              0,1395
     1 journal_prepare                            0,1429
    71 journal_mark_dirty                         0,0967
    13 journal_end                                0,3023
     4 remove_from_transaction                    0,0110
   100 check_journal_end                          0,1548
    19 reiserfs_update_inode_transaction          0,3585
     2 reiserfs_inode_in_this_transaction         0,0476
    44 reiserfs_restore_prepared_buffer           1,4194
    67 reiserfs_prepare_for_journal               0,6768
    69 do_journal_end                             0,0238
     1 sd_is_left_mergeable                       0,1429
     6 indirect_bytes_number                      0,2609
     6 indirect_decrement_key                     0,0472
     6 indirect_is_left_mergeable                 0,0517
     4 radix_tree_preload                         0,0252
    16 radix_tree_insert                          0,0792
   106 radix_tree_lookup                          1,3766
    22 radix_tree_delete                          0,0987
     8 number                                     0,0135
    10 vsnprintf                                  0,0092
     2 vsprintf                                   0,0465
     7 atomic_dec_and_lock                        0,0833
     2 __const_udelay                             0,0541
   103 memcpy                                     1,8727
     1 memset                                     0,0400
     5 strncpy_from_user                          0,0549
   321 clear_user                                 4,5211
     1 __clear_user                               0,0323
     2 __copy_user_intel                          0,0116
     2 __copy_to_user_ll                          0,0192
   499 __copy_from_user_ll                        4,7981
    49 read_zero                                  0,1008
     1 tty_poll                                   0,0085
     2 normal_poll                                0,0062
     1 pty_chars_in_buffer                        0,0137
    69 blk_rq_map_sg                              0,2156
     1 blk_congestion_wait                        0,0077
   107 __make_request                             0,0845
    16 generic_make_request                       0,0362
    17 submit_bio                                 0,1604
     1 get_io_context                             0,0079
     1 get_stats                                  0,0083
   270 ide_end_request                            0,8157
    19 ide_do_request                             0,0178
    15 ide_intr                                   0,0358
    75 ide_inb                                    6,2500
     1 ide_outb                                   0,0769
   149 ide_outbsync                              11,4615
     4 ide_outsl                                  0,2222
    26 ide_execute_command                        0,1461
     1 SELECT_DRIVE                               0,0133
     2 default_end_request                        0,2222
     3 __ide_do_rw_disk                           0,0016
     1 ide_do_rw_disk                             0,0147
     2 ide_dma_intr                               0,0108
     6 ide_build_sglist                           0,0349
     5 ide_build_dmatable                         0,0128
     1 ide_start_dma                              0,0062
     1 __ide_dma_write                            0,0050
     2 i8042_interrupt                            0,0036
     1 i8042_timer_func                           0,0161
    40 raid0_make_request                         0,1108
     2 sock_ioctl                                 0,0031
    11 sock_poll                                  0,2292
     2 sock_alloc_send_pskb                       0,0042
     1 sock_def_readable                          0,0077
     1 alloc_skb                                  0,0044
     2 tcp_poll                                   0,0055
     2 unix_stream_sendmsg                        0,0020
     2 unix_stream_recvmsg                        0,0016
     2 unix_ioctl                                 0,0097
     8 unix_poll                                  0,0530
 15452 gesamt                                     0,0065

--Boundary-00=_JTYM/p1D65CKbmi
Content-Type: text/plain;
  charset="iso-8859-1";
  name="profile-results.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="profile-results.2"

     1 restore_sigcontext                         0,0033
     1 setup_frame                                0,0021
   987 system_call                               22,4318
     5 syscall_call                               0,4545
     1 syscall_exit                               0,0909
     3 handle_IRQ_event                           0,0306
     1 do_gettimeofday                            0,0070
    11 delay_tsc                                  0,4074
     1 do_page_fault                              0,0008
     5 schedule                                   0,0053
   146 __wake_up                                  1,6782
     1 remove_wait_queue                          0,0094
     1 do_setitimer                               0,0026
     1 sys_setitimer                              0,0040
     8 current_kernel_time                        0,1333
   116 do_softirq                                 0,7250
     1 tasklet_action                             0,0099
     1 add_timer                                  0,0061
     1 run_timer_softirq                          0,0023
     1 group_send_sig_info                        0,0011
     6 add_to_page_cache                          0,0202
    22 page_waitqueue                             0,4681
     7 wait_on_page_bit                           0,0400
    30 unlock_page                                0,3797
     3 find_get_page                              0,0306
    40 find_lock_page                             0,1246
     9 remove_suid                                0,0900
   296 generic_file_aio_write_nolock              0,0953
    33 generic_file_write_nolock                  0,2276
    18 generic_file_write                         0,1698
     2 generic_file_readv                         0,0138
    20 mempool_alloc                              0,0593
     1 mempool_alloc_slab                         0,0476
     7 bad_range                                  0,0693
     4 prep_new_page                              0,0541
    22 free_hot_cold_page                         0,0843
    33 buffered_rmqueue                           0,0844
     4 __alloc_pages                              0,0055
     1 __get_page_state                           0,0092
    25 balance_dirty_pages_ratelimited            0,1748
    20 __set_page_dirty_nobuffers                 0,1000
    10 test_clear_page_dirty                      0,1724
     1 cache_init_objs                            0,0088
    31 kmem_cache_alloc                           0,4769
    21 __kmalloc                                  0,1780
     5 kmem_cache_free                            0,0704
    19 kfree                                      0,2021
    59 mark_page_accessed                         1,1800
     1 lru_cache_add_active                       0,0093
     1 lru_add_drain                              0,0104
     1 release_pages                              0,0027
    12 __pagevec_lru_add                          0,0480
     1 shrink_slab                                0,0029
     2 shrink_list                                0,0014
     5 shrink_cache                               0,0069
     2 refill_inactive_zone                       0,0016
     1 balance_pgdat                              0,0026
     1 blk_queue_bounce                           0,0128
     1 zap_pte_range                              0,0026
     2 do_anonymous_page                          0,0034
     1 do_no_page                                 0,0011
     3 do_mmap_pgoff                              0,0019
     1 get_unmapped_area                          0,0033
     1 detach_vmas_to_be_unmapped                 0,0105
     3 page_referenced                            0,0184
     1 add_to_swap                                0,0044
     1 dentry_open                                0,0020
     1 get_unused_fd                              0,0025
    42 vfs_read                                   0,1567
     1 do_sync_write                              0,0056
    58 vfs_write                                  0,2164
    44 sys_read                                   0,4731
    40 sys_write                                  0,4301
     1 fput                                       0,0400
     4 fget                                       0,0588
    37 fget_light                                 0,2701
     1 __set_page_buffers                         0,0133
     3 __clear_page_buffers                       0,0246
     8 __find_get_block_slow                      0,0288
     3 buffer_insert_list                         0,0280
     2 create_buffers                             0,0129
     1 grow_dev_page                              0,0027
    11 mark_buffer_dirty                          0,1467
    34 __brelse                                   0,5965
   490 __find_get_block                           2,2477
    66 __getblk                                   0,8800
    65 __bread                                    1,1404
     1 set_bh_page                                0,0164
     2 try_to_release_page                        0,0202
    11 create_empty_buffers                       0,0710
     7 unmap_underlying_metadata                  0,0753
     1 __block_write_full_page                    0,0011
   806 __block_prepare_write                      0,8723
    41 __block_commit_write                       0,2950
     1 block_read_full_page                       0,0016
     8 block_prepare_write                        0,1231
    35 generic_commit_write                       0,2288
     1 submit_bh                                  0,0029
     1 drop_buffers                               0,0052
     2 try_to_free_buffers                        0,0106
    10 alloc_buffer_head                          0,1099
     1 free_buffer_head                           0,0101
     5 init_buffer_head                           0,1163
    11 bio_alloc                                  0,0270
     2 cp_new_stat64                              0,0088
     1 getname                                    0,0054
     1 follow_mount                               0,0072
     4 do_lookup                                  0,0276
     6 link_path_walk                             0,0028
     1 path_lookup                                0,0032
     1 poll_freewait                              0,0149
     2 __pollwait                                 0,0117
     5 do_select                                  0,0079
     1 sys_select                                 0,0009
     1 d_alloc                                    0,0021
    12 __d_lookup                                 0,0383
     1 d_rehash                                   0,0095
     1 find_inode_fast                            0,0116
    51 inode_times_differ                         0,7391
     1 update_atime                               0,0050
    50 inode_update_time                          0,2959
    52 dnotify_parent                             0,3312
     3 __mark_inode_dirty                         0,0128
     1 __writeback_single_inode                   0,0057
     5 mpage_writepages                           0,0065
     1 proc_lookup                                0,0038
     1 kstat_read_proc                            0,0014
     5 write_profile                              0,0758
     5 scan_bitmap_block                          0,0045
     2 scan_bitmap                                0,0039
     1 determine_prealloc_size                    0,0076
    12 reiserfs_allocate_blocknrs                 0,0060
    19 balance_leaf                               0,0018
    14 free_thrown                                0,1346
    11 do_balance                                 0,0421
     6 do_balance_mark_leaf_dirty                 0,0492
    81 _make_cpu_key                              0,4378
    21 make_cpu_key                               0,2234
     1 add_to_flushlist                           0,0169
    77 reiserfs_get_block                         0,0154
    27 inode2sd                                   0,1812
    27 update_stat_data                           0,1084
   132 reiserfs_update_sd                         0,3048
     2 lock_buffer_for_writepage                  0,0139
    18 reiserfs_write_full_page                   0,0236
     2 reiserfs_writepage                         0,0351
    29 reiserfs_prepare_write                     0,2071
   130 reiserfs_commit_write                      0,3066
     3 i_attrs_to_sd_attrs                        0,0280
     6 reiserfs_releasepage                       0,0390
    13 reiserfs_file_write                        0,0081
     1 check_right                                0,0029
     7 set_parameters                             0,0551
     4 get_lfree                                  0,0385
     6 get_rfree                                  0,0606
    14 get_parents                                0,0352
    23 ip_check_balance                           0,0079
     1 check_balance                              0,0067
     5 get_direct_parent                          0,0256
     3 get_virtual_node_size                      0,0375
     1 get_mem_for_virtual_node                   0,0046
     1 clear_all_dirty_bits                       0,0278
    72 wait_tb_buffers_until_unlocked             0,0829
    10 fix_nodes                                  0,0093
    54 unfix_nodes                                0,1538
     1 reiserfs_dirty_inode                       0,0051
     1 leaf_define_dest_src_infos                 0,0024
   464 leaf_paste_in_buffer                       0,6563
     1 internal_insert_childs                     0,0021
     7 decrement_counters_in_path                 0,0886
     7 pathrelse_and_restore                      0,0897
    30 pathrelse                                  0,5455
   117 is_leaf                                    0,2635
    78 is_internal                                0,5612
   114 is_tree_node                               1,0962
  1585 search_by_key                              0,4455
    13 search_for_position_by_key                 0,0134
    20 init_tb_struct                             0,2532
     5 reiserfs_paste_into_item                   0,0182
     1 B_IS_IN_TREE                               0,0476
     1 copy_short_key                             0,0278
     6 copy_item_head                             0,1667
     2 comp_short_keys                            0,0247
     2 decrement_bcount                           0,0370
     1 reiserfs_check_lock_depth                  0,2000
     2 push_journal_writer                        0,2857
     3 pop_journal_writer                         0,4286
     1 dump_journal_writers                       0,0164
    36 reiserfs_in_journal                        0,0756
    38 reiserfs_wait_on_write_block               0,2754
    63 do_journal_begin_r                         0,0969
    11 journal_begin                              0,2558
     2 journal_prepare                            0,2857
    64 journal_mark_dirty                         0,0872
     6 journal_end                                0,1395
     1 remove_from_transaction                    0,0027
    62 check_journal_end                          0,0960
    12 reiserfs_update_inode_transaction          0,2264
     2 reiserfs_inode_in_this_transaction         0,0476
    24 reiserfs_restore_prepared_buffer           0,7742
    48 reiserfs_prepare_for_journal               0,4848
    37 do_journal_end                             0,0128
     2 sd_is_left_mergeable                       0,2857
     3 indirect_bytes_number                      0,1304
     2 indirect_is_left_mergeable                 0,0172
     1 cap_vm_enough_memory                       0,0057
     1 radix_tree_preload                         0,0063
     8 radix_tree_insert                          0,0396
    73 radix_tree_lookup                          0,9481
     5 radix_tree_delete                          0,0224
     4 number                                     0,0067
     4 vsnprintf                                  0,0037
     2 vsprintf                                   0,0465
     3 atomic_dec_and_lock                        0,0357
     1 __const_udelay                             0,0270
    66 memcpy                                     1,2000
     3 strncpy_from_user                          0,0330
   186 clear_user                                 2,6197
     2 __clear_user                               0,0645
     2 __copy_user_intel                          0,0116
     4 __copy_to_user_ll                          0,0385
   266 __copy_from_user_ll                        2,5577
    28 read_zero                                  0,0576
     1 tty_poll                                   0,0085
     1 normal_poll                                0,0031
     1 add_entropy_words                          0,0060
     2 con_chars_in_buffer                        0,2857
    46 blk_rq_map_sg                              0,1437
     1 get_request                                0,0015
    67 __make_request                             0,0529
    12 generic_make_request                       0,0271
     1 submit_bio                                 0,0094
     1 as_set_request                             0,0093
     2 get_stats                                  0,0165
    98 ide_end_request                            0,2961
    17 ide_do_request                             0,0159
     6 ide_intr                                   0,0143
    41 ide_inb                                    3,4167
     2 ide_outb                                   0,1538
   106 ide_outbsync                               8,1538
     3 ide_outsl                                  0,1667
    18 ide_execute_command                        0,1011
     1 __ide_do_rw_disk                           0,0005
     2 ide_dma_intr                               0,0108
     3 ide_build_dmatable                         0,0077
     1 i8042_interrupt                            0,0018
    17 raid0_make_request                         0,0471
     1 sock_sendmsg                               0,0057
     1 sock_poll                                  0,0208
     1 dev_seq_start                              0,0075
     2 unix_peer_get                              0,0370
     4 unix_poll                                  0,0265
  8982 gesamt                                     0,0038

--Boundary-00=_JTYM/p1D65CKbmi--

