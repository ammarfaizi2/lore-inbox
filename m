Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274961AbTHFXL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274967AbTHFXL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:11:58 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:55164 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S274961AbTHFXK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:10:26 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 01:10:16 +0200
User-Agent: KMail/1.5.3
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308070044.41198.fsdeveloper@yahoo.de> <20030806155638.1fdd0a30.akpm@osdl.org>
In-Reply-To: <20030806155638.1fdd0a30.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, gardiol@libero.it
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YrYM/ICLE6oqUCP"
Message-Id: <200308070110.19660.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YrYM/ICLE6oqUCP
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 07 August 2003 00:56, Andrew Morton wrote:
> it does seem that ide has gone bad.  Perhaps you can run `hdaprm -X udma2'
> or whatever the `-X' argument is to force it into UDMA2 mode.
>
> But the driver should have done that for itself.

I've done -X udma2 and it did a _massive_ performance drop.

root@lfs:/home/mb> hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.31 seconds =3D417.00 MB/sec
 Timing buffered disk reads:  64 MB in  3.24 seconds =3D 19.73 MB/sec

"Timing buffered disk reads" is only as half as fast as without udma2.

I've made a new profile with udma2 enabled and appended it.

The system-performance while dd is way better now, but still not as
good as in 2.4
But for what price? Now I have a disk-speed like DMA-33. :) (on a
DMA-100 controller)

=2D --=20
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MYrYoxoigfggmSgRAm9KAKCCQwbsCW5nwImZcusGVLJhgvxP9gCeJO9h
LJK0UBrkAVGXd0yLUAmhdic=3D
=3DIYVd
=2D----END PGP SIGNATURE-----

