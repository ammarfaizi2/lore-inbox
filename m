Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTBOVMX>; Sat, 15 Feb 2003 16:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBOVMX>; Sat, 15 Feb 2003 16:12:23 -0500
Received: from smtp.terra.es ([213.4.129.129]:6326 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id <S265066AbTBOVMU>;
	Sat, 15 Feb 2003 16:12:20 -0500
Date: Sat, 15 Feb 2003 22:22:29 +0100
From: Arador <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: 2.5: system time goes up to 100%
Message-Id: <20030215222229.10b56e5f.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i've the following case (more info provided below):

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1  44268 124776  10380  64736    5    8    93    37  600   281   11  2 85  3
 1  0  44268 124160  10584  64736    0    0   196   196 1750  1518  1 41 49  9
 1  0  44268 123544  10676  64864    0    0   220     0 1722  1424  2 49 47  2
 2  0  44268 123088  10696  64992    0    0   148     0 1777  1681  2 56 41  0
 2  0  44268 122304  10712  65136  144    0   304     0 1738  1554  3 51 44  3
 1  0  44268 121616  10716  65264    0    0   132     0 1697  1385  2 50 47  0
 2  0  44268 120904  10728  65392    0    0   132   376 1791  1425  3 56 42  0
 2  0  44268 120408  10728  65520    0    0   128     0 1696  1385  2 50 48  0
 2  0  44268 119848  10728  65648    0    0   128     0 1699  1393  2 50 48  0
 2  0  44268 119232  10728  65776    0    0   128     0 1698  1375  2 50 47  0
 2  0  44268 118728  10728  65904    0    0   128     0 1694  1392  2 50 49  0
 2  0  44268 118240  10736  66032    0    0   128    96 1754  2130  6 62 31  0
 2  0  44268 117792  10736  66032    0    0   128     0 1739  1664  2 56 43  0
 2  0  44268 117232  10736  66160   16    0    16     0 1756  1761  4 60 36  0
 3  0  44268 116736  10736  66288    0    0   128     0 1775  1754  2 58 40  0
 1  0  44268 116248  10736  66416    0    0   128     0 1343   728  2 56 42  0
 1  0  44268 115688  10744  66544    0    0   128    32 1021   106  0 51 48  0
 1  0  44268 115072  10744  66672    0    0   128     0 1012    57  1 50 49  0
 3  0  44268 114512  10744  66800    0    0   128     0 1036   177  1 51 47  0
 7  0  44268 114080  10744  66928    0    0   128     0 1108   455  2 55 43  0
 1  0  44268 113464  10752  67056    0    0   128    28 1042   518  4 57 39  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0  44268 112904  10752  67184    0    0   128     0 1043   148  1 51 48  0
 1  0  44268 112344  10752  67312    0    0   128     0 1012   140  1 52 47  0
 1  0  44268 111864  10752  67440    0    0   128     0 1009    45  0 50 49  0
 1  0  44268 111248  10752  67568    0    0   128     0 1045   264  2 53 44  0
 1  0  44268 110688  10760  67696    0    0   128    20 1108   693  1 55 43  0
 1  0  44268 110184  10760  67824    0    0   128     0 1012   370  2 50 48  0
 1  0  44268 109584  10760  67952    0    0   128     0 1015   158  1 52 47  0
 1  0  44268 109136  10760  67996    0    0    44     0 1023   221  1 53 46  0
 1  0  44268 108688  10760  67996    0    0     0     0 1013   224  1 51 47  0
 1  0  44268 108408  10772  68028    0    0    36    16 1014   122  4 47 49  1
 1  0  44268 103256  10780  68440    4    0   424     0 1084   362 39  4 50  7
 1  0  44268 101232  10788  61964    0    0    16     0 1006   522 51  3 46  0

(sorry if it's disordered, it's on a Eterm and i can't cut paste in a decent shape)

system is a p3 2x800, 256 mb ram; kernel is 2.5.61; but i've
experimented it more times in ther 2.5 releases

Disk is a UDMA100, fs is a only ext3 particion (no htree and/or orlov)

It just happens sometimes when i open the mail client  sylpheed
in the lkml carpet; 137 MB, like 29000 messages
This mail client saves each message in a file
diego@estel:~/sylpheed-mail/inbox/linux-kernel$ ls -l | wc -l
  29096

It takes a lot of time, usually it's opened very fast (as expected
in this great mail client ;)

i took readprofile just after doing this, i hope it helps (BTW shouldn't "total" show more time?):
8209527 total                                      4,5041
8035501 default_idle                             100443,7625
 39060 ext3_find_entry                           35,9007
 19200 serial_in                                171,4286
 18957 check_poison_obj                         131,6458
 10930 __constant_c_and_count_memset             68,3125
  4057 delay_tsc                                126,7812
  3843 __preempt_spin_lock                       24,0188
  2944 __copy_to_user_ll                         23,0000
  2911 kmem_cache_free                           20,2153
  2784 do_page_fault                              2,3533
  2251 page_remove_rmap                           4,6896
  1955 schedule                                   1,9092
  1940 __constant_memcpy                          7,1324
  1907 page_add_rmap                              5,6756
  1469 buffered_rmqueue                           3,1659
  1410 do_anonymous_page                          1,4936
  1346 fget                                      10,5156
  1247 zap_pte_range                              2,2268
  1235 kfree                                      5,1458
  1050 link_path_walk                             0,5048
   961 ide_outb                                  60,0625
   934 find_get_page                              7,2969
   898 __d_lookup                                 4,0089
   867 ide_end_request                            2,0069
   858 cpu_idle                                  10,7250
   836 __wake_up                                  4,3542
   825 release_pages                              1,3936
   810 free_hot_cold_page                         2,6645
   782 system_call                               17,7727
   767 kmem_cache_alloc                           4,3580
   711 handle_mm_fault                            2,9625
   708 find_vma                                   7,3750
   701 radix_tree_lookup                          6,2589
   681 __find_get_block_slow                      2,1281
   654 do_no_page                                 0,6928
   628 cache_alloc_debugcheck_after               3,0192
   617 lookup_bh_lru                              4,2847
   608 __might_sleep                              4,7500
   607 __copy_from_user_ll                        4,8952
   561 do_select                                  0,8766
   519 pte_alloc_map                              1,4103
   506 __pagevec_lru_add_active                   1,1295
   470 kmalloc                                    1,9583
   468 __make_request                             0,3250
   456 unix_poll                                  2,8500
   456 bh_lru_install                             1,9000
   439 copy_page_range                            0,3049
   428 do_get_write_access                        0,2106
   399 poison_obj                                 6,2344
   398 __alloc_pages                              0,5293
   391 ext3_do_update_inode                       0,3703
   389 do_mmap_pgoff                              0,2152
   384 __copy_user_intel                          2,1818
   364 filemap_nopage                             0,4946
   360 ide_inb                                   22,5000
   359 ext3_get_block_handle                      0,3740
   349 fput                                      10,9062
   335 remove_wait_queue                          1,9034
   328 dnotify_parent                             1,4643
   326 .text.lock.sched                           1,1088
   325 serial_out                                 2,9018
   325 add_wait_queue                             2,0312
   324 handle_IRQ_event                           2,8929
   321 __pte_chain_free                           2,2292
   321 journal_dirty_metadata                     0,4666
   320 pte_chain_alloc                            2,0000
   316 sys_brk                                    1,0395
   311 do_generic_mapping_read                    0,2817
   310 __get_page_state                           1,7614
   300 sock_poll                                  4,6875
   293 ext3_get_inode_loc                         0,7043
   289 vma_merge                                  0,3284
   289 mark_page_accessed                         4,5156
   284 prep_new_page                              3,5500
   258 strnlen_user                               3,2250
   253 bad_range                                  2,2589
   251 unix_stream_recvmsg                        0,2752
   245 ide_do_request                             0,3828
   240 probe_irq_on                               0,3000
   238 receive_chars                              0,3628
   237 journal_add_journal_head                   0,4003
   234 lru_cache_add_active                       2,4375
   233 start_this_handle                          0,2468
   230 atomic_dec_and_lock                        1,5972
   227 ll_rw_block                                1,5764
   225 __brelse                                   3,5156
   216 ide_intr                                   0,2935
   214 ext3_dirty_inode                           0,6080
   213 handle_pte_fault                           0,7422
   212 find_vma_prepare                           1,8929
   206 sys_select                                 0,1497
   204 free_one_pmd                               0,7500
   200 journal_stop                               0,2778
   199 vm_enough_memory                           1,0365
   198 unlock_buffer                              2,0625
   196 nr_free_pages                              2,4500
   196 __constant_c_and_count_memset              1,2250
   195 dput                                       0,6771
   191 __pollwait                                 0,9183
   191 path_lookup                                0,4263
   191 journal_cancel_revoke                      0,4263
   187 arch_get_unmapped_area                     0,9947
   184 serial8250_interrupt                       0,4259
   179 kmem_flagcheck                             2,7969
   178 journal_get_write_access                   1,1125
   175 ext3_read_inode                            0,1854
   173 do_brk                                     0,3180
   172 unix_stream_sendmsg                        0,2108
   172 __constant_c_and_count_memset              1,0750
   171 ext3_check_dir_entry                       0,7125
   167 find_revoke_record                         1,4911
   167 __find_get_block                           1,3047
   164 unlock_nd                                  0,9318
   162 __mark_inode_dirty                         0,4821
   162 get_unused_fd                              0,3375
   156 vfs_read                                   0,5132
   155 journal_unlock_journal_head                0,6458
   153 may_open                                   0,3187
   153 __do_page_cache_readahead                  0,3741
   152 __set_page_dirty_buffers                   0,2714
   147 snd_pcm_lib_write1                         0,0875
   147 skb_dequeue                                0,7656
   145 find_next_usable_block                     0,1849
   145 dentry_open                                0,3125
   144 do_lookup                                  0,3750
   142 old_mmap                                   0,3859
   139 generic_fillattr                           1,0859
   137 strncpy_from_user                          1,2232
   137 __journal_file_buffer                      0,2141
   136 current_kernel_time                        1,7000
   135 wake_up_buffer                             2,1094
   131 getname                                    0,6298
   130 __fput                                     0,4062
   129 ext3_get_branch                            0,5375
   129 dget_locked                                2,6875
   125 __constant_c_and_count_memset              0,7812
   124 add_timer                                  0,4844
   123 remove_shared_vm_struct                    0,7688
   122 get_empty_filp                             0,2007
   120 do_wp_page                                 0,1136
   117 __generic_file_aio_read                    0,2216
[...]
    67 syscall_exit                               6,0909
(i left this, just because it shows too many time compared to others in its zone)



Diego Calleja
