Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbTDOUuo (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTDOUuo 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 16:50:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:5294 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261392AbTDOUum convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 16:50:42 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.66-mm3 -  bad ext2 performance ?
Date: Tue, 15 Apr 2003 14:00:05 -0700
User-Agent: KMail/1.4.1
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304151356.24323.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is kind of extreem. But  I have 1070 LUNS and I mkfs/mounted (ext2) all
these and running "fsx" on all of them. 

I see very bad IO rate on the machine.  fsx with O_DIRECT seems to be
doing okay. Any ideas on why regular filesystem (buffered) IO sucks ?
I dont' see even cache increasing ..

Thanks,
Badari

vmstat:
======

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
1089  0  3      0 2597396 169324 219896    0    0     0  2304 1221   330 68 32  0
1093  0  4      0 2596732 169400 219820    0    0     0  1969 1195   332 68 32  0
1090  0  5      0 2599076 169452 217688    0    0     0  2611 1234   523 67 33  0
1089  0  5      0 2595908 169500 220500    0    0     0  2034 1195   345 68 32  0
1085  0  4      0 2595292 169584 221716    0    0     0  2444 1244   305 68 32  0
1082  0  5      0 2598204 169620 219080    0    0     0  2790 1234   442 67 33  0
1081  0  5      0 2595252 169680 222140    0    0     0  1980 1208   278 68 32  0
1077  0  4      0 2595084 169708 222372    0    0     0  2481 1257   377 67 33  0
1075  0  5      0 2598980 169736 218704    0    0     0  2057 1187   448 67 33  0
 

10 second profile output:
====================

c0137860 __filemap_fdatawrite                        331   1.8807
c0137810 remove_from_page_cache                      333   4.1625
c0187480 proc_pid_stat                               334   0.2747
c0157130 __clear_page_buffers                        347   4.3375
c01589a0 set_bh_page                                 350   5.4688
c0158110 create_buffers                              352   2.0000
c013d3a0 do_page_cache_readahead                     365   0.8449
c01a3e50 grab_block                                  366   0.7148
c0157cc0 mark_buffer_dirty_inode                     379   3.9479
c0171db0 dnotify_parent                              394   1.5391
c01588e0 __bread                                     407   6.3594
c02947c0 scsi_request_fn                             407   0.5653
c01710f0 inode_setattr                               413   0.8327
c015a970 drop_buffers                                415   2.1615
c0208800 __lookup                                    429   1.5772
c015aa30 try_to_free_buffers                         464   1.7059
c013ace0 bad_range                                   495   5.1562
c0138100 find_get_pages                              514   4.5893
c015abd0 recalc_bh_state                             530   3.6806
c013cc60 test_clear_page_dirty                       532   6.6500
c0159580 block_read_full_page                        541   0.7194
c01a6bd0 ext2_alloc_branch                           544   1.0303
c017af50 aio_complete                                554   0.9112
c015aca0 free_buffer_head                            556   6.9500
c015ac60 alloc_buffer_head                           568   8.8750
c01588a0 __getblk                                    599   9.3594
c01a74d0 ext2_free_branches                          600   1.6304
c01a3850 ext2_get_group_desc                         615   4.2708
c013dc20 check_poison_obj                            632   1.5800
c0158b50 create_empty_buffers                        634   2.6417
c0170e90 inode_change_ok                             637   1.0477
c013b520 __alloc_pages                               654   0.8516
c01385f0 file_read_actor                             655   3.1490
c015acf0 init_buffer_head                            661  13.7708
c01416e0 truncate_complete_page                      683   5.3359
c01557a0 generic_file_llseek                         709   3.4087
c0137f70 find_lock_page                              719   3.2098
c011d4e0 __might_sleep                               737   7.6771
c01a3bd0 ext2_free_blocks                            818   1.2781
c0158c40 unmap_underlying_metadata                   876   9.1250
c01584e0 mark_buffer_dirty                           880  13.7500
c013b090 prep_new_page                               925  14.4531
c0156c50 fget                                       1001  10.4271
c01594d0 __block_commit_write                       1014   5.7614
c01092d0 system_call                                1102  25.0455
c02087b0 radix_tree_lookup                          1151  14.3875
c0138240 do_generic_mapping_read                    1188   1.2585
c0156fd0 unlock_buffer                              1208  18.8750
c01a6810 ext2_alloc_block                           1232   6.4167
c0158520 __brelse                                   1233  25.6875
c0137ac0 add_to_page_cache                          1236   4.8281
c0141810 truncate_inode_pages                       1304   1.6633
c013cb40 __set_page_dirty_nobuffers                 1338   6.4327
c01a68d0 ext2_block_to_path                         1383   4.1161
c01a4050 ext2_new_block                             1474   1.2122
c0176a00 __mark_inode_dirty                         1577   4.9281
c0139470 generic_file_aio_write_nolock              1939   0.7869
c01412f0 __pagevec_lru_add                          2157   5.8614
c0141020 release_pages                              2203   4.1723
c0137d00 unlock_page                                2283  28.5375
c0123d60 current_kernel_time                        2446  30.5750
c0137ec0 find_get_page                              2604  32.5500
c01590b0 __block_prepare_write                      2654   2.5133
c013b2b0 free_hot_cold_page                         2687  10.4961
c0119740 kmap_atomic                                2813  19.5347
c0140e00 mark_page_accessed                         2905  36.3125
c01587a0 __find_get_block                           3392  13.2500
c01a6a20 ext2_get_branch                            3497  11.5033
c013b3d0 buffered_rmqueue                           3517  10.4673
c0157500 __find_get_block_slow                      3564   8.5673
c0158a40 block_invalidatepage                       3620  13.3088
c01a6de0 ext2_get_block                             5432   5.3889
c01197d0 kunmap_atomic                              6303  56.2768
c013dbe0 fprob                                     10266 160.4062
c013f920 kmem_cache_free                           16922  29.3785
c020a3d0 __copy_from_user_ll                       18886 168.6250
c013f570 kmem_cache_alloc                          19822  58.9940
c020a360 __copy_to_user_ll                         31509 281.3304
c0177b40 do_mpage_readpage                         48937  45.6502


vmstat output for O_DIRECT (fsx):
===========================
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
36 1034  5      0 2756980 150676  83844    0    0 43269 57496 9446  8861 70 30  0
45 1025  0      0 2757172 150728  83532    0    0 39107 53281 8499  8053 70 30  0
21 1049  3      0 2757252 150744  83516    0    0 40467 53607 8665  8128 70 30  0
57 1013  3      0 2757380 150756  83504    0    0 41798 54403 8842  8291 70 30  0
97 974  3      0 2757316 150780  83480    0    0 45418 59685 9657  8639 70 30  0
241 830  5      0 2756932 150852  83148    0    0 60914 81615 13457 11604 70 30  0
194 878  5      0 2757044 150920  83600    0    0 74382 90858 15219 12747 70 30  0