--Boundary-00=_YrYM/ICLE6oqUCP
Content-Type: text/plain;
  charset="iso-8859-1";
  name="p3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="p3"

     1 restore_sigcontext                         0,0033
   711 system_call                               16,1591
     4 syscall_call                               0,3636
     2 syscall_exit                               0,1818
     2 device_not_available                       0,0476
     2 handle_IRQ_event                           0,0204
     1 restore_i387_fxsave                        0,0076
    10 delay_tsc                                  0,3704
     1 queue_empty                                0,0500
     3 do_poll                                    0,0273
     1 do_page_fault                              0,0008
    16 schedule                                   0,0169
     1 preempt_schedule                           0,0149
   129 __wake_up                                  1,4828
     1 add_wait_queue                             0,0103
     2 remove_wait_queue                          0,0189
     1 finish_wait                                0,0088
     1 do_setitimer                               0,0026
     1 sys_gettimeofday                           0,0061
     8 current_kernel_time                        0,1333
   223 do_softirq                                 1,3938
     2 add_timer                                  0,0123
     1 del_timer                                  0,0072
     4 run_timer_softirq                          0,0094
     1 group_send_sig_info                        0,0011
     2 get_signal_to_deliver                      0,0026
     1 rcu_do_batch                               0,0161
     8 add_to_page_cache                          0,0269
    10 page_waitqueue                             0,2128
     6 wait_on_page_bit                           0,0343
    22 unlock_page                                0,2785
     5 find_get_page                              0,0510
    31 find_lock_page                             0,0966
     4 remove_suid                                0,0400
   225 generic_file_aio_write_nolock              0,0725
    28 generic_file_write_nolock                  0,1931
    14 generic_file_write                         0,1321
    12 mempool_alloc                              0,0356
     3 bad_range                                  0,0297
     1 prep_new_page                              0,0135
    21 free_hot_cold_page                         0,0805
    14 buffered_rmqueue                           0,0358
     7 __alloc_pages                              0,0097
     1 __get_free_pages                           0,0145
     1 __pagevec_free                             0,0278
     1 nr_free_pages                              0,0137
     1 __get_page_state                           0,0092
     2 balance_dirty_pages                        0,0054
    17 balance_dirty_pages_ratelimited            0,1189
    13 __set_page_dirty_nobuffers                 0,0650
     9 test_clear_page_dirty                      0,1552
     1 cache_init_objs                            0,0088
     1 cache_grow                                 0,0017
    22 kmem_cache_alloc                           0,3385
    11 __kmalloc                                  0,0932
    19 kmem_cache_free                            0,2676
    15 kfree                                      0,1596
    31 mark_page_accessed                         0,6200
     2 release_pages                              0,0053
     2 __pagevec_release_nonlru                   0,0148
    10 __pagevec_lru_add                          0,0400
     1 invalidate_complete_page                   0,0040
     1 invalidate_mapping_pages                   0,0044
     5 shrink_list                                0,0035
     8 shrink_cache                               0,0111
     3 refill_inactive_zone                       0,0023
     1 wakeup_kswapd                              0,0179
     1 blk_queue_bounce                           0,0128
     5 do_anonymous_page                          0,0085
     1 do_mmap_pgoff                              0,0006
     1 unmap_region                               0,0047
     6 page_referenced                            0,0368
     1 try_to_unmap_one                           0,0021
    19 vfs_read                                   0,0709
    23 vfs_write                                  0,0858
    28 sys_read                                   0,3011
    27 sys_write                                  0,2903
     1 fput                                       0,0400
    10 fget                                       0,1471
    36 fget_light                                 0,2628
     3 __set_page_buffers                         0,0400
     6 __find_get_block_slow                      0,0216
     1 mark_buffer_async_write                    0,0435
     2 buffer_insert_list                         0,0187
     1 inode_has_buffers                          0,0385
     2 create_buffers                             0,0129
    12 mark_buffer_dirty                          0,1600
    18 __brelse                                   0,3158
   252 __find_get_block                           1,1560
    42 __getblk                                   0,5600
    45 __bread                                    0,7895
     2 set_bh_page                                0,0328
     1 create_empty_buffers                       0,0065
     1 unmap_underlying_metadata                  0,0108
     1 __block_write_full_page                    0,0011
   568 __block_prepare_write                      0,6147
    25 __block_commit_write                       0,1799
     2 block_read_full_page                       0,0031
    11 block_prepare_write                        0,1692
    26 generic_commit_write                       0,1699
     5 submit_bh                                  0,0147
     1 drop_buffers                               0,0052
     3 alloc_buffer_head                          0,0330
     2 free_buffer_head                           0,0202
     2 init_buffer_head                           0,0465
     7 bio_alloc                                  0,0172
     1 cp_new_stat64                              0,0044
     3 pipe_poll                                  0,0248
     1 follow_mount                               0,0072
     3 link_path_walk                             0,0014
     3 path_lookup                                0,0096
     1 __user_walk                                0,0118
     1 may_open                                   0,0024
     1 __pollwait                                 0,0058
     3 max_select_fd                              0,0133
     8 do_select                                  0,0127
     1 sys_poll                                   0,0016
     1 dput                                       0,0019
     2 prune_dcache                               0,0045
    15 __d_lookup                                 0,0479
     1 generic_forget_inode                       0,0030
     1 iput                                       0,0081
    25 inode_times_differ                         0,3623
     2 update_atime                               0,0100
    27 inode_update_time                          0,1598
    49 dnotify_parent                             0,3121
     4 __mark_inode_dirty                         0,0170
     3 mpage_writepages                           0,0039
     1 proc_delete_inode                          0,0071
     1 proc_alloc_inode                           0,0087
     2 proc_get_inode                             0,0066
     1 proc_root_lookup                           0,0092
     4 proc_lookup                                0,0150
     6 write_profile                              0,0909
     7 scan_bitmap_block                          0,0063
     3 use_preallocated_list_if_available         0,0256
    11 reiserfs_allocate_blocknrs                 0,0055
    14 balance_leaf                               0,0013
     5 free_thrown                                0,0481
     2 do_balance                                 0,0077
     9 do_balance_mark_leaf_dirty                 0,0738
    42 _make_cpu_key                              0,2270
    15 make_cpu_key                               0,1596
     1 file_capable                               0,0192
    78 reiserfs_get_block                         0,0156
    25 inode2sd                                   0,1678
    21 update_stat_data                           0,0843
    93 reiserfs_update_sd                         0,2148
     1 lock_buffer_for_writepage                  0,0069
     9 reiserfs_write_full_page                   0,0118
     1 reiserfs_writepage                         0,0175
    14 reiserfs_prepare_write                     0,1000
    67 reiserfs_commit_write                      0,1580
     2 i_attrs_to_sd_attrs                        0,0187
     4 reiserfs_releasepage                       0,0260
     9 reiserfs_file_write                        0,0056
     1 create_virtual_node                        0,0008
     1 get_lfree                                  0,0096
     5 get_rfree                                  0,0505
    11 get_parents                                0,0276
    21 ip_check_balance                           0,0072
     3 check_balance                              0,0201
     3 get_direct_parent                          0,0154
     3 get_neighbors                              0,0087
     4 get_virtual_node_size                      0,0500
     1 get_mem_for_virtual_node                   0,0046
     2 clear_all_dirty_bits                       0,0556
    40 wait_tb_buffers_until_unlocked             0,0461
     9 fix_nodes                                  0,0083
    32 unfix_nodes                                0,0912
     1 leaf_copy_boundary_item                    0,0005
     2 leaf_insert_into_buf                       0,0032
   413 leaf_paste_in_buffer                       0,5842
     1 leaf_cut_from_buffer                       0,0009
     3 decrement_counters_in_path                 0,0380
     9 pathrelse_and_restore                      0,1154
    20 pathrelse                                  0,3636
   160 is_leaf                                    0,3604
    66 is_internal                                0,4748
    76 is_tree_node                               0,7308
  1184 search_by_key                              0,3328
    15 search_for_position_by_key                 0,0155
    12 init_tb_struct                             0,1519
     5 reiserfs_paste_into_item                   0,0182
     3 B_IS_IN_TREE                               0,1429
     6 copy_item_head                             0,1667
     2 reiserfs_check_lock_depth                  0,4000
     1 push_journal_writer                        0,1429
     2 pop_journal_writer                         0,2857
     1 dump_journal_writers                       0,0164
    19 reiserfs_in_journal                        0,0399
    32 reiserfs_wait_on_write_block               0,2319
    30 do_journal_begin_r                         0,0462
     4 journal_begin                              0,0930
     2 journal_prepare                            0,2857
    36 journal_mark_dirty                         0,0490
     8 journal_end                                0,1860
    54 check_journal_end                          0,0836
    10 reiserfs_update_inode_transaction          0,1887
    20 reiserfs_restore_prepared_buffer           0,6452
    31 reiserfs_prepare_for_journal               0,3131
    24 do_journal_end                             0,0083
     1 sd_part_size                               0,0455
     3 direct_is_left_mergeable                   0,0229
     2 indirect_bytes_number                      0,0870
     1 indirect_is_left_mergeable                 0,0086
     1 indirect_check_right                       0,0227
     5 radix_tree_insert                          0,0248
    48 radix_tree_lookup                          0,6234
     1 __lookup                                   0,0050
    13 radix_tree_delete                          0,0583
     9 number                                     0,0152
     8 vsnprintf                                  0,0074
     1 vsprintf                                   0,0233
     1 sprintf                                    0,0286
     8 atomic_dec_and_lock                        0,0952
    50 memcpy                                     0,9091
     1 strncpy_from_user                          0,0110
   129 clear_user                                 1,8169
     4 __copy_user_intel                          0,0233
     6 __copy_to_user_ll                          0,0577
   208 __copy_from_user_ll                        2,0000
    24 read_zero                                  0,0494
     1 tty_poll                                   0,0085
     1 con_chars_in_buffer                        0,1429
    17 blk_rq_map_sg                              0,0531
     1 blk_congestion_wait                        0,0077
    48 __make_request                             0,0379
     5 generic_make_request                       0,0113
     2 submit_bio                                 0,0189
     1 get_io_context                             0,0079
     1 get_stats                                  0,0083
    88 ide_end_request                            0,2659
    12 ide_do_request                             0,0113
     8 ide_intr                                   0,0191
    36 ide_inb                                    3,0000
     1 ide_outb                                   0,0769
    77 ide_outbsync                               5,9231
     3 ide_outsl                                  0,1667
    10 ide_execute_command                        0,0562
     1 SELECT_DRIVE                               0,0133
     1 default_end_request                        0,1111
     1 __ide_do_rw_disk                           0,0005
     1 ide_do_rw_disk                             0,0147
     1 ide_dma_intr                               0,0054
     1 ide_build_sglist                           0,0058
     3 ide_build_dmatable                         0,0077
     1 __ide_dma_end                              0,0065
     1 i8042_interrupt                            0,0018
     1 i8042_timer_func                           0,0161
     8 raid0_make_request                         0,0222
     1 sock_aio_read                              0,0048
    16 sock_poll                                  0,3333
     1 sock_def_readable                          0,0077
     1 dev_seq_printf_stats                       0,0044
     1 dev_seq_show                               0,0084
     2 tcp_poll                                   0,0055
     3 unix_stream_sendmsg                        0,0029
     3 unix_stream_recvmsg                        0,0024
     7 unix_poll                                  0,0464
  6804 gesamt                                     0,0029

--Boundary-00=_YrYM/ICLE6oqUCP--

